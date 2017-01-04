    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Plan_auditoria extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_plan_auditoria';
	public $plan_auditoriatable;
	public $entidadmodel;
	public $programamodel;
	public $proyectomodel;
	public $auditoriaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->plan_auditoriatable=JTable::getInstance('Plan_auditoria');

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
        return $this->plan_auditoriatable->id_plan_auditoria==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->plan_auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->plan_auditoriatable->store();
    }


    function  bind($plan_auditoria)
    {
        return $this->plan_auditoriatable->bind($plan_auditoria);
    }


     function load($pk)
    {
        $this->plan_auditoriatable->load($pk);
        $this->entidadmodel->load( $this->plan_auditoriatable->id_entidad);
        $this->programamodel->load( $this->plan_auditoriatable->id_programa);
        $this->proyectomodel->load( $this->plan_auditoriatable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->plan_auditoriatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->plan_auditoriatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->plan_auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->plan_auditoriatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->plan_auditoriatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_plan_auditoria'=>$item->id_plan_auditoria

          	 );

            $plan_auditoriaitem=JModelLegacy::getInstance('Plan_auditoria');
            $plan_auditoriaitem->load($pk);
            array_push($modellist,$plan_auditoriaitem);
        }
        return $modellist;
    }




   function getPlan_auditoriaModelArray($condition)    {
       $plan_auditoriaarraymodel= array();
       $plan_auditorialist=$this->loadAll('*',$condition);
		if(!$plan_auditorialist)
           return $plan_auditoriaarraymodel;
        foreach($plan_auditorialist as $item)
        {
          	 $plan_auditoriapk= array(
          	 	'id_plan_auditoria'=>$item->id_plan_auditoria

          	 );
            $item=JModelLegacy::getInstance('Plan_auditoria');
          	 $item->load($plan_auditoriapk);
            array_push($plan_auditoriaarraymodel,$item);
        }
        return $plan_auditoriaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Auditoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_auditoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_plan_auditoria='.$this->plan_auditoriatable->id_plan_auditoria
        	);
        $auditoria=JModelLegacy::getInstance('Auditoria');
        $this->auditoriaarray_model=$auditoria->getAuditoriaModelArray($condition);

    }


}
