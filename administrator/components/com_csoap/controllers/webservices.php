<?php
// No direct access.
defined('_JEXEC') or die;

jimport('joomla.application.component.controlleradmin');

class CSOAPControllerWebservices extends JControllerAdmin{

	public function getModel($name = 'Webservice', $prefix = 'CSOAPModel', $config = array('ignore_request' => true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}
}
