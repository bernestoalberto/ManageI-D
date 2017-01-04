    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Informe_ejecucion_programa extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_informe_ejecucion_programa';
	public $informe_ejecucion_programatable;
	public $programamodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->informe_ejecucion_programatable=JTable::getInstance('Informe_ejecucion_programa');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
    }


 function is_null()    
{
        return $this->informe_ejecucion_programatable->id_informe_ejecucion_programa==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->informe_ejecucion_programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->informe_ejecucion_programatable->store();
    }


    function  bind($informe_ejecucion_programa)
    {
        return $this->informe_ejecucion_programatable->bind($informe_ejecucion_programa);
    }


     function load($pk)
    {
        $this->informe_ejecucion_programatable->load($pk);
        $this->programamodel->load( $this->informe_ejecucion_programatable->id_programa);
    }


    function loadAll($key,$where=null)
    {
        return $this->informe_ejecucion_programatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->informe_ejecucion_programatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->informe_ejecucion_programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);


        return $this->informe_ejecucion_programatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->informe_ejecucion_programatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_informe_ejecucion_programa'=>$item->id_informe_ejecucion_programa
,
          	 	'id_programa'=>$item->id_programa

          	 );

            $informe_ejecucion_programaitem=JModelLegacy::getInstance('Informe_ejecucion_programa');
            $informe_ejecucion_programaitem->load($pk);
            array_push($modellist,$informe_ejecucion_programaitem);
        }
        return $modellist;
    }




   function getInforme_ejecucion_programaModelArray($condition)    {
       $informe_ejecucion_programaarraymodel= array();
       $informe_ejecucion_programalist=$this->loadAll('*',$condition);
		if(!$informe_ejecucion_programalist)
           return $informe_ejecucion_programaarraymodel;
        foreach($informe_ejecucion_programalist as $item)
        {
          	 $informe_ejecucion_programapk= array(
          	 	'id_informe_ejecucion_programa'=>$item->id_informe_ejecucion_programa
,
          	 	'id_programa'=>$item->id_programa

          	 );
            $item=JModelLegacy::getInstance('Informe_ejecucion_programa');
          	 $item->load($informe_ejecucion_programapk);
            array_push($informe_ejecucion_programaarraymodel,$item);
        }
        return $informe_ejecucion_programaarraymodel;
    }




}
