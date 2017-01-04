    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

    class Dictamen_eval_perfil_proy extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_dictamen_eval_perfil_proy';
	public $dictamen_eval_perfil_proytable;
	public $evaluacionmodel;
	public $perfil_proyectomodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->dictamen_eval_perfil_proytable=JTable::getInstance('Dictamen_eval_perfil_proy');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_evaluacion');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->evaluacionmodel=JModelLegacy::getInstance('Evaluacion');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->perfil_proyectomodel=JModelLegacy::getInstance('Perfil_proyecto');
    }


 function is_null()    
{
        return $this->dictamen_eval_perfil_proytable->id_dictamen==null;
    }


    function  store($id_proyecto,$evaluacion,$nombreperfil)
    {
        header('Content-Type: application/json');
        //Crear traza
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];

        $trazamodel->CreateTrace($accion,$entidad,$nombreperfil);
        //insertar en tabla proyecto
        $proyecto['id_proyecto'] = $id_proyecto;
       if($evaluacion == "aprobado") {
           JModelLegacy::addIncludePath(JPATH_ROOT .'/components/com_proyecto/models');
           $proyectomodel = JModelLegacy::getInstance('proyecto');
           $proyectomodel->bind($proyecto);
           try {
               $proyectomodel->store();
               $trazamodel->store();



           } catch (Exception $e) {
               JLog::addLogger(
                   array(
                       // Sets file name
                       'text_file' => 'logs.php'
                   ),
                   // Sets messages of all log levels to be sent to the file
                   JLog::ALL,
                   array('com_dictamen_eval_perfil_proy')
               );
               JLog::add($e->getMessage(),JLog::ERROR, 'com_dictamen_eval_perfil_proy');

           }

       }

        return $this->dictamen_eval_perfil_proytable->store();
    }
        function SendEmailtoProjectSenior($correoJefeProyecto,$correoJefePrograma,$nombreJefePrograma,$criterio,$evaluacion,$observaciones,$conclusiones,$recomendaciones){
        $mailer = JFactory::getMailer();
        $mailer->setSender( array( $correoJefePrograma, $nombreJefePrograma ) );
        $mailer->addRecipient( $correoJefeProyecto );
        $mailer->setSubject( 'Dictamen del Perfil de  Proyecto emitido por el Departamento Desarrollo Tecnologias e Inversiones del MINCOM' );
        $mailer->setBody(  'Tenga un saludo cordial, mediante la presente le informamos que en el proceso de seleccion y compatibilizacion de los perfiles quedo en la siguiente situación
        El criterio del Grupo de Experto:'.$criterio.'\n'.
            'La evaluacion obtenida:'.$evaluacion.'\n'.
            'Con las siguientes observaciones:'.$observaciones.'\n'.
            ',conclusiones'.$conclusiones.'\n'.
            'y recomendamos:'.$recomendaciones.'.');
        $mailer->Send();
        }


    function  bind($dictamen_eval_perfil_proy)
    {
        return $this->dictamen_eval_perfil_proytable->bind($dictamen_eval_perfil_proy);
    }


     function load($pk)
    {
        $this->dictamen_eval_perfil_proytable->load($pk);
        $this->evaluacionmodel->load( $this->dictamen_eval_perfil_proytable->id_evaluacion);
        $this->perfil_proyectomodel->load( $this->dictamen_eval_perfil_proytable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->dictamen_eval_perfil_proytable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->dictamen_eval_perfil_proytable->loadAllOr($key,$where);
    }


    function  delete($pk=null,$nombreperfil)
    {
        //Crear traza
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];

        $trazamodel->CreateTrace($accion,$entidad,$nombreperfil);
        return $this->dictamen_eval_perfil_proytable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->dictamen_eval_perfil_proytable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_dictamen'=>$item->id_dictamen

          	 );

            $dictamen_eval_perfil_proyitem=JModelLegacy::getInstance('Dictamen_eval_perfil_proy');
            $dictamen_eval_perfil_proyitem->load($pk);
            array_push($modellist,$dictamen_eval_perfil_proyitem);
        }
        return $modellist;
    }




   function getDictamen_eval_perfil_proyModelArray($condition)    {
       $dictamen_eval_perfil_proyarraymodel= array();
       $dictamen_eval_perfil_proylist=$this->loadAll('*',$condition);
		if(!$dictamen_eval_perfil_proylist)
           return $dictamen_eval_perfil_proyarraymodel;
        foreach($dictamen_eval_perfil_proylist as $item)
        {
          	 $dictamen_eval_perfil_proypk= array(
          	 	'id_dictamen'=>$item->id_dictamen

          	 );
            $item=JModelLegacy::getInstance('Dictamen_eval_perfil_proy');
          	 $item->load($dictamen_eval_perfil_proypk);
            array_push($dictamen_eval_perfil_proyarraymodel,$item);
        }
        return $dictamen_eval_perfil_proyarraymodel;
    }




}
