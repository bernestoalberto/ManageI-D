    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class rep_informe_auditoria extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_rep_informe_auditoria';
	public $repConvocatoriatable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->repConvocatoriatable=JTable::getInstance('rep_informe_auditoria');

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

            $trazaitem=JModelLegacy::getInstance('rep_informe_auditoria');
            $trazaitem->load($pk);
            array_push($modellist,$trazaitem);
        }
        return $modellist;
    }




   function getrep_informe_auditoriaModelArray($condition)    {
       $trazaarraymodel= array();
       $trazalist=$this->loadAll('*',$condition);
		if(!$trazalist)
           return $trazaarraymodel;
        foreach($trazalist as $item)
        {
          	 $trazapk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );
            $item=JModelLegacy::getInstance('rep_informe_auditoria');
          	 $item->load($trazapk);
            array_push($trazaarraymodel,$item);
        }
        return $trazaarraymodel;
    }




}
