<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class Documentacion_evidencias_objetivasController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_documentacion_evidencias_objetivas';
	public $documentacion_evidencias_objetivasmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->documentacion_evidencias_objetivasmodel=JModelLegacy::getInstance('documentacion_evidencias_objetivas');
    }


    
 public function documentacion_evidencias_objetivas()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_auditoria/assets/js/kendo_auditoria.js',
            '3'=>$base.'components/com_lista_chequeo_auditoria/assets/js/kendo_lista_chequeo_auditoria.js',
            '4'=> $base.'components/com_plan_auditoria/assets/js/kendo_plan_auditoria.js',
            '5'=> $base.'components/com_informe_auditoria/assets/js/kendo_informe_auditoria.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('documentacion_evidencias_objetivas');
        $view->display();
    }


    
public function documentacion_evidencias_objetivas_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->documentacion_evidencias_objetivasmodel=JModelLegacy::getInstance('documentacion_evidencias_objetivas');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');

        $list=$this->documentacion_evidencias_objetivasmodel->loadAll('*');
         if($list!=false){
             $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
             $programamodel = JModelLegacy::getInstance('programa');


             for($i=0;$i<count($list);$i++){
                 $perfilproyecto = (object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                 $list[$i]->proyecto =$perfilproyecto->titulo_proyecto;
                 $programa = (object)$programamodel->loadPrograma($perfilproyecto->id_programa);
                 $list[$i]->programa =$programa->nombre;
             }



         echo json_encode($list);
                               }
                 JFactory::getApplication()->close();
    }


    
public function documentacion_evidencias_objetivas_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $documentacion_evidencias_objetivas = $this->input->post->get('documentacion_evidencias_objetivas', array(), 'array');
        $this->documentacion_evidencias_objetivasmodel=JModelLegacy::getInstance('documentacion_evidencias_objetivas');

        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');

        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($documentacion_evidencias_objetivas['id_proyecto']);
        $documentacion_evidencias_objetivas['id_programa']=$perfilproyecto->id_programa;
        $this->documentacion_evidencias_objetivasmodel->bind($documentacion_evidencias_objetivas);

        try {
            $this->documentacion_evidencias_objetivasmodel->store();
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


    
public function documentacion_evidencias_objetivas_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));

        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $documentacion_evidencias_objetivas = $this->input->post->get('documentacion_evidencias_objetivas', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $documentacion_evidencias_objetivas['id_documentacion_evidencias']=$olditem1->id_documentacion_evidencias ;
        $documentacion_evidencias_objetivas['id_proyecto']=$olditem1->id_proyecto ;
        $this->documentacion_evidencias_objetivasmodel=JModelLegacy::getInstance('documentacion_evidencias_objetivas');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');

        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($documentacion_evidencias_objetivas['id_proyecto']);
        $documentacion_evidencias_objetivas['id_programa']=$perfilproyecto->id_programa;
        $this->documentacion_evidencias_objetivasmodel->bind($documentacion_evidencias_objetivas);

        try {
            $this->documentacion_evidencias_objetivasmodel->store();
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


    
public function documentacion_evidencias_objetivas_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $documentacion_evidencias_objetivas =  json_decode($array['array']);  
         $this->documentacion_evidencias_objetivasmodel=JModelLegacy::getInstance('documentacion_evidencias_objetivas');
        foreach($documentacion_evidencias_objetivas as $p){                                 
        $this->documentacion_evidencias_objetivasmodel->bind($p);
        try {
            $this->documentacion_evidencias_objetivasmodel->delete();
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
