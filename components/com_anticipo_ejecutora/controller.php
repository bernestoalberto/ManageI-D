<?php
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class anticipo_ejecutoraController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_anticipo_ejecutora';
	public $anticipo_ejecutoramodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->anticipo_ejecutoramodel=JModelLegacy::getInstance('anticipo_ejecutora');
    }


    
 public function anticipo_ejecutora()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_anticipo_ejecutora.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('anticipo_ejecutora');
        $view->display();
    }
        public function anticipo_ejecutora_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

            $list=$this->anticipo_ejecutoramodel->loadAll('*');
            if($list!=false){
                for($i=0;$i< count($list);$i++){

                    $list[$i]->persona = $list[$i]->persona. $list[$i]->apellido;

                }

            }

            echo json_encode($list);

            JFactory::getApplication()->close();
        }

    





}
