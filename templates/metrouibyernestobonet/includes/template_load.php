<?php
/**
 * Created by PhpStorm.
 * User: Ernesto
 * Date: 8/28/14
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

$doc->addScript($templateadress . '/js/jquery/jquery.min.js');
$doc->addScript($templateadress . '/jquery/jQueryUI/jquery-ui-1.10.3.min.js');
$doc->addScript($templateadress . '/bootstrap/js/bootstrap.min.js');
$doc->addScript($templateadress . '/bootstrap/plugins/iCheck/icheck.min.js');
$doc->addScript($templateadress . '/bootstrap/plugins/slimScroll/jquery.slimscroll.min.js');
$doc->addScript($templateadress . '/bootstrap/plugins/admin/js/app.min.js');
$doc->addScript($templateadress . '/admin/js/demo.js');
$doc->addScript($templateadress . '/bootstrap/plugins/sparkline/jquery.sparkline.min.js');
$doc->addScript($templateadress . '/bootstrap/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js');
$doc->addScript($templateadress . '/bootstrap/plugins/jvectormap/jquery-jvectormap-world-mill-en.js');
$doc->addScript($templateadress . '/bootstrap/plugins/knob/jquery.knob.js');
$doc->addScript($templateadress . '/bootstrap/plugins/daterangepicker/daterangepicker.js');
$doc->addScript($templateadress . '/bootstrap/plugins/datepicker/bootstrap-datepicker.js');
$doc->addScript($templateadress . '/bootstrap/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js');
$doc->addScript($templateadress . '/admin/js/pages/dashboard.js');
$doc->addScript($templateadress . '/notifications/js/scriptgates.js');


$doc->addStyleSheet($templateadress. '/bootstrap/css/bootstrap.min.css');
$doc->addStyleSheet($templateadress. '/font_awesome/css/font-awesome.css');
$doc->addStyleSheet($templateadress. '/ionicons/css/ionicons.min.css');
$doc->addStyleSheet($templateadress. '/admin/css/admin.min.css');
$doc->addStyleSheet($templateadress. '/admin/css/skins/_all-skins.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/iCheck/flat/blue.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/iCheck/all.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/morris/morris.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/jvectormap/jquery-jvectormap-1.2.2.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/datepicker/datepicker3.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/daterangepicker/daterangepicker-bs3.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/daterangepicker/daterangepicker-bs3.css');
$doc->addStyleSheet($templateadress. '/bootstrap/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css');

?>

