     <?php defined( '_JEXEC') or die( 'Restricted access');
       jimport( 'joomla.application.component.view');
 
       class logsViewlogs extends JViewLegacy 
         {
		   protected $lista;
		   protected $listaNegocio;

	        function display($tpl = null)
	          {
				  $list = file(JPATH_LOGFILE, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
				  for($i=0;$i<count($list);$i++){
					  $this->lista[$i] = $list[$i];
				  }
				  $list1 = file(JPATH_LOGFILEBUSSINES, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
				  for($i=0;$i<count($list1);$i++){
					  $this->listaNegocio[$i] = $list1[$i];
				  }
			//	$this->lista;

				parent::display($tpl);
	    	  }
    	}
     ?>
