<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */

// No direct access
defined('_JEXEC') or die;

jimport('joomla.application.component.controller');
	
class CSOAPController extends JControllerLegacy{
	
	public function start(){
		jimport('nusoap.nusoap');
		
		
		$model =& $this->getModel();
		$webservice = $model->getItem();
		
		// Create the server instance
		$server = new soap_server();
		
		if(!$webservice || !$webservice->id || $webservice->state != 1 ){
			$server->fault('SOAP-ENV:Client', 'This webservice is not available');
			$server->send_response();
			jexit();
		}
		
		$typeList = array();
		$functionList = array();
		if($webservice && $webservice->state == 1 ){
			//check for username and password
			$wsvrParams = new JRegistry($webservice->params);
			if($wsvrParams->get('xml_encoding_utf8', false)){
				$server->soap_defencoding = 'UTF-8';
			}
			if($wsvrParams->get('authentication') == 1){
				if($wsvrParams->get('username') == '' || $wsvrParams->get('password') == ''){
					$server->fault('SOAP-ENV:Client', 'Please corretly configure a username and password');
					$server->send_response();
					jexit();
				}
			}else if($wsvrParams->get('authentication') == 2){
				if(!$wsvrParams->get('juserid')){
					$server->fault('SOAP-ENV:Client', 'Please select a Joomla user who has access to this webservice');
					$server->send_response();
					jexit();
				}
			}
			

			//A request is received, check if the user needs to be validated
			$server->parse_http_headers();
			if($server->SOAPAction){
				//check if a authorization is mandatory and is requested
				if($wsvrParams->get('authentication') != 0){
					if(	!isset($server->headers['authorization']) || 
						!$this->_authorize($server->headers['authorization'], $wsvrParams)){
							$server->fault('SOAP-ENV:Client', 'Access denied');
							$server->send_response();
							jexit();
					}
				}
			}

			
			
			$namespace = $webservice->namespace;
			$uri =& JFactory::getURI();
			// Initialize WSDL support
			$route = JRoute::_('index.php?option=com_csoap&id=' . $webservice->id, true);
			$port = $uri->getPort();
			$url = $uri->getScheme() . '://' . $uri->getHost() . ($port && $port != 80 && $port != 443?':'.$port:'') . $route;
			//$server->configureWSDL($namespace, 'urn:' . $namespace, $url . (stristr($route, '?')?'&amp;':'?') . 'wsdl', 'document');
			$server->configureWSDL($namespace, 'urn:' . $namespace, $url . (stristr($route, '?')?'&amp;':'?') . 'wsdl', ($wsvrParams->get('style', 0) == 0?'rpc':'document'));

			JLoader::register('CSOAPPlugin', JPATH_COMPONENT.DS.'classes'.DS.'csoapplugin.php');
			$plugins = $wsvrParams->get('plugins', array());
	
			if(count($plugins)){
				foreach($plugins as $plugin){
					JPluginHelper::importPlugin('soap', $plugin);
				}
			}else{
				JPluginHelper::importPlugin('soap');
			}
	
			$dispatcher = JDispatcher::getInstance();
			$dispatcher->trigger('onRegisterFunctions', array(&$functionList));
		}
		//print_r($response );
		if(!count($functionList)){
			$server->fault('SOAP-ENV:Client', 'No functions registered for this webservice');
			$server->send_response();
			jexit();
		}else{
		
			//collect the custom added data types
			$dispatcher->trigger('onRegisterDataTypes', array(&$typeList));
			if(!empty($typeList)){
				// Register the data types
				foreach($typeList as $typeClass => $dataTypes){
					foreach($dataTypes as $name => $data){
						if(strtolower($typeClass) == 'enumeration'){
							$server->wsdl->addSimpleType(
														$name,
														$data['restrictionBase'],
														'simpleType',
														($data['phpType'] != 'scalar'?'scalar':$data['phpType']),
														$data['compositor'] //contains the elements for the enumeration
													);
						}else{
							$server->wsdl->addComplexType(
														$name,
														$typeClass,
														$data['phpType'],
														$data['compositor'],
														$data['restrictionBase'],
														$data['elements'],
														$data['attributes'],
														$data['arrayType']
													);

						}
					}
				}
			}
	
			// Register the method to expose
			/*$server->register('CSOAPController.hello',                // method name
				array('name' => 'xsd:string'),        // input parameters
				array('return' => 'xsd:string'),      // output parameters
				'urn:hellowsdl',                      // namespace
				'urn:hellowsdl#hello',                // soapaction
				'rpc',                                // style
				'encoded',                            // use
				'Says hello to the caller'            // documentation
			);*/
			$comParams =& JComponentHelper::getParams('com_csoap');
			$deliStrCls = $comParams->get('class_delimiter', '.');
			$deliStrStat = $comParams->get('static_delimiter', '..');
			
			foreach($functionList as $name => $registers){
				$functionName = explode(($registers['static']?$deliStrStat:$deliStrCls), $name);
				$server->register(	$name,
									$registers['inputs'],
									array('return' => $registers['return']),
									($wsvrParams->get('style', 0) == 0?'urn:' . $namespace:false),
									'urn:' . $namespace.'#'.$functionName[1],
									//$url .'#'.$functionName[1],
									($wsvrParams->get('style', 0) == 0?'rpc':'document'),
									($wsvrParams->get('style', 0) == 0?'encoded':'literal'),
									$registers['desc']);
			}
		}
		global $HTTP_RAW_POST_DATA;
		$HTTP_RAW_POST_DATA = isset($HTTP_RAW_POST_DATA) ? $HTTP_RAW_POST_DATA : file_get_contents("php://input");
		$server->service($HTTP_RAW_POST_DATA);
		jexit();
	}
	
	private function _authorize($authHeader, $wsvrParams){
		$a = explode(' ', $authHeader);
		$b = explode(':', base64_decode($a[1]));
		if(count($b) != 2){
			//no username and password present
			return false;
		}
		$type = $a[0];
		$username = $b[0];
		$pwd = $b[1];
		switch($wsvrParams->get('authentication')){
			case 1:
				//username and password
				if(	$wsvrParams->get('username') == $username && 
					$wsvrParams->get('password') == $pwd){
					return true;
				}
				break;
			case 2:
			case 3:
				//check for a valid Joomla user
				jimport('joomla.user.authentication');

				$authenticate = JAuthentication::getInstance();
				$credentials = array('username'=>$username, 'password'=>$pwd);
				$response = $authenticate->authenticate($credentials);
				if($response->status === JAuthentication::STATUS_SUCCESS){
					if($wsvrParams->get('authentication') == 3){
						$user =& JUser::getInstance(JUserHelper::getUserId($username));
						return in_array($wsvrParams->get('access'), $user->getAuthorisedViewLevels());
					}else{
						return true;
					}
				}
				break;
		}
		return false;
	}
}

