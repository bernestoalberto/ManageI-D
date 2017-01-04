<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class ContratoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_contrato';
	public $contratomodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->contratomodel=JModelLegacy::getInstance('contrato');
    }


    
 public function contrato()
    {
        $base = JFactory::getUri()->base();
        JFactory::
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=> $base.'components/com_financista/assets/js/kendo_financista.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('contrato');
        $view->display();
    }


    
public function contrato_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_forma_entrega/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_financista/models');


        $this->contratomodel=JModelLegacy::getInstance('contrato');
        $personamodel=JModelLegacy::getInstance('persona');
        $perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $forma_entregamodel=JModelLegacy::getInstance('forma_entrega');
        $entidadmodel=JModelLegacy::getInstance('entidad');
        //$financistamodel=JModelLegacy::getInstance('financista');

        $list=$this->contratomodel->loadAll('*');
        if($list!=false) {
            for ($i=0;$i<count($list);$i++){
                $profile = (Object)$perfil_proyectomodel->loadPerfilProyecto($list[$i]->id_proyecto_contrato);
               // $financista = $financistamodel->loadidPersonaFinancista($list[$i]->id_proyecto_contrato);
              //  $personafinancista = $personamodel->loadPersona($financista->id_persona);
               // $list[$i]->financista=$personafinancista->nombre;
                $delivery = (Object) $forma_entregamodel->loadForma($list[$i]->id_forma_entrega);
                $list[$i]->forma_entrega=$delivery->informe;
                $list[$i]->proyecto=$profile->titulo_proyecto;
                $persona =(Object) $personamodel->loadPersona($profile->id_persona);
                $list[$i]->jefe_proyecto=$persona->nombre;
                $entity = (Object)$entidadmodel->loadNombreEntidad($profile->id_entidad);
                $list[$i]->representante_entidad_ejecutora=$entity->nombre;

            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }
public function proyecto_combo_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_proyecto/models');
        $this->contratomodel=JModelLegacy::getInstance('contrato');

        $proyectomodel = JModelLegacy::getInstance('proyecto');
$lista = array();
        $list=$this->contratomodel->loadProyecto();
        if($list!=false) {
            for ($i=0;$i<count($list);$i++){
                $profile = (Object)$proyectomodel->loadProyecto($list[$i]->id_proyecto_contrato);
                $lista[$i]->id_proyecto=$list[$i]->id_proyecto_contrato;
                $lista[$i]->nombre_proyecto=$profile->nombre_proyecto;
            }
            echo json_encode($lista);
        }
        JFactory::getApplication()->close();
    }


    
public function contrato_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'componenst/com_perfil_proyecto/models');
        $contrato = $this->input->post->get('contrato', array(), 'array');
        $this->contratomodel=JModelLegacy::getInstance('contrato');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $profile = $perfilproyectomodel->loadPerfilProyecto($contrato['id_proyecto_contrato']);
        $contrato['id_persona']=$profile->id_persona;
        $this->contratomodel->bind($contrato);


        try {
            $this->contratomodel->store();
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
                array('com_contrato')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_contrato');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function contrato_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.500
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        $apk = JFactory::getDate();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $contrato = $this->input->post->get('contrato', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $contrato['id_contrato']=$olditem1->id_contrato;
        $contrato['id_proyecto']=$olditem1->id_proyecto;
        $this->contratomodel=JModelLegacy::getInstance('contrato');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $profile = $perfilproyectomodel->loadPerfilProyecto($contrato['id_proyecto_contrato']);
        $contrato['id_persona']=$profile->id_persona;

      /*  $contrato['duracionInicio']=$apk->toSql($contrato['duracionInicio']);
        $contrato['duracionFinal']=$apk->toSql($contrato['duracionFinal']);
        $contrato['fechaEntrega']=$apk->toSql($contrato['fechaEntrega']);*/

        $this->contratomodel->bind($contrato);

        try {
            $this->contratomodel->store();
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
                array('com_contrato')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_contrato');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function contrato_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $contrato =  json_decode($array['array']);  
         $this->contratomodel=JModelLegacy::getInstance('contrato');
        foreach($contrato as $p){                                 
        $this->contratomodel->bind($p);
        try {
            $this->contratomodel->delete();

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
                array('com_contrato')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_contrato');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento esta Asociado no es posible su eliminación';
            echo json_encode($response);
            JFactory::getApplication()->close();
       } }

    }


}
