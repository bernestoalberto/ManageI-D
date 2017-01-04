<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class estado_ejecucion_programa_proyectoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_estado_ejecucion_programa_proyecto';
	public $controlmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->controlmodel=JModelLegacy::getInstance('estado_ejecucion_programa_proyecto');
    }


    
 public function estado_ejecucion_programa_proyecto()
    {
 $base = JFactory::getUri()->base();
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('estado_ejecucion_programa_proyecto');
        $view->display();
    }

        public function estado_ejecucion_proyecto_json_list()
        {
            header('Content-Type: application/json');

            $list=$this->controlmodel->loadAll('*');
            if($list!=false)
                echo json_encode($list);
            JFactory::getApplication()->close();
        }

}
