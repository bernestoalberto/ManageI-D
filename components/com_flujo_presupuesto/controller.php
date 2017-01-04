<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');


class flujo_presupuestoController extends JControllerLegacy
{


    /**
     * Constructor
     *
     * @param object Database connector object
     */

    public $name_component='com_flujo_presupuesto';
    public $flujopresupuesto;


    function __construct() {

        parent::__construct();
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->flujopresupuesto=JModelLegacy::getInstance('flujo_presupuesto');
    }



    public function flujo_presupuesto()
    {
        $base = JFactory::getUri()->base();
        $url=$base.'components/'.$this->name_component.'/assets/js/chart.js';
        array_push(JFactory::getDocument()->_script,$url);
        $view = $this->getView('flujo_presupuesto');
        $view->display();
    }

    public function flujo_presupuesto_json_list(){
        // Check for ajax request.
        JSession::isAjaxRequest('server') or  jexit(JText::_('JINVALID_REQUEST'));
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $flujo = $this->input->post->get('flujo_presupuesto', 'array', array());
        $listag=$this->gasto_json_list($flujo['proyecto']);
        $listai=$this->ingreso_json_list($flujo['proyecto']);

        echo json_encode(array('r'=>$listag,'f'=>$listai));

        JFactory::getApplication()->close();
    }
    public function json_list(){
        $var = new stdClass();
        $var= [56000, 63000, 74000, 91000];
        //  $var->listai=[52000, 34000, 23000, 48000];
        echo json_encode($var);

        JFactory::getApplication()->close();
    }
    public function gasto_json_list($id_proyecto){
        // Send the response.
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->flujopresupuesto=JModelLegacy::getInstance('flujo_presupuesto');
        return $this->flujopresupuesto->gastoProyecto($id_proyecto);

    }
    public function ingreso_json_list($id_proyecto){
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        $this->flujopresupuesto=JModelLegacy::getInstance('flujo_presupuesto');
        return $this->flujopresupuesto->ingresoProyecto($id_proyecto);

    }

    public function chart_json_list(){
        JModelLegacy::addIncludePath( JPATH_COMPONENT.'/models');
        header('Content-Type: application/json');

        $gastosresp=array();
        $ingresoresp=array();
         $this->flujopresupuesto=JModelLegacy::getInstance('flujo_presupuesto');
         $ingreso=$this->flujopresupuesto->ingresoProyecto($_GET['fd'],$_GET['anno']);
        for($i=0;$i<4;$i++)
        {
            $val=$ingreso[$i];
            if(isset($val))
            {
                array_push($ingresoresp,intval($val->autorizo_registrar_ingreso));
            }
            else
            {
                array_push($ingresoresp,0);
            }
        }
         $gastos=$this->flujopresupuesto->gastoProyecto($_GET['fd'],$_GET['anno']);
        for($i=0;$i<4;$i++)
        {
            $val=$gastos[$i];
            if(isset($val))
            {
                array_push($gastosresp,intval($val->autorizo_registrar_gasto));
            }
            else
            {
                array_push($gastosresp,0);
            }
        }
        $array= array([
            "gastos"=>  $gastosresp,
            "ingreso"=> $ingresoresp
        ]);
        echo json_encode($array);

        JFactory::getApplication()->close();

    }



}
