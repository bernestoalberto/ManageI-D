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

class CSOAPViewFunctieMatch extends JViewLegacy{

	protected $state;
	protected $item;

	function display($tpl = null){
	
		$item =& $this->getItem();
	
		parent::display($tpl);
	}
}
