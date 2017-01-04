    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Informe_auditoria extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_informe_auditoria';
	public $informe_auditoriatable;
	public $entidadmodel;
	public $programamodel;
	public $proyectomodel;
	public $auditoriaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->informe_auditoriatable=JTable::getInstance('Informe_auditoria');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_entidad');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->entidadmodel=JModelLegacy::getInstance('Entidad');
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
        return $this->informe_auditoriatable->id_nforme_auditoria==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->informe_auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->informe_auditoriatable->store();
    }


    function  bind($informe_auditoria)
    {
        return $this->informe_auditoriatable->bind($informe_auditoria);
    }


     function load($pk)
    {
        $this->informe_auditoriatable->load($pk);
        $this->entidadmodel->load( $this->informe_auditoriatable->id_entidad);
        $this->programamodel->load( $this->informe_auditoriatable->id_programa);
        $this->proyectomodel->load( $this->informe_auditoriatable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->informe_auditoriatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->informe_auditoriatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->informe_auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->informe_auditoriatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->informe_auditoriatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_nforme_auditoria'=>$item->id_nforme_auditoria

          	 );

            $informe_auditoriaitem=JModelLegacy::getInstance('Informe_auditoria');
            $informe_auditoriaitem->load($pk);
            array_push($modellist,$informe_auditoriaitem);
        }
        return $modellist;
    }




   function getInforme_auditoriaModelArray($condition)    {
       $informe_auditoriaarraymodel= array();
       $informe_auditorialist=$this->loadAll('*',$condition);
		if(!$informe_auditorialist)
           return $informe_auditoriaarraymodel;
        foreach($informe_auditorialist as $item)
        {
          	 $informe_auditoriapk= array(
          	 	'id_nforme_auditoria'=>$item->id_nforme_auditoria

          	 );
            $item=JModelLegacy::getInstance('Informe_auditoria');
          	 $item->load($informe_auditoriapk);
            array_push($informe_auditoriaarraymodel,$item);
        }
        return $informe_auditoriaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Auditoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_auditoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_nforme_auditoria='.$this->informe_auditoriatable->id_nforme_auditoria
        	);
        $auditoria=JModelLegacy::getInstance('Auditoria');
        $this->auditoriaarray_model=$auditoria->getAuditoriaModelArray($condition);

    }


}
