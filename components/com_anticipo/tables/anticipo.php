    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableAnticipo extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

        public $id_anticipo;
        public $cantidad_anticipa;
        public $id_proyecto;
        public $id_programa;
        public $anno;
        public $fecha_firma;
        public $etapa;
        public $nombre_recibe;
        public $cargo_recibe;
        public $fecha_recibe;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
         $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__anticipo','id_anticipo', $db);
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

        function loadAnticipobyProyecto($key,$anno)
        {
            $condition = array(
                'id_proyecto'=>$key
            );
            $condition1 = array(
                'anno'=>$anno

            );
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from($this->getTableName());
            $query->where($condition)->where($condition1);
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
        function loadAnticipo($key)
        {
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from($this->getTableName());
            $query->where('id_anticipo='.$key);
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
