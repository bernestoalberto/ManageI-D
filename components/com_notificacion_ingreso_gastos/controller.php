<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

class Notificacion_ingreso_gastosController extends JControllerLegacy
{


    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_notificacion_ingreso_gastos';
    public $notificacion_ingreso_gastosmodel;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->notificacion_ingreso_gastosmodel=JModelLegacy::getInstance('notificacion_ingreso_gastos');
    }



    public function notificacion_ingreso_gastos()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_anticipo/assets/js/kendo_anticipo.js',
            '3'=> $base.'components/com_oponencia_informe_etapa/assets/js/kendo_oponencia_informe_etapa.js',
            '4'=> $base.'components/com_dictamen_grupo_expertos_inf_etapa/assets/js/kendo_dictamen_grupo_expertos_inf_etapa.js',
            '5'=> $base.'components/com_informe_ejecucion_programa/assets/js/kendo_informe_ejecucion_programa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('notificacion_ingreso_gastos');
        $view->display();
    }



    public function notificacion_ingreso_gastos_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        $this->notificacion_ingreso_gastosmodel=JModelLegacy::getInstance('notificacion_ingreso_gastos');
        $list=$this->notificacion_ingreso_gastosmodel->loadAll('*');
        if($list!=false){
            $programamodel=JModelLegacy::getInstance('programa');
            $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
            $anticipomodel=JModelLegacy::getInstance('anticipo');
            $evaluacionmodel=JModelLegacy::getInstance('evaluacion');
            $personamodel=JModelLegacy::getInstance('persona');
            for($i=0;$i<count($list);$i++){
                $proyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                $list[$i]->proyecto =$proyecto->titulo_proyecto;
                $programa = (Object)$programamodel->loadPrograma($proyecto->id_programa);
                $list[$i]->programa =$programa->nombre;
                $evaluacion = (Object)$evaluacionmodel->loadEvaluacion($list[$i]->id_evaluacion);
                $list[$i]->evaluacion =$evaluacion->evaluacion;
                $anticipo = (Object)$anticipomodel->loadAnticipo($list[$i]->id_anticipo);
                $list[$i]->cantidad_anticipa =$anticipo->cantidad_anticipa;
                $persona = (Object)$personamodel->loadPersona($programa->secretarioprograma);
                $list[$i]->secretario =$persona->nombre;
            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }



    public function notificacion_ingreso_gastos_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_financista/models');

        $notificacion_ingreso_gastos = $this->input->post->get('notificacion_ingreso_gastos', array(), 'array');
        $this->notificacion_ingreso_gastosmodel=JModelLegacy::getInstance('notificacion_ingreso_gastos');
        $programamodel=JModelLegacy::getInstance('programa');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $anticipomodel = JModelLegacy::getInstance('anticipo');
        $financistamodel=JModelLegacy::getInstance('financista');

        $profile = (Object)$perfilproyectomodel->loadPerfilProyecto($notificacion_ingreso_gastos['id_proyecto']);
        $evaluacionmodel = JModelLegacy::getInstance('evaluacion');
        $evaluacion = $evaluacionmodel->loadEvaluacion($notificacion_ingreso_gastos['id_evaluacion']);
        $programa= (Object)$programamodel->loadPrograma($profile->id_programa);
        $notificacion_ingreso_gastos['id_programa']=$profile->id_programa;
        $anticipo= (Object)$anticipomodel->loadAnticipobyProyecto($notificacion_ingreso_gastos['id_proyecto'],$notificacion_ingreso_gastos['anno'],$notificacion_ingreso_gastos['etapa']);
        $notificacion_ingreso_gastos['id_anticipo']=$anticipo->id_anticipo;

        $notificacion_ingreso_gastos['nombre_apellidos_secretario']=$programa->secretarioprograma;
        $this->notificacion_ingreso_gastosmodel->bind($notificacion_ingreso_gastos);
        try {
            $this->notificacion_ingreso_gastosmodel->store();
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
                array('com_notificacion_ingreso_gastos')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_notificacion_ingreso_gastos');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }
        $programamodel=JModelLegacy::getInstance('programa');
        $personamodel=JModelLegacy::getInstance('persona');
        $entidadmodel=JModelLegacy::getInstance('entidad');
        //Necesario para enviar correo a financista y ejecutor
        $programa = (Object)$programamodel->loadPrograma($profile->id_programa);
        $secretario_programa= (Object)$personamodel->loadPersona($programa->secretarioprograma);
        $JefeProyecto= (Object)$personamodel->loadPersona($profile->id_persona);
        $ejecutor= (Object)$entidadmodel->loadNombreEntidad($profile->id_entidad);
        $id_financista= (Object)$financistamodel->loadEntidadFinancista($notificacion_ingreso_gastos['id_proyecto']);
        $financista = (Object)$entidadmodel->loadEntidad($id_financista->id_entidad);
        $correoFinancista = $financista->correo;
        $correoJefeProyecto = $JefeProyecto->correo;
        $correoSecretarioPrograma=$secretario_programa->correo;
        $nombreSecretarioPrograma=$secretario_programa->nombre. $secretario_programa->apellido;

        $concat=array();
        $concat['head']=' Mediante la presente le adjuntamos los datos necesarios para la continiuidad del proceso'.             '';
        $concat['anno']= $notificacion_ingreso_gastos['anno'].'                           ';
        $concat['etapa']= $notificacion_ingreso_gastos['etapa'].'                           ';
        $concat['programa']= $programa->nombre.'                           ';
        $concat['proyecto']= $profile->titulo_proyecto.'                           ';
        $concat['ingreso']= $notificacion_ingreso_gastos['autorizo_registrar_ingreso'].'        ';
        $concat['gasto']= $notificacion_ingreso_gastos['autorizo_registrar_gasto'].'        ';'                           ';
        $concat['evaluacion']= $evaluacion->evaluacion.'       ';
        $concat['fecha']= $notificacion_ingreso_gastos['fecha'].'                                                 ';
        $concat['anticipo']= $anticipo->cantidad_anticipa.'                                                  ';




        $resultado=  file_put_contents(JPATH_NOTIF,$concat);
        $file = file_get_contents(JPATH_NOTIF);
        $nombre= "Modelo de Notificacion de Ingresos y Gastos";

        if($resultado!=false){
            // enviar correo a jefe proyecto;
            $this->notificacion_ingreso_gastosmodel->SendEmailtoProjectSenior($correoJefeProyecto,$correoSecretarioPrograma,$nombreSecretarioPrograma,$file,$nombre);
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_notificacion_ingreso_gastos')
            );
            JLog::add("Se pudo enviar el correo  al financista".$financista->nombre."",JLog::ALERT, 'com_notificacion_ingreso_gastos');
            /*   $response= new stdClass();
               $response->success=true;
               $response->message='Se pudo enviar el correo  al financista';
               echo json_encode($response);*/

            if($correoFinancista!=null) {
                $this->notificacion_ingreso_gastosmodel->SendEmailtoFinancista($correoFinancista, $correoSecretarioPrograma, $nombreSecretarioPrograma, $file, $nombre);

            }
            else{
                JLog::addLogger(
                    array(
                        // Sets file name
                        'text_file' => 'logs.php'
                    ),
                    // Sets messages of all log levels to be sent to the file
                    JLog::ALL,
                    array('com_notificacion_ingreso_gastos')
                );
                JLog::add("No se pudo enviar el correo  al financista".$financista->nombre."",JLog::ERROR, 'com_notificacion_ingreso_gastos');

            }

        }

        else{
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_notificacion_ingreso_gastos')
            );
            JLog::add("No se pudo enviar el correo al ejecutor".$ejecutor->nombre."y al financista".$financista->nombre."",JLog::ERROR, 'com_notificacion_ingreso_gastos');

        }




    }



    public function notificacion_ingreso_gastos_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        header('Content-Type: application/json');
        $notificacion_ingreso_gastos = $this->input->post->get('notificacion_ingreso_gastos', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $notificacion_ingreso_gastos['id_notif_ingresos_gastos ']=$olditem1->id_notif_ingresos_gastos ;
        $this->notificacion_ingreso_gastosmodel=JModelLegacy::getInstance('notificacion_ingreso_gastos');
        $programamodel=JModelLegacy::getInstance('programa');
        $anticipomodel = JModelLegacy::getInstance('anticipo');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $profile = $perfilproyectomodel->loadPerfilProyecto($notificacion_ingreso_gastos['id_proyecto']);
        $programa= $programamodel->loadPrograma($profile->id_programa);
        $notificacion_ingreso_gastos['id_programa']=$profile->id_programa;
        $notificacion_ingreso_gastos['nombre_apellidos_secretario']=$programa->secretarioprograma;
        $anticipo= $anticipomodel->loadAnticipobyProyecto($notificacion_ingreso_gastos['id_proyecto'],$notificacion_ingreso_gastos['anno'],$notificacion_ingreso_gastos['etapa']);
        $notificacion_ingreso_gastos['id_anticipo']=$anticipo->id_anticipo;


        $this->notificacion_ingreso_gastosmodel->bind($notificacion_ingreso_gastos);

        try {
            $this->notificacion_ingreso_gastosmodel->store();
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
                array('com_notificacion_ingreso_gastos')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_notificacion_ingreso_gastos');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function notificacion_ingreso_gastos_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $notificacion_ingreso_gastos =  json_decode($array['array']);
        $this->notificacion_ingreso_gastosmodel=JModelLegacy::getInstance('notificacion_ingreso_gastos');
        header('Content-Type: application/json');
        foreach($notificacion_ingreso_gastos as $p){
            $this->notificacion_ingreso_gastosmodel->bind($p);
            try {
                $this->notificacion_ingreso_gastosmodel->delete();
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
                    array('com_notificacion_ingreso_gastos')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_notificacion_ingreso_gastos');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);
                JFactory::getApplication()->close();
            }
        }

    }


}
