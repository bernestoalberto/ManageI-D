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

class CSOAPViewWebservices extends JView{

	protected $items;
	protected $pagination;
	protected $state;

	public function display($tpl = null){
		$this->state		= $this->get('State');
		$this->items		= $this->get('Items');
		
		$this->pagination	= $this->get('Pagination');
		
		//$aliasses = $this->get('Aliasses');

		// Check for errors.
		if (count($errors = $this->get('Errors'))) {
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}
		/*$comParams =& JComponentHelper::getParams('com_csoap');
		if(!$comParams->get('main_domain', false)){
			$app =& JFactory::getApplication();
			$app->enqueueMessage(JText::_('COM_CDOMAINMANAGER_WARN_NO_MAINDOMAIN'), 'warning');
		}*/

		$this->addToolbar();
		//$this->assignRef('aliasses', $aliasses);
		parent::display($tpl);
	}

	protected function addToolbar(){
		$state	= $this->get('State');
		$user	= JFactory::getUser();
		$option	= 'com_csoap';

		JToolBarHelper::title(JText::_('COM_CSOAP') . ' - ' . JText::_('COM_CSOAP_WEBSERIVCES'), 'webservices.png');
		
		if ($user->authorize('core.create', $option)) {
			JToolBarHelper::addNew('webservice.add');
		}
		if ($user->authorize('core.edit', $option)) {
			JToolBarHelper::editList('webservice.edit');
		}
		if ($user->authorize('core.edit.state', $option)) {

			JToolBarHelper::divider();
			JToolBarHelper::publish('webservices.publish', 'JTOOLBAR_PUBLISH', true);
			JToolBarHelper::unpublish('webservices.unpublish', 'JTOOLBAR_UNPUBLISH', true);


			JToolBarHelper::divider();
			JToolBarHelper::archiveList('webservices.archive');
			JToolBarHelper::checkin('webservices.checkin');
		}
		if ($state->get('filter.state') == -2 && $user->authorize('core.delete', $option)) {
			JToolBarHelper::deleteList('', 'webservices.delete', 'JTOOLBAR_EMPTY_TRASH');
			JToolBarHelper::divider();
		} elseif ($user->authorize('core.edit.state', $option)) {
			JToolBarHelper::trash('webservices.trash');
			JToolBarHelper::divider();
		}
		if ($user->authorize('core.admin', $option)) {
			JToolBarHelper::preferences($option);
			JToolBarHelper::divider();
		}
	}
}
