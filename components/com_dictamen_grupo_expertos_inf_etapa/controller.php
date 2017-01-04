<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

class Dictamen_grupo_expertos_inf_etapaController extends JControllerLegacy
{


    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_dictamen_grupo_expertos_inf_etapa';
    public $dictamen_grupo_expertos_inf_etapamodel;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->dictamen_grupo_expertos_inf_etapamodel=JModelLegacy::getInstance('dictamen_grupo_expertos_inf_etapa');
    }



    public function dictamen_grupo_expertos_inf_etapa()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_notificacion_ingreso_gastos/assets/js/kendo_notificacion_ingreso_gastos.js',
            '3'=> $base.'components/com_oponencia_informe_etapa/assets/js/kendo_oponencia_informe_etapa.js',
            '4'=> $base.'components/com_anticipo/assets/js/kendo_anticipo.js',
            '5'=> $base.'components/com_informe_ejecucion_programa/assets/js/kendo_informe_ejecucion_programa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('dictamen_grupo_expertos_inf_etapa');
        $view->display();
    }



    public function dictamen_grupo_expertos_inf_etapa_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_informe_etapa/models');
        $this->dictamen_grupo_expertos_inf_etapamodel=JModelLegacy::getInstance('dictamen_grupo_expertos_inf_etapa');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_notificacion_ingreso_gastos/models');
        $list=$this->dictamen_grupo_expertos_inf_etapamodel->loadAll('*');
        if($list!=false){
            $informeetapamodel = JModelLegacy::getInstance('informe_etapa');
            $proyectomodel=JModelLegacy::getInstance('proyecto');
            $programamodel=JModelLegacy::getInstance('programa');
            $entidadmodel=JModelLegacy::getInstance('entidad');
            $evaluacionmodel=JModelLegacy::getInstance('evaluacion');
            $antcipomodel=JModelLegacy::getInstance('anticipo');
            $notificacioningresogastosmodel=JModelLegacy::getInstance('notificacion_ingreso_gastos');
            for ($i =0; $i < count($list); $i++) {
                $informe=(object)$informeetapamodel->loadInforme($list[$i]->id_informe_etapa);
                $list[$i]->etapa =$informe->etapa;
                /* $list[$i]->anno =$informe->anno;*/
                $programa = (object)$programamodel->loadPrograma($informe->id_programa);
                $list[$i]->programa = $programa->nombre;
                $profile = (object)$proyectomodel->loadProyecto($informe->id_proyecto);
                $list[$i]->proyecto = $profile->nombre_proyecto;
                $list[$i]->codigo= $profile->numero;
                $entidad = (object)$entidadmodel->loadNombreEntidad($informe->id_entidad);
                $list[$i]->entidad = $entidad->nombre;
                $eval1=(object)$evaluacionmodel->loadEvaluacion($list[$i]->evaluacion_objetivos);
                $list[$i]->evaluacion_objetivos=$eval1->evaluacion;
                $eval2=(object)$evaluacionmodel->loadEvaluacion($list[$i]->evaluacion_resultados);
                $list[$i]->evaluacion_resultados=$eval2->evaluacion;
                $eval3=(object)$evaluacionmodel->loadEvaluacion($list[$i]->evaluacion_actividades);
                $list[$i]->evaluacion_actividades=$eval3->evaluacion;
                $antcipo= (object)$antcipomodel->loadAnticipobyProyecto($informe->id_proyecto,$informe->anno,$informe->etapa);
                $list[$i]->anticipo = $antcipo->cantidad_anticipa;
                $notificacion=(object)$notificacioningresogastosmodel->loadNotificationbyProyecto($informe->id_proyecto,$informe->anno,$informe->etapa);
                $list[$i]->gastos = $notificacion->autorizo_registrar_gasto;

            }
            echo json_encode($list);

        }
        JFactory::getApplication()->close();
    }



    public function dictamen_grupo_expertos_inf_etapa_add()
    {

        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $dictamen_grupo_expertos_inf_etapa = $this->input->post->get('dictamen_grupo_expertos_inf_etapa', array(), 'array');
        $this->dictamen_grupo_expertos_inf_etapamodel=JModelLegacy::getInstance('dictamen_grupo_expertos_inf_etapa');
        $this->dictamen_grupo_expertos_inf_etapamodel->bind($dictamen_grupo_expertos_inf_etapa);
        try {
            $this->dictamen_grupo_expertos_inf_etapamodel->store();
            $array=array('success'=>true);
            echo json_encode($array);
            JFactory::getApplication()->close();
        }
        catch(Exception $e)
        {
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_dictamen_grupo_expertos_inf_etapa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_dictamen_grupo_expertos_inf_etapa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function dictamen_grupo_expertos_inf_etapa_update()
    {

        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $dictamen_grupo_expertos_inf_etapa = $this->input->post->get('dictamen_grupo_expertos_inf_etapa', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $dictamen_grupo_expertos_inf_etapa['id_dictamen_grup_exp']=$olditem1->id_dictamen_grup_exp ;
        $dictamen_grupo_expertos_inf_etapa['id_informe_etapa']=$olditem1->id_informe_etapa ;
        $this->dictamen_grupo_expertos_inf_etapamodel=JModelLegacy::getInstance('dictamen_grupo_expertos_inf_etapa');
        $this->dictamen_grupo_expertos_inf_etapamodel->bind($dictamen_grupo_expertos_inf_etapa);

        try {
            $this->dictamen_grupo_expertos_inf_etapamodel->store();
            $array=array('success'=>true);
            echo json_encode($array);
            JFactory::getApplication()->close();
        }
        catch(SQLiteException $e)
        {
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_dictamen_grupo_expertos_inf_etapa ')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_dictamen_grupo_expertos_inf_etapa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function dictamen_grupo_expertos_inf_etapa_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        header('Content-Type: application/json');
        $dictamen_grupo_expertos_inf_etapa =  json_decode($array['array']);
        $this->dictamen_grupo_expertos_inf_etapamodel=JModelLegacy::getInstance('dictamen_grupo_expertos_inf_etapa');
        foreach($dictamen_grupo_expertos_inf_etapa as $p){
            $this->dictamen_grupo_expertos_inf_etapamodel->bind($p);
            try {
                $this->dictamen_grupo_expertos_inf_etapamodel->delete();
                $array=array('success'=>true);
                echo json_encode($array);
                JFactory::getApplication()->close();
            }
            catch(Exception $e)
            {
                JLog::addLogger(
                    array(
                        // Sets file name
                        'text_file' => 'logs.php'
                    ),
                    // Sets messages of all log levels to be sent to the file
                    JLog::ALL,
                    array('com_dictamen_grupo_expertos_inf_etapa')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_dictamen_grupo_expertos_inf_etapa');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);
                JFactory::getApplication()->close();
            } }

    }


}
