    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Perfil_proyecto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_perfil_proyecto';
	public $perfil_proyectotable;
	public $clasificacionmodel;
	public $entidadmodel;
	public $programamodel;
	public $tipo_proyectomodel;
	public $dictamen_eval_perfil_proyarray_model;
	public $jefeproyectoarray_model;
	public $proyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->perfil_proyectotable=JTable::getInstance('Perfil_proyecto');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_clasificacion');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->clasificacionmodel=JModelLegacy::getInstance('Clasificacion');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_entidad');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->entidadmodel=JModelLegacy::getInstance('Entidad');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_tipo_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->tipo_proyectomodel=JModelLegacy::getInstance('Tipo_proyecto');
        $this->dictamen_eval_perfil_proyarray_model=array();
        $this->jefeproyectoarray_model=array();
        $this->proyectoarray_model=array();
    }
        function loadPerfilProyecto($pk){
            return $this->perfil_proyectotable->loadProyecto($pk);
        }
        function loadIdJefeProyecto($pk){

            return $this->perfil_proyectotable->loadIdJefeProyecto($pk);
        }

 function is_null()    
{
        return $this->perfil_proyectotable->id_proyecto==null;
    }


    function  store()
    {
        //Crear traza
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->perfil_proyectotable->getTableName();
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->perfil_proyectotable->store();
    }
        function loadNombreProyecto($pk){
            return $this->perfil_proyectotable->loadNombreProyecto($pk);
        }

        function loadProyecto($pk){
            return $this->perfil_proyectotable->loadProyecto($pk);
        }


    function  bind($perfil_proyecto)
    {
        return $this->perfil_proyectotable->bind($perfil_proyecto);
    }


     function load($pk)
    {
        $this->perfil_proyectotable->load($pk);
        $this->clasificacionmodel->load( $this->perfil_proyectotable->id_clasificacion);
        $this->entidadmodel->load( $this->perfil_proyectotable->id_entidad);
        $this->programamodel->load( $this->perfil_proyectotable->id_programa);
        $this->tipo_proyectomodel->load( $this->perfil_proyectotable->numero);
    }


    function loadAll($key,$where=null)
    {
        return $this->perfil_proyectotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->perfil_proyectotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->perfil_proyectotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->perfil_proyectotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->perfil_proyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $perfil_proyectoitem=JModelLegacy::getInstance('Perfil_proyecto');
            $perfil_proyectoitem->load($pk);
            array_push($modellist,$perfil_proyectoitem);
        }
        return $modellist;
    }




   function getPerfil_proyectoModelArray($condition)    {
       $perfil_proyectoarraymodel= array();
       $perfil_proyectolist=$this->loadAll('*',$condition);
		if(!$perfil_proyectolist)
           return $perfil_proyectoarraymodel;
        foreach($perfil_proyectolist as $item)
        {
          	 $perfil_proyectopk= array(
          	 	'id_proyecto'=>$item->id_proyecto

          	 );
            $item=JModelLegacy::getInstance('Perfil_proyecto');
          	 $item->load($perfil_proyectopk);
            array_push($perfil_proyectoarraymodel,$item);
        }
        return $perfil_proyectoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Dictamen_eval_perfil_proy
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_dictamen_eval_perfil_proy');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->perfil_proyectotable->id_proyecto
        	);
        $dictamen_eval_perfil_proy=JModelLegacy::getInstance('Dictamen_eval_perfil_proy');
        $this->dictamen_eval_perfil_proyarray_model=$dictamen_eval_perfil_proy->getDictamen_eval_perfil_proyModelArray($condition);
        
        //Dependencia con la tabla Jefeproyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_jefeproyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->perfil_proyectotable->id_proyecto
        	);
        $jefeproyecto=JModelLegacy::getInstance('Jefeproyecto');
        $this->jefeproyectoarray_model=$jefeproyecto->getJefeproyectoModelArray($condition);
        
        //Dependencia con la tabla Proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->perfil_proyectotable->id_proyecto
        	);
        $proyecto=JModelLegacy::getInstance('Proyecto');
        $this->proyectoarray_model=$proyecto->getProyectoModelArray($condition);

    }


}
