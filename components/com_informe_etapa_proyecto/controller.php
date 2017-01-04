<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


    class informe_etapa_proyectoController extends JControllerLegacy
{


     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_informe_etapa_proyecto';
	public $informe_proyecto;


	function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->informe_proyecto=JModelLegacy::getInstance('informe_etapa_proyecto');
    }


    
 public function informe_etapa_proyecto()
    {
        $base = JFactory::getUri()->base();
        $url = $base.'components/'.$this->name_component.'/assets/js/kendo_informe_etapa_proyecto.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('informe_etapa_proyecto');
        $view->display();
    }

        public function informe_etapa_proyecto_json_list()
        {
            header('Content-Type: application/json');
            // Send the response.
            JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');

            $list=$this->informe_proyecto->loadAll('*');
            if($list!=false){
                for($i=0;$i< count($list);$i++){

                    $list[$i]->jefeprograma = $list[$i]->nombre. $list[$i]->apellido;
                }

            }

            echo json_encode($list);

            JFactory::getApplication()->close();
        }


}
