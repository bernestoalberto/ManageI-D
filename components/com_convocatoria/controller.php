<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');


    class ConvocatoriaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_convocatoria';
	public $convocatoriamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->convocatoriamodel=JModelLegacy::getInstance('convocatoria');
    }


    
 public function convocatoria()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_programa/assets/js/kendo_programa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('convocatoria');
        $view->display();
    }


    
public function convocatoria_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_programa/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_persona/models');
        $this->convocatoriamodel=JModelLegacy::getInstance('convocatoria');
        $where = "id_persona >= 500";
        $list=$this->convocatoriamodel->loadAll('*',$where);
        if($list!=false){
        $programmodel = JModelLegacy::getInstance('programa');
        $personamodel = JModelLegacy::getInstance('persona');
        for($i=0;$i< count($list);$i++){
            if($list[$i]->id_programa_convocatoria != 4){
            $program = $programmodel->loadNombrePrograma($list[$i]->id_programa_convocatoria);

            $personajefe = $personamodel->loadNombreJefePersona($list[$i]->id_persona);

            $list[$i]->nombre = $program->nombre;
            $list[$i]->nombre_jefe = $personajefe->nombre;
            }

        }

        echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }
        public function programa_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_programa/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_perfil_programa/models');
        $list=$this->convocatoriamodel->loadAll('*');
        $lista =array();
        if($list!=false){
        $perfilprogrammodel = JModelLegacy::getInstance('perfil_programa');
        $programmodel = JModelLegacy::getInstance('programa');
        for($i=0;$i< count($list);$i++){

            $program = (object)$programmodel->loadNombrePrograma($list[$i]->id_programa_convocatoria);
            $lista[$i]->id_programa = $list[$i]->id_programa_convocatoria;
            $lista[$i]->nombre = $program->nombre;
            $profile = (object)$perfilprogrammodel->loadPresupuesto($list[$i]->id_programa_convocatoria);
            $lista[$i]->presupuesto =$profile->presupuesto;


        }

        echo json_encode($lista);
        }
        JFactory::getApplication()->close();
    }

        public function jefe_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_persona/models');
        $list=$this->convocatoriamodel->loadAll('*');
        $lista =array();
        if($list!=false){
        $personammodel = JModelLegacy::getInstance('persona');
        for($i=0;$i< count($list);$i++){

            $persona = (object)$personammodel->loadPersona($list[$i]->id_persona);
            $lista[$i]->id_persona = $persona->id_persona;
            $lista[$i]->nombre = $persona->nombre;


        }

        echo json_encode($lista);
        }
        JFactory::getApplication()->close();
    }


    
public function convocatoria_add()
{
    // Check for ajax request.
    JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
    // Check for request forgeries.
    JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
    header('Content-Type: application/json');
    JModelLegacy::addIncludePath(JPATH_COMPONENT . '/models');
    JModelLegacy::addIncludePath(JPATH_ROOT .'/components/com_programa/models');
    $convocatoria = $this->input->post->get('convocatoria', array(), 'array');
    $this->convocatoriamodel = JModelLegacy::getInstance('convocatoria');
    $programamodel = JModelLegacy::getInstance('programa');
    $id_persona= (object)$programamodel->loadJefePrograma($convocatoria['id_programa_convocatoria']);
    $convocatoria['id_persona']=$id_persona->id_persona;
    $this->convocatoriamodel->bind($convocatoria);

        try {
            $this->convocatoriamodel->store();
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
                array('com_convocatoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_convocatoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible insertarlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function convocatoria_update()
{
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
    header('Content-Type: application/json');
        JModelLegacy::addIncludePath(JPATH_COMPONENT . '/models');
        $convocatoria = $this->input->post->get('convocatoria', array(), 'array');
        $olditem = $this->input->post->get('olditem', array(), 'array');
        $olditem1 = json_decode($olditem[0]);
        $convocatoria['id_convocatoria'] = $olditem1->id_convocatoria;
        $this->convocatoriamodel = JModelLegacy::getInstance('convocatoria');
        $this->convocatoriamodel->bind($convocatoria);

        try {
            $this->convocatoriamodel->store();

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
                array('com_convocatoria')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_convocatoria');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function convocatoria_delete_one()
    {
        // Check for request forgeries.
     //   JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $convocatoria =  json_decode($array['array']);  
         $this->convocatoriamodel=JModelLegacy::getInstance('convocatoria');
        foreach($convocatoria as $p){                                 
        $this->convocatoriamodel->bind($p);
        try {
            $this->convocatoriamodel->delete();
            $array=array('success'=>true);
            echo json_encode($array);
        }
        catch(Exception $e)
        {
            JLog::add($e->getMessage(),JLog::ERROR);
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
