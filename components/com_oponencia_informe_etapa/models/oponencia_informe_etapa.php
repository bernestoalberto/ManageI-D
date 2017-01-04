    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Oponencia_informe_etapa extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_oponencia_informe_etapa';
	public $oponencia_informe_etapatable;
	public $informe_etapamodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->oponencia_informe_etapatable=JTable::getInstance('Oponencia_informe_etapa');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_informe_etapa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->informe_etapamodel=JModelLegacy::getInstance('Informe_etapa');
    }


 function is_null()    
{
        return $this->oponencia_informe_etapatable->id_informe_etapa==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->oponencia_informe_etapatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->oponencia_informe_etapatable->store();
    }


    function  bind($oponencia_informe_etapa)
    {
        return $this->oponencia_informe_etapatable->bind($oponencia_informe_etapa);
    }


     function load($pk)
    {
        $this->oponencia_informe_etapatable->load($pk);
        $this->informe_etapamodel->load( $this->oponencia_informe_etapatable->id_informe_etapa);
    }


    function loadAll($key,$where=null)
    {
        return $this->oponencia_informe_etapatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->oponencia_informe_etapatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        return $this->oponencia_informe_etapatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->oponencia_informe_etapatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_informe_etapa'=>$item->id_informe_etapa
,
          	 	'id_oponencia'=>$item->id_oponencia

          	 );

            $oponencia_informe_etapaitem=JModelLegacy::getInstance('Oponencia_informe_etapa');
            $oponencia_informe_etapaitem->load($pk);
            array_push($modellist,$oponencia_informe_etapaitem);
        }
        return $modellist;
    }




   function getOponencia_informe_etapaModelArray($condition)    {
       $oponencia_informe_etapaarraymodel= array();
       $oponencia_informe_etapalist=$this->loadAll('*',$condition);
		if(!$oponencia_informe_etapalist)
           return $oponencia_informe_etapaarraymodel;
        foreach($oponencia_informe_etapalist as $item)
        {
          	 $oponencia_informe_etapapk= array(
          	 	'id_informe_etapa'=>$item->id_informe_etapa
,
          	 	'id_oponencia'=>$item->id_oponencia

          	 );
            $item=JModelLegacy::getInstance('Oponencia_informe_etapa');
          	 $item->load($oponencia_informe_etapapk);
            array_push($oponencia_informe_etapaarraymodel,$item);
        }
        return $oponencia_informe_etapaarraymodel;
    }




}
