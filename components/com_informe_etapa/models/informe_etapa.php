    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Informe_etapa extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_informe_etapa';
	public $informe_etapatable;
	public $entidadmodel;
	public $jefeproyectomodel;
	public $programamodel;
	public $proyectomodel;
	public $dictamen_grupo_expertos_inf_etapaarray_model;
	public $oponencia_informe_etapaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->informe_etapatable=JTable::getInstance('Informe_etapa');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_entidad');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->entidadmodel=JModelLegacy::getInstance('Entidad');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_jefeproyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->jefeproyectomodel=JModelLegacy::getInstance('Jefeproyecto');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->programamodel=JModelLegacy::getInstance('Programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->proyectomodel=JModelLegacy::getInstance('Proyecto');
        $this->dictamen_grupo_expertos_inf_etapaarray_model=array();
        $this->oponencia_informe_etapaarray_model=array();
    }


 function is_null()    
{
        return $this->informe_etapatable->id_informe_etapa==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->informe_etapatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->informe_etapatable->store();
    }
        function SendEmailtoSecretarioPrograma($correoJefeProyecto,$nombrejefeproyecto,$correoSecretarioPrograma,$file,$nombre){
            $mailer = JFactory::getMailer();
            $mailer->setSender(array( $correoJefeProyecto, $nombrejefeproyecto ));
            $mailer->addRecipient( $correoSecretarioPrograma );
            $mailer->setSubject( $nombre );
            $mailer->setBody( 'Tenga un saludo cordial, mediante la presente le informamos que se le envía el informe de etapa. Para mas detalles, consultar el adjunto');
            $mailer->addAttachment($file);
            $mailer->Send();
        }
        function  loadInforme($pk)
    {
        return $this->informe_etapatable->loadInforme($pk);
    }

     function loadInformebyPrograma($pk){
         return $this->informe_etapatable->loadInformebyPrograma($pk);
     }
    function  bind($informe_etapa)
    {
        return $this->informe_etapatable->bind($informe_etapa);
    }


     function load($pk)
    {
        $this->informe_etapatable->load($pk);
        $this->entidadmodel->load( $this->informe_etapatable->id_entidad);
        $this->jefeproyectomodel->load( $this->informe_etapatable->id_persona);
        $this->programamodel->load( $this->informe_etapatable->id_programa);
        $this->proyectomodel->load( $this->informe_etapatable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->informe_etapatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->informe_etapatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->informe_etapatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$nombre);
        return $this->informe_etapatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->informe_etapatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_informe_etapa'=>$item->id_informe_etapa

          	 );

            $informe_etapaitem=JModelLegacy::getInstance('Informe_etapa');
            $informe_etapaitem->load($pk);
            array_push($modellist,$informe_etapaitem);
        }
        return $modellist;
    }




   function getInforme_etapaModelArray($condition)    {
       $informe_etapaarraymodel= array();
       $informe_etapalist=$this->loadAll('*',$condition);
		if(!$informe_etapalist)
           return $informe_etapaarraymodel;
        foreach($informe_etapalist as $item)
        {
          	 $informe_etapapk= array(
          	 	'id_informe_etapa'=>$item->id_informe_etapa

          	 );
            $item=JModelLegacy::getInstance('Informe_etapa');
          	 $item->load($informe_etapapk);
            array_push($informe_etapaarraymodel,$item);
        }
        return $informe_etapaarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Dictamen_grupo_expertos_inf_etapa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_dictamen_grupo_expertos_inf_etapa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_informe_etapa='.$this->informe_etapatable->id_informe_etapa
        	);
        $dictamen_grupo_expertos_inf_etapa=JModelLegacy::getInstance('Dictamen_grupo_expertos_inf_etapa');
        $this->dictamen_grupo_expertos_inf_etapaarray_model=$dictamen_grupo_expertos_inf_etapa->getDictamen_grupo_expertos_inf_etapaModelArray($condition);
        
        //Dependencia con la tabla Oponencia_informe_etapa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_oponencia_informe_etapa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_informe_etapa='.$this->informe_etapatable->id_informe_etapa
        	);
        $oponencia_informe_etapa=JModelLegacy::getInstance('Oponencia_informe_etapa');
        $this->oponencia_informe_etapaarray_model=$oponencia_informe_etapa->getOponencia_informe_etapaModelArray($condition);

    }


}
