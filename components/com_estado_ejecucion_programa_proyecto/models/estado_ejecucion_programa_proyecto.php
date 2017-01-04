    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class estado_ejecucion_programa_proyecto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_estado_ejecucion_programa_proyecto';
	public $repConvocatoriatable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->repConvocatoriatable=JTable::getInstance('estado_ejecucion_programa_proyecto');

    }


 function is_null()    
{
        return $this->repConvocatoriatable->id_traza==null;
    }



     function load($pk)
    {
        $this->repConvocatoriatable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->repConvocatoriatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->repConvocatoriatable->loadAllOr($key,$where);
    }




    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->repConvocatoriatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );

            $trazaitem=JModelLegacy::getInstance('estado_ejecucion_programa_proyecto');
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
            $item=JModelLegacy::getInstance('estado_ejecucion_programa_proyecto');
          	 $item->load($trazapk);
            array_push($trazaarraymodel,$item);
        }
        return $trazaarraymodel;
    }




}
