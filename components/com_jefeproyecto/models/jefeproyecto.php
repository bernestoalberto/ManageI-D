
<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
class Jefeproyecto extends JModelLegacy
{



    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_jefeproyecto';
    public $jefeproyectotable;
    public $cat_cientificamodel;
    public $grado_cientificomodel;
    public $perfil_proyectomodel;
    public $personamodel;
    public $control_programa_proyectoarray_model;
    public $informe_etapaarray_model;

    function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->jefeproyectotable=JTable::getInstance('Jefeproyecto');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_cat_cientifica');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->cat_cientificamodel=JModelLegacy::getInstance('Cat_cientifica');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_grado_cientifico');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->grado_cientificomodel=JModelLegacy::getInstance('Grado_cientifico');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->perfil_proyectomodel=JModelLegacy::getInstance('Perfil_proyecto');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_persona');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->personamodel=JModelLegacy::getInstance('Persona');
        $this->control_programa_proyectoarray_model=array();
        $this->informe_etapaarray_model=array();
    }


    function is_null()
    {
        return $this->jefeproyectotable->id_persona==null;
    }


    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->jefeproyectotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->jefeproyectotable->store();
    }


    function  bind($jefeproyecto)
    {
        return $this->jefeproyectotable->bind($jefeproyecto);
    }
function loadProject($id_persona){
    return $this->jefeproyectotable->loadJefeProject($id_persona);
}

    function load($pk)
    {
        $this->jefeproyectotable->load($pk);
        $this->cat_cientificamodel->load( $this->jefeproyectotable->id_categoria);
        $this->grado_cientificomodel->load( $this->jefeproyectotable->id_grado);
        $this->perfil_proyectomodel->load( $this->jefeproyectotable->id_proyecto);
        $this->personamodel->load( $this->jefeproyectotable->id_persona);
    }


    function loadAll($key,$where=null)
    {
        return $this->jefeproyectotable->loadAll($key,$where);
    }
    function loadOnlyPersonAvailable()
    {
        return $this->jefeproyectotable->loadOnlyPersonAvailable();
    }

    function loadAllOr($key,$where=null)
    {
        return $this->jefeproyectotable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->jefeproyectotable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->jefeproyectotable->delete($pk);
    }
    function loadtituloObtenidoJefeProyecto($key){
        return $this->jefeproyectotable->loadtituloObtenidoJefeProyecto($key);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->jefeproyectotable->loadAll($key,$where);
        foreach($lista as $item)
        {
            $pk= array(
                'id_persona'=>$item->id_persona

            );

            $jefeproyectoitem=JModelLegacy::getInstance('Jefeproyecto');
            $jefeproyectoitem->load($pk);
            array_push($modellist,$jefeproyectoitem);
        }
        return $modellist;
    }




    function getJefeproyectoModelArray($condition)    {
        $jefeproyectoarraymodel= array();
        $jefeproyectolist=$this->loadAll('*',$condition);
        if(!$jefeproyectolist)
            return $jefeproyectoarraymodel;
        foreach($jefeproyectolist as $item)
        {
            $jefeproyectopk= array(
                'id_persona'=>$item->id_persona

            );
            $item=JModelLegacy::getInstance('Jefeproyecto');
            $item->load($jefeproyectopk);
            array_push($jefeproyectoarraymodel,$item);
        }
        return $jefeproyectoarraymodel;
    }


    function load_dependences()
    {

        //Dependencia con la tabla Control_programa_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_control_programa_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
            '0'=>'id_persona='.$this->jefeproyectotable->id_persona
        );
        $control_programa_proyecto=JModelLegacy::getInstance('Control_programa_proyecto');
        $this->control_programa_proyectoarray_model=$control_programa_proyecto->getControl_programa_proyectoModelArray($condition);

        //Dependencia con la tabla Informe_etapa
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_informe_etapa');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
            '0'=>'id_persona='.$this->jefeproyectotable->id_persona
        );
        $informe_etapa=JModelLegacy::getInstance('Informe_etapa');
        $this->informe_etapaarray_model=$informe_etapa->getInforme_etapaModelArray($condition);

    }


}
