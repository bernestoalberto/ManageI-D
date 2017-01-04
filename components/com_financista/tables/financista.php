    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableFinancista extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_entidad;
	public $plan_CIT;
	public $cifra_planificada;
	public $id_programa;
	public $id_proyecto;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__financista','id_entidad', $db);
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
  function  loadFinancista($pk){
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
        function  loadEntidadFinancista($pk){
      $db=$this->getDbo();
      $query=$db->getQuery(true);
      $query->select('id_entidad');
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
        function  loadidPersonaFinancista($pk){
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
