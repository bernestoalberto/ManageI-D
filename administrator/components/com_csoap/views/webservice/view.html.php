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

jimport('joomla.application.component.view');

class CSOAPViewWebservice extends JView{

	protected $state;
	protected $item;
	protected $form;


	public function display($tpl = null){
		$this->state	= $this->get('State');
		$this->item		= $this->get('Item');
		$this->form		= $this->get('Form');

		// Check for errors.
		if (count($errors = $this->get('Errors'))) {
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}

		$this->addToolbar();
		parent::display($tpl);
	}

	protected function addToolbar(){
		JRequest::setVar('hidemainmenu', true);

		$user		= JFactory::getUser();
		$isNew		= ($this->item->id == 0);
		$checkedOut	= !($this->item->checked_out == 0 || $this->item->checked_out == $user->get('id'));
		$option		= 'com_csoap';

		JToolBarHelper::title(
						JText::_('COM_CSOAP') . ' - '
						. ($isNew?JText::_('COM_CSOAP_NEW_WEBSERVICE'):JText::_('COM_CSOAP_EDIT_WEBSERVICE')), 
						'webservices.png'
						);

		// If not checked out, can save the item.
		if (!$checkedOut && ($user->authorize('core.edit', $option) || ($user->authorize('core.create', $option))))
		{
			JToolBarHelper::apply('webservice.apply');
			JToolBarHelper::save('webservice.save');
		}
		if (!$checkedOut && ($user->authorize('core.create', $option))){
			JToolBarHelper::save2new('webservice.save2new');
		}
		// If an existing item, can save to a copy.
		if (!$isNew && ($user->authorize('core.create', $option))) {
			JToolBarHelper::save2copy('webservice.save2copy');
		}
		if (empty($this->item->id)) {
			JToolBarHelper::cancel('webservice.cancel');
		}
		else {
			JToolBarHelper::cancel('webservice.cancel', 'JTOOLBAR_CLOSE');
		}

	}
}
