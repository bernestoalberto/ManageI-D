<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */

defined('_JEXEC') or die;

function CSOAPBuildRoute(&$query){
	$segments = array();
	
	$db = JFactory::getDBO();
	$q = 'SELECT alias FROM `#__csoap_webservices` WHERE id = '.$query['id'];
	$db->setQuery($q);
	$alias = $db->loadResult();
	$segments[] = $alias;
	unset($query['id']);

	return $segments;
}

function CSOAPParseRoute($segments){
	$vars = array();
	$alias = str_replace(':', '-', $segments[0]);

	$db = JFactory::getDBO();
	$query = 'SELECT id FROM `#__csoap_webservices` WHERE alias = '.$db->Quote($alias);
	$db->setQuery($query);
	$id = $db->loadResult();
	$vars['id'] = $id;

	return $vars;
}
