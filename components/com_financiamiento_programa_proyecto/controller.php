<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class financiamiento_programa_proyectoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_financiamiento_programa_proyecto';
	public $financiamientomodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->financiamientomodel=JModelLegacy::getInstance('financiamiento_programa_proyecto');
    }


    
 public function financiamiento_programa_proyecto()
    {
$base = JFactory::getUri()->base();
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('financiamiento_programa_proyecto');
        $view->display();
    }

        public function financiamiento_programa_proyecto_json_list()
        {
            header('Content-Type: application/json');

            $list=$this->financiamientomodel->loadAll('*');
            if($list!=false)
                echo json_encode($list);

            JFactory::getApplication()->close();
        }

}
