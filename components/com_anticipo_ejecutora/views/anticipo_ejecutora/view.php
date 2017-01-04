     <?php defined( '_JEXEC') or die( 'Restricted access');
       jimport( 'joomla.application.component.view');

 
       class anticipo_ejecutoraViewanticipo_ejecutora extends JViewLegacy

         {
		   protected $listado;
	        function display($tpl = null)
	          {
			    JModelLegacy::addIncludePath(JPATH_COMPONENT.'/models');
				  $repmodel = JModelLegacy::getInstance('anticipo_ejecutora');
				  $this->listado = $repmodel->loadAll('*');
				parent::display($tpl);
	    	  }
    	}
     ?>
