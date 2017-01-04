    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTablePerfil_proyecto extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

        public $id_proyecto;
        public $titulo_proyecto;
        public $id_tipo_proyecto;
        public $id_clasificacion;
        public $clientes;
        public $duracion;
        public $presupuesto_total;
        public $resumen;
        public $fecha_recepcion;
        public $id_entidad;
        public $id_programa;
        public $id_persona;
        public $otra_institucion;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
          $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__perfil_proyecto','id_proyecto', $db);
    }


    
 	function loadAll($key=null,$where=null)
    {
        $db=$this->getDbo();
        JFactory::
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
        function loadProyecto($pk){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from($this->getTableName());
            $query->where('id_proyecto='.$pk);
            $db->escape($query);
            $db->setQuery($query);
            $row=$db->loadAssoc();
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
        function loadIdJefeProyecto($pk){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('id_persona');
            $query->from($this->getTableName());
            $query->where('id_proyecto='.$pk);
            $db->escape($query);
            $db->setQuery($query);
            $row=$db->loadObject();
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


        function loadNombreProyecto($pk){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('titulo_proyecto');
            $query->from($this->getTableName());
            $query->where('id_proyecto='.$pk);
            $db->escape($query);
            $db->setQuery($query);
            $row=$db->loadObject();
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
