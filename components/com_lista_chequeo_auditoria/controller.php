<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');
    class Lista_chequeo_auditoriaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_lista_chequeo_auditoria';
	public $lista_chequeo_auditoriamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->lista_chequeo_auditoriamodel=JModelLegacy::getInstance('lista_chequeo_auditoria');
    }


    
 public function lista_chequeo_auditoria()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_auditoria/assets/js/kendo_auditoria.js',
            '3'=>$base.'components/com_plan_auditoria/assets/js/kendo_plan_auditoria.js',
            '4'=> $base.'components/com_evidencias_objetivas/assets/js/kendo_evidencias_objetivas.js',
            '5'=> $base.'components/com_informe_auditoria/assets/js/kendo_informe_auditoria.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('lista_chequeo_auditoria');
        $view->display();
    }


    
public function lista_chequeo_auditoria_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->lista_chequeo_auditoriamodel=JModelLegacy::getInstance('lista_chequeo_auditoria');
        $list=$this->lista_chequeo_auditoriamodel->loadAll('*');
         if($list!=false){                       
         echo json_encode($list);
                               }
                 JFactory::getApplication()->close();
    }


    
public function lista_chequeo_auditoria_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $lista_chequeo_auditoria = $this->input->post->get('lista_chequeo_auditoria', array(), 'array');
        $this->lista_chequeo_auditoriamodel=JModelLegacy::getInstance('lista_chequeo_auditoria');
        $this->lista_chequeo_auditoriamodel->bind($lista_chequeo_auditoria);

        try {
            $this->lista_chequeo_auditoriamodel->store();
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
                array('com_lista_chequeo_auditoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_lista_chequeo_auditoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function lista_chequeo_auditoria_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

        $lista_chequeo_auditoria = $this->input->post->get('lista_chequeo_auditoria', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $lista_chequeo_auditoria['id_lista_chequeo']=$olditem1->id_lista_chequeo ;
        $this->lista_chequeo_auditoriamodel=JModelLegacy::getInstance('lista_chequeo_auditoria');
        $this->lista_chequeo_auditoriamodel->bind($lista_chequeo_auditoria);

        try {
            $this->lista_chequeo_auditoriamodel->store();
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
                array('com_lista_chequeo_auditoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_lista_chequeo_auditoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function lista_chequeo_auditoria_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $lista_chequeo_auditoria =  json_decode($array['array']);  
         $this->lista_chequeo_auditoriamodel=JModelLegacy::getInstance('lista_chequeo_auditoria');
        foreach($lista_chequeo_auditoria as $p){                                 
        $this->lista_chequeo_auditoriamodel->bind($p);
        try {
            $this->lista_chequeo_auditoriamodel->delete();
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
                array('com_lista_chequeo_auditoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_lista_chequeo_auditoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
