    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Control_ejecucion_presupuesto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_control_ejecucion_presupuesto';
	public $control_ejecucion_presupuestotable;
	public $mesmodel;
	public $annomodel;
	public $anticipomodel;
	public $certificacion_activdades_resultadosmodel;
	public $notificacion_ingreso_gastosmodel;
	public $programamodel;
	public $proyectomodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->control_ejecucion_presupuestotable=JTable::getInstance('Control_ejecucion_presupuesto');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_mes');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->mesmodel=JModelLegacy::getInstance('Mes');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_anno');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->annomodel=JModelLegacy::getInstance('Anno');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_anticipo');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->anticipomodel=JModelLegacy::getInstance('Anticipo');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_certificacion_activdades_resultados');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->certificacion_activdades_resultadosmodel=JModelLegacy::getInstance('Certificacion_activdades_resultados');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_notificacion_ingreso_gastos');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->notificacion_ingreso_gastosmodel=JModelLegacy::getInstance('Notificacion_ingreso_gastos');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
    }


 function is_null()    
{
        return $this->control_ejecucion_presupuestotable->id_control_ejecucion_presupuesto==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->control_ejecucion_presupuestotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->control_ejecucion_presupuestotable->store();
    }


    function  bind($control_ejecucion_presupuesto)
    {
        return $this->control_ejecucion_presupuestotable->bind($control_ejecucion_presupuesto);
    }


     function load($pk)
    {
        $this->control_ejecucion_presupuestotable->load($pk);
        $this->mesmodel->load( $this->control_ejecucion_presupuestotable->id_mes);
        $this->annomodel->load( $this->control_ejecucion_presupuestotable->id_anno);
        $this->anticipomodel->load( $this->control_ejecucion_presupuestotable->id_anticipo);
        $this->certificacion_activdades_resultadosmodel->load( $this->control_ejecucion_presupuestotable->id_certificacion);
        $this->notificacion_ingreso_gastosmodel->load( $this->control_ejecucion_presupuestotable->id_notif_ingresos_gastos);
        $this->programamodel->load( $this->control_ejecucion_presupuestotable->id_programa);
        $this->proyectomodel->load( $this->control_ejecucion_presupuestotable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->control_ejecucion_presupuestotable->loadAll($key,$where);
    }
        function loadIdProgramas(){
            return $this->control_ejecucion_presupuestotable->loadIdProgramas();
        }


    function loadAllOr($key,$where=null)
    {
        return $this->control_ejecucion_presupuestotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->control_ejecucion_presupuestotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->control_ejecucion_presupuestotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->control_ejecucion_presupuestotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_control_ejecucion_presupuesto'=>$item->id_control_ejecucion_presupuesto

          	 );

            $control_ejecucion_presupuestoitem=JModelLegacy::getInstance('Control_ejecucion_presupuesto');
            $control_ejecucion_presupuestoitem->load($pk);
            array_push($modellist,$control_ejecucion_presupuestoitem);
        }
        return $modellist;
    }




   function getControl_ejecucion_presupuestoModelArray($condition)    {
       $control_ejecucion_presupuestoarraymodel= array();
       $control_ejecucion_presupuestolist=$this->loadAll('*',$condition);
		if(!$control_ejecucion_presupuestolist)
           return $control_ejecucion_presupuestoarraymodel;
        foreach($control_ejecucion_presupuestolist as $item)
        {
          	 $control_ejecucion_presupuestopk= array(
          	 	'id_control_ejecucion_presupuesto'=>$item->id_control_ejecucion_presupuesto

          	 );
            $item=JModelLegacy::getInstance('Control_ejecucion_presupuesto');
          	 $item->load($control_ejecucion_presupuestopk);
            array_push($control_ejecucion_presupuestoarraymodel,$item);
        }
        return $control_ejecucion_presupuestoarraymodel;
    }




}
