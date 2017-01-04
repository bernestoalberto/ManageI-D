<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */
 
// no direct access
defined('_JEXEC') or die('Restricted access');

jimport( 'joomla.installer.installer' );

class com_csoapInstallerScript{

	public function install($installer){

		echo '<h3>'. JText::_('COM_CSOAP_INSTALLED') .'</h3>';
	}
	
	public function update($installer){
		echo '<h3>'. JText::_('COM_CSOAP_UPDATED') .'</h3>';
	}
    
    public function uninstall($installer){
		
	
	    echo '<h3>'. JText::_('COM_CSOAP_UNINSTALLED') .'</h3>';
	    
		return true;
	}
	
}
?>
