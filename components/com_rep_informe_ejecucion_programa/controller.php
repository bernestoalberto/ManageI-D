<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class rep_informe_ejecucion_programaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_rep_informe_ejecucion_programa';
	public $repinformeejecucionprogramamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->repinformeejecucionprogramamodel=JModelLegacy::getInstance('rep_informe_ejecucion_programa');
    }


    
 public function rep_informe_ejecucion_programa()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_rep_informe_ejecucion_programa.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('rep_informe_ejecucion_programa');
        $view->display();
    }

        public function rep_informe_ejecucion_programa_ejecutora_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_evaluacion/models/');
            $evaluacionmodel =JModelLegacy::getInstance('evaluacion');
            $list=$this->repinformeejecucionprogramamodel->loadAll('*');
            if($list!=false){
                for($i=0;$i< count($list);$i++){

                    $list[$i]->jefe_programa = $list[$i]->nombrejefe. $list[$i]->apellidojefe;
                    $list[$i]->secretario_programa = $list[$i]->secrenombre. $list[$i]->secreapellido;
                     $eval1=$evaluacionmodel->loadEvaluacion($list[$i]->evaluacion_objetivos);
                    $list[$i]->evaluacion_objetivos =$eval1->evaluacion;
                    $eval2=$evaluacionmodel->loadEvaluacion($list[$i]->evaluacion_resultados);
                    $list[$i]->evaluacion_resultados =$eval2->evaluacion;
                    $eval3=$evaluacionmodel->loadEvaluacion($list[$i]->evaluacion_actividades);
                    $list[$i]->evaluacion_actividades =$eval3->evaluacion;

                }

            }

            echo json_encode($list);

            JFactory::getApplication()->close();
        }


}
