    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableControl_ejecucion_presupuesto extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_control_ejecucion_presupuesto;
	public $anno;
	public $fecha_inicio;
	public $id_anticipo;
	public $fecha_terminacion;
	public $id_certificacion;
	public $id_notif_ingresos_gastos;
	public $id_programa;
	public $id_proyecto;
        public $etapa;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__control_ejecucion_presupuesto','id_control_ejecucion_presupuesto', $db);
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
        function loadIdProgramas(){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('id_programa');
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


    
 	function loadAllOr($key=null,$where=null)
    {
        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select($key);
        if(!is_null($where) && !empty($where))
            $query->where($where,'OR');
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




}
