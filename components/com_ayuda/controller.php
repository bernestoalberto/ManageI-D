<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class AyudaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_ayuda';


	function __construct() {

        parent::__construct();

    }


    
 public function ayuda()
    {
        $view = $this->getView('ayuda');
        $view->display();
    }




}
