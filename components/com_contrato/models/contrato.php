    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Contrato extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_contrato';
	public $contratotable;
	public $forma_entregamodel;
	public $proyectomodel;
	public $pago_know_how_gananciaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->contratotable=JTable::getInstance('Contrato');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_forma_entrega');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->forma_entregamodel=JModelLegacy::getInstance('Forma_entrega');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
        $this->pago_know_how_gananciaarray_model=array();
    }


 function is_null()    
{
        return $this->contratotable->id_contrato==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->contratotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->contratotable->store();
    }


    function  bind($contrato)
    {
        return $this->contratotable->bind($contrato);
    }


     function load($pk)
    {
        $this->contratotable->load($pk);
        $this->forma_entregamodel->load( $this->contratotable->id_forma_entrega);
        $this->proyectomodel->load( $this->contratotable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->contratotable->loadAll($key,$where);
    }
        function loadProyecto()
    {
        return $this->contratotable->loadProyecto();
    }


    function loadAllOr($key,$where=null)
    {
        return $this->contratotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->contratotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);


        return $this->contratotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->contratotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_contrato'=>$item->id_contrato
,
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $contratoitem=JModelLegacy::getInstance('Contrato');
            $contratoitem->load($pk);
            array_push($modellist,$contratoitem);
        }
        return $modellist;
    }




   function getContratoModelArray($condition)    {
       $contratoarraymodel= array();
       $contratolist=$this->loadAll('*',$condition);
		if(!$contratolist)
           return $contratoarraymodel;
        foreach($contratolist as $item)
        {
          	 $contratopk= array(
          	 	'id_contrato'=>$item->id_contrato
,
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );
            $item=JModelLegacy::getInstance('Contrato');
          	 $item->load($contratopk);
            array_push($contratoarraymodel,$item);
        }
        return $contratoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Pago_know_how_ganancia
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_pago_know_how_ganancia');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->contratotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->contratotable->id_persona
        	);
        $pago_know_how_ganancia=JModelLegacy::getInstance('Pago_know_how_ganancia');
        $this->pago_know_how_gananciaarray_model=$pago_know_how_ganancia->getPago_know_how_gananciaModelArray($condition);

    }


}
