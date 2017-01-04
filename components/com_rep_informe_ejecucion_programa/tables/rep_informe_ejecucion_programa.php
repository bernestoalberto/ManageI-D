
<?php
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTablerep_informe_ejecucion_programa extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__rep_informe_ejecucion_programa','', $db);
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
        function countProyectosbyID_programa($key)
    {
        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select('');
        $query->from('#__perfil_proyecto')->innerJoin('#__proyecto');
        $query->where('id_programa='.$key);
        $db->escape($query);
        $db->setQuery($query);
        $row=$db->getNumRows();
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
