    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class Financista extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_financista';
	public $financistatable;

	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JTable::addIncludePath( $path['site'].'/tables');
        JModelLegacy::addIncludePath( $path['site'].'/models');
        $this->financistatable=JTable::getInstance('Financista');

    }
     function   loadFinancista($pk){
         return $this->financistatable->loadFinancista($pk);
     }
        function  loadidPersonaFinancista($pk){
            return $this->financistatable->loadidPersonaFinancista($pk);
        }

 function is_null()    
{
        return $this->financistatable->id_entidad==null;
    }
        function  loadEntidadFinancista($pk){
            return $this->financistatable->loadEntidadFinancista($pk);
        }

    function  store()
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->financistatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->financistatable->store();
    }


    function  bind($financista)
    {
        return $this->financistatable->bind($financista);
    }


     function load($pk)
    {
        $this->financistatable->load($pk);
    }


    function loadAll($key,$where=null)
    {
        return $this->financistatable->loadAll($key,$where);
    }


    function loadAllOr($key,$where=null)
    {
        return $this->financistatable->loadAllOr($key,$where);
    }


    function  delete($pk=null)
    {
        JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_traza/models');
        $trazamodel = JModelLegacy::getInstance('Traza');
        $accion= $_GET['task'];
        $entidad = $_REQUEST['view'];
        $nombre = $this->financistatable->nombre;
        $trazamodel->CreateTrace($accion,$entidad,$this->name_component ,$nombre);
        return $this->financistatable->delete($pk);
    }


    function loadAllItem($key,$where=null)
    {
        $modellist=array();
        $lista=$this->financistatable->loadAll($key,$where);
        foreach($lista as $item)
        {
          	 $pk= array(
          	 	'id_entidad'=>$item->id_entidad

          	 );

            $financistaitem=JModelLegacy::getInstance('Financista');
            $financistaitem->load($pk);
            array_push($modellist,$financistaitem);
        }
        return $modellist;
    }




   function getFinancistaModelArray($condition)    {
       $financistaarraymodel= array();
       $financistalist=$this->loadAll('*',$condition);
		if(!$financistalist)
           return $financistaarraymodel;
        foreach($financistalist as $item)
        {
          	 $financistapk= array(
          	 	'id_entidad'=>$item->id_entidad

          	 );
            $item=JModelLegacy::getInstance('Financista');
          	 $item->load($financistapk);
            array_push($financistaarraymodel,$item);
        }
        return $financistaarraymodel;
    }




}
