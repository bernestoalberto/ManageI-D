     <?php defined( '_JEXEC') or die( 'Restricted access');
       jimport( 'joomla.application.component.view');
 
       class rep_convocatoriaViewrep_convocatoria extends JViewLegacy
         {
		   protected $listado;

	/*	   protected $params;

		   protected $state;

		   protected $user;*/


	        function display($tpl = null)
	          {
				  JModelLegacy::addIncludePath(JPATH_COMPONENT.'/models');
				  $repmodel = JModelLegacy::getInstance('rep_convocatoria');
				  $this->listado = $repmodel->loadAll('*');

				parent::display($tpl);
	    	  }
    	}
     ?>
