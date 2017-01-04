    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class flujo_presupuesto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_flujo_presupuesto';
	public $flujo_presupuesto;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->flujo_presupuesto=JTable::getInstance('flujo_presupuesto');

    }


 function is_null()    
{
        return $this->flujo_presupuesto->id_traza==null;
    }



     function load($pk)
    {
        $this->flujo_presupuesto->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->flujo_presupuesto->loadAll($key,$where);
    }
        function ingresoProyecto($id_proyecto,$anno)
        {
            return $this->flujo_presupuesto->ingresoProyecto($id_proyecto,$anno);
        }
        function gastoProyecto($id_proyecto,$anno)
        {
            return $this->flujo_presupuesto->gastoProyecto($id_proyecto,$anno);
        }

    function loadAllOr($key,$where=null)
    {
        return $this->flujo_presupuesto->loadAllOr($key,$where);
    }




    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->flujo_presupuesto->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );

            $trazaitem=JModelLegacy::getInstance('flujo_presupuesto');
            $trazaitem->load($pk);
            array_push($modellist,$trazaitem);
        }
        return $modellist;
    }




   function getTrazaModelArray($condition)    {
       $trazaarraymodel= array();
       $trazalist=$this->loadAll('*',$condition);
		if(!$trazalist)
           return $trazaarraymodel;
        foreach($trazalist as $item)
        {
          	 $trazapk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );
            $item=JModelLegacy::getInstance('flujo_presupuesto');
          	 $item->load($trazapk);
            array_push($trazaarraymodel,$item);
        }
        return $trazaarraymodel;
    }




}
