    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Provincia extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_provincia';
	public $provinciatable;
	public $entidadarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->provinciatable=JTable::getInstance('Provincia');

        $this->entidadarray_model=array();
    }


 function is_null()    
{
        return $this->provinciatable->id_provincia==null;
    }
        function  loadNombreProvincia($key){
            return $this->provinciatable->loadNombreProvincia($key);
        }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->provinciatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);


        return $this->provinciatable->store();
    }


    function  bind($provincia)
    {
        return $this->provinciatable->bind($provincia);
    }


     function load($pk)
    {
        $this->provinciatable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->provinciatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->provinciatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->provinciatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->provinciatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->provinciatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_provincia'=>$item->id_provincia

          	 );

            $provinciaitem=JModelLegacy::getInstance('Provincia');
            $provinciaitem->load($pk);
            array_push($modellist,$provinciaitem);
        }
        return $modellist;
    }




   function getProvinciaModelArray($condition)    {
       $provinciaarraymodel= array();
       $provincialist=$this->loadAll('*',$condition);
		if(!$provincialist)
           return $provinciaarraymodel;
        foreach($provincialist as $item)
        {
          	 $provinciapk= array(
          	 	'id_provincia'=>$item->id_provincia

          	 );
            $item=JModelLegacy::getInstance('Provincia');
          	 $item->load($provinciapk);
            array_push($provinciaarraymodel,$item);
        }
        return $provinciaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Entidad
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_entidad');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_provincia='.$this->provinciatable->id_provincia
        	);
        $entidad=JModelLegacy::getInstance('Entidad');
        $this->entidadarray_model=$entidad->getEntidadModelArray($condition);

    }


}
