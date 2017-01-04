    <?php defined('_JEXEC') or die; 
     	  $controller	= JControllerLegacy::getInstance('marco_regulatorio');
         $controller->execute(JFactory::getApplication()->input->get('task'));;
         $controller->redirect();
 	 ?>
