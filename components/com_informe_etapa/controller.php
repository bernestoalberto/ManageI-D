<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');
class Informe_etapaController extends JControllerLegacy
{
    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_informe_etapa';
    public $informe_etapamodel;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->informe_etapamodel=JModelLegacy::getInstance('informe_etapa');
    }



    public function informe_etapa()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_certificacion_activdades_resultados/assets/js/kendo_certificacion_activdades_resultados.js',
            '3'=>$base.'components/com_notificacion_ingreso_gastos/assets/js/kendo_notificacion_ingreso_gastos.js',
            '4'=> $base.'components/com_control_ejecucion_presupuesto/assets/js/kendo_control_ejecucion_presupuesto.js',
            '5'=> $base.'components/com_anticipo/assets/js/kendo_anticipo.js',
            '6'=> $base.'components/com_oponencia_informe_etapa/assets/js/kendo_oponencia_informe_etapa.js',
            '7'=> $base.'components/com_dictamen_grupo_expertos_inf_etapa/assets/js/kendo_dictamen_grupo_expertos_inf_etapa.js',
            '8'=> $base.'components/com_informe_ejecucion_programa/assets/js/kendo_informe_ejecucion_programa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('informe_etapa');
        $view->display();
    }



    public function informe_etapa_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        $this->informe_etapamodel=JModelLegacy::getInstance('informe_etapa');
        $list=$this->informe_etapamodel->loadAll('*');
        if($list!=false) {

            $proyectomodel = JModelLegacy::getInstance('proyecto');
            $personamodel = JModelLegacy::getInstance('persona');
            $programamodel = JModelLegacy::getInstance('programa');
            $entidadmodel = JModelLegacy::getInstance('entidad');
            for ($i = 0; $i < count($list); $i++) {
                $profile = (object)$proyectomodel->loadProyecto($list[$i]->id_proyecto);
                $list[$i]->proyecto = $profile->nombre_proyecto;
                $entidad = (object)$entidadmodel->loadNombreEntidad($list[$i]->id_entidad);
                $list[$i]->entidad = $entidad->nombre;
                $list[$i]->numero= $profile->numero;
                $programa = (object)$programamodel->loadPrograma($list[$i]->id_programa);
                $list[$i]->programa = $programa->nombre;
                $persona = (object)$personamodel->loadPersona($list[$i]->id_persona);
                $list[$i]->jefe_proyecto=$persona->nombre;


            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }   public function informe_etapa_combo_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        $this->informe_etapamodel=JModelLegacy::getInstance('informe_etapa');
        $list=$this->informe_etapamodel->loadAll('*');
        if($list!=false) {

            $proyectomodel = JModelLegacy::getInstance('proyecto');
            $personamodel = JModelLegacy::getInstance('persona');
            $programamodel = JModelLegacy::getInstance('programa');
            $entidadmodel = JModelLegacy::getInstance('entidad');
            for ($i = 0; $i < count($list); $i++) {
                $profile = (object)$proyectomodel->loadProyecto($list[$i]->id_proyecto);
                $list[$i]->proyecto = $profile->nombre_proyecto;
                $entidad = (object)$entidadmodel->loadNombreEntidad($list[$i]->id_entidad);
                $list[$i]->entidad = $entidad->nombre;
                $list[$i]->numero= $profile->numero;
                $programa = (object)$programamodel->loadPrograma($list[$i]->id_programa);
                $list[$i]->programa = $programa->nombre;
                $persona = (object)$personamodel->loadPersona($list[$i]->id_persona);
                $list[$i]->jefe_proyecto=$persona->nombre;


            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }



    public function informe_etapa_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');

        $informe_etapa = $this->input->post->get('informe_etapa', array(), 'array');
        $this->informe_etapamodel=JModelLegacy::getInstance('informe_etapa');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $profile = (object)$perfilproyectomodel->loadPerfilProyecto($informe_etapa['id_proyecto']);
        $informe_etapa['id_programa'] =$profile->id_programa;
        $informe_etapa['id_entidad'] =$profile->id_entidad;
        $informe_etapa['id_persona'] =$profile->id_persona;


        $this->informe_etapamodel->bind($informe_etapa);
        try {
            $this->informe_etapamodel->store();
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
                array('com_informe_etapa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_informe_etapa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

        $personamodel=JModelLegacy::getInstance('persona');
        $entidadmodel=JModelLegacy::getInstance('entidad');
        $programamodel=JModelLegacy::getInstance('programa');

        $programa = (object)$programamodel->loadPrograma($profile->id_programa);
        $secretario_programa= (object)$personamodel->loadPersona($programa->secretarioprograma);
        $JefeProyecto= (object)$personamodel->loadPersona($profile->id_persona);
        $ejecutor= (object)$entidadmodel->loadNombreEntidad($profile->id_entidad);


        $correoJefeProyecto = $JefeProyecto->correo;
        $nombrejefeproyecto = $JefeProyecto->nombre. $JefeProyecto->apelido;
        $correoSecretarioPrograma=$secretario_programa->correo;


        $concat=array();
        $concat['head']=' Mediante la presente le adjuntamos los datos necesarios para la continiuidad del proceso'.                     '';
        $concat['anno']= $informe_etapa['anno'].'                           ';
        $concat['etapa']= $informe_etapa['etapa'].'                           ';
        $concat['programa']= $programa->nombre.'                           ';
        $concat['proyecto']= $profile->titulo_proyecto.'                           ';
        $concat['actividades']= $informe_etapa['cumplimiento_cronograma_actividades'].'                           ';
        $concat['programados']= $informe_etapa['cumplimiento_resultados_programados'].'                           ';
        $concat['jefe_proyecto']= $nombrejefeproyecto.'                           ';
        $resultado=  file_put_contents(JPATH_INFETAPA,$concat);
        $file = file_get_contents(JPATH_INFETAPA);
        $nombre= "Informe Etapa Proyecto";
        if($resultado!=false){
            // enviar correo a jefe proyecto;
            $this->informe_etapamodel->SendEmailtoSecretarioPrograma($correoJefeProyecto,$nombrejefeproyecto,$correoSecretarioPrograma,$file,$nombre);
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_informe_etapa')
            );
            JLog::add("Se pudo enviar el correo al ejecutor".$ejecutor->nombre,JLog::INFO, 'com_informe_etapa');

        }


        else{
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_informe_etapa')
            );
            JLog::add("No se pudo enviar el correo al ejecutor".$ejecutor->nombre,JLog::ERROR, 'com_informe_etapa');

        }


    }



    public function informe_etapa_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $informe_etapa = $this->input->post->get('informe_etapa', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $informe_etapa['id_informe_etapa']=$olditem1->id_informe_etapa ;
        $informe_etapa['id_proyecto']=$olditem1->id_proyecto ;
        $this->informe_etapamodel=JModelLegacy::getInstance('informe_etapa');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $profile = $perfilproyectomodel->loadPerfilProyecto($informe_etapa['id_proyecto']);
        $informe_etapa['id_programa'] =$profile->id_programa;
        $informe_etapa['id_entidad'] =$profile->id_entidad;
        $informe_etapa['id_persona'] =$profile->id_persona;
        $this->informe_etapamodel->bind($informe_etapa);

        try {
            $this->informe_etapamodel->store();
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
                array('com_informe_etapa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_informe_etapa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function informe_etapa_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $informe_etapa =  json_decode($array['array']);
        $this->informe_etapamodel=JModelLegacy::getInstance('informe_etapa');
        foreach($informe_etapa as $p){
            $this->informe_etapamodel->bind($p);
            try {
                $this->informe_etapamodel->delete();
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
                    array('com_informe_etapa')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_informe_etapa');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento  no es posible su modificación';
                echo json_encode($response);
                JFactory::getApplication()->close();
            } }

    }


}
