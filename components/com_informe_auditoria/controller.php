<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');
    class Informe_auditoriaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_informe_auditoria';
	public $informe_auditoriamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->informe_auditoriamodel=JModelLegacy::getInstance('informe_auditoria');
    }


    
 public function informe_auditoria()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_auditoria/assets/js/kendo_auditoria.js',
            '3'=>$base.'components/com_lista_chequeo_auditoria/assets/js/kendo_lista_chequeo_auditoria.js',
            '4'=> $base.'components/com_documentacion_evidencias_objetivas/assets/js/kendo_documentacion_evidencias_objetivas.js',
            '5'=> $base.'components/com_plan_auditoria/assets/js/kendo_plan_auditoria.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('informe_auditoria');
        $view->display();
    }


    
public function informe_auditoria_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_documentacion_evidencias_objetivas/models');

        $this->informe_auditoriamodel=JModelLegacy::getInstance('informe_auditoria');
        $list=$this->informe_auditoriamodel->loadAll('*');
         if($list!=false){
             $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
             $entidadmodel = JModelLegacy::getInstance('entidad');
             $programamodel = JModelLegacy::getInstance('programa');
             $evidenciamodel = JModelLegacy::getInstance('documentacion_evidencias_objetivas');


             for($i=0;$i<count($list);$i++){
                 $perfilproyecto = (object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                 $list[$i]->proyecto =$perfilproyecto->titulo_proyecto;
                 $programa =(object)$programamodel->loadPrograma($perfilproyecto->id_programa);
                 $list[$i]->programa =$programa->nombre;
                 $entity = (object)$entidadmodel->loadEntidad($list[$i]->id_entidad);
                 $list[$i]->entidad =$entity->nombre;
                 $evidence = (object)$evidenciamodel->loadDeficiencias($list[$i]->id_documentacion_evidencias);
                 $list[$i]->no_conformidades_detectadas =$evidence->deficiencias_evidencias;

             }
         echo json_encode($list);
                               }
                 JFactory::getApplication()->close();
    }


    
public function informe_auditoria_add()
    {

        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
     header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_documentacion_evidencias_objetivas/models');

        $informe_auditoria = $this->input->post->get('informe_auditoria', array(), 'array');

        $this->informe_auditoriamodel=JModelLegacy::getInstance('informe_auditoria');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $evidenciamodel = JModelLegacy::getInstance('documentacion_evidencias_objetivas');

        $perfilproyecto =(Object) $perfilproyectomodel->loadPerfilProyecto($informe_auditoria['id_proyecto']);
        $informe_auditoria['id_entidad']= $perfilproyecto->id_entidad;
        $informe_auditoria['id_programa']=$perfilproyecto->id_programa;
       $evidence =  (Object)$evidenciamodel->loadDEObyProjectDate($perfilproyecto->id_proyecto,$informe_auditoria['fecha_confeccion']);
        $informe_auditoria['id_documentacion_evidencias']=$evidence->id_documentacion_evidencias;

        $this->informe_auditoriamodel->bind($informe_auditoria);

        try {
            $this->informe_auditoriamodel->store();
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
                array('com_documentacion_evidencias_objetivas')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_documentacion_evidencias_objetivas');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function informe_auditoria_update()
    {

        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_documentacion_evindecias_objetivas/models');

        $informe_auditoria = $this->input->post->get('informe_auditoria', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $informe_auditoria['id_nforme_auditoria']=$olditem1->id_nforme_auditoria ;
        $informe_auditoria['id_proyecto']=$olditem1->id_proyecto ;

        $this->informe_auditoriamodel=JModelLegacy::getInstance('informe_auditoria');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $evidenciamodel = JModelLegacy::getInstance('documentacion_evindecias_objetivas');

        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($informe_auditoria['id_proyecto']);
        $informe_auditoria['id_entidad']= $perfilproyecto->id_entidad;
        $informe_auditoria['id_programa']=$perfilproyecto->id_programa;
        $evidence =  (Object)$evidenciamodel->loadDEObyProjectDate($perfilproyecto->id_proyecto,$informe_auditoria['fecha_confeccion']);
        $informe_auditoria['id_documentacion_evidencias']=$evidence->id_documentacion_evidencias;

        $this->informe_auditoriamodel->bind($informe_auditoria);

        try {
            $this->informe_auditoriamodel->store();
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
                array('com_documentacion_evidencias_objetivas')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_documentacion_evidencias_objetivas');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function informe_auditoria_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $informe_auditoria =  json_decode($array['array']);  
         $this->informe_auditoriamodel=JModelLegacy::getInstance('informe_auditoria');
        foreach($informe_auditoria as $p){                                 
        $this->informe_auditoriamodel->bind($p);
        try {
            $this->informe_auditoriamodel->delete();
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
                array('com_documentacion_evidencias_objetivas')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_documentacion_evidencias_objetivas');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
