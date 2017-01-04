    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class I_d extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_i_d';
	public $i_dtable;
	public $proyectofathermodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->i_dtable=JTable::getInstance('I_d');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectofathermodel=JModelLegacy::getInstance('Proyecto');
    }


 function is_null()    
{
        return $this->i_dtable->id_persona==null;
    }


    function  store($nombre)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->i_dtable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);


        return $this->i_dtable->store();
    }


    function  bind($i_d)
    {
        return $this->i_dtable->bind($i_d);
    }


     function load($pk)
    {
        $this->i_dtable->load($pk);
        $this->proyectofathermodel->load( $this->i_dtable->id_proyecto);
    }
        function loadID($pk)
    {

        return $this->i_dtable->loadID($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->i_dtable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->i_dtable->loadAllOr($key,$where);
    }


    function  delete($pk=null,$nombre)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->i_dtable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        $trazamodel->CreateTrace($accion,$entidad,$nombre);


        return $this->i_dtable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->i_dtable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $i_ditem=JModelLegacy::getInstance('I_d');
            $i_ditem->load($pk);
            array_push($modellist,$i_ditem);
        }
        return $modellist;
    }


    function loadAllItemWithParent($key,$where=null)
    {
        $modellist=array();
        $lista=$this->i_dtable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $i_ditem=JModelLegacy::getInstance('I_d');
            $i_ditem->load($pk);
            if($i_ditem->proyectofathermodel->proyectotable->id_persona==null)
                $i_ditem->proyectofathermodel->load($pk);
            array_push($modellist,$i_ditem);
        }
        return $modellist;
    }


   function getI_dModelArray($condition)    {
       $i_darraymodel= array();
       $i_dlist=$this->loadAll('*',$condition);
		if(!$i_dlist)
           return $i_darraymodel;
        foreach($i_dlist as $item)
        {
          	 $i_dpk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );
            $item=JModelLegacy::getInstance('I_d');
          	 $item->load($i_dpk);
            array_push($i_darraymodel,$item);
        }
        return $i_darraymodel;
    }




}
