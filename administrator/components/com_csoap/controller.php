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

	public function display($cachable = false, $urlparams = false){
		parent::display();

		return $this;
	}
}
