    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableTraza extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_traza;
	public $usuario;
	public $accion;
	public $componente;
	public $fecha;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__traza','id_traza', $db);

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
