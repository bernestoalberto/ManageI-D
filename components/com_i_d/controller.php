<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');
jimport('joomla.filesystem.file');

    class I_dController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_i_d';
	public $i_dmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->i_dmodel=JModelLegacy::getInstance('i_d');
    }


    
 public function i_d()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_ejecutora/assets/js/kendo_ejecutora.js',
            '3'=>$base.'components/com_perfil_proyecto/assets/js/kendo_perfil_proyecto.js',
            '4'=> $base.'components/com_innovacion/assets/js/kendo_innovacion.js',
            '5'=> $base.'components/com_jefeproyecto/assets/js/kendo_jefeproyecto.js'


        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('i_d');
        $view->display();
    }


    
public function i_d_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_persona/models');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $personamodel = JModelLegacy::getInstance('persona');
        $this->i_dmodel=JModelLegacy::getInstance('i_d');
        $list=$this->i_dmodel->loadAll('*');
       if($list!=false) {
            for ($i = 0; $i < count($list); $i++) {
                if ($list[$i]->id_entidad != "19") {
                    $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                    $list[$i]->proyecto = $perfilproyecto->titulo_proyecto;
                    $list[$i]->id_programa = $perfilproyecto->id_programa;
                    $persona = (Object)$personamodel->loadNombreJefePersona($perfilproyecto->id_persona);
                    $list[$i]->jefeproyecto = $persona->nombre;

                    if($list[$i]->otros_anexos_i_d==null)
                        $list[$i]->otros_anexos_i_d="---";
                }

            }
            echo json_encode($list);
       }
        JFactory::getApplication()->close();
    }


    
public function i_d_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $i_d = $this->input->post->get('i_d', array(), 'array');
        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($i_d['id_proyecto']);
        $i_d['id_programa'] =$perfilproyecto->id_programa;
        $i_d['id_persona'] =$perfilproyecto->id_persona;

        $nombre = $perfilproyecto->titulo_proyecto;
        $this->i_dmodel=JModelLegacy::getInstance('i_d');

        $file =  $this->input->files->get('i_d',array(),'array');
        $name = $file['otros_anexos_i_d']['name'];
        $tmp_name= $file['otros_anexos_i_d']['tmp_name'];
        $error = $file['otros_anexos_i_d']['error'];
        $path = JPATH_ANEXOSID.$name;
        $path=JPath::clean($path);

        if ( $error == UPLOAD_ERR_OK) {
            $r= JFile::upload($tmp_name,$path,false,false);
            if( $r==true)
                $i_d['otros_anexos_i_d']=$path ;

        }
        $this->i_dmodel->bind($i_d);

        try {
		
            $this->i_dmodel->store($nombre);
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
                array('com_i_d')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_i_d');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function i_d_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $this->i_dmodel = JModelLegacy::getInstance('i_d');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $i_d = $this->input->post->get('i_d', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $i_d['id_proyecto']=$olditem1->id_proyecto ;
        $i_d['id_programa'] =$olditem1->id_programa;
        $i_d['id_persona'] =$olditem1->id_persona;
        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($i_d['id_proyecto']);
        $nombre = $perfilproyecto->titulo_proyecto;

        $file =  $this->input->files->get('i_d',array(),'array');
        $name = $file['otros_anexos_i_d']['name'];
        $tmp_name= $file['otros_anexos_i_d']['tmp_name'];
        $error = $file['otros_anexos_i_d']['error'];
        $path = JPATH_ANEXOSID.$name;
        $path=JPath::clean($path);

        if ( $error == UPLOAD_ERR_OK) {
            $r= JFile::upload($tmp_name,$path,false,false);
            if( $r==true)
                $i_d['otros_anexos_i_d']=$path ;

        }

        $this->i_dmodel->bind($i_d);
        try {
            $this->i_dmodel->store($nombre);
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
                array('com_i_d')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_i_d');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function i_d_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $this->i_dmodel=JModelLegacy::getInstance('i_d');
        $perfilproyectomodel = JModelLegacy::getInstance('perfil_proyecto');
        $array = $this->input->post->getArray();
        $i_d =  json_decode($array['array']);  

        foreach($i_d as $p){                                 
        $this->i_dmodel->bind($p);
        try {
            $perfilproyecto = $perfilproyectomodel->loadPerfilProyecto($p['id_proyecto']);
            $nombre = $perfilproyecto->titulo_proyecto;
            $this->i_dmodel->delete($nombre);
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
                array('com_i_d')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_i_d');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
