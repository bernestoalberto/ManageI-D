<?php
/**
 * Created by PhpStorm.
 * User: Ernesto
 * Date: 8/28/15
 * Time: 4:43 p.m.
 */
defined('_JEXEC') or die;
$doc = JFactory::getDocument();
$doc->_scripts=null;
$site_name=JFactory::getApplication()->getCfg('sitename');
$baseurl=$this->baseurl;
/* Required Files */
JLoader::import('includes/defines.php');
JLoader::import('includes/framework.php');
require_once('components/com_content/models/articles.php');
$art= new ContentModelArticles();
$articles=$art->getItems();
$templateadress=$this->baseurl.'/templates/'.$this->template;
$themepath_image=$templateadress.'/images';


//    <!-- Load JavaScript Libraries -->
	
$doc->addScript($templateadress . '/assets/js/metro.min.js');
//<!--Jquery General-->
$doc->addScript($templateadress . '/assets/js/jquery/jquery.min.js');
$doc->addScript($templateadress . '/assets/js/jquery/jquery.widget.min.js');
// <!-- jQuery UI 1.11.2 -->
$doc->addScript($templateadress . '/assets/js/jquery/jQueryUI/jquery-ui-1.10.3.min.js');
//    <!-- Metro UI CSS JavaScript plugins -->
$doc->addScript($templateadress . '/assets/js/jquery/jquery.mousewheel.js');
$doc->addScript($templateadress . '/assets/js/prettify/prettify.js');
$doc->addScript($templateadress . '/assets/js/load-metro.js');

//    My js
$doc->addScript($templateadress . '/assets/js/login.js');
$doc->addScript($templateadress . '/assets/js/template.js');

//<!--Kendo-->
//<!--<script src="--><!--"></script>-->
$doc->addScript($templateadress . '/assets/kendo/js/kendo.all.min.js');
$doc->addScript($templateadress . '/assets/kendo/js/underscore.js');
$doc->addScript($templateadress . '/assets/kendo/content/shared/js/console.js');
$doc->addScript($templateadress . '/assets/kendo/content/shared/js/orders.js');


//<!-- Bootstrap 3.3.2 JS -->
$doc->addScript($templateadress . '/assets/bootstrap/js/bootstrap.min.js');
/*<!-- Sparkline -->
<!--<script src="--><!-- " type="text/javascript"></script>-->
<!-- jvectormap -->
<!--<script src="--><!-- " type="text/javascript"></script>-->
<!--<script src="--><!-- " type="text/javascript"></script>-->
<!-- jQuery Knob Chart -->
<!--<script src="--><!-- " type="text/javascript"></script>-->
<!-- daterangepicker -->
<!--<script src="--><!-- " type="text/javascript"></script>-->
<!-- datepicker -->
<!--<script src="--><!-- " type="text/javascript"></script>-->
<!-- Bootstrap WYSIHTML5 -->
<!--<script src="--><!-- " type="text/javascript"></script>-->*/
//<!-- iCheck -->
$doc->addScript($templateadress . '/assets/bootstrap/plugins/iCheck/icheck.min.js ');
//<!-- Slimscroll -->
$doc->addScript($templateadress . '/assets/bootstrap/plugins/slimScroll/jquery.slimscroll.min.js ');
//<!-- FastClick -->
//<!--<script src="--><!-- "></script>-->
//<!-- AdminLTE App -->
$doc->addScript($templateadress . '/assets/admin/js/app.min.js ');
//<!--<!-- AdminLTE for demo purposes -->
//<!--<script src="--><!-- " type="text/javascript"></script>-->
//<!--<!-- AdminLTE for demo purposes -->
$doc->addScript($templateadress . '/assets/admin/js/demo.js ');
//<!--Notifications-->
$doc->addScript($templateadress . '/assets/notifications/js/scriptgates.js');
$doc->addStyleSheet($templateadress . '/assets/notifications/css/MetroNotificationStyle.css'); 
//<!--<link href="--><!--" rel="stylesheet">-->
//<!--Javascripts mios    -->
$doc->addScript($templateadress . '/assets/bootstrap/plugins/sparkline/jquery.sparkline.min.js');
$doc->addScript($templateadress . '/assets/bootstrap/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js');
$doc->addScript($templateadress . '/assets/bootstrap/plugins/jvectormap/jquery-jvectormap-world-mill-en.js');
$doc->addScript($templateadress . '/assets/bootstrap/plugins/knob/jquery.knob.js');
$doc->addScript($templateadress . '/assets/bootstrap/plugins/daterangepicker/daterangepicker.js');
$doc->addScript($templateadress . '/assets/bootstrap/plugins/datepicker/bootstrap-datepicker.js');
$doc->addScript($templateadress . '/assets/bootstrap/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js');
$doc->addScript($templateadress . '/assets/admin/js/pages/dashboard.js');

?>

