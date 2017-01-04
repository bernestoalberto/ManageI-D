<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');
    class AuditoriaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_auditoria';
	public $auditoriamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->auditoriamodel=JModelLegacy::getInstance('auditoria');
    }


    
 public function auditoria()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_plan_auditoria/assets/js/kendo_plan_auditoria.js',
            '3'=>$base.'components/com_lista_chequeo/assets/js/kendo_lista_chequeo.js',
            '4'=> $base.'components/com_evidencias_objetivas/assets/js/kendo_evidencias_objetivas.js',
            '5'=> $base.'components/com_informe_auditoria/assets/js/kendo_informe_auditoria.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('auditoria');
        $view->display();
    }


    
public function auditoria_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        $this->auditoriamodel=JModelLegacy::getInstance('auditoria');
        $list=$this->auditoriamodel->loadAll('*');
         if($list!=false){

             $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
             $entidadmodel = JModelLegacy::getInstance('entidad');
             $programamodel = JModelLegacy::getInstance('programa');


             for($i=0;$i<count($list);$i++){
                 $perfilproyecto =  (object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                 $list[$i]->proyecto =$perfilproyecto->titulo_proyecto;
                 $programa =  (object)$programamodel->loadPrograma($perfilproyecto->id_programa);
                 $list[$i]->programa =$programa->nombre;
                 $entity =  (object)$entidadmodel->loadEntidad($list[$i]->id_entidad);
                 $list[$i]->entidad =$entity->nombre;

             }
         echo json_encode($list);

                               }
                 JFactory::getApplication()->close();
    }


    
public function auditoria_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $auditoria = $this->input->post->get('auditoria', array(), 'array');
        $this->auditoriamodel=JModelLegacy::getInstance('auditoria');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');

        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($auditoria['id_proyecto']);
        $auditoria['id_entidad']= $perfilproyecto->id_entidad;
        $auditoria['id_programa']=$perfilproyecto->id_programa;


        $this->auditoriamodel->bind($auditoria);

        try {
            $this->auditoriamodel->store();
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
                array('com_auditoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_auditoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function auditoria_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
            header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $auditoria = $this->input->post->get('auditoria', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $auditoria['id_programa_auditoria']=$olditem1->id_auditoria ;
        $auditoria['id_proyecto']=$olditem1->id_proyecto ;
        $this->auditoriamodel=JModelLegacy::getInstance('auditoria');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');

        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($auditoria['id_proyecto']);
        $auditoria['id_entidad']= $perfilproyecto->id_entidad;
        $auditoria['id_programa']=$perfilproyecto->id_programa;
        $this->auditoriamodel->bind($auditoria);

        try {
            $this->auditoriamodel->store();
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
                array('com_auditoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_auditoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function auditoria_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $auditoria =  json_decode($array['array']);  
         $this->auditoriamodel=JModelLegacy::getInstance('auditoria');
        foreach($auditoria as $p){                                 
        $this->auditoriamodel->bind($p);
        try {
            $this->auditoriamodel->delete();
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
                array('com_auditoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_auditoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
