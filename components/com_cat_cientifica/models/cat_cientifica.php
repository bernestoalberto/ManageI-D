    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Cat_cientifica extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_cat_cientifica';
	public $cat_cientificatable;
	public $jefeproyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->cat_cientificatable=JTable::getInstance('Cat_cientifica');

        $this->jefeproyectoarray_model=array();
    }


 function is_null()    
{
        return $this->cat_cientificatable->id_categoria==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->cat_cientificatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->cat_cientificatable->store();
    }


    function  bind($cat_cientifica)
    {
        return $this->cat_cientificatable->bind($cat_cientifica);
    }


     function load($pk)
    {
        $this->cat_cientificatable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->cat_cientificatable->loadAll($key,$where);
    }
        function loadNombreCategory($pk){
            return $this->cat_cientificatable->loadNombreCategory($pk);
        }


    function loadAllOr($key,$where=null)
    {
        return $this->cat_cientificatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->cat_cientificatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->cat_cientificatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->cat_cientificatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_categoria'=>$item->id_categoria

          	 );

            $cat_cientificaitem=JModelLegacy::getInstance('Cat_cientifica');
            $cat_cientificaitem->load($pk);
            array_push($modellist,$cat_cientificaitem);
        }
        return $modellist;
    }




   function getCat_cientificaModelArray($condition)    {
       $cat_cientificaarraymodel= array();
       $cat_cientificalist=$this->loadAll('*',$condition);
		if(!$cat_cientificalist)
           return $cat_cientificaarraymodel;
        foreach($cat_cientificalist as $item)
        {
          	 $cat_cientificapk= array(
          	 	'id_categoria'=>$item->id_categoria

          	 );
            $item=JModelLegacy::getInstance('Cat_cientifica');
          	 $item->load($cat_cientificapk);
            array_push($cat_cientificaarraymodel,$item);
        }
        return $cat_cientificaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Jefeproyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_jefeproyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_categoria='.$this->cat_cientificatable->id_categoria
        	);
        $jefeproyecto=JModelLegacy::getInstance('Jefeproyecto');
        $this->jefeproyectoarray_model=$jefeproyecto->getJefeproyectoModelArray($condition);

    }


}
