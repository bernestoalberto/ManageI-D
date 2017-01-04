<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

class Control_ejecucion_presupuestoController extends JControllerLegacy
{


    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_control_ejecucion_presupuesto';
    public $control_ejecucion_presupuestomodel;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->control_ejecucion_presupuestomodel=JModelLegacy::getInstance('control_ejecucion_presupuesto');
    }



    public function control_ejecucion_presupuesto()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_certificacion_activdades_resultados/assets/js/kendo_certificacion_activdades_resultados.js',
            '3'=>$base.'components/com_notificacion_ingreso_gastos/assets/js/kendo_notificacion_ingreso_gastos.js',
            '4'=> $base.'components/com_anticipo/assets/js/kendo_anticipo.js',
            '5'=> $base.'components/com_informe_etapa/assets/js/kendo_informe_etapa.js',
            '6'=> $base.'components/com_oponencia_informe_etapa/assets/js/kendo_oponencia_informe_etapa.js',
            '7'=> $base.'components/com_dictamen_grupo_expertos_inf_etapa/assets/js/kendo_dictamen_grupo_expertos_inf_etapa.js',
            '8'=> $base.'components/com_informe_ejecucion_programa/assets/js/kendo_informe_ejecucion_programa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('control_ejecucion_presupuesto');
        $view->display();
    }



    public function control_ejecucion_presupuesto_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_financista/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_notificacion_ingreso_gastos');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_certificacion_activdades_resultados/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');

        $this->control_ejecucion_presupuestomodel=JModelLegacy::getInstance('control_ejecucion_presupuesto');


        $list=$this->control_ejecucion_presupuestomodel->loadAll('*');
        if($list!=false){
            $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
            $proyectomodel = JModelLegacy::getInstance('proyecto');
            $programamodel = JModelLegacy::getInstance('programa');
            $anticipomodel = JModelLegacy::getInstance('anticipo');
            $notificacionmodel = JModelLegacy::getInstance('notificacion_ingreso_gastos');
            $certificacionmodel = JModelLegacy::getInstance('certificacion_activdades_resultados');
            $financistamodel = JModelLegacy::getInstance('financista');
            $evaluacionmodel=JModelLegacy::getInstance('evaluacion');

            for($i=0;$i<count($list);$i++){

                $perfilproyecto = (object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                $list[$i]->proyecto =$perfilproyecto->titulo_proyecto;
                $proyecto = (object)$proyectomodel->loadProyecto($list[$i]->id_proyecto);
                $list[$i]->codigo =$proyecto->numero;
                $financiamiento = (object)$financistamodel->loadFinancista($list[$i]->id_proyecto);
                $list[$i]->financiamiento_planificado=$financiamiento->cifra_planificada;
                $programa = (object)$programamodel->loadPrograma($perfilproyecto->id_programa);
                $list[$i]->programa =$programa->nombre;
                $anticipo = (object)$anticipomodel->loadAnticipo($list[$i]->id_anticipo);
                $list[$i]->cantidad_anticipa =$anticipo->cantidad_anticipa;
                $list[$i]->etapa =$anticipo->etapa;
                $cert = (object)$certificacionmodel->loadCertificado($list[$i]->id_certificacion);
                $evaluacion =(object)$evaluacionmodel->loadEvaluacion($cert->id_evaluacion);
                $list[$i]->calificacion =$evaluacion->evaluacion;
                $notify =$notificacionmodel->loadNotify($list[$i]->id_notif_ingresos_gastos);
                $list[$i]->ingreso =$notify->autorizo_registrar_ingreso;
                $list[$i]->gastos =$notify->autorizo_registrar_gasto;
                $list[$i]->saldo =$anticipo->cantidad_anticipa+$notify->autorizo_registrar_ingreso-$notify->autorizo_registrar_gasto;

            }
            echo json_encode($list);
            JFactory::getApplication()->close();

        }
        echo json_encode($list);
        JFactory::getApplication()->close();

    }



    public function control_ejecucion_presupuesto_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_notificacion_ingreso_gastos');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_certificacion_activdades_resultados/models');

        $proyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $anticipomodel = JModelLegacy::getInstance('anticipo');
        $notificacioningresogastosmodel = JModelLegacy::getInstance('notificacion_ingreso_gastos');
        $certificacionactivdadesresultadosmodel = JModelLegacy::getInstance('certificacion_activdades_resultados');
        $this->control_ejecucion_presupuestomodel=JModelLegacy::getInstance('control_ejecucion_presupuesto');

        $control_ejecucion_presupuesto = $this->input->post->get('control_ejecucion_presupuesto', array(), 'array');

        $proyecto =(object) $proyectomodel->loadPerfilProyecto($control_ejecucion_presupuesto['id_proyecto']);
        $id=$proyecto->id_proyecto;
        $anno = $control_ejecucion_presupuesto['anno'];
        $etapa = $control_ejecucion_presupuesto['etapa'];
        $control_ejecucion_presupuesto['id_programa']=$proyecto->id_programa;
        $certify =(object)$certificacionactivdadesresultadosmodel->loadCertifybyProyecto($id,$anno,$etapa);
        $control_ejecucion_presupuesto['id_certificacion']=$certify->id_certificacion;
        $anticipo =(object) $anticipomodel->loadAnticipobyProyecto($control_ejecucion_presupuesto['id_proyecto'],$control_ejecucion_presupuesto['anno'],$control_ejecucion_presupuesto['etapa']);
        $control_ejecucion_presupuesto['id_anticipo']=$anticipo->id_anticipo;
        $notify = $notificacioningresogastosmodel->loadNotificationbyProyecto($control_ejecucion_presupuesto['id_proyecto'],$control_ejecucion_presupuesto['anno'],$control_ejecucion_presupuesto['etapa']);
        $control_ejecucion_presupuesto['id_notif_ingresos_gastos']=$notify->id_notif_ingresos_gastos;



        $this->control_ejecucion_presupuestomodel->bind($control_ejecucion_presupuesto);

        try {
            $this->control_ejecucion_presupuestomodel->store();
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
                array('com_control_ejecucion_presupuesto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_control_ejecucion_presupuesto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function control_ejecucion_presupuesto_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_notificacion_ingreso_gastos');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_certificacion_activdades_resultados/models');

        $proyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $anticipomodel = JModelLegacy::getInstance('anticipo');
        $notificacioningresogastosmodel = JModelLegacy::getInstance('notificacion_ingreso_gastos');
        $certificacionactivdadesresultadosmodel = JModelLegacy::getInstance('certificacion_activdades_resultados');


        $this->control_ejecucion_presupuestomodel=JModelLegacy::getInstance('control_ejecucion_presupuesto');

        $control_ejecucion_presupuesto = $this->input->post->get('control_ejecucion_presupuesto', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $control_ejecucion_presupuesto['id_control_ejecucion_presupuesto']=$olditem1->id_control_ejecucion_presupuesto ;
        $control_ejecucion_presupuesto['id_proyecto']=$olditem1->id_proyecto ;

        $proyecto = $proyectomodel->loadPerfilProyecto($control_ejecucion_presupuesto['id_proyecto']);
        $id=$proyecto->id_proyecto;
        $anno = $control_ejecucion_presupuesto['anno'];
        $etapa = $control_ejecucion_presupuesto['etapa'];
        $control_ejecucion_presupuesto['id_programa']=$proyecto->id_programa;
        $certify =$certificacionactivdadesresultadosmodel->loadCertifybyProyecto($id,$anno,$etapa);
        $control_ejecucion_presupuesto['id_certificacion']=$certify->id_certificacion;
        $anticipo = $anticipomodel->loadAnticipobyProyecto($control_ejecucion_presupuesto['id_proyecto'],$control_ejecucion_presupuesto['anno'],$control_ejecucion_presupuesto['etapa']);
        $control_ejecucion_presupuesto['id_anticipo']=$anticipo->id_anticipo;
        $notify = $notificacioningresogastosmodel->loadNotificationbyProyecto($control_ejecucion_presupuesto['id_proyecto'],$control_ejecucion_presupuesto['anno'],$control_ejecucion_presupuesto['etapa']);
        $control_ejecucion_presupuesto['id_notif_ingresos_gastos']=$notify->id_notif_ingresos_gastos;



        $this->control_ejecucion_presupuestomodel->bind($control_ejecucion_presupuesto);

        try {
            $this->control_ejecucion_presupuestomodel->store();
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
                array('com_control_ejecucion_presupuesto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_control_ejecucion_presupuesto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function control_ejecucion_presupuesto_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $control_ejecucion_presupuesto =  json_decode($array['array']);
        $this->control_ejecucion_presupuestomodel=JModelLegacy::getInstance('control_ejecucion_presupuesto');
        foreach($control_ejecucion_presupuesto as $p){
            $this->control_ejecucion_presupuestomodel->bind($p);
            try {
                $this->control_ejecucion_presupuestomodel->delete();
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
                    array('com_control_ejecucion_presupuesto')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_control_ejecucion_presupuesto');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);
                JFactory::getApplication()->close();
            } }

    }


}
