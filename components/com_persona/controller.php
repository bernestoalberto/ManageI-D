<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class PersonaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_persona';
	public $personamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->personamodel=JModelLegacy::getInstance('persona');
    }


    
 public function persona()
    {
 $base = JFactory::getUri()->base();                      
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);                    
        $view = $this->getView('persona');
        $view->display();
    }


    
public function persona_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->personamodel=JModelLegacy::getInstance('persona');
        $list=$this->personamodel->loadAll('*');
        $path = "../../images/users/";
        if($list!=false)
            for($i=0;$i<count($list);$i++){
             $list[$i]->foto = $path.$list[$i]->foto;
            }
        echo json_encode($list);
        JFactory::getApplication()->close();
    }


    
public function persona_add()
    {
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));

        JTable::addIncludePath( JPATH_COMPONENT.'/models');
        $persona = $this->input->post->get('persona', array(), 'array');
        $this->personamodel=JModelLegacy::getInstance('persona');
        $this->personamodel->bind($persona);

        try {
            $this->personamodel->store();
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
            JFactory::getApplication()->close();
        }

    }


    
public function persona_update()
    {
        // Check for request forgeries.
        JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JTable::addIncludePath( JPATH_COMPONENT.'/models');

        $persona = $this->input->post->get('persona', array(), 'array');
        $olditem = $this->input->post->getArray() ;
        $olditem1 =json_decode($olditem['array']);
        $persona['id_persona']=$olditem1->id_persona;
        $this->personamodel=JModelLegacy::getInstance('persona');
        $this->personamodel->bind($persona);

        try {
            $this->personamodel->store();
        }
        catch(Exception $e)
        {
            echo $e->getMessage();
            JFactory::getApplication()->close();
        }

    }


    
public function persona_delete_one()
    {
        // Check for request forgeries.
       // JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
        JTable::addIncludePath( JPATH_COMPONENT.'/models');
        $array = $this->input->post->getArray();
        $persona = json_decode($array['array']) ;
        $this->personamodel=JModelLegacy::getInstance('persona');
        foreach($persona as $p){
            $this->personamodel->bind($p);
            try {
                $this->personamodel->delete();
            }
            catch(Exception $e)
            {
                echo $e->getMessage();
                JFactory::getApplication()->close();
            }
        }

    }


}
