<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class rep_dictmn_evl_gexpController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_rep_dictmn_evl_gexp';
	public $rep_dictamen_gexpmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->rep_dictamen_gexpmodel=JModelLegacy::getInstance('rep_dictmn_evl_gexp');
    }


    
 public function rep_dictmn_evl_gexp()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_rep_dictmanen_evl_gexp.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('rep_dictmn_evl_gexp');
        $view->display();
    }
        public function rep_dictmn_evl_gexp_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
         //   JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        //    JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_evaluacion/models/');
           // $evaluacionmodel =JModelLegacy::getInstance('evaluacion');
            $list=$this->rep_dictamen_gexpmodel->loadAll('*');
            if($list!=false)
            echo json_encode($list);

            JFactory::getApplication()->close();
        }


}
