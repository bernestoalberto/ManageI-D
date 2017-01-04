    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class Prioridad extends JModelLegacy
{
     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_prioridad';
	public $prioridadtable;
	public $perfil_programaarray_model;

	function __construct(&$db) {


        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->prioridadtable=JTable::getInstance('Prioridad');

        $this->perfil_programaarray_model=array();
    }


 function is_null()    
{
        return $this->prioridadtable->id_prioridad==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->prioridadtable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->prioridadtable->store();
    }


    function  bind($prioridad)
    {
        return $this->prioridadtable->bind($prioridad);
    }


     function load($pk)
    {
        $this->prioridadtable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->prioridadtable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->prioridadtable->loadAllOr($key,$where);
    }
        function loadProblema($key,$condition){
       return $this->prioridadtable->loadProblema($key);
    }


    function  delete($pk = null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->prioridadtable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->prioridadtable->delete($pk);
    }
    function  check(){
      return $this->prioridadtable->check();
    }

    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->prioridadtable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_prioridad'=>$item->id_prioridad

          	 );

            $prioridaditem=JModelLegacy::getInstance('Prioridad');
            $prioridaditem->load($pk);
            array_push($modellist,$prioridaditem);
        }
        return $modellist;
    }




   function getPrioridadModelArray($condition)    {
       $prioridadarraymodel= array();
       $prioridadlist=$this->loadAll('*',$condition);
		if(!$prioridadlist)
           return $prioridadarraymodel;
        foreach($prioridadlist as $item)
        {
          	 $prioridadpk= array(
          	 	'id_prioridad'=>$item->id_prioridad

          	 );
            $item=JModelLegacy::getInstance('Prioridad');
          	 $item->load($prioridadpk);
            array_push($prioridadarraymodel,$item);
        }
        return $prioridadarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Perfil_programa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_prioridad='.$this->prioridadtable->id_prioridad
        	);
        $perfil_programa=JModelLegacy::getInstance('Perfil_programa');
        $this->perfil_programaarray_model=$perfil_programa->getPerfil_programaModelArray($condition);

    }



    }
