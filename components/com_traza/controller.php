<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class TrazaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_traza';
	public $trazamodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->trazamodel=JModelLegacy::getInstance('traza');
    }


    
 public function traza()
    {
 $base = JFactory::getUri()->base();                      
    $url= $base.'components/'.''.$this->name_component.'/assets/js/kendo_'.$this->name.'.js'; 
   array_push(JFactory::getDocument()->_script,$url);                    
        $view = $this->getView('traza');
        $view->display();
    }


    
public function traza_json_list()
    {
        header('Content-Type: application/json');
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->trazamodel=JModelLegacy::getInstance('traza');
        $list=$this->trazamodel->loadAll('*');
        if($list!=false)
        echo json_encode($list);
        JFactory::getApplication()->close();
    }

        public function traza_delete_one()
        {
            // Check for request forgeries.
            //JSession::checkToken('post') or jexit(JText::_('JINVALID_TOKEN'));
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
            $array = $this->input->post->getArray();
            $traza =  json_decode($array['array']);
            $this->trazamodel=JModelLegacy::getInstance('traza');
            foreach($traza as $t){
                $this->trazamodel->bind($t);
                try {
                    $this->trazamodel->delete();
                }
                catch(Exception $e)
                {
                    echo $e->getMessage();
                    JFactory::getApplication()->close();
                } }

        }






}
