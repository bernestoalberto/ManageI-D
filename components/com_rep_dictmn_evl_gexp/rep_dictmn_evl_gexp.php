<?php 
defined('_JEXEC') or die; 

    function getfunction()
   {
        $result=strrpos($_SERVER['REQUEST_URI'],'/');
        if(substr_count($_SERVER['REQUEST_URI'],'?')>0) {
            $result = substr($_SERVER['REQUEST_URI'], $result + 1);
            $pos=stripos($result,'?');
            $result = substr($result, 0,$pos);
        }
        else {
            $result = substr($_SERVER['REQUEST_URI'], $result + 1);
        }
        return $result;
    }
    

    	  $controller	= JControllerLegacy::getInstance('rep_dictmn_evl_gexp');
         $task=JFactory::getApplication()->input->get('task');
		  if($task==null)
			{
			    $accion=getfunction();
               if($accion=='rep-dictmn-evl-gexp')
                $accion="rep_dictmn_evl_gexp";
			    if($accion)
			        $controller->execute($accion);	
			    else	
			        $controller->execute('index');
			}
			else
			{	
			    $controller->execute($task);	
			}
         $controller->redirect();
 	 	?>
