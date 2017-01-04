    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Persona extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_persona';
	public $personatable;
	public $ejecutorarray_model;
	public $jefeproyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->personatable=JTable::getInstance('Persona');

        $this->ejecutorarray_model=array();
        $this->jefeprogramaarray_model=array();
        $this->jefeproyectoarray_model=array();
        $this->secretario_programaarray_model=array();
    }


 function is_null()    
{
        return $this->personatable->id_persona==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->personatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->personatable->store();
    }


    function  bind($persona)
    {
        return $this->personatable->bind($persona);
    }


     function load($pk)
    {
        $this->personatable->load($pk);
    }

    function loadNombreJefePersona($pk){
        return $this->personatable->loadNombreJefePersona($pk);
    }

    function loadPersona($pk){
        return $this->personatable->loadPersona($pk);
    }
    function loadAll($key,$where=null)
    {
        return $this->personatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->personatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->personatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->personatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->personatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_persona'=>$item->id_persona

          	 );

            $personaitem=JModelLegacy::getInstance('Persona');
            $personaitem->load($pk);
            array_push($modellist,$personaitem);
        }
        return $modellist;
    }




   function getPersonaModelArray($condition)    {
       $personaarraymodel= array();
       $personalist=$this->loadAll('*',$condition);
		if(!$personalist)
           return $personaarraymodel;
        foreach($personalist as $item)
        {
          	 $personapk= array(
          	 	'id_persona'=>$item->id_persona

          	 );
            $item=JModelLegacy::getInstance('Persona');
          	 $item->load($personapk);
            array_push($personaarraymodel,$item);
        }
        return $personaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Ejecutor
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_ejecutor');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_persona='.$this->personatable->id_persona
        	);
        $ejecutor=JModelLegacy::getInstance('Ejecutor');
        $this->ejecutorarray_model=$ejecutor->getEjecutorModelArray($condition);
        
        //Dependencia con la tabla Jefeprograma
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_jefeprograma');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_persona='.$this->personatable->id_persona
        	);
        $jefeprograma=JModelLegacy::getInstance('Jefeprograma');
        $this->jefeprogramaarray_model=$jefeprograma->getJefeprogramaModelArray($condition);
        
        //Dependencia con la tabla Jefeproyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_jefeproyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_persona='.$this->personatable->id_persona
        	);
        $jefeproyecto=JModelLegacy::getInstance('Jefeproyecto');
        $this->jefeproyectoarray_model=$jefeproyecto->getJefeproyectoModelArray($condition);
        
        //Dependencia con la tabla Secretario_programa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_secretario_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_persona='.$this->personatable->id_persona
        	);
        $secretario_programa=JModelLegacy::getInstance('Secretario_programa');
        $this->secretario_programaarray_model=$secretario_programa->getSecretario_programaModelArray($condition);

    }


}
