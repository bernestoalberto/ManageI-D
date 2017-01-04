    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Estado_ejecucion_proyecto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_estado_ejecucion_proyecto';
	public $estado_ejecucion_proyectotable;
	public $control_programa_proyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->estado_ejecucion_proyectotable=JTable::getInstance('Estado_ejecucion_proyecto');

        $this->control_programa_proyectoarray_model=array();
    }


 function is_null()    
{
        return $this->estado_ejecucion_proyectotable->id_estado_ejecucion_proyecto==null;
    }
        function loadEstado($key)
        {
            return $this->estado_ejecucion_proyectotable->loadEstado($key);
        }

    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->estado_ejecucion_proyectotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->estado_ejecucion_proyectotable->store();
    }


    function  bind($estado_ejecucion_proyecto)
    {
        return $this->estado_ejecucion_proyectotable->bind($estado_ejecucion_proyecto);
    }


     function load($pk)
    {
        $this->estado_ejecucion_proyectotable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->estado_ejecucion_proyectotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->estado_ejecucion_proyectotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->estado_ejecucion_proyectotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->estado_ejecucion_proyectotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->estado_ejecucion_proyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_estado_ejecucion_proyecto'=>$item->id_estado_ejecucion_proyecto

          	 );

            $estado_ejecucion_proyectoitem=JModelLegacy::getInstance('Estado_ejecucion_proyecto');
            $estado_ejecucion_proyectoitem->load($pk);
            array_push($modellist,$estado_ejecucion_proyectoitem);
        }
        return $modellist;
    }




   function getEstado_ejecucion_proyectoModelArray($condition)    {
       $estado_ejecucion_proyectoarraymodel= array();
       $estado_ejecucion_proyectolist=$this->loadAll('*',$condition);
		if(!$estado_ejecucion_proyectolist)
           return $estado_ejecucion_proyectoarraymodel;
        foreach($estado_ejecucion_proyectolist as $item)
        {
          	 $estado_ejecucion_proyectopk= array(
          	 	'id_estado_ejecucion_proyecto'=>$item->id_estado_ejecucion_proyecto

          	 );
            $item=JModelLegacy::getInstance('Estado_ejecucion_proyecto');
          	 $item->load($estado_ejecucion_proyectopk);
            array_push($estado_ejecucion_proyectoarraymodel,$item);
        }
        return $estado_ejecucion_proyectoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Control_programa_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_programa_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_estado_ejecucion_proyecto='.$this->estado_ejecucion_proyectotable->id_estado_ejecucion_proyecto
        	);
        $control_programa_proyecto=JModelLegacy::getInstance('Control_programa_proyecto');
        $this->control_programa_proyectoarray_model=$control_programa_proyecto->getControl_programa_proyectoModelArray($condition);

    }


}
