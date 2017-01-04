<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class deficiencias_proyectosController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_deficiencias_proyectos';
	public $deficienciasmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->deficienciasmodel=JModelLegacy::getInstance('deficiencias_proyectos');
    }


    
 public function deficiencias_proyectos()
    {
 $base = JFactory::getUri()->base();
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('deficiencias_proyectos');
        $view->display();
    }

        public function deficiencias_proyectos_json_list()
        {
            header('Content-Type: application/json');

            $list=$this->deficienciasmodel->loadAll('*');
            if($list!=false)
                echo json_encode($list);
                        JFactory::getApplication()->close();
        }

}
