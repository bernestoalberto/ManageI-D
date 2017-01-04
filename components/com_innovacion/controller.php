<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.filesystem.file');
jimport('joomla.log.log');

    class InnovacionController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_innovacion';
	public $innovacionmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->innovacionmodel=JModelLegacy::getInstance('innovacion');
    }


    
 public function innovacion()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_ejecutora/assets/js/kendo_ejecutora.js',
            '3'=>$base.'components/com_perfil_proyecto/assets/js/kendo_perfil_proyecto.js',
            '4'=> $base.'components/com_jefeproyecto/assets/js/kendo_jefeproyecto.js',
            '5'=> $base.'components/com_i_d/assets/js/kendo_i_d.js',


        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('innovacion');
        $view->display();
    }


    
public function innovacion_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_persona/models');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $personamodel = JModelLegacy::getInstance('persona');
        $this->innovacionmodel=JModelLegacy::getInstance('innovacion');
        $list=$this->innovacionmodel->loadAll('*');
        if($list!=false){
        for($i=0;$i< count($list);$i++){
            if($list[$i]->id_entidad != "19"){
                $perfilproyecto= (Object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                $list[$i]->proyecto =  $perfilproyecto->titulo_proyecto;
                $list[$i]->id_programa =  $perfilproyecto->id_programa;
                $persona= (Object)$personamodel->loadNombreJefePersona( $perfilproyecto->id_persona);
                $list[$i]->jefeproyecto =  $persona->nombre;


            }

        }

        echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }


    
public function innovacion_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath(JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $this->innovacionmodel=JModelLegacy::getInstance('innovacion');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $innovacion = $this->input->post->get('innovacion', array(), 'array');

        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($innovacion['id_proyecto']);
        $nombre = $perfilproyecto->titulo_proyecto;
        $innovacion['id_programa'] =$perfilproyecto->id_programa;
        $innovacion['id_persona'] =$perfilproyecto->id_persona;
        $file =  $this->input->files->get('innovacion',array(),'array');
        $name = $file['otros_anexos']['name'];
        $tmp_name= $file['otros_anexos']['tmp_name'];
        $error = $file['otros_anexos']['error'];
        $path = JPATH_COMPONENT.'/assets/anexos/'.$name;
        $path=JPath::clean($path);

            if ( $error == UPLOAD_ERR_OK) {
               $r= JFile::upload($tmp_name,$path,false,false);
                if( $r==true)
                $innovacion['otros_anexos']=$path ;

            }
        $this->innovacionmodel->bind($innovacion);

        try {
		
            $this->innovacionmodel->store($nombre);
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
                array('com_innovacion')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_innovacion');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function innovacion_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $this->innovacionmodel=JModelLegacy::getInstance('innovacion');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
 /*       $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
       $proyecto = $this->input->post->get('olditem', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $innovacion['id_proyecto'] = $olditem1->id_proyecto ;*/
       // $proyectomodel=JModelLegacy::getInstance('proyecto');

        $innovacion = $this->input->post->get('innovacion', array(), 'array');
        $file =  $this->input->files->get('innovacion',array(),'array');
        $name = $file['otros_anexos']['name'];
        $tmp_name= $file['otros_anexos']['tmp_name'];
        $error = $file['otros_anexos']['error'];
        $path = JPATH_COMPONENT.'/assets/anexos/'.$name;
        $path=JPath::clean($path);
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $innovacion['id_proyecto']=$olditem1->id_proyecto ;
        $innovacion['id_programa'] =$olditem1->id_programa;
        $innovacion['id_persona'] =$olditem1->id_persona;
        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($innovacion['id_proyecto']);
        $nombre = $perfilproyecto->titulo_proyecto;
        if($error == UPLOAD_ERR_NO_FILE){
            $innovacion['otros_anexos']= $olditem1->otros_anexos;

        }
        else if($error == UPLOAD_ERR_OK){

            $r= JFile::upload($tmp_name,$path,false,true);
            if( $r==true)
                $innovacion['otros_anexos']=$path ;

        }

        $this->innovacionmodel->bind($innovacion);
        try {
            //$proyectomodel->store();
            $this->innovacionmodel->store($nombre);
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
                array('com_innovacion')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_innovacion');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function innovacion_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $array = $this->input->post->getArray();
        $innovacion =  json_decode($array['array']);

         $this->innovacionmodel=JModelLegacy::getInstance('innovacion');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        foreach($innovacion as $p){
         JFile::delete($p->otros_anexos);
        $this->innovacionmodel->bind($p);
        try {
            $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($p['id_proyecto']);
            $nombre = $perfilproyecto->titulo_proyecto;
            $this->innovacionmodel->delete($nombre);
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
                array('com_innovacion')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_innovacion');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
