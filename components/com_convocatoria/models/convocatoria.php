    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Convocatoria extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_convocatoria';
	public $convocatoriatable;
	public $programamodel;
	public $proyectoconvocatoriaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->convocatoriatable=JTable::getInstance('Convocatoria');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $this->proyectoconvocatoriaarray_model=array();
    }


 function is_null()    
{
        return $this->convocatoriatable->id_convocatoria==null;
    }

        function loadPrograma(){
            return $this->convocatoriatable->loadPrograma();
        }
    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->convocatoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->convocatoriatable->store();
    }


    function  bind($convocatoria)
    {
        return $this->convocatoriatable->bind($convocatoria);
    }


     function load($pk)
    {
        $this->convocatoriatable->load($pk);
        $this->programamodel->load( $this->convocatoriatable->id_programa);
    }


    function loadAll($key,$where=null)
    {
        return $this->convocatoriatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->convocatoriatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->convocatoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->convocatoriatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->convocatoriatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_convocatoria'=>$item->id_convocatoria
,
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_programa'=>$item->id_programa

          	 );

            $convocatoriaitem=JModelLegacy::getInstance('Convocatoria');
            $convocatoriaitem->load($pk);
            array_push($modellist,$convocatoriaitem);
        }
        return $modellist;
    }




   function getConvocatoriaModelArray($condition)    {
       $convocatoriaarraymodel= array();
       $convocatorialist=$this->loadAll('*',$condition);
		if(!$convocatorialist)
           return $convocatoriaarraymodel;
        foreach($convocatorialist as $item)
        {
          	 $convocatoriapk= array(
          	 	'id_convocatoria'=>$item->id_convocatoria
,
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_programa'=>$item->id_programa

          	 );
            $item=JModelLegacy::getInstance('Convocatoria');
          	 $item->load($convocatoriapk);
            array_push($convocatoriaarraymodel,$item);
        }
        return $convocatoriaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Proyectoconvocatoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyectoconvocatoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_convocatoria='.$this->convocatoriatable->id_convocatoria,
          	 	'0'=>'id_programa='.$this->convocatoriatable->id_programa,
          	 	'0'=>'id_persona='.$this->convocatoriatable->id_persona
        	);
        $proyectoconvocatoria=JModelLegacy::getInstance('Proyectoconvocatoria');
        $this->proyectoconvocatoriaarray_model=$proyectoconvocatoria->getProyectoconvocatoriaModelArray($condition);

    }


}
