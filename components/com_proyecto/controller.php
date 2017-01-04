<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class ProyectoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_proyecto';
	public $proyectomodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->proyectomodel=JModelLegacy::getInstance('proyecto');
    }


    
 public function proyecto()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_'.$this->name.'.js';

        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('proyecto');
        $view->display();
    }
        public function proyecto_json_combo_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            $this->proyectomodel=JModelLegacy::getInstance('proyecto');
            $list=$this->proyectomodel->loadAll('*');
            if($list!=false)
                echo json_encode($list);
            JFactory::getApplication()->close();
        }

    
public function proyecto_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        $this->proyectomodel=JModelLegacy::getInstance('proyecto');
        $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $personamodel=JModelLegacy::getInstance('persona');
        $list=$this->proyectomodel->loadAll('*');
        if($list!=false) {
            for ($i = 0; $i < count($list); $i++) {

                    $perfilproyecto = (Object)$perfilproyectomodel->loadProyecto($list[$i]->id_proyecto);
                $list[$i]->nombre_proyecto = $perfilproyecto->titulo_proyecto;
                    $persona = (Object)$personamodel->loadPersona($perfilproyecto->id_persona);
                    $list[$i]->jefeproyecto = $persona->nombre;


            }
            echo json_encode($list);
        }
        JFactory::getApplication()->close();
    }
public function proyecto_combo_innovacion_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
  /*      JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
        JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_i_d/models');
        $this->proyectomodel=JModelLegacy::getInstance('proyecto');*/
    /*    $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $personamodel=JModelLegacy::getInstance('persona');
        $idmodel=JModelLegacy::getInstance('i_d');*/
        $lista=$this->proyectomodel->loadProyectobyFilter('*');
       // if($list!=false) {
        /*    for ($i = 0; $i < count($list); $i++) {
                 $ipd= $idmodel->loadID($list[$i]->id_proyecto);

                    if($ipd== false || $ipd->sostenibilidad_resultados_proyecto=""){
                        $lista[$i] = $list[$i];
                        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);

                        $persona = (Object)$personamodel->loadPersona($perfilproyecto->id_persona);
                        $lista[$i]->jefeproyecto = $persona->nombre;


                    }
                }*/


            echo json_encode($lista);
        //}
        JFactory::getApplication()->close();
    }
        public function proyecto_combo_i_d_list()
        {
            header('Content-Type: application/json');
            // Send the response.
           JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            /*JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_perfil_proyecto/models');
           JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_persona/models');
           JModelLegacy::addIncludePath( JPATH_ROOT.'/components/com_innovacion/models');
           $this->proyectomodel=JModelLegacy::getInstance('proyecto');
           $perfilproyectomodel=JModelLegacy::getInstance('perfil_proyecto');
           $personamodel=JModelLegacy::getInstance('persona');
           $innovacionmodel=JModelLegacy::getInstance('innovacion');*/
            $lista=$this->proyectomodel->loadProyectobyFilter('*');
      /*      if($list!=false) {
                for ($i = 0; $i < count($list); $i++) {
                    $innovacion= (Object)$innovacionmodel->loadInnovacion($list[$i]->id_proyecto);

                    if($innovacion== false || $innovacion->propiedad_intelectual=""){
                        $lista[$i] = $list[$i];
                        $perfilproyecto = (Object)$perfilproyectomodel->loadPerfilProyecto($list[$i]->id_proyecto);

                        $persona = (Object)$personamodel->loadPersona($perfilproyecto->id_persona);
                        $lista[$i]->jefeproyecto = $persona->nombre;


                    }
                }*/


                echo json_encode($lista);
          //  }
            JFactory::getApplication()->close();
        }




    
public function proyecto_add()
    {
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JTable::addIncludePath( JPATH_COMPONENT.'/models');
        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $perfil_proyecto = $this->input->post->get('perfil_proyecto', array(), 'array');
        $perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');
        $perfil_proyectomodel->bind($perfil_proyecto);

        $proyecto = $this->input->post->get('proyecto', array(), 'array');
        $this->proyectomodel=JModelLegacy::getInstance('proyecto');
        $this->proyectomodel->bind($proyecto);

        try {
        	$perfil_proyectomodel->store();
        	$pk=$perfil_proyectomodel->perfil_proyectotable->getPrimaryKey();
        	$this->proyectomodel->bind($pk);
		
            $this->proyectomodel->store();
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
            JFactory::getApplication()->close();
        }

    }


    
public function proyecto_update()
    {
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JTable::addIncludePath( JPATH_COMPONENT.'/models');

        $path=FOFPlatform::getInstance()->getComponentBaseDirs('com_perfil_proyecto');
        JModelLegacy::addIncludePath( $path['site'].'/models');

        $perfil_proyecto = $this->input->post->get('olditem', array(), 'array');
        $olditem = $this->input->post->get('olditem',array(),'array') ;                                                 
        $olditem1 =json_decode($olditem[0]);                                                                             
        $proyecto['id_proyecto'] = $olditem1->id_proyecto ;
        $perfil_proyectomodel=JModelLegacy::getInstance('perfil_proyecto');

          	$pk= array(
          	 	/*'id_persona'=>$item->id_persona
,
          	 	'id_proyecto'=>$item->id_proyecto*/

          	 );
        $perfil_proyectomodel->load($pk);
        $perfil_proyectomodel->bind($perfil_proyecto);
		 
        $proyecto = $this->input->post->get('proyecto', array(), 'array');
$olditem = $this->input->post->get('olditem',array(),'array') ;
 $olditem1 =json_decode($olditem[0]); 
 $proyecto['proyecto']=$olditem1->id_proyecto ;
        $this->proyectomodel=JModelLegacy::getInstance('proyecto');
        $this->proyectomodel->bind($proyecto);

        try {
            $perfil_proyectomodel->store();
            $this->proyectomodel->store();
        }
        catch(SQLiteException $e)
        {
            echo $e->getMessage();
            JFactory::getApplication()->close();
        }

    }


    
public function proyecto_delete_one()
    {
        // Check for request forgeries.
        //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JTable::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $proyecto =  json_decode($array['array']);  
         $this->proyectomodel=JModelLegacy::getInstance('proyecto');
        foreach($proyecto as $p){                                 
        $this->proyectomodel->bind($p);
        try {
            $this->proyectomodel->delete();
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
            JFactory::getApplication()->close();
       } }

    }


}
