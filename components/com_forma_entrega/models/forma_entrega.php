    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Forma_entrega extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_forma_entrega';
	public $forma_entregatable;
	public $contratoarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->forma_entregatable=JTable::getInstance('Forma_entrega');

        $this->contratoarray_model=array();
    }


 function is_null()    
{
        return $this->forma_entregatable->id_forma_entrega==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->forma_entregatable->store();
    }


    function  bind($forma_entrega)
    {
        return $this->forma_entregatable->bind($forma_entrega);
    }


     function load($pk)
    {
        $this->forma_entregatable->load($pk);
    }
        function loadForma($pk)
    {
       return $this->forma_entregatable->loadForma($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->forma_entregatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->forma_entregatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->forma_entregatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->forma_entregatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_forma_entrega'=>$item->id_forma_entrega

          	 );

            $forma_entregaitem=JModelLegacy::getInstance('Forma_entrega');
            $forma_entregaitem->load($pk);
            array_push($modellist,$forma_entregaitem);
        }
        return $modellist;
    }




   function getForma_entregaModelArray($condition)    {
       $forma_entregaarraymodel= array();
       $forma_entregalist=$this->loadAll('*',$condition);
		if(!$forma_entregalist)
           return $forma_entregaarraymodel;
        foreach($forma_entregalist as $item)
        {
          	 $forma_entregapk= array(
          	 	'id_forma_entrega'=>$item->id_forma_entrega

          	 );
            $item=JModelLegacy::getInstance('Forma_entrega');
          	 $item->load($forma_entregapk);
            array_push($forma_entregaarraymodel,$item);
        }
        return $forma_entregaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Contrato
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_contrato');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_forma_entrega='.$this->forma_entregatable->id_forma_entrega
        	);
        $contrato=JModelLegacy::getInstance('Contrato');
        $this->contratoarray_model=$contrato->getContratoModelArray($condition);

    }


}
