<?php


// No direct access
defined('_JEXEC') or die;

jimport('joomla.application.component.modelitem');

class CSOAPModelCSOAP extends JModelItem{

	protected $_context = 'com_csoap.csoap';

	protected function populateState(){
		$app = JFactory::getApplication();
		$params	= $app->getParams();

		// Load the object state.
		$id	= JRequest::getInt('id');
		$this->setState('webservice.id', $id);

		// Load the parameters.
		$this->setState('params', $params);
	}

	public function &getItem($id = null){
		if ($this->_item === null)
		{
			$this->_item = false;

			if (empty($id)) {
				$id = $this->getState('webservice.id');
			}

			// Get a level row instance.
			$table = JTable::getInstance('Webservice', 'CSOAPTable');

			// Attempt to load the row.
			if ($table->load($id))
			{
				// Check published state.
				if ($published = $this->getState('filter.published'))
				{
					if ($table->state != $published) {
						return $this->_item;
					}
				}

				// Convert the JTable to a clean JObject.
				$properties = $table->getProperties(1);
				$this->_item = JArrayHelper::toObject($properties, 'JObject');
			}
			elseif ($error = $table->getError()) {
				$this->setError($error);
			}
		}

		return $this->_item;
	}

	public function hit($id = null){
		if (empty($id)) {
			$id = $this->getState('webservice.id');
		}

		$weblink = $this->getTable('Webservice', 'CSOAPTable');
		return $weblink->hit($id);
	}
}
