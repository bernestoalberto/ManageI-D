<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');
jimport('joomla.filesystem.file');

    class Perfil_programaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_perfil_programa';
	public $perfil_programamodel;



	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->perfil_programamodel=JModelLegacy::getInstance('perfil_programa');

    }
        public function profile_filtro_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            $list=$this->perfil_programamodel->loadFilter();
            if($list!=false){
                echo json_encode($list);
            }
            JFactory::getApplication()->close();
        }

    
 public function perfil_programa()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('perfil_programa');
        $view->display();
    }


    
public function perfil_programa_json_list()
    {

        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'component/com_indicadores_impacto/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'component/com_prioridad/models');
        $this->perfil_programamodel=JModelLegacy::getInstance('perfil_programa');
        $list=$this->perfil_programamodel->loadAll('*');
        if($list!=false) {
            $indicadormodel = JModelLegacy::getInstance('Indicadores_impacto');
            $prioridadmodel = JModelLegacy::getInstance('prioridad');
            for ($i = 0; $i < count($list); $i++) {
                $prioridad = $prioridadmodel->loadProblema($list[$i]->id_prioridad);
                $indicador = $indicadormodel->loadIndicador($list[$i]->id_indicador);

                $list[$i]->problema = $prioridad->problema;
                $list[$i]->indicador = $indicador->indicador;


            }

            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }


    
public function perfil_programa_add()
    {

           // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath(JPATH_COMPONENT . '/models');
        $perfil_programa = $this->input->post->get('perfil_programa', array(), 'array');
        $this->perfil_programamodel = JModelLegacy::getInstance('perfil_programa');

        $file =  $this->input->files->get('perfil_programa',array(),'array');
        $name = $file['archivo']['name'];
        $tmp_name= $file['archivo']['tmp_name'];
        $error = $file['archivo']['error'];
        $path = JPATH_COMPONENT.'/assets/archivos/'.$name;
        $path=JPath::clean($path);

        if ( $error == UPLOAD_ERR_OK ) {
            $r= JFile::upload($tmp_name,$path,false,false);
            if( $r==true)
                $perfil_programa['archivo']=$path ;

        }

            $this->perfil_programamodel->bind($perfil_programa);

            try {
                $this->perfil_programamodel->store();
                $array=array('success'=>true);
                echo json_encode($array);
                JFactory::getApplication()->close();

            }
            catch (Exception $e) {
                JLog::addLogger(
                    array(
                        // Sets file name
                        'text_file' => 'logs.php'
                    ),
                    // Sets messages of all log levels to be sent to the file
                    JLog::ALL,
                    array('com_perfil_programa')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_perfil_programa');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento no es posible su insertarlo';
                echo json_encode($response);
                JFactory::getApplication()->close();
            }
        }



    ///no coje el id del programa
public function perfil_programa_update()
{
    // Check for ajax request.
    JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
    // Check for request forgeries.
    JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
    header('Content-Type: application/json');
    JModelLegacy::addIncludePath(JPATH_COMPONENT . '/models');
    $perfil_programa = $this->input->post->get('perfil_programa', array(), 'array');
    $olditem = $this->input->post->get('olditem', array(), 'array');
    $olditem1 = json_decode($olditem[0]);
    $perfil_programa['id_programa'] = $olditem1->id_programa;
    $this->perfil_programamodel = JModelLegacy::getInstance('perfil_programa');
    $file =  $this->input->files->get('perfil_programa',array(),'array');
    $name = $file['archivo']['name'];
    $tmp_name= $file['archivo']['tmp_name'];
    $error = $file['archivo']['error'];
    $path = JPATH_COMPONENT.'/assets/archivos/'.$name;
    $path=JPath::clean($path);

    if ( $error == UPLOAD_ERR_OK) {

        $r= JFile::upload($tmp_name,$path,false,false);
        if( $r==true)
            $perfil_programa['archivo']=$path ;

    }


        $this->perfil_programamodel->bind($perfil_programa);


        try {
            $this->perfil_programamodel->store();
            $array=array('success'=>true);
            echo json_encode($array);

        } catch (Exception $e) {
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_perfil_programa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_perfil_programa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function perfil_programa_delete_one()
    {
        // Check for request forgeries.
       // JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

        $array = $this->input->post->getArray();
        $perfil_programa = json_decode($array['array']);
        $this->perfil_programamodel=JModelLegacy::getInstance('perfil_programa');
        foreach($perfil_programa as $p){
            JFile::delete($p->archivo);
            $this->perfil_programamodel->bind($p);
            try {
                $this->perfil_programamodel->delete();
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
                    array('com_perfil_programa')
                );
               JLog::add($e->getMessage(),JLog::ERROR, 'com_perfil_programa');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);

                JFactory::getApplication()->close();
            }
        }

    }


}
