    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Entidad extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_entidad';
	public $entidadtable;
	public $provinciamodel;
	public $ejecutoraarray_model;
	public $perfil_proyectoarray_model;
	public $programaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->entidadtable=JTable::getInstance('Entidad');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_provincia');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->provinciamodel=JModelLegacy::getInstance('Provincia');
        $this->ejecutoraarray_model=array();
        $this->perfil_proyectoarray_model=array();
        $this->programaarray_model=array();
    }


 function is_null()    
{
        return $this->entidadtable->id_entidad==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->entidadtable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->entidadtable->store();
    }


    function  bind($entidad)
    {
        return $this->entidadtable->bind($entidad);
    }


     function load($pk)
    {
        $this->entidadtable->load($pk);
        $this->provinciamodel->load( $this->entidadtable->id_provincia);
    }
        function loadNombreEntidad($pk){
         return $this->entidadtable->loadNombreEntidad($pk);
        }

        function loadEntidad($pk){
            return $this->entidadtable->loadEntidad($pk);
        }




    function loadAll($key,$where=null)
    {
        return $this->entidadtable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->entidadtable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->entidadtable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->entidadtable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->entidadtable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_entidad'=>$item->id_entidad

          	 );

            $entidaditem=JModelLegacy::getInstance('Entidad');
            $entidaditem->load($pk);
            array_push($modellist,$entidaditem);
        }
        return $modellist;
    }




   function getEntidadModelArray($condition)    {
       $entidadarraymodel= array();
       $entidadlist=$this->loadAll('*',$condition);
		if(!$entidadlist)
           return $entidadarraymodel;
        foreach($entidadlist as $item)
        {
          	 $entidadpk= array(
          	 	'id_entidad'=>$item->id_entidad

          	 );
            $item=JModelLegacy::getInstance('Entidad');
          	 $item->load($entidadpk);
            array_push($entidadarraymodel,$item);
        }
        return $entidadarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Ejecutora
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_ejecutora');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_entidad='.$this->entidadtable->id_entidad
        	);
        $ejecutora=JModelLegacy::getInstance('Ejecutora');
        $this->ejecutoraarray_model=$ejecutora->getEjecutoraModelArray($condition);
        
        //Dependencia con la tabla Perfil_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_entidad='.$this->entidadtable->id_entidad
        	);
        $perfil_proyecto=JModelLegacy::getInstance('Perfil_proyecto');
        $this->perfil_proyectoarray_model=$perfil_proyecto->getPerfil_proyectoModelArray($condition);
        
        //Dependencia con la tabla Programa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_entidad='.$this->entidadtable->id_entidad
        	);
        $programa=JModelLegacy::getInstance('Programa');
        $this->programaarray_model=$programa->getProgramaModelArray($condition);

    }


}
