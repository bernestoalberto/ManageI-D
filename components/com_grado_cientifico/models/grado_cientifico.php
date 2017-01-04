    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Grado_cientifico extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_grado_cientifico';
	public $grado_cientificotable;
	public $jefeproyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->grado_cientificotable=JTable::getInstance('Grado_cientifico');

        $this->jefeproyectoarray_model=array();
    }


 function is_null()    
{
        return $this->grado_cientificotable->id_grado==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->grado_cientificotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->grado_cientificotable->store();
    }


    function  bind($grado_cientifico)
    {
        return $this->grado_cientificotable->bind($grado_cientifico);
    }
        function loadNombreGRade($pk){
            return $this->grado_cientificotable->loadNombreGRade($pk);
        }


     function load($pk)
    {
        $this->grado_cientificotable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->grado_cientificotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->grado_cientificotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->grado_cientificotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->grado_cientificotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->grado_cientificotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_grado'=>$item->id_grado

          	 );

            $grado_cientificoitem=JModelLegacy::getInstance('Grado_cientifico');
            $grado_cientificoitem->load($pk);
            array_push($modellist,$grado_cientificoitem);
        }
        return $modellist;
    }




   function getGrado_cientificoModelArray($condition)    {
       $grado_cientificoarraymodel= array();
       $grado_cientificolist=$this->loadAll('*',$condition);
		if(!$grado_cientificolist)
           return $grado_cientificoarraymodel;
        foreach($grado_cientificolist as $item)
        {
          	 $grado_cientificopk= array(
          	 	'id_grado'=>$item->id_grado

          	 );
            $item=JModelLegacy::getInstance('Grado_cientifico');
          	 $item->load($grado_cientificopk);
            array_push($grado_cientificoarraymodel,$item);
        }
        return $grado_cientificoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Jefeproyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_jefeproyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_grado='.$this->grado_cientificotable->id_grado
        	);
        $jefeproyecto=JModelLegacy::getInstance('Jefeproyecto');
        $this->jefeproyectoarray_model=$jefeproyecto->getJefeproyectoModelArray($condition);

    }


}
