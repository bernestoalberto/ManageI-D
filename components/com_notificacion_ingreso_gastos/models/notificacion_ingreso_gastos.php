    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Notificacion_ingreso_gastos extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_notificacion_ingreso_gastos';
	public $notificacion_ingreso_gastostable;
	public $anticipomodel;
	public $evaluacionmodel;
	public $programamodel;
	public $control_ejecucion_presupuestoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->notificacion_ingreso_gastostable=JTable::getInstance('Notificacion_ingreso_gastos');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_anticipo');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->anticipomodel=JModelLegacy::getInstance('Anticipo');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_evaluacion');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->evaluacionmodel=JModelLegacy::getInstance('Evaluacion');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $this->control_ejecucion_presupuestoarray_model=array();
    }
        function SendEmailtoProjectSenior($correoJefeProyecto,$correoSecretarioPrograma,$nombreSecretarioPrograma,$file,$nombre){
            $mailer = JFactory::getMailer();
            $mailer->setSender(array( $correoSecretarioPrograma, $nombreSecretarioPrograma ));
            $mailer->addRecipient( $correoJefeProyecto );
            $mailer->setSubject( $nombre );
            $mailer->setBody(  'Tenga un saludo cordial, mediante la presente le informamos que se le autotiza a registrar como ingreso y gastos los siguientes datos. Para mas detalles, consultar el adjunto');
            $mailer->addAttachment($file);
            $mailer->Send();
        }
        function SendEmailtoFinancista($correoFinancista,$correoSecretarioPrograma,$nombreSecretarioPrograma,$file,$nombre){
            $mailer = JFactory::getMailer();
            $mailer->setSender(array( $correoSecretarioPrograma, $nombreSecretarioPrograma ));
            $mailer->addRecipient( $correoFinancista );
            $mailer->setSubject( $nombre );
            $mailer->setBody(  'Tenga un saludo cordial, mediante la presente le informamos que se le autotiza a registrar como ingreso y gastos los siguientes datos. Para mas detalles, consultar el adjunto');
            $mailer->addAttachment($file);
            $mailer->Send();
        }

 function is_null()    
{
        return $this->notificacion_ingreso_gastostable->id_notif_ingresos_gastos==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->notificacion_ingreso_gastostable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->notificacion_ingreso_gastostable->store();
    }


    function  bind($notificacion_ingreso_gastos)
    {
        return $this->notificacion_ingreso_gastostable->bind($notificacion_ingreso_gastos);
    }


     function load($pk)
    {
        $this->notificacion_ingreso_gastostable->load($pk);
        $this->anticipomodel->load( $this->notificacion_ingreso_gastostable->id_anticipo);
        $this->evaluacionmodel->load( $this->notificacion_ingreso_gastostable->id_evaluacion);
        $this->programamodel->load( $this->notificacion_ingreso_gastostable->id_programa);
    }


    function loadAll($key,$where=null)
    {
        return $this->notificacion_ingreso_gastostable->loadAll($key,$where);
    }
   function loadNotify($key)
    {
        return $this->notificacion_ingreso_gastostable->loadNotify($key);
    }

        function loadNotificationbyProyecto($key,$anno,$etapa)
        {
            $lista =$this->notificacion_ingreso_gastostable->loadNotificationbyProyecto($key,$anno);
            $i=0;
            $found = false;

            while($i<count($lista)  ){

                if($lista[$i]->etapa == $etapa || $found == false){
                    $notificacion=$lista[$i];
                    $found = true;
                }
                $i++;
            }


            return $notificacion;
        }


    function loadAllOr($key,$where=null)
    {
        return $this->notificacion_ingreso_gastostable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->notificacion_ingreso_gastostable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->notificacion_ingreso_gastostable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->notificacion_ingreso_gastostable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_notif_ingresos_gastos'=>$item->id_notif_ingresos_gastos

          	 );

            $notificacion_ingreso_gastositem=JModelLegacy::getInstance('Notificacion_ingreso_gastos');
            $notificacion_ingreso_gastositem->load($pk);
            array_push($modellist,$notificacion_ingreso_gastositem);
        }
        return $modellist;
    }




   function getNotificacion_ingreso_gastosModelArray($condition)    {
       $notificacion_ingreso_gastosarraymodel= array();
       $notificacion_ingreso_gastoslist=$this->loadAll('*',$condition);
		if(!$notificacion_ingreso_gastoslist)
           return $notificacion_ingreso_gastosarraymodel;
        foreach($notificacion_ingreso_gastoslist as $item)
        {
          	 $notificacion_ingreso_gastospk= array(
          	 	'id_notif_ingresos_gastos'=>$item->id_notif_ingresos_gastos

          	 );
            $item=JModelLegacy::getInstance('Notificacion_ingreso_gastos');
          	 $item->load($notificacion_ingreso_gastospk);
            array_push($notificacion_ingreso_gastosarraymodel,$item);
        }
        return $notificacion_ingreso_gastosarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Control_ejecucion_presupuesto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_ejecucion_presupuesto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_notif_ingresos_gastos='.$this->notificacion_ingreso_gastostable->id_notif_ingresos_gastos
        	);
        $control_ejecucion_presupuesto=JModelLegacy::getInstance('Control_ejecucion_presupuesto');
        $this->control_ejecucion_presupuestoarray_model=$control_ejecucion_presupuesto->getControl_ejecucion_presupuestoModelArray($condition);

    }


}
