<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class ProgramaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_programa';
	public $programamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->programamodel=JModelLegacy::getInstance('programa');
    }


    
 public function programa()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=> $base.'components/com_convocatoria/assets/js/kendo_convocatoria.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('programa');
        $view->display();
    }
        public function programa_filtro_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            $list=$this->programamodel->loadFilter();
            if($list!=false){
                echo json_encode($list);
            }
            JFactory::getApplication()->close();
        }
        public function programa_combo_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_control_ejecucion_presupuesto/models');
                $controlmodel = JModelLegacy::getInstance('control_ejecucion_presupuesto');
            $list = array();
            $lista = $controlmodel->loadIdProgramas();
            if($lista!=false) {
                $this->programamodel=JModelLegacy::getInstance('programa');

                for($i=0;$i<count($lista);$i++){
                    $id=$lista[$i];
                   $programa=  $this->programamodel->loadPrograma($id->id_programa);

                    if($i ==0 || $lista[$i-1]->id_programa != $programa->id_programa )
                    $list[$i]=$programa;

                }

                echo json_encode($list);
            }
            JFactory::getApplication()->close();
        }
        public function programa_combo_ejecucion_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            $this->programamodel=JModelLegacy::getInstance('programa');
            $list = $this->programamodel->loadAll('*');
            if($list!=false){

                echo json_encode($list);
            }
            JFactory::getApplication()->close();
        }
        public function programa__list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_programa/models');
            $perfilprogramamodel=JModelLegacy::getInstance('perfil_programa');

             $this->programamodel=JModelLegacy::getInstance('programa');

            $list = $this->programamodel->loadAll('*');
            for($i=0;$i<count($list);$i++){
                $presupuesto = $perfilprogramamodel->loadPresupuesto($list[$i]->id_programa);
                $list[$i]->presupuesto=$presupuesto;
            }

                echo json_encode($list);

            JFactory::getApplication()->close();
        }

    
public function programa_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_entidad/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_persona/models');
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_perfil_programa/models');
        $this->programamodel=JModelLegacy::getInstance('programa');
        $list=$this->programamodel->loadAll('*');
        if($list!=false) {
            $entidadmodel = JModelLegacy::getInstance('entidad');
            $personamodel = JModelLegacy::getInstance('persona');
            $perfilprogrammodel = JModelLegacy::getInstance('perfil_programa');

            for ($i = 0; $i < count($list); $i++) {
                $perfilprogram = $perfilprogrammodel->loadNombrePerfilPrograma($list[$i]->id_programa);
                $personajefe = $personamodel->loadNombreJefePersona($list[$i]->id_persona);
                $personasecre = $personamodel->loadNombreJefePersona($list[$i]->secretarioprograma);
                $entidad = $entidadmodel->loadNombreEntidad($list[$i]->id_entidad);


                $list[$i]->denominacion = $perfilprogram->denominacion;
                $list[$i]->nombre_secre = $personasecre->nombre;
                $list[$i]->nombre_entidad = $entidad->nombre;
                $list[$i]->nombre_jefe = $personajefe->nombre;
                if($list[$i]->otras_entidades == null)
                    $list[$i]->otras_entidades='---';


            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }

        public function programtoconvocatoria_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath(JPATH_ROOT.'components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->programamodel=JModelLegacy::getInstance('programa');
        $list=$this->programamodel->loadAll('*');
        $lista =[];
        $personamodel = JModelLegacy::getInstance('persona');
        for($i=0;$i< count($list);$i++){
            if($list[$i]->id_entidad != "19"){
                $program =  $this->programamodel->loadNombrePrograma($list[$i]->id_programa);

                $personajefe = $personamodel->loadNombreJefePersona($list[$i]->id_persona);

                $list[$i]->nombre = $program->nombre;
                $list[$i]->nombre_jefe = $personajefe->nombre;
            }

        }


        echo json_encode($list);
        JFactory::getApplication()->close();
    }
        public function programtoconvocatoria_combo_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
            $this->programamodel=JModelLegacy::getInstance('programa');
            $personamodel=JModelLegacy::getInstance('persona');
            $lista=$this->programamodel->loadAllJefePrograma();
            $list =array();
            if($lista!=false){
                for($i=0;$i<count($lista);$i++){
                // if($lista[$i]->id_persona){
                     $boss =  (Object)$personamodel->loadNombreJefePersona($lista[$i]->id_persona);


                     $list[$i]->nombre = $boss->nombre;
                     $list[$i]->id_persona = $lista[$i]->id_persona;

                // }
                }
                echo json_encode($list);
            }


            JFactory::getApplication()->close();
        }




        public function programa_add()
        {

            // Check for ajax request.
            JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
                // Check for request forgeries.
                JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
            header('Content-Type: application/json');

            JModelLegacy::addIncludePath(JPATH_COMPONENT . '/models');
                $programa = $this->input->post->get('programa', array(), 'array');
                $this->programamodel = JModelLegacy::getInstance('programa');
                $this->programamodel->bind($programa);

                try {
                    $this->programamodel->store();
                    $array=array('success'=>true);
                    echo json_encode($array);
                    JFactory::getApplication()->close();

                } catch (Exception $e) {
                    JLog::addLogger(
                        array(
                            // Sets file name
                            'text_file' => 'logs.php'
                        ),
                        // Sets messages of all log levels to be sent to the file
                        JLog::ALL,
                        array('com_programa')
                    );
                    JLog::add($e->getMessage(),JLog::ERROR, 'com_programa');
                    $response= new stdClass();
                    $response->success=false;
                    $response->message='Este elemento no es posible añadirlo';
                    echo json_encode($response);
                    JFactory::getApplication()->close();
                }

            }


    
public function programa_update()
{
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
    header('Content-Type: application/json');

    JModelLegacy::addIncludePath(JPATH_COMPONENT . '/models');
        $programa = $this->input->post->get('programa', array(), 'array');
        $olditem = $this->input->post->get('olditem', array(), 'array');
        $olditem1 = json_decode($olditem[0]);
        $programa['id_programa'] = $olditem1->id_programa;
        $this->programamodel = JModelLegacy::getInstance('programa');
        $this->programamodel->bind($programa);

        try {
            $this->programamodel->store();
            $array=array('success'=>true);
            echo json_encode($array);
            JFactory::getApplication()->close();

        } catch (Exception $e) {
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_programa')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_programa');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function programa_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $programa =  json_decode($array['array']);
         $this->programamodel=JModelLegacy::getInstance('programa');
        for($i=0;$i<count($programa);$i++) {

                    $this->programamodel->bind($programa[$i]);

                    try {
                        $this->programamodel->delete();
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
                            array('com_programa')
                        );
                        JLog::add($e->getMessage(),JLog::ERROR, 'com_programa');
                        $response= new stdClass();
                        $response->success=false;
                        $response->message='Este elemento esta Asociado no es posible su eliminación';
                        echo json_encode($response);
                        JFactory::getApplication()->close();
                    }
                }
            }


}
