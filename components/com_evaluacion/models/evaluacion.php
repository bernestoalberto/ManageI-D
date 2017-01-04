    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Evaluacion extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_evaluacion';
	public $evaluaciontable;
	public $certificacion_activdades_resultadosarray_model;
	public $dictamen_eval_perfil_proyarray_model;
	public $dictamen_grupo_expertos_inf_etapaarray_model;
	public $notificacion_ingreso_gastosarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->evaluaciontable=JTable::getInstance('Evaluacion');

        $this->certificacion_activdades_resultadosarray_model=array();
        $this->dictamen_eval_perfil_proyarray_model=array();
        $this->dictamen_grupo_expertos_inf_etapaarray_model=array();
        $this->notificacion_ingreso_gastosarray_model=array();
    }


 function is_null()    
{
        return $this->evaluaciontable->id_evaluacion==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->evaluaciontable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->evaluaciontable->store();
    }
        function loadEvaluacion($pk){
            return $this->evaluaciontable->loadEvaluacion($pk);
        }

    function  bind($evaluacion)
    {
        return $this->evaluaciontable->bind($evaluacion);
    }


     function load($pk)
    {
        $this->evaluaciontable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->evaluaciontable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->evaluaciontable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->evaluaciontable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->evaluaciontable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->evaluaciontable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_evaluacion'=>$item->id_evaluacion

          	 );

            $evaluacionitem=JModelLegacy::getInstance('Evaluacion');
            $evaluacionitem->load($pk);
            array_push($modellist,$evaluacionitem);
        }
        return $modellist;
    }




   function getEvaluacionModelArray($condition)    {
       $evaluacionarraymodel= array();
       $evaluacionlist=$this->loadAll('*',$condition);
		if(!$evaluacionlist)
           return $evaluacionarraymodel;
        foreach($evaluacionlist as $item)
        {
          	 $evaluacionpk= array(
          	 	'id_evaluacion'=>$item->id_evaluacion

          	 );
            $item=JModelLegacy::getInstance('Evaluacion');
          	 $item->load($evaluacionpk);
            array_push($evaluacionarraymodel,$item);
        }
        return $evaluacionarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Certificacion_activdades_resultados
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_certificacion_activdades_resultados');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_evaluacion='.$this->evaluaciontable->id_evaluacion
        	);
        $certificacion_activdades_resultados=JModelLegacy::getInstance('Certificacion_activdades_resultados');
        $this->certificacion_activdades_resultadosarray_model=$certificacion_activdades_resultados->getCertificacion_activdades_resultadosModelArray($condition);
        
        //Dependencia con la tabla Dictamen_eval_perfil_proy
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_dictamen_eval_perfil_proy');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_evaluacion='.$this->evaluaciontable->id_evaluacion
        	);
        $dictamen_eval_perfil_proy=JModelLegacy::getInstance('Dictamen_eval_perfil_proy');
        $this->dictamen_eval_perfil_proyarray_model=$dictamen_eval_perfil_proy->getDictamen_eval_perfil_proyModelArray($condition);
        
        //Dependencia con la tabla Dictamen_grupo_expertos_inf_etapa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_dictamen_grupo_expertos_inf_etapa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_evaluacion='.$this->evaluaciontable->id_evaluacion
        	);
        $dictamen_grupo_expertos_inf_etapa=JModelLegacy::getInstance('Dictamen_grupo_expertos_inf_etapa');
        $this->dictamen_grupo_expertos_inf_etapaarray_model=$dictamen_grupo_expertos_inf_etapa->getDictamen_grupo_expertos_inf_etapaModelArray($condition);
        
        //Dependencia con la tabla Notificacion_ingreso_gastos
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_notificacion_ingreso_gastos');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_evaluacion='.$this->evaluaciontable->id_evaluacion
        	);
        $notificacion_ingreso_gastos=JModelLegacy::getInstance('Notificacion_ingreso_gastos');
        $this->notificacion_ingreso_gastosarray_model=$notificacion_ingreso_gastos->getNotificacion_ingreso_gastosModelArray($condition);

    }


}
