<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class Perfil_proyectoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_perfil_proyecto';
	public $perfil_proyectomodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
    }


    
 public function perfil_proyecto()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_jefeproyecto/assets/js/kendo_jefeproyecto.js',
            '3'=>$base.'components/com_ejecutora/assets/js/kendo_ejecutora.js',
            '6'=> $base.'components/com_innovacion/assets/js/kendo_innovacion.js',
            '7'=> $base.'components/com_i_d/assets/js/kendo_i_d.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('perfil_proyecto');
        $view->display();
    }


    
public function perfil_proyecto_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_prioridad/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_tipo_proyecto/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_clasificacion/models');
        $this->perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $entidadmodel = JModelLegacy::getInstance('entidad');
        $prioridadmodel = JModelLegacy::getInstance('prioridad');
        $programamodel = JModelLegacy::getInstance('programa');
        $tipoproyectomodel = JModelLegacy::getInstance('tipo_proyecto');
        $jefeproyectomodel = JModelLegacy::getInstance('persona');
        $clasificacionmodel = JModelLegacy::getInstance('clasificacion');
        $list=$this->perfil_proyectomodel->loadAll('*');
        if($list!=false) {
            for ($i = 0; $i < count($list); $i++) {
                $entidad = (object)$entidadmodel->loadNombreEntidad($list[$i]->id_entidad);

                if($list[$i]->id_programa==0) {
                    $list[$i]->nombre_programa = '---';

                }
                else{
                    $programa = (object)$programamodel->loadNombrePrograma($list[$i]->id_programa);
                    $list[$i]->nombre_programa =$programa->nombre;
                }
                if($list[$i]->otra_institucion==null)
                    $list[$i]->otra_institucion='---';
                $tipo_proyecto = (object)$tipoproyectomodel->loadNombreTipoProyecto($list[$i]->id_tipo_proyecto);
                $clasificacion = (object)$clasificacionmodel->loadNombreClasificacion($list[$i]->id_clasificacion);
                $jefeproyecto = (object)$jefeproyectomodel->loadNombreJefePersona($list[$i]->id_persona);
                $list[$i]->nombre_entidad = $entidad->nombre;
                $list[$i]->tipo_proyecto = $tipo_proyecto->tipo;
                $list[$i]->nombre_clasificacion = $clasificacion->nombre_clasificacion;
                $list[$i]->nombre_persona = $jefeproyecto->nombre;
                if( $list[$i]->id_prioridad== 0 ||  $list[$i]->id_prioridad == null){
                    $list[$i]->problema = "El problema esta asociado al programa";

                }
                else{
                  $prioridad =  (object) $prioridadmodel->loadProblema($list[$i]->id_prioridad);
                    $list[$i]->problema=$prioridad->problema;
                }
            }


            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }
        //Check this out
        public function perfil_proyecto_json_combo_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            JModelLegacy::addIncludePath(JPATH_COMPONENT.'/components/com_programa/models');
            $this->entidadmodel=JModelLegacy::getInstance('entidad');
            $programamodel = JModelLegacy::getInstance('programa');
            $programas = (object)$programamodel->loadAll('*');
            $list=$this->entidadmodel->loadAll('*');
            $k =0;
            for($i=0;$i<count($list);$i++){
                $entidad = $list[$i];
                $found =false;
                for($j=0;$j<count($programas);$j++){
                    $programa = $programas[$j];
                    if($entidad->id_programa== $programa->id_programa && $programa->id_entidad != 19 ){
                        $found =true;
                    }
                }
                if($found==false) {
                    $lista[$k] = $entidad;
                    $k++;
                }

            }
            echo json_encode($lista);
            JFactory::getApplication()->close();
        }


    
public function perfil_proyecto_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $perfil_proyecto = $this->input->post->get('perfil_proyecto', array(), 'array');
        $this->perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $perfil_proyecto['fecha_recepcion'] = JFactory::getDate()->format("Y-m-d H:i:s");



        $this->perfil_proyectomodel->bind($perfil_proyecto);

        try {
            $this->perfil_proyectomodel->store();
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
                array('com_perfil_proyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_perfil_proyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function perfil_proyecto_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

        $perfil_proyecto = $this->input->post->get('perfil_proyecto', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $perfil_proyecto['id_proyecto']=$olditem1->id_proyecto ;


        $this->perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $perfil_proyecto['fecha_recepcion'] = JFactory::getDate()->format("Y-m-d H:i:s");
        $this->perfil_proyectomodel->bind($perfil_proyecto);

        try {
            $this->perfil_proyectomodel->store();
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
                array('com_perfil_proyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_perfil_proyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function perfil_proyecto_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $perfil_proyecto =  json_decode($array['array']);  
         $this->perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        foreach($perfil_proyecto as $p){                                 
        $this->perfil_proyectomodel->bind($p);
        try {
            $this->perfil_proyectomodel->delete();
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
                array('com_perfil_proyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_perfil_proyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
