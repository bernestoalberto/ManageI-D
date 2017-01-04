    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Indicadores_impacto extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_indicadores_impacto';
	public $indicadores_impactotable;
	public $perfil_programaarray_model;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->indicadores_impactotable=JTable::getInstance('Indicadores_impacto');

        $this->perfil_programaarray_model=array();
    }


 function is_null()    
{
        return $this->indicadores_impactotable->id_indicador==null;
    }


    function  store()
    {


        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->indicadores_impactotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->indicadores_impactotable->store();
    }


    function  bind($indicadores_impacto)
    {
        return $this->indicadores_impactotable->bind($indicadores_impacto);
    }


     function load($pk)
    {
        $this->indicadores_impactotable->load($pk);
    }
        function loadIndicador($pk){
            return   $this->indicadores_impactotable->loadIndicador($pk);
        }


    function loadAll($key,$where=null)
    {
        return $this->indicadores_impactotable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->indicadores_impactotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->indicadores_impactotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->indicadores_impactotable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->indicadores_impactotable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_indicador'=>$item->id_indicador

          	 );

            $indicadores_impactoitem=JModelLegacy::getInstance('Indicadores_impacto');
            $indicadores_impactoitem->load($pk);
            array_push($modellist,$indicadores_impactoitem);
        }
        return $modellist;
    }




   function getIndicadores_impactoModelArray($condition)    {
       $indicadores_impactoarraymodel= array();
       $indicadores_impactolist=$this->loadAll('*',$condition);
		if(!$indicadores_impactolist)
           return $indicadores_impactoarraymodel;
        foreach($indicadores_impactolist as $item)
        {
          	 $indicadores_impactopk= array(
          	 	'id_indicador'=>$item->id_indicador

          	 );
            $item=JModelLegacy::getInstance('Indicadores_impacto');
          	 $item->load($indicadores_impactopk);
            array_push($indicadores_impactoarraymodel,$item);
        }
        return $indicadores_impactoarraymodel;
    }


     function load_dependences()
    {
        
        //Dependencia con la tabla Perfil_programa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
          	 	'0'=>'id_indicador='.$this->indicadores_impactotable->id_indicador
        	);
        $perfil_programa=JModelLegacy::getInstance('Perfil_programa');
        $this->perfil_programaarray_model=$perfil_programa->getPerfil_programaModelArray($condition);

    }
     /*   public function getNFieldbyID($id){

           $indicador= $this->loadAllItem($id);
            return  $indicador->indicador;
        }*/


}
