    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class rep_informe_ejecucion_programa extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_rep_informe_ejecucion_programa';
	public $informe_ejecucion_programatable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->informe_ejecucion_programatable=JTable::getInstance('rep_informe_ejecucion_programa');

    }


 function is_null()    
{
        return $this->informe_ejecucion_programatable->id_traza==null;
    }



     function load($pk)
    {
        $this->informe_ejecucion_programatable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->informe_ejecucion_programatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->informe_ejecucion_programatable->loadAllOr($key,$where);
    }

        function countProyectosbyID_programa($key)
        {
            return $this->informe_ejecucion_programatable->countProyectosbyID_programa($key);
        }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->informe_ejecucion_programatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 //	'id_traza'=>$item->id_traza

          	 );

            $trazaitem=JModelLegacy::getInstance('rep_informe_ejecucion_programa');
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
            $item=JModelLegacy::getInstance('rep_informe_ejecucion_programa');
          	 $item->load($trazapk);
            array_push($trazaarraymodel,$item);
        }
        return $trazaarraymodel;
    }




}
