    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class deficiencias_proyectos extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_deficiencias_proyectos';
	public $deficiencias_proyectostable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->deficiencias_proyectostable=JTable::getInstance('deficiencias_proyectos');

    }


 function is_null()    
{
        return $this->deficiencias_proyectostable->id_deficiencias_proyectos==null;
    }



     function load($pk)
    {
        $this->deficiencias_proyectostable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->deficiencias_proyectostable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->deficiencias_proyectostable->loadAllOr($key,$where);
    }




    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->deficiencias_proyectostable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );

            $deficiencias_proyectosarraymodelitem=JModelLegacy::getInstance('deficiencias_proyectos');
            $deficiencias_proyectosarraymodelitem->load($pk);
            array_push($modellist,$deficiencias_proyectosarraymodelitem);
        }
        return $modellist;
    }




   function getdeficiencias_proyectosModelArray($condition)    {
       $deficiencias_proyectosarraymodel= array();
       $deficiencias_proyectoslist=$this->loadAll('*',$condition);
		if(!$deficiencias_proyectoslist)
           return $deficiencias_proyectosarraymodel;
        foreach($deficiencias_proyectoslist as $item)
        {
          	 $deficiencias_proyectospk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );
            $item=JModelLegacy::getInstance('deficiencias_proyectos');
          	 $item->load($deficiencias_proyectospk);
            array_push($deficiencias_proyectosarraymodel,$item);
        }
        return $deficiencias_proyectosarraymodel;
    }




}
