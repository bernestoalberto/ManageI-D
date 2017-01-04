<?php
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class Informe_ejecucion_programaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_informe_ejecucion_programa';
	public $informe_ejecucion_programamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->informe_ejecucion_programamodel=JModelLegacy::getInstance('informe_ejecucion_programa');
    }


    
 public function informe_ejecucion_programa()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_notificacion_ingreso_gastos/assets/js/kendo_notificacion_ingreso_gastos.js',
            '3'=> $base.'components/com_oponencia_informe_etapa/assets/js/kendo_oponencia_informe_etapa.js',
            '4'=> $base.'components/com_dictamen_grupo_expertos_inf_etapa/assets/js/kendo_dictamen_grupo_expertos_inf_etapa.js',
            '5'=> $base.'components/com_anticipo/assets/js/kendo_anticipo.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('informe_ejecucion_programa');
        $view->display();
    }


    
public function informe_ejecucion_programa_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        $programamodel=JModelLegacy::getInstance('programa');
        $personamodel=JModelLegacy::getInstance('persona');
        $entidadmodel=JModelLegacy::getInstance('entidad');
        $this->informe_ejecucion_programamodel=JModelLegacy::getInstance('informe_ejecucion_programa');
        $list=$this->informe_ejecucion_programamodel->loadAll('*');
         if($list!=false){

             for($i=0;$i<count($list);$i++) {

                 $programa= $programamodel->loadPrograma($list[$i]->id_programa);
                 $list[$i]->programa=$programa->nombre;
                 $entity=$entidadmodel->loadNombreEntidad($programa->id_entidad);
                 $list[$i]->entidad=$entity->nombre;
                 $jefe = $personamodel->loadPersona($programa->id_persona);
                 $list[$i]->nombre_apellidos_jefe=$jefe->nombre.$jefe->apellidos;
                 $secre = $personamodel->loadPersona($programa->secretarioprograma);
                 $list[$i]->nombre_apellidos_secretatio=$secre->nombre.$secre->apellidos;

             }
             echo json_encode($list);
                               }
                 JFactory::getApplication()->close();
    }


    
public function informe_ejecucion_programa_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_informe_etapa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_dictamen_grupo_expertos_inf_etapa/models');

        $informe_ejecucion_programa = $this->input->post->get('informe_ejecucion_programa', array(), 'array');
       $informemodel=JModelLegacy::getInstance('informe_etapa');
       $dictamenmodel=JModelLegacy::getInstance('dictamen_grupo_expertos_inf_etapa');

        $informe = $informemodel->loadInformebyPrograma($informe_ejecucion_programa['id_programa']);

        $dictamen = $dictamenmodel->loadDictamenbyInforme($informe->id_informe_etapa);
        $informe_ejecucion_programa['id_dictamen_grup_exp']=$dictamen->id_dictamen_grup_exp;

        $this->informe_ejecucion_programamodel=JModelLegacy::getInstance('informe_ejecucion_programa');


        $this->informe_ejecucion_programamodel->bind($informe_ejecucion_programa);

        try {
            $this->informe_ejecucion_programamodel->store();
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
                array('com_informe_ejecucion_programa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_informe_ejecucion_programa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function informe_ejecucion_programa_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_informe_etapa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_dictamen_grupo_expertos_inf_etapa/models');
        $informe_ejecucion_programa = $this->input->post->get('informe_ejecucion_programa', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $informe_ejecucion_programa['id_informe_ejecucion_programa']=$olditem1->id_informe_ejecucion_programa ;
        $informe_ejecucion_programa['id_programa']=$olditem1->id_programa ;
        $informemodel=JModelLegacy::getInstance('informe_etapa');

        $dictamenmodel=JModelLegacy::getInstance('dictamen_grupo_expertos_inf_etapa');

        $informe = $informemodel->loadInformebyPrograma($informe_ejecucion_programa['id_programa']);

        $dictamen = $dictamenmodel->loadDictamenbyInforme($informe->id_informe_etapa);
        $informe_ejecucion_programa['id_dictamen_grup_exp']=$dictamen->id_dictamen_grup_exp;
        $this->informe_ejecucion_programamodel=JModelLegacy::getInstance('informe_ejecucion_programa');
        $this->informe_ejecucion_programamodel->bind($informe_ejecucion_programa);

        try {
            $this->informe_ejecucion_programamodel->store();
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
                array('com_informe_ejecucion_programa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_informe_ejecucion_programa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function informe_ejecucion_programa_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $informe_ejecucion_programa =  json_decode($array['array']);  
         $this->informe_ejecucion_programamodel=JModelLegacy::getInstance('informe_ejecucion_programa');
        foreach($informe_ejecucion_programa as $p){                                 
        $this->informe_ejecucion_programamodel->bind($p);
        try {
            $this->informe_ejecucion_programamodel->delete();
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
                array('com_informe_ejecucion_programa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_informe_ejecucion_programa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
