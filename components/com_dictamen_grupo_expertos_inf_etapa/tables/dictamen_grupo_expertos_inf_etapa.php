    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableDictamen_grupo_expertos_inf_etapa extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_dictamen_grup_exp;
	public $id_informe_etapa;
	public $evaluacion_objetivos;
	public $evaluacion_resultados;
	public $evaluacion_actividades;
	public $observaciones;
	public $conclusiones;
	public $recomendaciones;
	public $nombre_apellidos_miembroGEP;
	public $fecha_dictamen;
	public $anno;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__dictamen_grupo_expertos_inf_etapa','id_dictamen_grup_exp', $db);
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

        function loadDictamenbyInforme($pk){
            $condition = array(
                'id_informe_etapa'=>$pk);
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from($this->getTableName());
            $query->where($condition);
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
