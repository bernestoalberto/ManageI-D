    
<?php 
defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class JTablePrograma extends JTable
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $id_programa;
	public $nombre;
	public $secretarioprograma;
	public $objetivoGeneral;
	public $grupoExpertos;
	public $id_entidad;
	public $id_persona;
	public $otras_entidades;

	function __construct( &$db ) {
          $option = require(JPATH_DB_FILE);
  $db=JDatabaseDriver::getInstance( $option );
        parent::__construct('#__programa','id_programa', $db);
        $this->_autoincrement =false;
    }

        function loadAllENNP($key)
        {
            //$condition = array('id_programa'<> 4);
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select($key);
            $query->from($this->getTableName());
         //  $query->where($condition);
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
        }    function loadAllJefePrograma()
        {
            $condition = array('id_programa'<> 4);
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('id_persona');
            $query->from($this->getTableName());
           $query->where($condition);
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
        function loadPrograma($key){

            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('*');
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
            $query->from('combo_programa_convocatoria');
            $db->setQuery($query);
            $row=$db->loadObjectList();
            return $row;

        }
        function loadNombrePrograma($key){
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('nombre');
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
        function loadPersons()
        {
            $option = require(JPATH_DB_FILE);
            $db=JDatabaseDriver::getInstance( $option );
            $query=$db->getQuery(true);
            $query->select('*');
            $query->from('#__persona');
            $db->escape($query);
            $db->setQuery($query );
            $row= $db->loadObjectList();
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
        function loadJefePrograma($key)
        {
            $condition = array(
                'id_programa='.$key
            );
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('id_persona');
            $query->from($this->getTableName());
            $query->where($condition);
            $db->escape($query);
            $db->setQuery($query );
            $row= $db->loadObject();
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
        function loadSecretario($key)
        {
            $condition = array(
                'id_programa='.$key
            );
            $db=$this->getDbo();
            $query=$db->getQuery(true);
            $query->select('secretarioprograma');
            $query->from($this->getTableName());
            $query->where($condition);
            $db->escape($query);
            $db->setQuery($query );
            $row= $db->loadObject();
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
        function loadOnlyPersonAvailable()
        {
            $listpersonas = $this->loadPersons();
            $cantpersonas =count($listpersonas);
            $listajefes = $this->loadJefesProgramas();
            $cantjefes = count($listajefes);
            $listcandidatos = null;

            $j =0;
            for($i=0;$i<$cantpersonas-1;$i++){
                $found = false;
                $id = $listpersonas[$i]->id_persona;
                while($j<=$cantjefes-1 && $found == false){
                    $idj = $listajefes[$j];
                    if($id==$idj->id_persona){
                        $found = true;
                    }
                    $j++;
                }
                if($found == false)
                    $listcandidatos[$i]=$listpersonas[$i];
            }

            return $listcandidatos;
        }




}
