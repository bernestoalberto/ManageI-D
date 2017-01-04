<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');
jimport('joomla.filesystem.file');

class JefeproyectoController extends JControllerLegacy
{


    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_jefeproyecto';
    public $jefeproyectomodel;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->jefeproyectomodel=JModelLegacy::getInstance('jefeproyecto');
    }



    public function jefeproyecto()
    {

        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_ejecutora/assets/js/kendo_ejecutora.js',
            '3'=>$base.'components/com_perfil_proyecto/assets/js/kendo_perfil_proyecto.js',
            '4'=> $base.'components/com_innovacion/assets/js/kendo_innovacion.js',
            '5'=> $base.'components/com_i_d/assets/js/kendo_i_d.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('jefeproyecto');
        $view->display();
    }
    public function jefeproyecto_list_combo()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_COMPONENT.'/components/com_persona/models');
        $this->jefeproyectomodel=JModelLegacy::getInstance('jefeproyecto');
        $personamodel = JModelLegacy::getInstance('persona');
        $list=$this->jefeproyectomodel->loadAll('*');
        if($list!=false) {
            foreach ($list as $item) {
                $persona = $personamodel->loadNombreSecretPersona($item->id_persona);
                $item->nombre = $persona->nombre;
            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }
    public function jefeproyecto_one_list($id_proeycto)
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_COMPONENT.'/components/com_persona/models');
        $this->jefeproyectomodel=JModelLegacy::getInstance('jefeproyecto');
        $list=$this->jefeproyectomodel->loadJefeProject($id_proeycto);
        if($list!=false)
            echo json_encode($list);

        JFactory::getApplication()->close();
    }




    public function jefeproyecto_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath(JPATH_COMPONENT.'/components/com_persona/models');
        JModelLegacy::addIncludePath(JPATH_COMPONENT.'/components/com_grado_cientifico/models');
        JModelLegacy::addIncludePath(JPATH_COMPONENT.'/components/com_cat_cientifica/models');

        $this->jefeproyectomodel=JModelLegacy::getInstance('jefeproyecto');
        $list=$this->jefeproyectomodel->loadAll('*');
        if($list!=false) {
            $personamodel = JModelLegacy::getInstance('persona');
            $catmodel = JModelLegacy::getInstance('cat_cientifica');
            $gradomodel = JModelLegacy::getInstance('grado_cientifico');

            for ($i = 0; $i < count($list); $i++) {

                $persona = $personamodel->loadPersona($list[$i]->id_persona);
                $cat = $catmodel->loadNombreCategory($list[$i]->id_categoria);
                $grade = $gradomodel->loadNombreGRade($list[$i]->id_grado);

                $list[$i]->nombre = $persona->nombre;
                $list[$i]->categoria = $cat->categoria;
                $list[$i]->grado = $grade->grado;
                if( $list[$i]->otros_aspectos =="")
                    $list[$i]->otros_aspectos= "-------";
            }

            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }

    public function personasdisponibles_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath(JPATH_COMPONENT . '/components/com_persona/models');
        //JModelLegacy::addIncludePath(JPATH_COMPONENT . '/components/com_programa/models');
        $personamodel = JModelLegacy::getInstance('persona');
       /* $programamodel = JModelLegacy::getInstance('programa');
        $list=[];
        $k=0;*/
        $listpersonas = $personamodel->loadAll('*');
        //$listprogramas = $programamodel->loadAll('*');
 /*       for ($i = 0; $i < count($listpersonas); $i++) {
            $found = false;
            $persona = $listpersonas[$i];

            for ($j = 0; $j < count($listprogramas); $j++) {
                $programa = $listprogramas[$j];

                if ($persona->id_persona == $programa->id_persona || $persona->id_persona == $programa->secretarioprograma)
                    $found = true;
            }

        if ($found == false) {
            $list[$k] = $persona;
            $k++;

        }

    }*/

        echo json_encode($listpersonas);
        JFactory::getApplication()->close();
    }


    public function jefeproyecto_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $jefeproyecto = $this->input->post->get('jefeproyecto', array(), 'array');
        $this->jefeproyectomodel=JModelLegacy::getInstance('jefeproyecto');


        $file =  $this->input->files->get('jefeproyecto',array(),'array');
        $name = $file['cv']['name'];
        $tmp_name= $file['cv']['tmp_name'];
        $error = $file['cv']['error'];
        $path = JPATH_CV.$name;
        $path=JPath::clean($path);

        if ( $error == UPLOAD_ERR_OK) {
            $r= JFile::upload($tmp_name,$path,false,false);
            if( $r==true)
                $jefeproyecto['cv']=$path ;

        }
        $this->jefeproyectomodel->bind($jefeproyecto);
        try {
            $this->jefeproyectomodel->store();
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
                array('com_jefeproyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_jefeproyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento no es posible añadirlo';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function jefeproyecto_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

        $jefeproyecto = $this->input->post->get('jefeproyecto', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $jefeproyecto['id_persona']=$olditem1->id_persona ;
        $this->jefeproyectomodel=JModelLegacy::getInstance('jefeproyecto');



        $file =  $this->input->files->get('jefeproyecto',array(),'array');
        $name = $file['cv']['name'];
        $tmp_name= $file['cv']['tmp_name'];
        $error = $file['cv']['error'];
        $path = JPATH_CV.$name;
        $path=JPath::clean($path);

        if ( $error == UPLOAD_ERR_OK) {
            $r= JFile::upload($tmp_name,$path,false,false);
            if( $r==true)
                $jefeproyecto['cv']=$path ;

        }
        $this->jefeproyectomodel->bind($jefeproyecto);

        try {

            $this->jefeproyectomodel->store();
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
                array('com_jefeproyecto')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_jefeproyecto');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function jefeproyecto_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $jefeproyecto =  json_decode($array['array']);
        $this->jefeproyectomodel=JModelLegacy::getInstance('jefeproyecto');
        for($i=0;$i<count($jefeproyecto);$i++) {

            $this->jefeproyectomodel->bind($jefeproyecto[$i]);

            try {

                $this->jefeproyectomodel->delete();
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
                    array('com_jefeproyecto')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_jefeproyecto');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);
                JFactory::getApplication()->close();
            }
        }
    }


}
