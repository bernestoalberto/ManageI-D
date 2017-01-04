<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class Grado_cientificoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_grado_cientifico';
	public $grado_cientificomodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->grado_cientificomodel=JModelLegacy::getInstance('grado_cientifico');
    }


    
 public function grado_cientifico()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_entidad/assets/js/kendo_entidad.js',
            '3'=>$base.'components/com_provincia/assets/js/kendo_provincia.js',
            '4'=> $base.'components/com_indicadores_impacto/assets/js/kendo_indicadores_impacto.js',
            '5'=> $base.'components/com_cat_cientifica/assets/js/kendo_cat_cientifica.js',
            '6'=> $base.'components/com_clasificacion/assets/js/kendo_clasificacion.js',
            '7'=> $base.'components/com_tipo_proyecto/assets/js/kendo_tipo_proyecto.js',
            '8'=> $base.'components/com_evaluacion/assets/js/kendo_evaluacion.js',
            '9'=> $base.'components/com_forma_entrega/assets/js/kendo_forma_entrega.js',
            '10'=> $base.'components/com_estado_ejecucion_proyecto/assets/js/kendo_estado_ejecucion_proyecto.js',
            '11'=> $base.'components/com_problemas_detectados/assets/js/kendo_problemas_detectados.js',
            '12'=> $base.'components/com_prioridad/assets/js/kendo_prioridad.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('grado_cientifico');
        $view->display();
    }


    
public function grado_cientifico_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->grado_cientificomodel=JModelLegacy::getInstance('grado_cientifico');
        $list=$this->grado_cientificomodel->loadAll('*');
        if($list!=false)
        echo json_encode($list);
        JFactory::getApplication()->close();
    }


    
public function grado_cientifico_add()
    {

        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $grado_cientifico = $this->input->post->get('grado_cientifico', array(), 'array');
        $this->grado_cientificomodel=JModelLegacy::getInstance('grado_cientifico');
        $this->grado_cientificomodel->bind($grado_cientifico);

        try {
            $this->grado_cientificomodel->store();
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
                array('com_grado_cientifico')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_grado_cientifico');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function grado_cientifico_update()
    {

        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

        $grado_cientifico = $this->input->post->get('grado_cientifico', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $grado_cientifico['id_grado']=$olditem1->id_grado ;
        $this->grado_cientificomodel=JModelLegacy::getInstance('grado_cientifico');
        $this->grado_cientificomodel->bind($grado_cientifico);

        try {
            $this->grado_cientificomodel->store();
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
                array('com_grado_cientifico')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_grado_cientifico');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function grado_cientifico_delete_one()
    {
        // Check for request forgeries.
      //  JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $grado_cientifico =  json_decode($array['array']);  
         $this->grado_cientificomodel=JModelLegacy::getInstance('grado_cientifico');
        foreach($grado_cientifico as $p){                                 
        $this->grado_cientificomodel->bind($p);
        try {
            $this->grado_cientificomodel->delete();
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
                array('com_grado_cientifico')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_grado_cientifico');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
