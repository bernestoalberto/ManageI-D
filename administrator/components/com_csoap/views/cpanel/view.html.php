<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */

// no direct access
defined('_JEXEC') or die();

jimport( 'joomla.application.component.view' );

jimport( 'joomla.html.pane' );

class CSOAPViewCPanel extends JView
{
	function display($tpl = null)
	{
		JToolBarHelper::title(JText::_('COM_CSOAP') . ' - ' . JText::_('COM_CSOAP_CPANEL'), 'csoap.png');
		
		$user = JFactory::getUser();
		if ($user->authorise('core.admin', 'com_csoap')) {
		    JToolBarHelper::preferences('com_csoap');
		}
		
		$info =& $this->get('Info');
		
		$this->assignRef('info', $info);
				
		parent::display($tpl);
	}
}
