    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableJefeproyecto extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

        public $id_persona;
        public $titulo_obtenido;
        public $situacion_laboral;
        public $publicaciones;
        public $otros_aspectos;
        public $presupuesto_anual;
        public $id_categoria;
        public $id_grado;
        public $cv;


	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
        $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__jefeproyecto','id_persona', $db);
        $this->_autoincrement=false;
    }


        function loadtituloObtenidoJefeProyecto($key){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('titulo_obtenido');
            $query->from($this->getTableName());
            $query->where('id_persona='.$key);
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
        function loadJefeProject($id_persona){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from($this->getTableName());
            $query->where('id_persona='.$id_persona);
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
