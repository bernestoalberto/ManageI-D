<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
jimport('joomla.log.log');

class AnticipoController extends JControllerLegacy
{


    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_anticipo';
    public $anticipomodel;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->anticipomodel=JModelLegacy::getInstance('anticipo');
    }



    public function anticipo()
    {
        $base = JFactory::getUri()->base();
        $list = array(
            '1'=>$base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js',
            '2'=>$base.'components/com_notificacion_ingreso_gastos/assets/js/kendo_notificacion_ingreso_gastos.js',
            '3'=> $base.'components/com_oponencia_informe_etapa/assets/js/kendo_oponencia_informe_etapa.js',
            '4'=> $base.'components/com_dictamen_grupo_expertos_inf_etapa/assets/js/kendo_dictamen_grupo_expertos_inf_etapa.js',
            '5'=> $base.'components/com_informe_ejecucion_programa/assets/js/kendo_informe_ejecucion_programa.js'

        );
        array_push(JFactory::getDocument()->_script,$list);
        $view = $this->getView('anticipo');
        $view->display();
    }



    public function anticipo_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_mes/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_ejecutora/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_anno/models');
        $this->anticipomodel=JModelLegacy::getInstance('anticipo');
        $list=$this->anticipomodel->loadAll('*');
        if($list!=false){

            $ejecutoramodel=JModelLegacy::getInstance('ejecutora');
            $programamodel=JModelLegacy::getInstance('programa');
            $personamodel=JModelLegacy::getInstance('persona');
            $entidadmodel=JModelLegacy::getInstance('entidad');
            $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
            // $annomodel=JModelLegacy::getInstance('anno');

            for($i=0;$i<count($list);$i++){


                $profile =(Object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);
                $list[$i]->proyecto = $profile->titulo_proyecto;
                $list[$i]->anno = $list[$i]->anno;
                $entidad= $entidadmodel->loadNombreEntidad($profile->id_entidad);
                $ejecutora=(Object) $ejecutoramodel->loadEjecutora($profile->id_entidad);
                $list[$i]->ejecutor=$entidad->nombre;
                $list[$i]->codigo=$ejecutora->id_entidad;
                $list[$i]->cuenta_bancaria=$ejecutora->numero_cuenta_bancaria;
                $list[$i]->sucursal_creditos=$ejecutora->sucursal_creditos;
                $programa = (Object)$programamodel->loadPrograma( $list[$i]->id_programa);
                $list[$i]->programa = $programa->nombre;
                $persona = (Object)$personamodel->loadPersona( $programa->secretarioprograma);
                $list[$i]->secretario=$persona->nombre;


            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }



    public function anticipo_add()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_programa/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_entidad/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_financista/models');

        $anticipo = $this->input->post->get('anticipo', array(), 'array');
        $this->anticipomodel=JModelLegacy::getInstance('anticipo');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $personamodel=JModelLegacy::getInstance('persona');
        $programamodel=JModelLegacy::getInstance('programa');
        $entidadmodel=JModelLegacy::getInstance('entidad');
        $financistamodel=JModelLegacy::getInstance('financista');

        $profile = (Object)$perfilproyectomodel->loadPerfilProyecto($anticipo['id_proyecto']);
        $anticipo['id_programa']=$profile->id_programa;
        $this->anticipomodel->bind($anticipo);
        try {
            $this->anticipomodel->store();
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
                array('com_anticipo')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_anticipo');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su inserción';
            echo json_encode($response);
            JFactory::getApplication()->close();

        }

        //Necesario para enviar correo a financista y ejecutor
        $programa = (Object)$programamodel->loadPrograma($profile->id_programa);
        $secretario_programa= (Object)$personamodel->loadPersona($programa->secretarioprograma);
        $JefeProyecto= (Object)$personamodel->loadPersona($profile->id_persona);
        $ejecutor= (Object)$entidadmodel->loadNombreEntidad($profile->id_entidad);
        $id_financista= (Object)$financistamodel->loadEntidadFinancista($anticipo['id_proyecto']);
        $financista = (Object)$entidadmodel->loadEntidad($id_financista->id_entidad);

        $correoJefeProyecto = $JefeProyecto->correo;
        $correoSecretarioPrograma=$secretario_programa->correo;
        $nombreSecretarioPrograma=$secretario_programa->nombre. $secretario_programa->apellido;
        $correoFinancista = $financista->correo;
        $concat=array();
        $concat['head']=' Mediante la presente le adjuntamos los datos necesarios para la continiuidad del proceso'.                     '';
        $concat['anno']= $anticipo['anno'].'                           ';
        $concat['etapa']= $anticipo['etapa'].'                           ';
        $concat['programa']= $programa->nombre.'                           ';
        $concat['proyecto']= $profile->titulo_proyecto.'                           ';
        $concat['anticipo']= $anticipo['cantidad_anticipa'].'                           ';
        $concat['nombre_recibe']= $anticipo['nombre_recibe'].'                           ';
        $concat['cargo_recibe']= $anticipo['cargo_recibe'].'                           ';
        $concat['fecha_recibe']= $anticipo['fecha_recibe'].'                           ';
        $concat['fecha_firma']= $anticipo['fecha_firma'].'                           ';
        $resultado=  file_put_contents(JPATH_ANTICIPOFILES,$concat);
        $file = file_get_contents(JPATH_ANTICIPOFILES);
        $nombre= "Modelo Anticipo";
        if($resultado!=false){
            // enviar correo a jefe proyecto;
            $this->anticipomodel->SendEmailtoProjectSenior($correoJefeProyecto,$correoSecretarioPrograma,$nombreSecretarioPrograma,$file,$nombre);
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_anticipo')
            );
            JLog::add("correo enviado",JLog::NOTICE);
            if($correoFinancista!=null) {
                $this->anticipomodel->SendEmailtoFinancista($correoFinancista, $correoSecretarioPrograma, $nombreSecretarioPrograma, $file, $nombre);
                JLog::addLogger(
                    array(
                        // Sets file name
                        'text_file' => 'logs.php'
                    ),
                    // Sets messages of all log levels to be sent to the file
                    JLog::ALL,
                    array('com_anticipo')
                );
                JLog::add("correo enviado",JLog::NOTICE, 'com_anticipo');
            }
            else{
                JLog::addLogger(
                    array(
                        // Sets file name
                        'text_file' => 'logs.php'
                    ),
                    // Sets messages of all log levels to be sent to the file
                    JLog::ALL,
                    array('com_anticipo')
                );
                JLog::add("No se pudo enviar el correo  al financista".$financista->nombre."",JLog::ERROR, 'com_anticipo');
             //   JFactory::getApplication()->close();
            }

        }


        else{
            JLog::addLogger(
                array(
                    // Sets file name
                    'text_file' => 'logs.php'
                ),
                // Sets messages of all log levels to be sent to the file
                JLog::ALL,
                array('com_anticipo')
            );
            JLog::add("No se pudo enviar el correo al ejecutor".$ejecutor->nombre."y al financista".$financista->nombre."",JLog::ERROR, 'com_anticipo');
           // JFactory::getApplication()->close();
        }


    }



    public function anticipo_update()
    {
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        $anticipo = $this->input->post->get('anticipo', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;
        $olditem1 =json_decode($olditem[0]);
        $anticipo['id_anticipo']=$olditem1->id_anticipo ;
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $profile = $perfilproyectomodel->loadPerfilProyecto($anticipo['id_proyecto']);
        $anticipo['id_programa']=$profile->id_programa;
        /*    $date =JFactory::getDate()->toSql( $anticipo['fecha_recibe']);
            $anticipo['fecha_recibe']=$date;
            $date1 =JFactory::getDate()->toSql( $anticipo['fecha_firma']);
            $anticipo['fecha_firma']=$date1;*/
        $this->anticipomodel=JModelLegacy::getInstance('anticipo');

        $this->anticipomodel->bind($anticipo);

        try {
            $this->anticipomodel->store();
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
                array('com_anticipo')
            );
            JLog::add($e->getMessage(),JLog::ERROR, 'com_anticipo');
            $response= new stdClass();
            $response->success=false;
            $response->message='Este elemento  no es posible su modificación';
            echo json_encode($response);
            JFactory::getApplication()->close();
        }

    }



    public function anticipo_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');
        $array = $this->input->post->getArray();
        $anticipo =  json_decode($array['array']);
        $this->anticipomodel=JModelLegacy::getInstance('anticipo');
        foreach($anticipo as $p){
            $this->anticipomodel->bind($p);
            try {
                $this->anticipomodel->delete();
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
                    array('com_anticipo')
                );
                JLog::add($e->getMessage(),JLog::ERROR, 'com_anticipo');
                $response= new stdClass();
                $response->success=false;
                $response->message='Este elemento esta Asociado no es posible su eliminación';
                echo json_encode($response);
                JFactory::getApplication()->close();
            } }

    }


}
