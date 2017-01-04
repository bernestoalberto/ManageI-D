     <?php defined( '_JEXEC') or die( 'Restricted access');
       jimport( 'joomla.application.component.view');
 
       class rep_informe_ejecucion_programaViewrep_informe_ejecucion_programa extends JViewLegacy
         {
		   protected $listcant;
		   protected $listado;
	        function display($tpl = null)
	          {
				  JModelLegacy::addIncludePath(JPATH_COMPONENT.'/models');
				  $repmodel = JModelLegacy::getInstance('rep_informe_ejecucion_programa');
				  $this->listado = $repmodel->loadAll('*');

				//  $this->listcant = $repmodel->countProyectosbyID_programa('*');
				parent::display($tpl);
	    	  }
    	}
     ?>
