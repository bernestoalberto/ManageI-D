    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Clasificacion extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_clasificacion';
	public $clasificaciontable;
	public $perfil_proyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->clasificaciontable=JTable::getInstance('Clasificacion');

        $this->perfil_proyectoarray_model=array();
    }

        function loadNombreClasificacion($pk){
            return $this->clasificaciontable->loadNombreClasificacion($pk);
        }


 function is_null()    
{
        return $this->clasificaciontable->id_clasificacion==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->clasificaciontable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->clasificaciontable->store();
    }


    function  bind($clasificacion)
    {
        return $this->clasificaciontable->bind($clasificacion);
    }


     function load($pk)
    {
        $this->clasificaciontable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->clasificaciontable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->clasificaciontable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->clasificaciontable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->clasificaciontable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->clasificaciontable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_clasificacion'=>$item->id_clasificacion

          	 );

            $clasificacionitem=JModelLegacy::getInstance('Clasificacion');
            $clasificacionitem->load($pk);
            array_push($modellist,$clasificacionitem);
        }
        return $modellist;
    }




   function getClasificacionModelArray($condition)    {
       $clasificacionarraymodel= array();
       $clasificacionlist=$this->loadAll('*',$condition);
		if(!$clasificacionlist)
           return $clasificacionarraymodel;
        foreach($clasificacionlist as $item)
        {
          	 $clasificacionpk= array(
          	 	'id_clasificacion'=>$item->id_clasificacion

          	 );
            $item=JModelLegacy::getInstance('Clasificacion');
          	 $item->load($clasificacionpk);
            array_push($clasificacionarraymodel,$item);
        }
        return $clasificacionarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Perfil_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_clasificacion='.$this->clasificaciontable->id_clasificacion
        	);
        $perfil_proyecto=JModelLegacy::getInstance('Perfil_proyecto');
        $this->perfil_proyectoarray_model=$perfil_proyecto->getPerfil_proyectoModelArray($condition);

    }


}
