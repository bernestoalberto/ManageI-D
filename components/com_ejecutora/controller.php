<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');


    class EjecutoraController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_ejecutora';
	public $ejecutoramodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->ejecutoramodel=JModelLegacy::getInstance('ejecutora');
    }


    
 public function ejecutora()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_jefeproyecto/assets/js/kendo_jefeproyecto.js',
            '3'=>$base.'components/com_perfil_proyecto/assets/js/kendo_perfil_proyecto.js',
            '4'=> $base.'components/com_innovacion/assets/js/kendo_innovacion.js',
            '5'=> $base.'components/com_i_d/assets/js/kendo_i_d.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('ejecutora');
        $view->display();
    }


    
public function ejecutora_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_entidad/models');
        $this->ejecutoramodel=JModelLegacy::getInstance('ejecutora');
        $entidadmodel = JModelLegacy::getInstance('entidad');
        $list=$this->ejecutoramodel->loadAll('*');
        if($list!=false) {
            for ($i = 0; $i < count($list); $i++) {
                $entidad = (object)$entidadmodel->loadNombreEntidad($list[$i]->id_entidad);
                $list[$i]->nombre = $entidad->nombre;

            }

            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }


    
public function ejecutora_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $ejecutora = $this->input->post->get('ejecutora', array(), 'array');
        $this->ejecutoramodel=JModelLegacy::getInstance('ejecutora');
        $this->ejecutoramodel->bind($ejecutora);

        try {
            $this->ejecutoramodel->store();
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
                array('com_ejecutora')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_ejecutora');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function ejecutora_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

        $ejecutora = $this->input->post->get('ejecutora', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $ejecutora['ejecutora']=$olditem1->id_entidad ;
        $this->ejecutoramodel=JModelLegacy::getInstance('ejecutora');
        $this->ejecutoramodel->bind($ejecutora);

        try {
            $this->ejecutoramodel->store();
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
                array('com_ejecutora')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_ejecutora');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function ejecutora_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JTable::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $ejecutora =  json_decode($array['array']);  
         $this->ejecutoramodel=JModelLegacy::getInstance('ejecutora');
        foreach($ejecutora as $p){                                 
        $this->ejecutoramodel->bind($p);
        try {
            $this->ejecutoramodel->delete();
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
                array('com_ejecutora')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_ejecutora');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
