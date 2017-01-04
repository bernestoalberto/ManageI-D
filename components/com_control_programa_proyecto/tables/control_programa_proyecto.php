    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableControl_programa_proyecto extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_control;
	public $entidad_finacista;
	public $otros_aspectos;
	public $acuerdos_adoptados;
	public $nombre_apellidos_evaluador;
	public $nombre_apellidos_evaluado;
	public $participante;
	public $fecha_control;
	public $id_estado_ejecucion_proyecto;
	public $id_problema_detectado;
	public $id_entidad;
	public $id_proyecto;
	public $fecha_firma_evaluador;
	public $fecha_firma_evaluado;


	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__control_programa_proyecto','id_control', $db);
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
