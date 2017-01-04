    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class certificn_actvs_resultds extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_certificn_actvs_resultds';
	public $certificn_actvs_resultdstable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->certificn_actvs_resultdstable=JTable::getInstance('certificn_actvs_resultds');

    }



    function loadAll($key,$where=null)
    {
        return $this->certificn_actvs_resultdstable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->certificn_actvs_resultdstable->loadAllOr($key,$where);
    }




    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->certificn_actvs_resultdstable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );

            $trazaitem=JModelLegacy::getInstance('certificn_actvs_resultds');
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
            $item=JModelLegacy::getInstance('certificn_actvs_resultds');
          	 $item->load($trazapk);
            array_push($trazaarraymodel,$item);
        }
        return $trazaarraymodel;
    }




}
