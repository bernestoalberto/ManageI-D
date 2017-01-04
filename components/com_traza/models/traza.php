    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Traza extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_traza';
	public $trazatable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->trazatable=JTable::getInstance('Traza');

    }


 function is_null()    
{
        return $this->trazatable->id_traza==null;
    }


    function  store()
    {
        return $this->trazatable->store();
    }




    function CreateTrace($accion,$entidad,$componente,$nombre){


        $fecha = JFactory::getDate()->format('Y-m-d H:i:s', time()) ;


        $traza = array();
        $traza['usuario'] = JFactory::getUser()->username;
        if($accion == $entidad.'_add')
        $traza['accion'] = 'Creó el(la) '. $entidad.' '.$nombre;
        else if($accion == $entidad.'_update')
            $traza['accion'] = 'Actualizó el(la) '.$entidad.' '.$nombre;
            else
                $traza['accion'] = 'Canceló el(la) '.$entidad.' '.$nombre;
        $traza['componente']=$componente;
        $traza['fecha']=  $fecha;

        $this->trazatable->bind($traza);
        try {
            $this->trazatable->store($traza);
        }
        catch(SQLiteException $e){
            echo $e->getMessage();
            JFactory::getApplication()->close();
        }

    }
    function  bind($traza)
    {
        return $this->trazatable->bind($traza);
    }


     function load($pk)
    {
        $this->trazatable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->trazatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->trazatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        return $this->trazatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->trazatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_traza'=>$item->id_traza

          	 );

            $trazaitem=JModelLegacy::getInstance('Traza');
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
          	 	'id_traza'=>$item->id_traza

          	 );
            $item=JModelLegacy::getInstance('Traza');
          	 $item->load($trazapk);
            array_push($trazaarraymodel,$item);
        }
        return $trazaarraymodel;
    }




}
