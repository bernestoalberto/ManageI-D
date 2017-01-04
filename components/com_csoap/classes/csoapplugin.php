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

abstract class CSOAPPlugin extends JPlugin{

	public function register(&$response, $functionName, array $inputTypes = array(), $returnType = 'string', $functionDescription = '', $staticCall = false){
		$class = get_class($this);
		$comParams =& JComponentHelper::getParams('com_csoap');
		$deliStrCls = $comParams->get('class_delimiter', '.');
		$deliStrStat = $comParams->get('static_delimiter', '..');
		if(method_exists($class, $functionName)){
			$key = $class . ($staticCall?$deliStrStat:$deliStrCls) . $functionName;
			$fObj = new ReflectionMethod($class, $functionName);
			$params = $fObj->getParameters();
			$inputs = array();
			for($i=0;$i<count($params);$i++){
				$inputs[$params[$i]->getName()] = ( isset($inputTypes[$i]) ? (!stristr($inputTypes[$i], ':')?'xsd:':'') . $inputTypes[$i] : 'xsd:string');
			}
			$response[$key]['inputs'] = $inputs;
			$response[$key]['return'] = (!stristr($returnType, ':')?'xsd:':'') . $returnType;
			$response[$key]['desc'] = $functionDescription;
			$response[$key]['static'] = $staticCall;
		}
	}
	
	public function addType(&$response, $typeName, $typeClass = 'complexType', $phpType = 'assoc', $compositor = '', $restrictionBase = '', $elements = array(), $attributes = array(), $arrayType = ''){
		$restrictionBase = ($restrictionBase == '' && $phpType == 'array' ? 'SOAP-ENC:Array' : $restrictionBase);
		$phpType = ($phpType == 'assoc' ? 'struct' : $phpType);
		$compositor = ($compositor == '' && $phpType == 'assoc' ? 'all' : $compositor);
		
		$response[$typeClass][$typeName] = array(
												'phpType' => $phpType,
												'compositor' => $compositor,
												'restrictionBase' => $restrictionBase,
												'elements' => $elements,
												'attributes' => $attributes,
												'arrayType' => ($arrayType != '' && !stristr($arrayType, ':')?'xsd:':'') . $arrayType
											);
	}
}

?>
