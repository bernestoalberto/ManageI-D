<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class rep_convocatoriaController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_rep_convocatoria';
	public $repmodel;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->repmodel=JModelLegacy::getInstance('rep_convocatoria');
    }


    
 public function rep_convocatoria()
    {

        $view = $this->getView('rep_convocatoria');
        $view->display();
    }




}
