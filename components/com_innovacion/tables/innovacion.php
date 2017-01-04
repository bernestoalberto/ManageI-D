    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableInnovacion extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $problema_resolver;
	public $fundamentacion_tecnologica;
	public $fundamentacion_mercado;
	public $aspectos_tecncios;
	public $aspectos_eco_mercado;
	public $capacidad_asimilacion_desarrollo;
	public $energia;
	public $mat_primas_recursos_naturales;
	public $calidad;
	public $medio_ambiente;
	public $propiedad_intelectual;
	public $tecnlogias_constructivas;
	public $analisis_sostenibilidad_innovacion;
	public $otros_anexos;
	public $id_proyecto;
	public $id_persona;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__innovacion','id_proyecto', $db);
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


        function loadInnovacion($pk){
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


    
 	function loadAllwithParent($key=null,$where=null)
    {
        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select($key);
        if(!is_null($where) && !empty($where))
            $query->where($where);
        $query->from($this->getTableName());
        $query->rightJoin('#__proyecto on (#__innovacion.id_proyecto = #__proyecto.id_proyecto)');
        $query->rightJoin('#__proyecto on (#__innovacion.id_persona = #__proyecto.id_persona)');
        $query->order('#__proyecto.id_persona');
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
