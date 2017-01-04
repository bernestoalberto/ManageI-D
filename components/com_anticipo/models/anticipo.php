    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

    class Anticipo extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_anticipo';
	public $anticipotable;
	public $annomodel;
	public $programamodel;
	public $proyectomodel;
	public $certificacion_activdades_resultadosarray_model;
	public $control_ejecucion_presupuestoarray_model;
	public $notificacion_ingreso_gastosarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->anticipotable=JTable::getInstance('Anticipo');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_anno');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->annomodel=JModelLegacy::getInstance('Anno');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
        $this->certificacion_activdades_resultadosarray_model=array();
        $this->control_ejecucion_presupuestoarray_model=array();
        $this->notificacion_ingreso_gastosarray_model=array();
    }


 function is_null()    
{
        return $this->anticipotable->id_anticipo==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->anticipotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->anticipotable->store();
    }

        function SendEmailtoProjectSenior($correoJefeProyecto,$correoSecretarioPrograma,$nombreSecretarioPrograma,$file,$nombre){
            $mailer = JFactory::getMailer();
            $mailer->setSender(array( $correoSecretarioPrograma, $nombreSecretarioPrograma ));
            $mailer->addRecipient( $correoJefeProyecto );
            $mailer->setSubject( $nombre );
            $mailer->setBody(  'Tenga un saludo cordial, mediante la presente le informamos que se le anticipa dinero. Para mas detalles, consultar el adjunto');
            $mailer->addAttachment($file);
            $mailer->Send();
        }
        function SendEmailtoFinancista($correoFinancista,$correoSecretarioPrograma,$nombreSecretarioPrograma,$file,$nombre){
            $mailer = JFactory::getMailer();
            $mailer->setSender(array( $correoSecretarioPrograma, $nombreSecretarioPrograma ));
            $mailer->addRecipient( $correoFinancista );
            $mailer->setSubject( $nombre );
            $mailer->setBody(  'Tenga un saludo cordial, mediante la presente le informamos que se le anticipa dinero. Para mas detalles, consultar el adjunto');
            $mailer->addAttachment($file);
            $mailer->Send();
        }

    function  bind($anticipo)
    {
        return $this->anticipotable->bind($anticipo);
    }


     function load($pk)
    {
        $this->anticipotable->load($pk);
        $this->annomodel->load( $this->anticipotable->id_anno);
        $this->programamodel->load( $this->anticipotable->id_programa);
        $this->proyectomodel->load( $this->anticipotable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->anticipotable->loadAll($key,$where);
    }
  function loadAnticipo($key)
    {
        return $this->anticipotable->loadAnticipo($key);
    }

        function loadAnticipobyProyecto($key,$anno,$etapa)
    {
        $lista =$this->anticipotable->loadAnticipobyProyecto($key,$anno);
        $i=0;
        $found = false;
        while($i<count($lista) ){
          if($lista[$i]->etapa == $etapa || $found != true ){
              $anticipo=$lista[$i];
              $found = true;
          }
            $i++;
        }


       return $anticipo;
    }


    function loadAllOr($key,$where=null)
    {
        return $this->anticipotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->anticipotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->anticipotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->anticipotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_anticipo'=>$item->id_anticipo

          	 );

            $anticipoitem=JModelLegacy::getInstance('Anticipo');
            $anticipoitem->load($pk);
            array_push($modellist,$anticipoitem);
        }
        return $modellist;
    }




   function getAnticipoModelArray($condition)    {
       $anticipoarraymodel= array();
       $anticipolist=$this->loadAll('*',$condition);
		if(!$anticipolist)
           return $anticipoarraymodel;
        foreach($anticipolist as $item)
        {
          	 $anticipopk= array(
          	 	'id_anticipo'=>$item->id_anticipo

          	 );
            $item=JModelLegacy::getInstance('Anticipo');
          	 $item->load($anticipopk);
            array_push($anticipoarraymodel,$item);
        }
        return $anticipoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Certificacion_activdades_resultados
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_certificacion_activdades_resultados');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_anticipo='.$this->anticipotable->id_anticipo
        	);
        $certificacion_activdades_resultados=JModelLegacy::getInstance('Certificacion_activdades_resultados');
        $this->certificacion_activdades_resultadosarray_model=$certificacion_activdades_resultados->getCertificacion_activdades_resultadosModelArray($condition);
        
        //Dependencia con la tabla Control_ejecucion_presupuesto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_ejecucion_presupuesto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_anticipo='.$this->anticipotable->id_anticipo
        	);
        $control_ejecucion_presupuesto=JModelLegacy::getInstance('Control_ejecucion_presupuesto');
        $this->control_ejecucion_presupuestoarray_model=$control_ejecucion_presupuesto->getControl_ejecucion_presupuestoModelArray($condition);
        
        //Dependencia con la tabla Notificacion_ingreso_gastos
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_notificacion_ingreso_gastos');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_anticipo='.$this->anticipotable->id_anticipo
        	);
        $notificacion_ingreso_gastos=JModelLegacy::getInstance('Notificacion_ingreso_gastos');
        $this->notificacion_ingreso_gastosarray_model=$notificacion_ingreso_gastos->getNotificacion_ingreso_gastosModelArray($condition);

    }


}
