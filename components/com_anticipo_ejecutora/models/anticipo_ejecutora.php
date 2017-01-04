    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class anticipo_ejecutora extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_anticipo_ejecutora';
	public $anticipo_ejecutoratable;


	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->anticipo_ejecutoratable=JTable::getInstance('anticipo_ejecutora');

    
    }




    function loadAll($key,$where=null)
    {
        return $this->anticipo_ejecutoratable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->anticipo_ejecutoratable->loadAllOr($key,$where);
    }


  

    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->anticipo_ejecutoratable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	// 	'id_proyecto'=>$item->id_proyecto

          	 );

            $proyectoitem=JModelLegacy::getInstance('anticipo_ejecutora');
            $proyectoitem->load($pk);
            array_push($modellist,$proyectoitem);
        }
        return $modellist;
    }


    

   function getanticipo_ejecutoraModelArray($condition)    {
       $proyectoarraymodel= array();
       $proyectolist=$this->loadAll('*',$condition);
		if(!$proyectolist)
           return $proyectoarraymodel;
        foreach($proyectolist as $item)
        {
          	 $proyectopk= array(
          	 //	'id_proyecto'=>$item->id_proyecto

          	 );
            $item=JModelLegacy::getInstance('anticipo_ejecutora');
          	 $item->load($proyectopk);
            array_push($proyectoarraymodel,$item);
        }
        return $proyectoarraymodel;
    }


    

}
