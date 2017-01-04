    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Certificacion_activdades_resultados extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_certificacion_activdades_resultados';
	public $certificacion_activdades_resultadostable;
	public $anticipomodel;
	public $estado_cumplimientomodel;
	public $evaluacionmodel;
	public $programamodel;
	public $proyectomodel;
	public $control_ejecucion_presupuestoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->certificacion_activdades_resultadostable=JTable::getInstance('Certificacion_activdades_resultados');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_anticipo');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->anticipomodel=JModelLegacy::getInstance('Anticipo');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_estado_cumplimiento');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->estado_cumplimientomodel=JModelLegacy::getInstance('Estado_cumplimiento');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_evaluacion');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->evaluacionmodel=JModelLegacy::getInstance('Evaluacion');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
        $this->control_ejecucion_presupuestoarray_model=array();
    }


 function is_null()    
{
        return $this->certificacion_activdades_resultadostable->id_certificacion==null;
    }
        function SendEmailtoSecretarioPrograma($correoJefeProyecto,$nombrejefeproyecto,$correoSecretarioPrograma,$file,$nombre){
            $mailer = JFactory::getMailer();
            $mailer->setSender(array( $correoJefeProyecto, $nombrejefeproyecto ));
            $mailer->addRecipient( $correoSecretarioPrograma );
            $mailer->setSubject( $nombre );
            $mailer->setBody( 'Tenga un saludo cordial, mediante la presente le informamos que se le envía la certificacion de actividades resultados. Para mas detalles, consultar el adjunto');
            $mailer->addAttachment($file);
            $mailer->Send();
        }

    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->certificacion_activdades_resultadostable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->certificacion_activdades_resultadostable->store();
    }


    function  bind($certificacion_activdades_resultados)
    {
        return $this->certificacion_activdades_resultadostable->bind($certificacion_activdades_resultados);
    }


     function load($pk)
    {
        $this->certificacion_activdades_resultadostable->load($pk);
        $this->anticipomodel->load( $this->certificacion_activdades_resultadostable->id_anticipo);
        $this->estado_cumplimientomodel->load( $this->certificacion_activdades_resultadostable->id_estado_cumplimiento);
        $this->evaluacionmodel->load( $this->certificacion_activdades_resultadostable->id_evaluacion);
        $this->programamodel->load( $this->certificacion_activdades_resultadostable->id_programa);
        $this->proyectomodel->load( $this->certificacion_activdades_resultadostable->id_proyecto);
    }
    function loadCertifybyProyecto($pk,$anno,$etapa){
    return $this->certificacion_activdades_resultadostable->loadCertifybyProyecto($pk,$anno,$etapa);
    }
        function loadCertificado($key)
        {
            return $this->certificacion_activdades_resultadostable->loadCertificado($key);
        }


    function loadAll($key,$where=null)
    {
        return $this->certificacion_activdades_resultadostable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->certificacion_activdades_resultadostable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->certificacion_activdades_resultadostable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->certificacion_activdades_resultadostable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->certificacion_activdades_resultadostable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_certificacion'=>$item->id_certificacion

          	 );

            $certificacion_activdades_resultadositem=JModelLegacy::getInstance('Certificacion_activdades_resultados');
            $certificacion_activdades_resultadositem->load($pk);
            array_push($modellist,$certificacion_activdades_resultadositem);
        }
        return $modellist;
    }




   function getCertificacion_activdades_resultadosModelArray($condition)    {
       $certificacion_activdades_resultadosarraymodel= array();
       $certificacion_activdades_resultadoslist=$this->loadAll('*',$condition);
		if(!$certificacion_activdades_resultadoslist)
           return $certificacion_activdades_resultadosarraymodel;
        foreach($certificacion_activdades_resultadoslist as $item)
        {
          	 $certificacion_activdades_resultadospk= array(
          	 	'id_certificacion'=>$item->id_certificacion

          	 );
            $item=JModelLegacy::getInstance('Certificacion_activdades_resultados');
          	 $item->load($certificacion_activdades_resultadospk);
            array_push($certificacion_activdades_resultadosarraymodel,$item);
        }
        return $certificacion_activdades_resultadosarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Control_ejecucion_presupuesto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_ejecucion_presupuesto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_certificacion='.$this->certificacion_activdades_resultadostable->id_certificacion
        	);
        $control_ejecucion_presupuesto=JModelLegacy::getInstance('Control_ejecucion_presupuesto');
        $this->control_ejecucion_presupuestoarray_model=$control_ejecucion_presupuesto->getControl_ejecucion_presupuestoModelArray($condition);

    }


}
