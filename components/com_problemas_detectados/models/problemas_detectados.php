    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Problemas_detectados extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_problemas_detectados';
	public $problemas_detectadostable;
	public $control_programa_proyectoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->problemas_detectadostable=JTable::getInstance('Problemas_detectados');

        $this->control_programa_proyectoarray_model=array();
    }


 function is_null()    
{
        return $this->problemas_detectadostable->id_problema_detectado==null;
    }


    function  store()
    {


        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->problemas_detectadostable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->problemas_detectadostable->store();
    }
        function loadProblema($key)
        {
            return $this->problemas_detectadostable->loadProblema($key);
        }


    function  bind($problemas_detectados)
    {
        return $this->problemas_detectadostable->bind($problemas_detectados);
    }


     function load($pk)
    {
        $this->problemas_detectadostable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->problemas_detectadostable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->problemas_detectadostable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->problemas_detectadostable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->problemas_detectadostable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->problemas_detectadostable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_problema_detectado'=>$item->id_problema_detectado

          	 );

            $problemas_detectadositem=JModelLegacy::getInstance('Problemas_detectados');
            $problemas_detectadositem->load($pk);
            array_push($modellist,$problemas_detectadositem);
        }
        return $modellist;
    }




   function getProblemas_detectadosModelArray($condition)    {
       $problemas_detectadosarraymodel= array();
       $problemas_detectadoslist=$this->loadAll('*',$condition);
		if(!$problemas_detectadoslist)
           return $problemas_detectadosarraymodel;
        foreach($problemas_detectadoslist as $item)
        {
          	 $problemas_detectadospk= array(
          	 	'id_problema_detectado'=>$item->id_problema_detectado

          	 );
            $item=JModelLegacy::getInstance('Problemas_detectados');
          	 $item->load($problemas_detectadospk);
            array_push($problemas_detectadosarraymodel,$item);
        }
        return $problemas_detectadosarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Control_programa_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_programa_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_problema_detectado='.$this->problemas_detectadostable->id_problema_detectado
        	);
        $control_programa_proyecto=JModelLegacy::getInstance('Control_programa_proyecto');
        $this->control_programa_proyectoarray_model=$control_programa_proyecto->getControl_programa_proyectoModelArray($condition);

    }


}
