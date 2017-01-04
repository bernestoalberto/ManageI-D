<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

jimport('joomla.log.log');
    class Oponencia_informe_etapaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_oponencia_informe_etapa';
	public $oponencia_informe_etapamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->oponencia_informe_etapamodel=JModelLegacy::getInstance('oponencia_informe_etapa');
    }


    
 public function oponencia_informe_etapa()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_notificacion_ingreso_gastos/assets/js/kendo_notificacion_ingreso_gastos.js',
            '3'=> $base.'components/com_dictamen_grupo_expertos_inf_etapa/assets/js/kendo_dictamen_grupo_expertos_inf_etapa.js',
            '4'=> $base.'components/com_informe_ejecucion_programa/assets/js/kendo_informe_ejecucion_programa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('oponencia_informe_etapa');
        $view->display();
    }


    
public function oponencia_informe_etapa_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_informe_etapa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_proyecto/models');
        $this->oponencia_informe_etapamodel=JModelLegacy::getInstance('oponencia_informe_etapa');

        $list=$this->oponencia_informe_etapamodel->loadAll('*');
         if($list!=false) {
             $informetapamodel=JModelLegacy::getInstance('informe_etapa');
             $proyectopamodel=JModelLegacy::getInstance('proyecto');
             for ($i = 0; $i < count($list); $i++) {
            $informe= (Object)$informetapamodel->loadInforme($list[$i]->id_informe_etapa);
                 $list[$i]->etapa = $informe->etapa;
             $proyecto =  (Object) $proyectopamodel->loadProyecto( $list[$i]->id_proyecto);
                 $list[$i]->proyecto = $proyecto->nombre_proyecto;
         }
             echo json_encode($list);
         }
             JFactory::getApplication()->close();

    }


    
public function oponencia_informe_etapa_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $oponencia_informe_etapa = $this->input->post->get('oponencia_informe_etapa', array(), 'array');
        $this->oponencia_informe_etapamodel=JModelLegacy::getInstance('oponencia_informe_etapa');

        $oponencia_informe_etapa['id_proyecto']=$oponencia_informe_etapa['id_proyecto_oponencia'];
        $this->oponencia_informe_etapamodel->bind($oponencia_informe_etapa);

        try {
            $this->oponencia_informe_etapamodel->store();
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
                array('com_oponencia_informe_etapa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_oponencia_informe_etapa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function oponencia_informe_etapa_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $oponencia_informe_etapa = $this->input->post->get('oponencia_informe_etapa', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $oponencia_informe_etapa['id_oponencia']=$olditem1->id_oponencia ;
        $this->oponencia_informe_etapamodel=JModelLegacy::getInstance('oponencia_informe_etapa');
        $this->oponencia_informe_etapamodel->bind($oponencia_informe_etapa);

        try {
            $this->oponencia_informe_etapamodel->store();
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
                array('com_oponencia_informe_etapa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_oponencia_informe_etapa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function oponencia_informe_etapa_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $oponencia_informe_etapa =  json_decode($array['array']);  
         $this->oponencia_informe_etapamodel=JModelLegacy::getInstance('oponencia_informe_etapa');
        foreach($oponencia_informe_etapa as $p){                                 
        $this->oponencia_informe_etapamodel->bind($p);
        try {
            $this->oponencia_informe_etapamodel->delete();
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
                array('com_oponencia_informe_etapa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_oponencia_informe_etapa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
