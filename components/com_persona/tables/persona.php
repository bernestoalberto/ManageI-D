    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTablePersona extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

        public $id_persona;
        public $dni;
        public $nombre;
        public $direccion;
        public $correo;
        public $telefono;
        public $movil;
        public $username;
        public $password;
        public $foto;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__persona','id_persona', $db);
        $this->_autoincrement=false;
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

        function loadNombreJefePersona($pk){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('nombre');
            $query->from($this->getTableName());
            $query->where('id_persona='.$pk);
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


        function loadPersona($pk){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from($this->getTableName());
            $query->where('id_persona='.$pk);
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
