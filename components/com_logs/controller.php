<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class logsController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_logs';
	public $logsmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->logsmodel=JModelLegacy::getInstance('logs');
    }


    
 public function log()
    {
     $base = JFactory::getUri()->base();
        $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('logs');
        $view->display();
    }


    
public function logs_json_list()
    {
    $list = file(JPATH_LOGFILE, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        $arreglado = array();
        //$buffer= array();

        for($i=count($list)-1;$i>6;$i--){

            $buffer = explode("\t",$list[$i]);
            $arreglado[$i]->datetime=$buffer[0];
            $arreglado[$i]->priority=$buffer[1];
            $arreglado[$i]->category=$buffer[2];
            $arreglado[$i]->message=$buffer[3];
        }

            echo json_encode($arreglado);
        
        JFactory::getApplication()->close();
    }

       


}
