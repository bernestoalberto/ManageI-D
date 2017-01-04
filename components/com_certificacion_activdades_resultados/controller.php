<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');

class Certificacion_activdades_resultadosController extends JControllerLegacy
{


    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_certificacion_activdades_resultados';
    public $certificacion_activdades_resultadosmodel;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->certificacion_activdades_resultadosmodel=JModelLegacy::getInstance('certificacion_activdades_resultados');
    }



    public function certificacion_activdades_resultados()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=> $base.'components/com_control_ejecucion_presupuesto/assets/js/kendo_control_ejecucion_presupuesto.js',
            '3'=> $base.'components/com_informe_etapa/assets/js/kendo_informe_etapa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('certificacion_activdades_resultados');
        $view->display();
    }



    public function certificacion_activdades_resultados_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        $this->certificacion_activdades_resultadosmodel=JModelLegacy::getInstance('certificacion_activdades_resultados');
        $list=$this->certificacion_activdades_resultadosmodel->loadAll('*');
        if($list!=false){
            $progrmamodel = JModelLegacy::getInstance('programa');
            $profileproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
            $evaluacionmodel = JModelLegacy::getInstance('evaluacion');
            $anticipomodel = JModelLegacy::getInstance('anticipo');

            for($i=0;$i<count($list);$i++){
                $programa = (object)$progrmamodel->loadPrograma($list[$i]->id_programa);
                $list[$i]->programa =$programa->nombre;
                $proyecto = (object)$profileproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                $list[$i]->proyecto =$proyecto->titulo_proyecto;
                $evaluacion = (object)$evaluacionmodel->loadEvaluacion($list[$i]->id_evaluacion);
                $list[$i]->evaluacion =$evaluacion->evaluacion;
                $anticipo = (object)$anticipomodel->loadAnticipo($list[$i]->id_anticipo);
                $list[$i]->cantidad_anticipa =$anticipo->cantidad_anticipa;

                if($list[$i]->a_r_dos ==null){
                    $list[$i]->a_r_dos="No tiene otras actividades y resultados";
                    $list[$i]->cumplimiento_dos="---";

                }
                if($list[$i]->a_r_tres ==null){
                    $list[$i]->a_r_tres="No tiene otras actividades y resultados";
                    $list[$i]->cumplimiento_tres="---";

                }



            }

            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }



    public function certificacion_activdades_resultados_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anticipo/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');


        $certificacion_activdades_resultados = $this->input->post->get('certificacion_activdades_resultados', array(), 'array');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $anticipomodel = JModelLegacy::getInstance('anticipo');
        $this->certificacion_activdades_resultadosmodel=JModelLegacy::getInstance('certificacion_activdades_resultados');
        $evaluacionmodel = JModelLegacy::getInstance('evaluacion');
        $evaluacion = (object)$evaluacionmodel->loadEvaluacion($certificacion_activdades_resultados['id_evaluacion']);
        $profile = (object)$perfilproyectomodel->loadPerfilProyecto($certificacion_activdades_resultados['id_proyecto']);
        $id_anticipo= (object)$anticipomodel->loadAnticipobyProyecto($certificacion_activdades_resultados['id_proyecto'],$certificacion_activdades_resultados['anno'],$certificacion_activdades_resultados['periodo_evaluacion_cert']);
        $certificacion_activdades_resultados['id_anticipo']=$id_anticipo->id_anticipo;
        $certificacion_activdades_resultados['id_programa'] = $profile->id_programa;
        if($certificacion_activdades_resultados['a_r_dos']==null)
            $certificacion_activdades_resultados['cumplimiento_dos']="";
        if($certificacion_activdades_resultados['a_r_tres']==null)
            $certificacion_activdades_resultados['cumplimiento_tres']="";

        $this->certificacion_activdades_resultadosmodel->bind($certificacion_activdades_resultados);

        try {
            $this->certificacion_activdades_resultadosmodel->store();
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
                array('com_certificacion_activdades_resultados')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_certificacion_activdades_resultados');
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
        $programa = (object)$programamodel->loadPrograma($profile->id_programa);
        $secretario_programa=(object)$personamodel->loadPersona($programa->secretarioprograma);
        $JefeProyecto= (object)$personamodel->loadPersona($profile->id_persona);
        $ejecutor=(object) $entidadmodel->loadNombreEntidad($profile->id_entidad);

        $correoJefeProyecto = $JefeProyecto->correo;
        $correoSecretarioPrograma=$secretario_programa->correo;
        $nombrejefeproyecto=$JefeProyecto->nombre. $JefeProyecto->apellido;
        $concat=array();
        $concat['head']=' Mediante la presente le adjuntamos los datos necesarios para la continiuidad del proceso'.             '';
        $concat['anno']= $certificacion_activdades_resultados['anno'].'                           ';
        $concat['etapa']= $certificacion_activdades_resultados['periodo_evaluacion_cert'].'                           ';
        $concat['programa']= $programa->nombre.'                           ';
        $concat['proyecto']= $profile->titulo_proyecto.'                           ';
        $concat['actividades']= $certificacion_activdades_resultados['actividades_resultados'].'        ';
        $concat['cumplimiento']= $certificacion_activdades_resultados['cumplimiento'].'        ';
        $concat['a_r_dos']= $certificacion_activdades_resultados['a_r_dos'].'        ';
        $concat['cumplimiento_dos']= $certificacion_activdades_resultados['cumplimiento_dos'].'        ';
        $concat['a_r_tres']= $certificacion_activdades_resultados['a_r_tres'].'        ';
        $concat['cumplimiento_tres']= $certificacion_activdades_resultados['cumplimiento_tres'].'        ';
        $concat['a_r_tres']= $certificacion_activdades_resultados['a_r_tres'].'                           ';
        $concat['evaluacion']= $evaluacion->evaluacion.'       ';
        $concat['gastos']= $certificacion_activdades_resultados['gastos_incurridos'].'       ';
        $concat['observaciones']= $certificacion_activdades_resultados['observaciones'].'       ';
        $concat['presidente']= $certificacion_activdades_resultados['nombre_apellidos_presidente'].'       ';
        $concat['fecha_certifica_presidente']= $certificacion_activdades_resultados['fecha_certifica_presidente'].'       ';
        $concat['director']= $certificacion_activdades_resultados['nombre_apellidos_director'].'       ';
        $concat['fecha_certifica_director']= $certificacion_activdades_resultados['fecha_certifica_director'].'       ';



        $resultado=  file_put_contents(JPATH_CERTIFARFILES,$concat);
        $file = file_get_contents(JPATH_CERTIFARFILES);
        $nombre= "Modelo Certificacion Actividades y Resultados";
        if($resultado!=false){
            // enviar correo a jefe proyecto;
            $this->certificacion_activdades_resultadosmodel->SendEmailtoSecretarioPrograma($correoJefeProyecto,$nombrejefeproyecto,$correoSecretarioPrograma,$file,$nombre);
            $array=array('success'=>true);
            echo json_encode($array);
            JFactory::getApplication()->close();

        }

        else{
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_certificacion_activdades_resultados')
            );
            JLog::add("No se pudo enviar el correo al ejecutor".$ejecutor->nombre."",JLog::ERROR, 'com_certificacion_activdades_resultados');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }


    }



    public function certificacion_activdades_resultados_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $certificacion_activdades_resultados = $this->input->post->get('certificacion_activdades_resultados', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $certificacion_activdades_resultados['id_certificacion']=$olditem1->id_certificacion;
        $certificacion_activdades_resultados['id_proyecto']=$olditem1->id_proyecto ;

        $this->certificacion_activdades_resultadosmodel=JModelLegacy::getInstance('certificacion_activdades_resultados');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $profile = (object)$perfilproyectomodel->loadPerfilProyecto($certificacion_activdades_resultados['id_proyecto']);
        $certificacion_activdades_resultados['id_programa'] = $profile->id_programa;
        $this->certificacion_activdades_resultadosmodel->bind($certificacion_activdades_resultados);

        try {
            $this->certificacion_activdades_resultadosmodel->store();
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
                array('com_certificacion_activdades_resultados')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_certificacion_activdades_resultados');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function certificacion_activdades_resultados_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $certificacion_activdades_resultados =  json_decode($array['array']);
        $this->certificacion_activdades_resultadosmodel=JModelLegacy::getInstance('certificacion_activdades_resultados');
        foreach($certificacion_activdades_resultados as $p){
            $this->certificacion_activdades_resultadosmodel->bind($p);
            try {
                $this->certificacion_activdades_resultadosmodel->delete();
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
                    array('com_certificacion_activdades_resultados')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_certificacion_activdades_resultados');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);
                JFactory::getApplication()->close();

            } }

    }


}
