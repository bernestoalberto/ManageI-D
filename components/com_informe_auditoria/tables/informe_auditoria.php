    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableInforme_auditoria extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_nforme_auditoria;
	public $fecha_confeccion;
	public $objetivos;
	public $alcance;
	public $auditor_lider;
	public $equipo_auditor;
	public $documentacion_revisada;
	public $personal_entrevistado;
	public $opinion_equipo_auditor;
	public $observaciones;
	public $elaborado_por;
	public $id_programa;
	public $id_entidad;
	public $id_proyecto;
	public $id_documentacion_evidencias;


	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__informe_auditoria','id_nforme_auditoria', $db);
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
