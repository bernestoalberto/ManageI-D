    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Tipo_proyecto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_tipo_proyecto';
	public $tipo_proyectotable;
	public $perfil_proyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->tipo_proyectotable=JTable::getInstance('Tipo_proyecto');

        $this->perfil_proyectoarray_model=array();
    }


 function is_null()    
{
        return $this->tipo_proyectotable->id_tipo_proyecto==null;
    }
        function loadNombreTipoProyecto($pk){
            return $this->tipo_proyectotable->loadNombreTipoProyecto($pk);
        }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->tipo_proyectotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->tipo_proyectotable->store();
    }


    function  bind($tipo_proyecto)
    {
        return $this->tipo_proyectotable->bind($tipo_proyecto);
    }


     function load($pk)
    {
        $this->tipo_proyectotable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->tipo_proyectotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->tipo_proyectotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->tipo_proyectotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->tipo_proyectotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->tipo_proyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_tipo_proyecto'=>$item->id_tipo_proyecto

          	 );

            $tipo_proyectoitem=JModelLegacy::getInstance('Tipo_proyecto');
            $tipo_proyectoitem->load($pk);
            array_push($modellist,$tipo_proyectoitem);
        }
        return $modellist;
    }




   function getTipo_proyectoModelArray($condition)    {
       $tipo_proyectoarraymodel= array();
       $tipo_proyectolist=$this->loadAll('*',$condition);
		if(!$tipo_proyectolist)
           return $tipo_proyectoarraymodel;
        foreach($tipo_proyectolist as $item)
        {
          	 $tipo_proyectopk= array(
          	 	'id_tipo_proyecto'=>$item->id_tipo_proyecto

          	 );
            $item=JModelLegacy::getInstance('Tipo_proyecto');
          	 $item->load($tipo_proyectopk);
            array_push($tipo_proyectoarraymodel,$item);
        }
        return $tipo_proyectoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Perfil_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_tipo_proyecto='.$this->tipo_proyectotable->id_tipo_proyecto
        	);
        $perfil_proyecto=JModelLegacy::getInstance('Perfil_proyecto');
        $this->perfil_proyectoarray_model=$perfil_proyecto->getPerfil_proyectoModelArray($condition);

    }


}
