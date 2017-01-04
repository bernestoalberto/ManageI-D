<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class control_presupuestalController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_control_presupuestal';
	public $controlpresupuestalmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->controlpresupuestalmodel=JModelLegacy::getInstance('control_presupuestal');
    }


    
 public function control_presupuestal()
    {
 $base = JFactory::getUri()->base();
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('control_presupuestal');
        $view->display();
    }

        public function control_presupuestal_json_list()
        {
            header('Content-Type: application/json');

            $list=$this->controlpresupuestalmodel->loadAll('*');
            if($list!=false){
                for($i=0;$i< count($list);$i++){
                    if($list[$i]->fecha_terminacion == 0000-00-00) {
                        $list[$i]->fecha_terminacion = "No esta definida";
                    }
                }
                echo json_encode($list);
        }



            JFactory::getApplication()->close();
        }

}
