    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableAuditoria extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_programa_auditoria;
	public $fecha_auditoria;
	public $fecha_reunion_apertura;
	public $lugar_reunion_apertura;
	public $dia;
	public $nombre_auditor;
	public $aspectos_evaluar;
	public $fecha_reunion_auditores;
	public $lugar_reunion_auditores;
	public $fecha_reunion_clausura;
	public $lugar_reunion_clausura;
	public $nombre_enterado;
	public $fecha_enterado;
	public $comunica;
	public $fecha_comunica;
	public $id_programa;
	public $id_proyecto;
	public $id_entidad;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__auditoria','id_programa_auditoria', $db);
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
