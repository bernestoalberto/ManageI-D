<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class rep_informe_auditoriaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_rep_informe_auditoria';
	public $repmodel;


	function __construct() {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_rep_informe_auditoria.js';

        array_push(JFactory::getDocument()->_script,$url);
        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->repmodel=JModelLegacy::getInstance('rep_informe_auditoria');
    }


    
 public function rep_informe_auditoria()
    {

        $view = $this->getView('rep_informe_auditoria');
        $view->display();
    }
        public function rep_informe_auditoria_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

            $list=$this->repmodel->loadAll('*');
            if($list!=false)

                echo json_encode($list);

            JFactory::getApplication()->close();
        }



}
