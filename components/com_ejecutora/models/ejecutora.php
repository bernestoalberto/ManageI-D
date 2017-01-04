    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Ejecutora extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_ejecutora';
	public $ejecutoratable;
	public $ejecutormodel;
	public $entidadmodel;
	public $programamodel;
	public $proyectomodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->ejecutoratable=JTable::getInstance('Ejecutora');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_ejecutor');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->ejecutormodel=JModelLegacy::getInstance('Ejecutor');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_entidad');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->entidadmodel=JModelLegacy::getInstance('Entidad');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
    }


 function is_null()    
{
        return $this->ejecutoratable->id_entidad==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->ejecutoratable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->ejecutoratable->store();
    }


    function  bind($ejecutora)
    {
        return $this->ejecutoratable->bind($ejecutora);
    }


     function load($pk)
    {
        $this->ejecutoratable->load($pk);
        $this->ejecutormodel->load( $this->ejecutoratable->id_persona);
        $this->entidadmodel->load( $this->ejecutoratable->id_entidad);
        $this->programamodel->load( $this->ejecutoratable->id_programa);
        $this->proyectomodel->load( $this->ejecutoratable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->ejecutoratable->loadAll($key,$where);
    }
        function loadEjecutora($key)
    {
        return $this->ejecutoratable->loadEjecutora($key);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->ejecutoratable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->ejecutoratable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->ejecutoratable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->ejecutoratable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_entidad'=>$item->id_entidad

          	 );

            $ejecutoraitem=JModelLegacy::getInstance('Ejecutora');
            $ejecutoraitem->load($pk);
            array_push($modellist,$ejecutoraitem);
        }
        return $modellist;
    }




   function getEjecutoraModelArray($condition)    {
       $ejecutoraarraymodel= array();
       $ejecutoralist=$this->loadAll('*',$condition);
		if(!$ejecutoralist)
           return $ejecutoraarraymodel;
        foreach($ejecutoralist as $item)
        {
          	 $ejecutorapk= array(
          	 	'id_entidad'=>$item->id_entidad

          	 );
            $item=JModelLegacy::getInstance('Ejecutora');
          	 $item->load($ejecutorapk);
            array_push($ejecutoraarraymodel,$item);
        }
        return $ejecutoraarraymodel;
    }




}
