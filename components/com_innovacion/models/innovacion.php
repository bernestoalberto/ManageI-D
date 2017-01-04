    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Innovacion extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_innovacion';
	public $innovaciontable;
	public $proyectofathermodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->innovaciontable=JTable::getInstance('Innovacion');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectofathermodel=JModelLegacy::getInstance('Proyecto');
    }


 function is_null()    
{
        return $this->innovaciontable->id_persona==null;
    }


    function  store($nombre)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->innovaciontable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->innovaciontable->store();
    }
        function loadInnovacion($pk){
            return $this->innovaciontable->loadInnovacion($pk);
        }

    function  bind($innovacion)
    {
        return $this->innovaciontable->bind($innovacion);
    }


     function load($pk)
    {
        $this->innovaciontable->load($pk);
        $this->proyectofathermodel->load( $this->innovaciontable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->innovaciontable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->innovaciontable->loadAllOr($key,$where);
    }


    function  delete($pk=null,$nombre)
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->innovaciontable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->innovaciontable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->innovaciontable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $innovacionitem=JModelLegacy::getInstance('Innovacion');
            $innovacionitem->load($pk);
            array_push($modellist,$innovacionitem);
        }
        return $modellist;
    }


    function loadAllItemWithParent($key,$where=null)
    {
        $modellist=array();
        $lista=$this->innovaciontable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $innovacionitem=JModelLegacy::getInstance('Innovacion');
            $innovacionitem->load($pk);
            if($innovacionitem->proyectofathermodel->proyectotable->id_persona==null)
                $innovacionitem->proyectofathermodel->load($pk);
            array_push($modellist,$innovacionitem);
        }
        return $modellist;
    }


   function getInnovacionModelArray($condition)    {
       $innovacionarraymodel= array();
       $innovacionlist=$this->loadAll('*',$condition);
		if(!$innovacionlist)
           return $innovacionarraymodel;
        foreach($innovacionlist as $item)
        {
          	 $innovacionpk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );
            $item=JModelLegacy::getInstance('Innovacion');
          	 $item->load($innovacionpk);
            array_push($innovacionarraymodel,$item);
        }
        return $innovacionarraymodel;
    }




}
