<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class FinancistaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_financista';
	public $financistamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->financistamodel=JModelLegacy::getInstance('financista');
    }


    
 public function financista()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=> $base.'components/com_contrato/assets/js/kendo_contrato.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('financista');
        $view->display();
    }

        public function financista_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
            //JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
            JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
            JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');

            $this->financistamodel=JModelLegacy::getInstance('financista');
            $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
           // $personamodel=JModelLegacy::getInstance('persona');
            $programamodel=JModelLegacy::getInstance('programa');
            $entidadmodel=JModelLegacy::getInstance('entidad');
            $list=$this->financistamodel->loadAll('*');
            if($list!=false){
                for($i=0;$i<count($list);$i++){
                    $entity = $entidadmodel->loadNombreEntidad($list[$i]->id_entidad);
                    $list[$i]->entidad=$entity->nombre;
                    $profile = (Object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                    $list[$i]->proyecto=$profile->titulo_proyecto;
                    if($profile->id_programa!=null || $profile->id_programa >0){
                    $programa =  (Object)$programamodel->loadNombrePrograma($profile->id_programa);
                    $list[$i]->programa=$programa->nombre;
                    }
                    else{
                        $list[$i]->programa="No tiene programa";
                    }
                  /*  $persona =(Object) $personamodel->loadPersona($list[$i]->id_persona);
                    $list[$i]->financista=$persona->nombre;*/

                }
                echo json_encode($list);

            }
            JFactory::getApplication()->close();
        }
    
public function financista_combo_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        $entidadmodel=JModelLegacy::getInstance('entidad');
        $list=$this->financistamodel->loadAll('*');
         if($list!=false){
             for($i=0;$i<count($list);$i++){
                 $entity = $entidadmodel->loadNombreEntidad($list[$i]->id_entidad);
                 $list[$i]->entidad=$entity->nombre;

             }
         echo json_encode($list);

         }
                 JFactory::getApplication()->close();
    }


    
public function financista_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $financista = $this->input->post->get('financista', array(), 'array');
        $this->financistamodel=JModelLegacy::getInstance('financista');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
         $profile = (object) $perfilproyectomodel->loadPerfilProyecto($financista['id_proyecto']);
        $financista['id_programa'] = $profile->id_programa;

        $this->financistamodel->bind($financista);

        try {
            $this->financistamodel->store();
            $array=array('sucess'=>true);
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
                array('com_financista')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_financista');
            $response= new stdClass();
            $response->sucess=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function financista_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');

        $financista = $this->input->post->get('financista', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $financista['id_entidad ']=$olditem1->id_entidad ;
        $this->financistamodel=JModelLegacy::getInstance('financista');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $profile = $perfilproyectomodel->loadPerfilProyecto($financista['id_proyecto']);
        $financista['id_programa'] = $profile->id_programa;

        $this->financistamodel->bind($financista);

        try {
            $this->financistamodel->store();
            $array=array('sucess'=>true);
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
                array('com_financista')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_financista');
            $response= new stdClass();
            $response->sucess=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function financista_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $financista =  json_decode($array['array']);  
         $this->financistamodel=JModelLegacy::getInstance('financista');
        foreach($financista as $p){                                 
        $this->financistamodel->bind($p);
        try {
            $this->financistamodel->delete();
            $array=array('sucess'=>true);
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
                array('com_financista')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_financista');
            $response= new stdClass();
            $response->sucess=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
