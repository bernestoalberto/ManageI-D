<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class certificn_actvs_resultdsController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_certificn_actvs_resultds';
	public $certificn_actvs_resultdsmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->certificn_actvs_resultdsmodel=JModelLegacy::getInstance('certificn_actvs_resultds');
    }


    
 public function certificacion()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_certificacion.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('certificn_actvs_resultds');
        $view->display();
    }

        public function certificacion_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

            $list=$this->certificn_actvs_resultdsmodel->loadAll('*');
            if($list!=false){
                for($i=0;$i< count($list);$i++){

                    if($list[$i]->a_r_dos==null)
                        $list[$i]->a_r_dos='---';
                    if($list[$i]->cumplimiento_dos==null)
                        $list[$i]->cumplimiento_dos='---';
                    if($list[$i]->cumplimiento_tres==null)
                        $list[$i]->cumplimiento_tres='---';
                    if($list[$i]->a_r_tres==null)
                        $list[$i]->a_r_tres='---';

                    $list[$i]->jefe_proyecto =  $list[$i]->nombre. $list[$i]->apellido;
                }

            }

            echo json_encode($list);

            JFactory::getApplication()->close();
        }

}
