<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');
    class Control_programa_proyectoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_control_programa_proyecto';
	public $control_programa_proyectomodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->control_programa_proyectomodel=JModelLegacy::getInstance('control_programa_proyecto');
    }


    
 public function control_programa_proyecto()
    {
 $base = JFactory::getUri()->base();                      
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);                    
        $view = $this->getView('control_programa_proyecto');
        $view->display();
    }


    
public function control_programa_proyecto_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_problemas_detectados/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_estado_ejecucion_proyecto/models');

        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_provincia/models');

        $this->control_programa_proyectomodel=JModelLegacy::getInstance('control_programa_proyecto');
        $list=$this->control_programa_proyectomodel->loadAll('*');
         if($list!=false){
             $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
             $entidadmodel = JModelLegacy::getInstance('entidad');
             $programamodel = JModelLegacy::getInstance('programa');
             $proyectomodel = JModelLegacy::getInstance('proyecto');
             $problemasmodel = JModelLegacy::getInstance('problemas_detectados');
             $estadoejecucionmodel = JModelLegacy::getInstance('estado_ejecucion_proyecto');

             $provinciamodel = JModelLegacy::getInstance('provincia');


             for($i=0;$i<count($list);$i++){

                 $perfilproyecto = (Object) $perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                 $list[$i]->proyecto =$perfilproyecto->titulo_proyecto;
                 $programa = (Object)$programamodel->loadPrograma($perfilproyecto->id_programa);
                 $list[$i]->programa =$programa->nombre;
                 $proyecto = (Object)$proyectomodel->loadProyecto($list[$i]->id_proyecto);
                 $list[$i]->codigo =$proyecto->numero;
                 $entity = $entidadmodel->loadEntidad($list[$i]->id_entidad);
                 $list[$i]->entidad =$entity->nombre;
                 $provincia = (Object)$provinciamodel->loadNombreProvincia($entity->id_provincia);
                 $list[$i]->provincia =$provincia->nombre_provincia;
                 $entity = (Object)$entidadmodel->loadEntidad($list[$i]->entidad_finacista);
                 $list[$i]->finacista =$entity->nombre;
                 $entity = (Object)$entidadmodel->loadEntidad($list[$i]->participante);
                 $list[$i]->invitado =$entity->nombre;
                 $state =(Object)$estadoejecucionmodel->loadEstado($list[$i]->id_estado_ejecucion_proyecto);
                 $list[$i]->nombre_estado_ejecucion_proyecto =$state->nombre_estado_ejecucion_proyecto;
                  $problem = (Object)$problemasmodel->loadProblema($list[$i]->id_problema_detectado);
                 $list[$i]->problema =$problem->problema;


             }



         echo json_encode($list);
                               }
                 JFactory::getApplication()->close();
    }


    
public function control_programa_proyecto_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_financista/models');

        $control_programa_proyecto = $this->input->post->get('control_programa_proyecto', array(), 'array');

        $profilemodel = JModelLegacy::getInstance('perfil_proyecto');
        $financistamodel = JModelLegacy::getInstance('financista');
        $this->control_programa_proyectomodel=JModelLegacy::getInstance('control_programa_proyecto');

         $profile =  (Object)$profilemodel->loadPerfilProyecto($control_programa_proyecto['id_proyecto']);
         $control_programa_proyecto['id_entidad'] = $profile->id_entidad;
        $financista = (Object)$financistamodel->loadFinancista($profile->id_proyecto);
        $control_programa_proyecto['entidad_finacista']=$financista->id_entidad;
        $this->control_programa_proyectomodel->bind($control_programa_proyecto);

        try {
            $this->control_programa_proyectomodel->store();
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
                array('com_control_programa_proyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_control_programa_proyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function control_programa_proyecto_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_financista/models');

        $control_programa_proyecto = $this->input->post->get('control_programa_proyecto', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $control_programa_proyecto['id_control']=$olditem1->id_control ;
        $control_programa_proyecto['id_proyecto']=$olditem1->id_proyecto ;

        $profilemodel = JModelLegacy::getInstance('perfil_proyecto');
        $financistamodel = JModelLegacy::getInstance('financista');
        $this->control_programa_proyectomodel=JModelLegacy::getInstance('control_programa_proyecto');

        $profile = (Object)$profilemodel->loadPerfilProyecto($control_programa_proyecto['id_proyecto']);
        $control_programa_proyecto['id_entidad'] = $profile->id_entidad;
        $financista = (Object)$financistamodel->loadFinancista($profile->id_proyecto);
        $control_programa_proyecto['entidad_finacista']=$financista->id_entidad;
        $this->control_programa_proyectomodel->bind($control_programa_proyecto);

        try {
            $this->control_programa_proyectomodel->store();
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
                array('com_control_programa_proyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_control_programa_proyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function control_programa_proyecto_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $control_programa_proyecto =  json_decode($array['array']);  
         $this->control_programa_proyectomodel=JModelLegacy::getInstance('control_programa_proyecto');
        foreach($control_programa_proyecto as $p){                                 
        $this->control_programa_proyectomodel->bind($p);
        try {
            $this->control_programa_proyectomodel->delete();
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
                array('com_control_programa_proyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_control_programa_proyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
