<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

    class EntidadController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_entidad';
	public $entidadmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->entidadmodel=JModelLegacy::getInstance('entidad');
    }


    
 public function entidad()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_indicadores_impacto/assets/js/kendo_indicadores_impacto.js',
            '3'=>$base.'components/com_provincia/assets/js/kendo_provincia.js',
            '4'=> $base.'components/com_grado_cientifico/assets/js/kendo_grado_cientifico.js',
            '5'=> $base.'components/com_cat_cientifica/assets/js/kendo_cat_cientifica.js',
            '6'=> $base.'components/com_clasificacion/assets/js/kendo_clasificacion.js',
            '7'=> $base.'components/com_tipo_proyecto/assets/js/kendo_tipo_proyecto.js',
            '8'=> $base.'components/com_evaluacion/assets/js/kendo_evaluacion.js',
            '9'=> $base.'components/com_forma_entrega/assets/js/kendo_forma_entrega.js',
            '10'=> $base.'components/com_estado_ejecucion_proyecto/assets/js/kendo_estado_ejecucion_proyecto.js',
            '11'=> $base.'components/com_problemas_detectados/assets/js/kendo_problemas_detectados.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('entidad');
        $view->display();
    }


    
public function entidad_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_provincia/models');
        $this->entidadmodel=JModelLegacy::getInstance('entidad');
        $provinciadmodel=JModelLegacy::getInstance('provincia');
        $list=$this->entidadmodel->loadAll('*');
        if($list!=false) {
            for ($i = 0; $i < count($list); $i++) {
                $provincia = (Object)$provinciadmodel->loadNombreProvincia($list[$i]->id_provincia);

                $list[$i]->provincia = $provincia->nombre_provincia;
                if($list[$i]->telefono==null)
                    $list[$i]->telefono=000-00-000;
                if($list[$i]->direccion==null)
                    $list[$i]->direccion='---';
                if($list[$i]->correo==null)
                    $list[$i]->correo='---';
                if($list[$i]->paginaWeb==null)
                    $list[$i]->paginaWeb='---';
                if($list[$i]->vision==null)
                    $list[$i]->vision='---';
                if($list[$i]->mision==null)
                    $list[$i]->mision='---';
            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }

       /* public function ejecutora_json_combo_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_ROOT. '/components/com_programa/models');
        $programamodel = JModelLegacy::getInstance('programa');
        $this->entidadmodel= JModelLegacy::getInstance('entidad');

        $programas = $programamodel->loadAll('*');
        $list=$this->entidadmodel->loadAll('*');
        $k =0;
        for($i=0;$i<count($list);$i++){
                $entidad = $list[$i];
            $found =false;
            for($j=0;$j<count($programas);$j++){
               $programa = $programas[$j];
                if($entidad->id_entidad== $programa->id_entidad && $programa->id_entidad != 19 ){
                $found =true;
                }
            }
            if($found==false) {
                $lista[$k] = $entidad;
                $k++;
            }

        }
        echo json_encode($lista);
        JFactory::getApplication()->close();
    }*/


    
public function entidad_add()
    {

        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $entidad = $this->input->post->get('entidad', array(), 'array');
        $this->entidadmodel=JModelLegacy::getInstance('entidad');
        $this->entidadmodel->bind($entidad);

        try {
            $this->entidadmodel->store();
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
                array('com_entidad')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_entidad');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function entidad_update()
    {


        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $entidad = $this->input->post->get('entidad', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $entidad['id_entidad']=$olditem1->id_entidad ;
        $this->entidadmodel=JModelLegacy::getInstance('entidad');
        $this->entidadmodel->bind($entidad);

        try {
            $this->entidadmodel->store();
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
                array('com_entidad')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_entidad');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }


    
public function entidad_delete_one()
    {
        // Check for request forgeries.
      //  JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $entidad =  json_decode($array['array']);  
         $this->entidadmodel=JModelLegacy::getInstance('entidad');
        foreach($entidad as $p){
            $this->entidadmodel->bind($p);
            try {
                $this->entidadmodel->delete();
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
                    array('com_entidad')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_entidad');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);
                JFactory::getApplication()->close();
            }
        }

    }


}
