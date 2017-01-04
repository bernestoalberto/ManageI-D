    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class informe_etapa_proyecto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_informe_etapa_proyecto';
	public $informeetapaproyectotable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->informeetapaproyectotable=JTable::getInstance('informe_etapa_proyecto');

    }





     function load($pk)
    {
        $this->informeetapaproyectotable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->informeetapaproyectotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->informeetapaproyectotable->loadAllOr($key,$where);
    }




    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->informeetapaproyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );

            $trazaitem=JModelLegacy::getInstance('informe_etapa_proyecto');
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
            $item=JModelLegacy::getInstance('informe_etapa_proyecto');
          	 $item->load($trazapk);
            array_push($trazaarraymodel,$item);
        }
        return $trazaarraymodel;
    }




}
