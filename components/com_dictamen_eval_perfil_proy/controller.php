<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');
    class Dictamen_eval_perfil_proyController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_dictamen_eval_perfil_proy';
	public $dictamen_eval_perfil_proymodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->dictamen_eval_perfil_proymodel=JModelLegacy::getInstance('dictamen_eval_perfil_proy');
    }


    
 public function dictamen_eval_perfil_proy()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('dictamen_eval_perfil_proy');
        $view->display();
    }


    
public function dictamen_eval_perfil_proy_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');

        $this->dictamen_eval_perfil_proymodel=JModelLegacy::getInstance('dictamen_eval_perfil_proy');
        $programamodel=JModelLegacy::getInstance('programa');
        $personamodel=JModelLegacy::getInstance('persona');
        $proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $evaluacionmodel=JModelLegacy::getInstance('evaluacion');
        $list=$this->dictamen_eval_perfil_proymodel->loadAll('*');
        if($list!=false){
        for($i=0;$i< count($list);$i++){
            $proyecto=null;
            $id=$list[$i]->id_proyecto;
            $proyecto = (object)$proyectomodel->loadProyecto($id);
            $evaluacion = (object)$evaluacionmodel->loadEvaluacion($list[$i]->id_evaluacion);
            if($proyecto->id_programa>0) {
                $programa = (object)$programamodel->loadPrograma($proyecto->id_programa);
                $persona = (object)$personamodel->loadPersona($programa->id_persona);
            }
            $list[$i]->JefePrograma = $persona->nombre;
            $list[$i]->titulo_proyecto = $proyecto->titulo_proyecto;
            $list[$i]->evaluacion = $evaluacion->evaluacion;

        }

        echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }



    
public function dictamen_eval_perfil_proy_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
       JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_evaluacion/models');

        $dictamen_eval_perfil_proy = $this->input->post->get('dictamen_eval_perfil_proy', array(), 'array');
        $date =JFactory::getDate()->toSql( $dictamen_eval_perfil_proy['fecha_evaluacion']);
        $dictamen_eval_perfil_proy['fecha_evaluacion']=$date;
        $this->dictamen_eval_perfil_proymodel=JModelLegacy::getInstance('dictamen_eval_perfil_proy');
        $perfilproyectoamodel=JModelLegacy::getInstance('perfil_proyecto');
        $personamodel=JModelLegacy::getInstance('persona');
        $programamodel=JModelLegacy::getInstance('programa');
        $evaluacionmodel=JModelLegacy::getInstance('evaluacion');




        $idjproyecto =$dictamen_eval_perfil_proy['id_proyecto'];
        $idjprograma =$dictamen_eval_perfil_proy['id_persona'];
        $idevaluacion = $dictamen_eval_perfil_proy['id_evaluacion'];
        $eval=$evaluacionmodel->loadEvaluacion($idevaluacion);
        $perfilproyecto = (object) $perfilproyectoamodel->loadPerfilProyecto($idjproyecto) ;
        $nombreperfil= $perfilproyecto->titulo_proyecto;
        if($perfilproyecto->id_programa>0){
        $programa= (object)$programamodel->loadPrograma($perfilproyecto->id_programa);
        $JefePrograma= (object)$personamodel->loadPersona($programa->id_persona);
        }
        $JefeProyecto= (object)$personamodel->loadPersona($perfilproyecto->id_persona);
        $dictamen_eval_perfil_proy['id_persona']=$programa->id_persona;

        $this->dictamen_eval_perfil_proymodel->bind($dictamen_eval_perfil_proy);


        $correoJefeProyecto = $JefeProyecto->correo;
        $correoJefePrograma=$JefePrograma->correo;
        $nombreJefePrograma=$JefePrograma->nombre;
        $criterio= $dictamen_eval_perfil_proy['criterio'];
        $evaluacion=$eval->evaluacion;
        $observaciones=$dictamen_eval_perfil_proy['observaciones'];
        $conclusiones=$dictamen_eval_perfil_proy['conclusiones'];
        $recomendaciones=$dictamen_eval_perfil_proy['recomendaciones'];
       // enviar correo a jefe proyecto;
        $this->dictamen_eval_perfil_proymodel->SendEmailtoProjectSenior($correoJefeProyecto,$correoJefePrograma,$nombreJefePrograma,$criterio,$evaluacion,$observaciones
            ,$conclusiones,$recomendaciones);

        try {
            $this->dictamen_eval_perfil_proymodel->store($idjproyecto,$evaluacion,$nombreperfil);
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
                array('com_dictamen_eval_perfil_proy')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_dictamen_eval_perfil_proy');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function dictamen_eval_perfil_proy_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $dictamen_eval_perfil_proy = $this->input->post->get('dictamen_eval_perfil_proy', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $dictamen_eval_perfil_proy['id_dictamen']=$olditem1->id_dictamen ;
        $dictamen_eval_perfil_proy['id_proyecto']=$olditem1->id_proyecto ;
        $dictamen_eval_perfil_proy['id_persona']=$olditem1->id_persona ;
        $date =JFactory::getDate()->toSql( $dictamen_eval_perfil_proy['fecha_evaluacion']);
        $dictamen_eval_perfil_proy['fecha_evaluacion']=$date;


        $fecha =JFactory::getDate($dictamen_eval_perfil_proy->fecha_evaluacion)->toSql(true);
        $dictamen_eval_perfil_proy->fecha_evaluacion = $fecha;
        $this->dictamen_eval_perfil_proymodel=JModelLegacy::getInstance('dictamen_eval_perfil_proy');
        $this->dictamen_eval_perfil_proymodel->bind($dictamen_eval_perfil_proy);

        try {
            $this->dictamen_eval_perfil_proymodel->store();
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
                array('com_dictamen_eval_perfil_proy')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_dictamen_eval_perfil_proy');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function dictamen_eval_perfil_proy_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $array = $this->input->post->getArray();
        $dictamen_eval_perfil_proy =  json_decode($array['array']);
        $perfilproyectoamodel= JModelLegacy::getInstance('perfil_proyecto');


         $this->dictamen_eval_perfil_proymodel=JModelLegacy::getInstance('dictamen_eval_perfil_proy');
        for($i=0;$i<count($dictamen_eval_perfil_proy); $i++){
        $this->dictamen_eval_perfil_proymodel->bind($dictamen_eval_perfil_proy[$i]);
            $perfilproyecto = $perfilproyectoamodel->loadPerfilProyecto($dictamen_eval_perfil_proy[$i]->id_proyecto) ;
            $nombreperfil= $perfilproyecto->titulo_proyecto;
        try {
            $this->dictamen_eval_perfil_proymodel->delete($dictamen_eval_perfil_proy[$i]->id_dictamen,$nombreperfil);
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
                array('com_dictamen_eval_perfil_proy')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_dictamen_eval_perfil_proy');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
