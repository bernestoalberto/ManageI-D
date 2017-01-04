    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Dictamen_grupo_expertos_inf_etapa extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_dictamen_grupo_expertos_inf_etapa';
	public $dictamen_grupo_expertos_inf_etapatable;
	public $evaluacionmodel;
	public $informe_etapamodel;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->dictamen_grupo_expertos_inf_etapatable=JTable::getInstance('Dictamen_grupo_expertos_inf_etapa');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_evaluacion');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->evaluacionmodel=JModelLegacy::getInstance('Evaluacion');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_informe_etapa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->informe_etapamodel=JModelLegacy::getInstance('Informe_etapa');
    }


 function is_null()    
{
        return $this->dictamen_grupo_expertos_inf_etapatable->id_dictamen_grup_exp==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->dictamen_grupo_expertos_inf_etapatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->dictamen_grupo_expertos_inf_etapatable->store();
    }


    function  bind($dictamen_grupo_expertos_inf_etapa)
    {
        return $this->dictamen_grupo_expertos_inf_etapatable->bind($dictamen_grupo_expertos_inf_etapa);
    }


     function load($pk)
    {
        $this->dictamen_grupo_expertos_inf_etapatable->load($pk);
        $this->evaluacionmodel->load( $this->dictamen_grupo_expertos_inf_etapatable->id_evaluacion);
        $this->informe_etapamodel->load( $this->dictamen_grupo_expertos_inf_etapatable->id_informe_etapa);
    }

    function loadDictamenbyInforme($pk){
        return $this->dictamen_grupo_expertos_inf_etapatable->loadDictamenbyInforme($pk);
    }
    function loadAll($key,$where=null)
    {
        return $this->dictamen_grupo_expertos_inf_etapatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->dictamen_grupo_expertos_inf_etapatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->dictamen_grupo_expertos_inf_etapatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);

        return $this->dictamen_grupo_expertos_inf_etapatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->dictamen_grupo_expertos_inf_etapatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_dictamen_grup_exp'=>$item->id_dictamen_grup_exp
,
          	 	'id_informe_etapa'=>$item->id_informe_etapa

          	 );

            $dictamen_grupo_expertos_inf_etapaitem=JModelLegacy::getInstance('Dictamen_grupo_expertos_inf_etapa');
            $dictamen_grupo_expertos_inf_etapaitem->load($pk);
            array_push($modellist,$dictamen_grupo_expertos_inf_etapaitem);
        }
        return $modellist;
    }




   function getDictamen_grupo_expertos_inf_etapaModelArray($condition)    {
       $dictamen_grupo_expertos_inf_etapaarraymodel= array();
       $dictamen_grupo_expertos_inf_etapalist=$this->loadAll('*',$condition);
		if(!$dictamen_grupo_expertos_inf_etapalist)
           return $dictamen_grupo_expertos_inf_etapaarraymodel;
        foreach($dictamen_grupo_expertos_inf_etapalist as $item)
        {
          	 $dictamen_grupo_expertos_inf_etapapk= array(
          	 	'id_dictamen_grup_exp'=>$item->id_dictamen_grup_exp
,
          	 	'id_informe_etapa'=>$item->id_informe_etapa

          	 );
            $item=JModelLegacy::getInstance('Dictamen_grupo_expertos_inf_etapa');
          	 $item->load($dictamen_grupo_expertos_inf_etapapk);
            array_push($dictamen_grupo_expertos_inf_etapaarraymodel,$item);
        }
        return $dictamen_grupo_expertos_inf_etapaarraymodel;
    }




}
