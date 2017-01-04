    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Documentacion_evidencias_objetivas extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_documentacion_evidencias_objetivas';
	public $documentacion_evidencias_objetivastable;
	public $programamodel;
	public $proyectomodel;
	public $auditoriaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->documentacion_evidencias_objetivastable=JTable::getInstance('Documentacion_evidencias_objetivas');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
        $this->auditoriaarray_model=array();
    }


 function is_null()    
{
        return $this->documentacion_evidencias_objetivastable->id_documentacion_evidencias==null;
    }


    function  store()

    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->documentacion_evidencias_objetivastable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->documentacion_evidencias_objetivastable->store();
    }


    function  bind($documentacion_evidencias_objetivas)
    {
        return $this->documentacion_evidencias_objetivastable->bind($documentacion_evidencias_objetivas);
    }


     function load($pk)
    {
        $this->documentacion_evidencias_objetivastable->load($pk);
        $this->programamodel->load( $this->documentacion_evidencias_objetivastable->id_programa);
        $this->proyectomodel->load( $this->documentacion_evidencias_objetivastable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->documentacion_evidencias_objetivastable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->documentacion_evidencias_objetivastable->loadAllOr($key,$where);
    }
    function loadDeficiencias($key){
        return $this->documentacion_evidencias_objetivastable->loadDeficiencias($key);
    }
   function loadDEObyProjectDate($key,$date){
       return $this->documentacion_evidencias_objetivastable->loadDEObyProjectDate($key,$date);
   }

    function  delete($pk=null)
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->documentacion_evidencias_objetivastable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->documentacion_evidencias_objetivastable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->documentacion_evidencias_objetivastable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_documentacion_evidencias'=>$item->id_documentacion_evidencias

          	 );

            $documentacion_evidencias_objetivasitem=JModelLegacy::getInstance('Documentacion_evidencias_objetivas');
            $documentacion_evidencias_objetivasitem->load($pk);
            array_push($modellist,$documentacion_evidencias_objetivasitem);
        }
        return $modellist;
    }




   function getDocumentacion_evidencias_objetivasModelArray($condition)    {
       $documentacion_evidencias_objetivasarraymodel= array();
       $documentacion_evidencias_objetivaslist=$this->loadAll('*',$condition);
		if(!$documentacion_evidencias_objetivaslist)
           return $documentacion_evidencias_objetivasarraymodel;
        foreach($documentacion_evidencias_objetivaslist as $item)
        {
          	 $documentacion_evidencias_objetivaspk= array(
          	 	'id_documentacion_evidencias'=>$item->id_documentacion_evidencias

          	 );
            $item=JModelLegacy::getInstance('Documentacion_evidencias_objetivas');
          	 $item->load($documentacion_evidencias_objetivaspk);
            array_push($documentacion_evidencias_objetivasarraymodel,$item);
        }
        return $documentacion_evidencias_objetivasarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Auditoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_auditoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_documentacion_evidencias='.$this->documentacion_evidencias_objetivastable->id_documentacion_evidencias
        	);
        $auditoria=JModelLegacy::getInstance('Auditoria');
        $this->auditoriaarray_model=$auditoria->getAuditoriaModelArray($condition);

    }


}
