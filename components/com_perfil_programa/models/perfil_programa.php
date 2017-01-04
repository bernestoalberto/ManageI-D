    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Perfil_programa extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_perfil_programa';
	public $perfil_programatable;
	public $indicadores_impactomodel;
	public $prioridadmodel;
	public $programaarray_model;

	function __construct( &$db ) {


        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->perfil_programatable=JTable::getInstance('Perfil_programa');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_indicadores_impacto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->indicadores_impactomodel=JModelLegacy::getInstance('Indicadores_impacto');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_prioridad');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->prioridadmodel=JModelLegacy::getInstance('Prioridad');
        $this->programaarray_model=array();
    }


 function is_null()    
{
        return $this->perfil_programatable->id_programa==null;
    }
        function loadFilter()
        {
            return $this->perfil_programatable->loadFilter();
        }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion = $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->perfil_programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->perfil_programatable->store();

    }
    function loadNombrePerfilPrograma($key){
        return $this->perfil_programatable->loadNombrePerfilPrograma($key);

    }  function loadPKPerfilPrograma($denominacion){
        return $this->perfil_programatable->loadPKPerfilPrograma($denominacion);

    }


    function  bind($perfil_programa)
    {
        return $this->perfil_programatable->bind($perfil_programa);
    }
  function  loadPresupuesto($id_programa){
      return $this->perfil_programatable->loadPresupuesto($id_programa);
  }


     function load($pk)
    {
        $this->perfil_programatable->load($pk);
        $this->indicadores_impactomodel->load( $this->perfil_programatable->id_indicador);
        $this->prioridadmodel->load( $this->perfil_programatable->id_prioridad);
    }


    function loadAll($key,$where=null)
    {
        return $this->perfil_programatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->perfil_programatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion = $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->perfil_programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->perfil_programatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->perfil_programatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_programa'=>$item->id_programa

          	 );

            $perfil_programaitem=JModelLegacy::getInstance('Perfil_programa');
            $perfil_programaitem->load($pk);
            array_push($modellist,$perfil_programaitem);
        }
        return $modellist;
    }




   function getPerfil_programaModelArray($condition)    {
       $perfil_programaarraymodel= array();
       $perfil_programalist=$this->loadAll('*',$condition);
		if(!$perfil_programalist)
           return $perfil_programaarraymodel;
        foreach($perfil_programalist as $item)
        {
          	 $perfil_programapk= array(
          	 	'id_programa'=>$item->id_programa

          	 );
            $item=JModelLegacy::getInstance('Perfil_programa');
          	 $item->load($perfil_programapk);
            array_push($perfil_programaarraymodel,$item);
        }
        return $perfil_programaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Programa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_programa='.$this->perfil_programatable->id_programa
        	);
        $programa=JModelLegacy::getInstance('Programa');
        $this->programaarray_model=$programa->getProgramaModelArray($condition);

    }


}
