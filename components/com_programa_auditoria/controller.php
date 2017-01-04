<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class programa_auditoriaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_programa_auditoria';
	public $programa_auditoria;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->programa_auditoria=JModelLegacy::getInstance('programa_auditoria');
    }


    
 public function programa_auditoria()
    {
$base = JFactory::getUri()->base();
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('programa_auditoria');
        $view->display();
    }

        public function rep_programa_auditoria_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            //   JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            //    JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_evaluacion/models/');
            // $evaluacionmodel =JModelLegacy::getInstance('evaluacion');
            $list=$this->programa_auditoria->loadAll('*');
            if($list!=false)
                echo json_encode($list);

            JFactory::getApplication()->close();
        }

}
