    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Auditoria extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_auditoria';
	public $auditoriatable;
	public $perfil_proyectomodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->auditoriatable=JTable::getInstance('Auditoria');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->perfil_proyectomodel=JModelLegacy::getInstance('Perfil_proyecto');
    }


 function is_null()    
{
        return $this->auditoriatable->id_programa_auditoria==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->auditoriatable->store();
    }


    function  bind($auditoria)
    {
        return $this->auditoriatable->bind($auditoria);
    }


     function load($pk)
    {
        $this->auditoriatable->load($pk);
        $this->perfil_proyectomodel->load( $this->auditoriatable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->auditoriatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->auditoriatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->auditoriatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->auditoriatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->auditoriatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_programa_auditoria'=>$item->id_programa_auditoria

          	 );

            $auditoriaitem=JModelLegacy::getInstance('Auditoria');
            $auditoriaitem->load($pk);
            array_push($modellist,$auditoriaitem);
        }
        return $modellist;
    }




   function getAuditoriaModelArray($condition)    {
       $auditoriaarraymodel= array();
       $auditorialist=$this->loadAll('*',$condition);
		if(!$auditorialist)
           return $auditoriaarraymodel;
        foreach($auditorialist as $item)
        {
          	 $auditoriapk= array(
          	 	'id_programa_auditoria'=>$item->id_programa_auditoria

          	 );
            $item=JModelLegacy::getInstance('Auditoria');
          	 $item->load($auditoriapk);
            array_push($auditoriaarraymodel,$item);
        }
        return $auditoriaarraymodel;
    }




}
