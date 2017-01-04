    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableInforme_ejecucion_programa extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_informe_ejecucion_programa;
	public $nivel_ejecucion_presupuesto;
	public $etapa;
	public $principales_dificultades;
	public $conclusiones_recomendaciones;
	public $fecha_informe;
	public $cumplimiento_objtvs_propuestos;
	public $cumplimiento_resultados_programados;
	public $id_programa;
	public $id_dictamen_grup_exp;


	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__informe_ejecucion_programa','id_informe_ejecucion_programa', $db);
    }
 /*       function  loadCombo($programa)
        {
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('id_programa');
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

        }*/


    
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
