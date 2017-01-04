    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTableCertificacion_activdades_resultados extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_certificacion;
	public $periodo_evaluacion_cert;
	public $actividades_resultados;
	public $a_r_dos;
	public $a_r_tres;
	public $cumplimiento;
	public $cumplimiento_dos;
	public $cumplimiento_tres;
	public $gastos_incurridos;
	public $observaciones;
	public $nombre_apellidos_presidente;
	public $fecha_certifica_presidente;
	public $nombre_apellidos_director;
	public $fecha_certifica_director;
	public $id_programa;
	public $id_evaluacion;
	public $id_anticipo;
	public $id_proyecto;
    public $anno;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__certificacion_activdades_resultados','id_certificacion', $db);
    }
        function loadCertifybyProyecto($pk,$anno,$etapa){
            $condition3 = array(

                'periodo_evaluacion'=>$etapa

            );
          $list=  $this->loadCertify($pk,$anno);

            $found = false;
            $i=0;
            $cant =count($list);
            while($i< $cant ){
                if($list[$i]->periodo_evaluacion_cert==$etapa && $found != true){
                    $certf = $list[$i];
                    $found= true;

                }

                    $i++;
            }

            return $certf;
        }

  function  loadCertify($pk,$anno){
      $condition1 = array(
          'id_proyecto'=>$pk


      );
      $condition2 = array(
          'anno'=>$anno
      );

      $db=$this->getDbo();
      $query=$db->getQuery(true);
      $query->select('*');
      $query->from($this->getTableName());
      $query->where($condition1)->where($condition2);
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
        function loadCertificado($key)
    {
        $where = array(
            'id_certificacion'=>$key
        );

        $db=$this->getDbo();
        $query=$db->getQuery(true);
        $query->select('*');
        $query->from($this->getTableName());
        $query->where($where);
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
