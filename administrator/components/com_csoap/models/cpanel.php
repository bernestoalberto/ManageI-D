<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */

// no direct access
defined('_JEXEC') or die( 'Restricted access' );

jimport('joomla.application.component.model');

class CSOAPModelCPanel extends JModelLegacy {
	
	public function getInfo(){
		$info = array();
		
		//NuSOAP Lib version
		$NuSOAPManifest = JFactory::getXML(JPATH_MANIFESTS . DS . 'libraries' . DS . 'nusoap.xml');
		$info['nusoap_version'] = $NuSOAPManifest->version;
		
		//Component version
		$PackageManifest = JFactory::getXML(JPATH_MANIFESTS . DS . 'packages' . DS . 'pkg_csoap.xml');
		$info['package_version'] = $PackageManifest->version;
		$info['author'] = $PackageManifest->author;
		$info['email'] = $PackageManifest->authorEmail;
		$info['website'] = $PackageManifest->authorUrl;
		$info['extension_url'] = $PackageManifest->packagerurl;
		
		return $info;
	}
}
