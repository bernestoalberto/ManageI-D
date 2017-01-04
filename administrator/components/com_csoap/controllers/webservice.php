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

jimport('joomla.application.component.controllerform');

class CSOAPControllerWebservice extends JControllerForm{

	public function batch($model){
		JRequest::checkToken() or jexit(JText::_('JINVALID_TOKEN'));

		// Set the model
		$model = $this->getModel('Webservice', '', array());

		// Preset the redirect
		$this->setRedirect(JRoute::_('index.php?option=com_csoap&view=webservices'.$this->getRedirectToListAppend(), false));

		return parent::batch($model);
	}
}
