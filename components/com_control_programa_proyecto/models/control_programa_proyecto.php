    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Control_programa_proyecto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_control_programa_proyecto';
	public $control_programa_proyectotable;
	public $ejecutoramodel;
	public $estado_ejecucion_proyectomodel;
	public $problemas_detectadosmodel;
	public $proyectomodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->control_programa_proyectotable=JTable::getInstance('Control_programa_proyecto');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_ejecutora');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->ejecutoramodel=JModelLegacy::getInstance('Ejecutora');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_estado_ejecucion_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->estado_ejecucion_proyectomodel=JModelLegacy::getInstance('Estado_ejecucion_proyecto');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_problemas_detectados');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->problemas_detectadosmodel=JModelLegacy::getInstance('Problemas_detectados');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
    }


 function is_null()    
{
        return $this->control_programa_proyectotable->id_control==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->control_programa_proyectotable->nombre;;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->control_programa_proyectotable->store();
    }


    function  bind($control_programa_proyecto)
    {
        return $this->control_programa_proyectotable->bind($control_programa_proyecto);
    }


     function load($pk)
    {
        $this->control_programa_proyectotable->load($pk);
        $this->ejecutoramodel->load( $this->control_programa_proyectotable->id_entidad);
        $this->estado_ejecucion_proyectomodel->load( $this->control_programa_proyectotable->id_estado_ejecucion_proyecto);
        $this->problemas_detectadosmodel->load( $this->control_programa_proyectotable->id_problema_detectado);
        $this->proyectomodel->load( $this->control_programa_proyectotable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->control_programa_proyectotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->control_programa_proyectotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->control_programa_proyectotable->nombre;;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);


        return $this->control_programa_proyectotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->control_programa_proyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_control'=>$item->id_control

          	 );

            $control_programa_proyectoitem=JModelLegacy::getInstance('Control_programa_proyecto');
            $control_programa_proyectoitem->load($pk);
            array_push($modellist,$control_programa_proyectoitem);
        }
        return $modellist;
    }




   function getControl_programa_proyectoModelArray($condition)    {
       $control_programa_proyectoarraymodel= array();
       $control_programa_proyectolist=$this->loadAll('*',$condition);
		if(!$control_programa_proyectolist)
           return $control_programa_proyectoarraymodel;
        foreach($control_programa_proyectolist as $item)
        {
          	 $control_programa_proyectopk= array(
          	 	'id_control'=>$item->id_control

          	 );
            $item=JModelLegacy::getInstance('Control_programa_proyecto');
          	 $item->load($control_programa_proyectopk);
            array_push($control_programa_proyectoarraymodel,$item);
        }
        return $control_programa_proyectoarraymodel;
    }




}
