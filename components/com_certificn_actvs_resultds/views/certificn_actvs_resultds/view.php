     <?php defined( '_JEXEC') or die( 'Restricted access');
       jimport( 'joomla.application.component.view');
 
       class certificn_actvs_resultdsViewcertificn_actvs_resultds extends JViewLegacy
         {
		   protected $listado;
	        function display($tpl = null)
	          {
				  JModelLegacy::addIncludePath(JPATH_COMPONENT.'/models');
				  $repmodel = JModelLegacy::getInstance('certificn_actvs_resultds');
				  $this->listado = $repmodel->loadAll('*');
				parent::display($tpl);
	    	  }
    	}
     ?>
