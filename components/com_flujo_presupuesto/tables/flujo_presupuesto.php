    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableflujo_presupuesto extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__control_presupuestal','', $db);
    }


    
 	function loadAll($key=null,$where=null)
    {
        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select($key);
        if(!is_null($where) && !empty($where))
            $query->where($where);
        $query->from($this->getTableName());
        $db->escape($query);
        $db->setQuery($query);
        $row=$db->loadObjectList();
        if($db->getErrorNum())
        {            $this->setError($db->getErrorMsg());
            return false;
        }

        if(empty($row))
        {
            return false;
        }
        return $row;
    }
        function gastoProyecto($id_proyecto,$anno)
    {
        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select('autorizo_registrar_gasto');
        $query->from('notificacion_ingreso_gastos');
        $query->where( 'id_proyecto='.$id_proyecto);
        $query->where('anno='.$anno);
        $db->escape($query);
        $db->setQuery($query);
        $row=$db->loadObjectList();
        if($db->getErrorNum())
        {            $this->setError($db->getErrorMsg());
            return false;
        }

        if(empty($row))
        {
            return false;
        }
        return $row;
    }
        function ingresoProyecto($id_proyecto,$anno)
    {
        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select('autorizo_registrar_ingreso');
        $query->from('notificacion_ingreso_gastos');
        $query->where('id_proyecto='.$id_proyecto);
        $query->where('anno='.$anno);
        $db->escape($query);
        $db->setQuery($query);
        $row=$db->loadObjectList();
        if($db->getErrorNum())
        {            $this->setError($db->getErrorMsg());
            return false;
        }

        if(empty($row))
        {
            return false;
        }
        return $row;
    }


}
