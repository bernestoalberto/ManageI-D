    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Proyecto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_proyecto';
	public $proyectotable;
	public $perfil_proyectofathermodel;
	public $anticipoarray_model;
	public $certificacion_activdades_resultadosarray_model;
	public $contratoarray_model;
	public $control_ejecucion_presupuestoarray_model;
	public $control_programa_proyectoarray_model;
	public $documentacion_evidencias_objetivasarray_model;
	public $i_darray_model;
	public $informe_auditoriaarray_model;
	public $informe_etapaarray_model;
	public $innovacionarray_model;
	public $plan_auditoriaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->proyectotable=JTable::getInstance('Proyecto');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->perfil_proyectofathermodel=JModelLegacy::getInstance('Perfil_proyecto');
        $this->anticipoarray_model=array();
        $this->certificacion_activdades_resultadosarray_model=array();
        $this->contratoarray_model=array();
        $this->control_ejecucion_presupuestoarray_model=array();
        $this->control_programa_proyectoarray_model=array();
        $this->documentacion_evidencias_objetivasarray_model=array();
        $this->i_darray_model=array();
        $this->informe_auditoriaarray_model=array();
        $this->informe_etapaarray_model=array();
        $this->innovacionarray_model=array();
        $this->plan_auditoriaarray_model=array();
    }


 function is_null(){
        return $this->proyectotable->id_persona==null;
    }

        function loadProyecto($pk){
            return $this->proyectotable->loadProyecto($pk);
        }
        function loadProyectobyFilter($pk){
            return $this->proyectotable->loadProyectobyFilter($pk);
        }
        function  CreateBackup(){
            return $this->proyectotable->CreateBackup();
        }

    function  store()
    {
        return $this->proyectotable->store();
    }


    function  bind($proyecto)
    {
        return $this->proyectotable->bind($proyecto);
    }


     function load($pk)
    {
        $this->proyectotable->load($pk);
        $this->perfil_proyectofathermodel->load( $this->proyectotable->id_proyecto);
    }


    function loadAll($key,$where=null)
    {
        return $this->proyectotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->proyectotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        return $this->proyectotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->proyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $proyectoitem=JModelLegacy::getInstance('Proyecto');
            $proyectoitem->load($pk);
            array_push($modellist,$proyectoitem);
        }
        return $modellist;
    }



    function loadAllItemWithParent($key,$where=null)
    {
        $modellist=array();
        $lista=$this->proyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );

            $proyectoitem=JModelLegacy::getInstance('Proyecto');
            $proyectoitem->load($pk);
            if($proyectoitem->perfil_proyectofathermodel->perfil_proyectotable->id_persona==null)
                $proyectoitem->perfil_proyectofathermodel->load($pk);
            array_push($modellist,$proyectoitem);
        }
        return $modellist;
    }


   function getProyectoModelArray($condition)    {
       $proyectoarraymodel= array();
       $proyectolist=$this->loadAll('*',$condition);
		if(!$proyectolist)
           return $proyectoarraymodel;
        foreach($proyectolist as $item)
        {
          	 $proyectopk= array(
          	 	'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto

          	 );
            $item=JModelLegacy::getInstance('Proyecto');
          	 $item->load($proyectopk);
            array_push($proyectoarraymodel,$item);
        }
        return $proyectoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Anticipo
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_anticipo');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $anticipo=JModelLegacy::getInstance('Anticipo');
        $this->anticipoarray_model=$anticipo->getAnticipoModelArray($condition);
        
        //Dependencia con la tabla Certificacion_activdades_resultados
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_certificacion_activdades_resultados');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $certificacion_activdades_resultados=JModelLegacy::getInstance('Certificacion_activdades_resultados');
        $this->certificacion_activdades_resultadosarray_model=$certificacion_activdades_resultados->getCertificacion_activdades_resultadosModelArray($condition);
        
        //Dependencia con la tabla Contrato
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_contrato');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $contrato=JModelLegacy::getInstance('Contrato');
        $this->contratoarray_model=$contrato->getContratoModelArray($condition);
        
        //Dependencia con la tabla Control_ejecucion_presupuesto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_ejecucion_presupuesto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $control_ejecucion_presupuesto=JModelLegacy::getInstance('Control_ejecucion_presupuesto');
        $this->control_ejecucion_presupuestoarray_model=$control_ejecucion_presupuesto->getControl_ejecucion_presupuestoModelArray($condition);
        
        //Dependencia con la tabla Control_programa_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_programa_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto
        	);
        $control_programa_proyecto=JModelLegacy::getInstance('Control_programa_proyecto');
        $this->control_programa_proyectoarray_model=$control_programa_proyecto->getControl_programa_proyectoModelArray($condition);
        
        //Dependencia con la tabla Documentacion_evidencias_objetivas
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_documentacion_evidencias_objetivas');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $documentacion_evidencias_objetivas=JModelLegacy::getInstance('Documentacion_evidencias_objetivas');
        $this->documentacion_evidencias_objetivasarray_model=$documentacion_evidencias_objetivas->getDocumentacion_evidencias_objetivasModelArray($condition);
        
        //Dependencia con la tabla I_d
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_i_d');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $i_d=JModelLegacy::getInstance('I_d');
        $this->i_darray_model=$i_d->getI_dModelArray($condition);
        
        //Dependencia con la tabla Informe_auditoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_informe_auditoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $informe_auditoria=JModelLegacy::getInstance('Informe_auditoria');
        $this->informe_auditoriaarray_model=$informe_auditoria->getInforme_auditoriaModelArray($condition);
        
        //Dependencia con la tabla Informe_etapa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_informe_etapa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto
        	);
        $informe_etapa=JModelLegacy::getInstance('Informe_etapa');
        $this->informe_etapaarray_model=$informe_etapa->getInforme_etapaModelArray($condition);
        
        //Dependencia con la tabla Innovacion
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_innovacion');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $innovacion=JModelLegacy::getInstance('Innovacion');
        $this->innovacionarray_model=$innovacion->getInnovacionModelArray($condition);
        
        //Dependencia con la tabla Plan_auditoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_plan_auditoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_proyecto='.$this->proyectotable->id_proyecto,
          	 	'0'=>'id_persona='.$this->proyectotable->id_persona
        	);
        $plan_auditoria=JModelLegacy::getInstance('Plan_auditoria');
        $this->plan_auditoriaarray_model=$plan_auditoria->getPlan_auditoriaModelArray($condition);

    }


}
