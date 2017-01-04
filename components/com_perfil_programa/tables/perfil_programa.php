    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');

    class JTablePerfil_programa extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_programa;
	public $denominacion;
	public $fundamentacion;
	public $objetivo_especifico;
	public $principalesResultados;
	public $potencialHumano;
	public $presupuesto;
	public $plazoEjecucion;
	public $otro;
	public $numero_proyectos;
	public $id_prioridad;
	public $id_indicador;
	public $archivo;

	function __construct( &$db ) {
        $option = require(JPATH_DB_FILE);
        $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__perfil_programa','id_programa', $db);
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

        function loadNombrePerfilPrograma($key){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('denominacion');
            $query->from($this->getTableName());
            $query->where('id_programa='.$key);
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
        function loadFilter(){

            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from('combo_programa');
            $db->setQuery($query);
            $row=$db->loadObjectList();
            return $row;

        }
        function loadPresupuesto($key){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('presupuesto');
            $query->from($this->getTableName());
            $query->where('id_programa='.$key);
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
