    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Lista_chequeo_auditoria extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_lista_chequeo_auditoria';
	public $lista_chequeo_auditoriatable;
	public $auditoriaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->lista_chequeo_auditoriatable=JTable::getInstance('Lista_chequeo_auditoria');

        $this->auditoriaarray_model=array();
    }


 function is_null()    
{
        return $this->lista_chequeo_auditoriatable->id_lista_chequeo==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->lista_chequeo_auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->lista_chequeo_auditoriatable->store();
    }


    function  bind($lista_chequeo_auditoria)
    {
        return $this->lista_chequeo_auditoriatable->bind($lista_chequeo_auditoria);
    }


     function load($pk)
    {
        $this->lista_chequeo_auditoriatable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->lista_chequeo_auditoriatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->lista_chequeo_auditoriatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->lista_chequeo_auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->lista_chequeo_auditoriatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->lista_chequeo_auditoriatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_lista_chequeo'=>$item->id_lista_chequeo

          	 );

            $lista_chequeo_auditoriaitem=JModelLegacy::getInstance('Lista_chequeo_auditoria');
            $lista_chequeo_auditoriaitem->load($pk);
            array_push($modellist,$lista_chequeo_auditoriaitem);
        }
        return $modellist;
    }




   function getLista_chequeo_auditoriaModelArray($condition)    {
       $lista_chequeo_auditoriaarraymodel= array();
       $lista_chequeo_auditorialist=$this->loadAll('*',$condition);
		if(!$lista_chequeo_auditorialist)
           return $lista_chequeo_auditoriaarraymodel;
        foreach($lista_chequeo_auditorialist as $item)
        {
          	 $lista_chequeo_auditoriapk= array(
          	 	'id_lista_chequeo'=>$item->id_lista_chequeo

          	 );
            $item=JModelLegacy::getInstance('Lista_chequeo_auditoria');
          	 $item->load($lista_chequeo_auditoriapk);
            array_push($lista_chequeo_auditoriaarraymodel,$item);
        }
        return $lista_chequeo_auditoriaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Auditoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_auditoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_lista_chequeo='.$this->lista_chequeo_auditoriatable->id_lista_chequeo
        	);
        $auditoria=JModelLegacy::getInstance('Auditoria');
        $this->auditoriaarray_model=$auditoria->getAuditoriaModelArray($condition);

    }


}
