<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */
 
// no direct access
defined( '_JEXEC' ) or die( 'Restricted access' );

// Access check.
if (!JFactory::getUser()->authorise('core.manage', 'com_csoap')) {
	return JError::raiseWarning(404, JText::_('JERROR_ALERTNOAUTHOR'));
}

$view = JRequest::getVar('view', 'cpanel');
JRequest::setVar('view', $view);

$doc =& JFactory::getDocument();
$doc->addStyleSheet(DS.'administrator'.DS.'components'.DS.'com_csoap'.DS.'assets'.DS.'css'.DS.'com_csoap.css');

//Add sub menu
JSubMenuHelper::addEntry(JText::_('COM_CSOAP_CPANEL'), 'index.php?option=com_csoap', $view == 'cpanel');
JSubMenuHelper::addEntry(JText::_('COM_CSOAP_WEBSERIVCES'), 'index.php?option=com_csoap&view=webservices', $view == 'webservices');
JSubMenuHelper::addEntry(JText::_('COM_CSOAP_INSTALL_PLUGINS'), 'index.php?option=com_installer', false);

// Include dependancies
jimport('joomla.application.component.controller');

$controller	= JControllerLegacy::getInstance('CSOAP');
$controller->execute(JRequest::getCmd('task'));
$controller->redirect();
