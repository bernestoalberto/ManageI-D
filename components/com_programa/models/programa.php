
<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
class Programa extends JModelLegacy
{



    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_programa';
    public $programatable;
    public $entidadmodel;
    public $perfil_programamodel;
    public $personamodel;
    public $convocatoriaarray_model;
    public $ejecutoraarray_model;
    public $perfil_proyectoarray_model;
    public $revision_contratoarray_model;

    function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->programatable=JTable::getInstance('Programa');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_entidad');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->entidadmodel=JModelLegacy::getInstance('Entidad');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_programa');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->perfil_programamodel=JModelLegacy::getInstance('Perfil_programa');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_persona');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $this->personamodel=JModelLegacy::getInstance('Persona');
        $this->convocatoriaarray_model=array();
        $this->ejecutoraarray_model=array();
        $this->perfil_proyectoarray_model=array();
        $this->revision_contratoarray_model=array();

    }


    function is_null()
    {
        return $this->programatable->id_persona==null;
    }


    function  store()
    {

        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->programatable->store();
    }


    function  bind($programa)
    {
        return $this->programatable->bind($programa);
    }
    function  loadCombo($programa)
    {

        return $this->programatable->loadCombo($programa);
    }


    function load($pk)
    {
        $this->programatable->load($pk);
        $this->entidadmodel->load( $this->programatable->id_entidad);
        $this->perfil_programamodel->load( $this->programatable->id_programa);
        $this->personamodel->load( $this->programatable->id_persona);
    }
    function  loadAllJefePrograma(){
return $this->programatable->loadAllJefePrograma();
}

    function loadAll($key,$where=null)
    {
        return $this->programatable->loadAll($key,$where);
    }
   function loadAllENNP($key)
    {

        return $this->programatable->loadAllENNP($key);
    }
    function loadSecretario($key)
    {

        return $this->programatable->loadSecretario($key);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->programatable->loadAllOr($key,$where);
    }
    function loadFilter()
    {
        return $this->programatable->loadFilter();
    }

    function loadPrograma($key)
    {
        return $this->programatable->loadPrograma($key);
    }
    function loadJefePrograma($key)
    {
        return $this->programatable->loadJefePrograma($key);
    }

    function loadNombrePrograma($key)
    {
        return $this->programatable->loadNombrePrograma($key);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion = $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->programatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);

        return $this->programatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->programatable->loadAll($key,$where);
        foreach($lista as $item)
        {
            $pk= array(
                'id_persona'=>$item->id_persona
            ,
                'id_programa'=>$item->id_programa

            );

            $programaitem=JModelLegacy::getInstance('Programa');
            $programaitem->load($pk);
            array_push($modellist,$programaitem);
        }
        return $modellist;
    }




    function getProgramaModelArray($condition)    {
        $programaarraymodel= array();
        $programalist=$this->loadAll('*',$condition);
        if(!$programalist)
            return $programaarraymodel;
        foreach($programalist as $item)
        {
            $programapk= array(
                'id_persona'=>$item->id_persona
            ,
                'id_programa'=>$item->id_programa

            );
            $item=JModelLegacy::getInstance('Programa');
            $item->load($programapk);
            array_push($programaarraymodel,$item);
        }
        return $programaarraymodel;
    }


    function load_dependences()
    {

        //Dependencia con la tabla Convocatoria
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_convocatoria');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
            '0'=>'id_programa='.$this->programatable->id_programa,
            '0'=>'id_persona='.$this->programatable->id_persona
        );
        $convocatoria=JModelLegacy::getInstance('Convocatoria');
        $this->convocatoriaarray_model=$convocatoria->getConvocatoriaModelArray($condition);

        //Dependencia con la tabla Ejecutora
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_ejecutora');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
            '0'=>'id_programa='.$this->programatable->id_programa
        );
        $ejecutora=JModelLegacy::getInstance('Ejecutora');
        $this->ejecutoraarray_model=$ejecutora->getEjecutoraModelArray($condition);

        //Dependencia con la tabla Perfil_proyecto
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
            '0'=>'id_programa='.$this->programatable->id_programa,
            '0'=>'id_persona='.$this->programatable->id_persona
        );
        $perfil_proyecto=JModelLegacy::getInstance('Perfil_proyecto');
        $this->perfil_proyectoarray_model=$perfil_proyecto->getPerfil_proyectoModelArray($condition);

        //Dependencia con la tabla Revision_contrato
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_revision_contrato');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $condition=array(
            '0'=>'id_programa='.$this->programatable->id_programa,
            '0'=>'id_persona='.$this->programatable->id_persona
        );
        $revision_contrato=JModelLegacy::getInstance('Revision_contrato');
        $this->revision_contratoarray_model=$revision_contrato->getRevision_contratoModelArray($condition);

    }


}
