    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableProyecto extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_proyecto;
	public $numero;
	public $id_persona;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
       $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__proyecto','id_proyecto', $db);
        $this->_autoincrement=false;
    }

  function  CreateBackup(){
     $statement= require(JPATH_BACKUP_DB);




      $db = $this->getDbo();
      $query=$db->getQuery(true);
      $query->dump($statement);
      $db->setQuery($query);
      $rs=$db->loadResult();
      if($db->getErrorNum())
      {            $this->setError($db->getErrorMsg());
          return false;
      }

      if(empty($rs))
      {
          return false;
      }
      return $rs;
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


        function loadProyectobyFilter($pk)
        {
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select($pk);
            $query->from('#__listar_proyecto_i_d');
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
        function loadProyecto($pk){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
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

    
 	function loadAllwithParent($key=null,$where=null)
    {
        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select($key);
        if(!is_null($where) && !empty($where))
            $query->where($where);
        $query->from($this->getTableName());
        $query->rightJoin('#__perfil_proyecto on (#__proyecto.id_proyecto = #__perfil_proyecto.id_proyecto)');
        $query->rightJoin('#__perfil_proyecto on (#__proyecto.id_persona = #__perfil_proyecto.id_persona)');
        $query->order('#__perfil_proyecto.id_persona');
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
