<?php
/**
 * @package&nbsp;&nbsp;&nbsp;&nbsp; Joomla.Site
 * @subpackage&nbsp; Template.Your_New_template_name
 *
 * @copyright&nbsp;&nbsp; Copyright (C) 2005 - 2015 Joomquery.com.
 * @license&nbsp;&nbsp;&nbsp;&nbsp; GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

include('includes/template_load_css.php');
//include('includes/template_load_js.php');
include('includes/template_functions.php');
$menu =JFactory::getApplication()->getMenu()->getItems('menutype', 'top');
$year = JFactory::getDate()->year;
$style='';

$menu=getMenu($menu,$style);
$baseurl =$this->baseurl;

$user = JFactory::getUser();
/*JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_persona/models');
$personamodel= JModelLegacy::getInstance('persona');
$id = $user->id;
$persona =$personamodel->loadPersona($id);
$image = $persona->foto;*/
$templateaddress = $baseurl.'/templates/'.$this->template;
$logo = $baseurl.'/templates/'.$this->template.'/images/logos/3.png';
if($user->id==0){
    include('/includes/template_login.php');
//JFactory::getApplication()->redirect('/gestionando/?option=com_users&task=login');

}
else
{
    JModelLegacy::addIncludePath(JPATH_ROOT.'/components/com_persona/models');
    $personamodel= JModelLegacy::getInstance('persona');
    $id = $user->id;
    $persona =$personamodel->loadPersona($id);

    $image = $baseurl.'/images/users/'.$persona->foto;

    ?>
<!DOCTYPE html>
<html xmlns:jdoc="http://www.w3.org/2001/XSL/Transform">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title> I+D+i</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <jdoc:include type="head"/>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

<header class="main-header">
<!-- Logo -->
<a href="index.php?option=com_content&view=article&id=71" class="logo" name ="logo" id ="logo">
    <!-- mini logo for sidebar mini 50x50 pixels -->
    <span class="logo-mini"><img src="<?php echo $logo; ?>"/></span>
    <!-- logo for regular state and mobile devices -->
    <span class="logo-lg"><img src="<?php echo $logo; ?>"/></span>

</a>
<!-- Header Navbar: style can be found in header.less -->
<nav class="navbar navbar-static-top" role="navigation">
<!-- Sidebar toggle button-->
<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
    <span class="sr-only"> <?php  echo JText::_('Boton de navegacion');?></span>
</a>
<div class="navbar-custom-menu">
    <ul class="nav navbar-nav">
        <!-- Messages: style can be found in dropdown.less-->


        <!-- Notifications: style can be found in dropdown.less -->
        <li class="dropdown notifications-menu">

            <ul class="dropdown-menu">

                <li class="footer"><a href="#"> <?php  echo JText::_('Ver todo');?></a></li>
            </ul>
        </li>
        <!-- Tasks: style can be found in dropdown.less -->

        <!-- User Account: style can be found in dropdown.less -->
        <li class="dropdown user user-menu">




            <a href="#" class="dropdown-toggle" data-toggle="dropdown">

                <img src="<?php echo $image; ?> " class="user-image" alt="User Image"/>
                <span class="icon ion-wrench"></span><?php echo $user->username; ?></span>
            </a>
            <ul class="dropdown-menu <?php echo $style ?> place-right" >
                <!-- User image -->
                <li class="user-header">
                    <img src="<?php echo $image; ?>"  class="img-circle" alt="User Image" />
                    <p>
                        <span class="icon ion-paperclip"></span> <?php echo $user->username; ?></span>

                    </p>
                </li>


        </li>
        <!-- Menu Footer-->
        <li class="user-footer">
            <div class="pull-left">
                <form id="users-profile-core" method="post" action="<?php echo JRoute::_('index.php?option=com_users&view=profile'); ?>">

                    <a  onclick="$('#users-profile-core').submit()" class="btn btn-default btn-flat"  >
                        <i class="ion-person" style="margin-right: 5px"> <?php  echo JText::_('Perfil');?></i>
                    </a>

                    <?php echo JHtml::_('form.token'); ?>
                </form>


            </div>
            <div class="pull-right">

                        <form id="formlogout" method="post" action="<?php echo JRoute::_('index.php?option=com_users&task=user.logout'); ?>">

                            <a  onclick="$('#formlogout').submit()" class="btn btn-default btn-flat"  >
                                <i class="fa fa-power-off" style="margin-right: 5px"><?php  echo JText::_('Desconectarse');?> </i>
                            </a>

                            <?php echo JHtml::_('form.token'); ?>
                        </form>
            </div>
        </li>


    </ul>

</div>
</nav>
</header>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <?php if(JFactory::getUser()->id!=0)
            {?>
            <div class="pull-left image">
                <img src="<?php echo $image; ?>" class="user-image" alt="User Image"/>

            </div>
            <div class="pull-left info">

                <span class="icon ion-battery-charging"><a href="<?php echo JRoute::_('index.php?option=com_users&view=profile');?>">
                        <?php echo JFactory::getUser()->username; ?></a></span>
                <a href="#"><i class="fa fa-circle text-success"></i> <?php  echo JText::_('Conectado');?> </a>
            </div>
        </div>
        <?php
        }
        ?>
        <!-- search form
        <form action="<?php echo JRoute::_('index.php?option=com_finder&view=search');?>" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Buscar..."/>
              <span class="input-group-btn">
                <button type='submit' name='search' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
              </span>

            </div>
           <?php//  echo JHtml::_('form.token');?>
        </form>-->
        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <?php echo $menu;?>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>  <!-- Content Wrapper. Contains page content -->



<div class="content-wrapper">

    <main id="content" role="main" >
        <!-- Begin Content -->
        <jdoc:include type="message" />
        <jdoc:include type="component" />
        <!-- End Content -->
    </main>
</div>
<footer class="main-footer">
    <strong> <a href="http://www.mic.gov.cu"><?php  echo JText::_('MIC'.$year);?></a></strong>




    </a>
</footer>
    <div class="pull-right">
        <form id="formgotop"  method="post" action="<?= JRoute::_('#') ?>" >
            <a class="go-top"  onclick="$('#formgotop').submit()" style="display: inline;">Ir arriba
                <i class="fa fa-arrow-circle-up"></i>
    </div>
    <?php echo JHtml::_('form.token'); ?>
        </form>

</div>


<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/jquery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4  no esta-->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/plugins/JQueryUI/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>

<!-- Morris.js charts
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>-->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/morris/morris.min.js"></script>


<!-- daterangepicker-->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/plugins/moment/moment.min.js"></script>


<!-- Slimscroll -->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick-->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/plugins/fastclick/fastclick.min.js"></script>




<!--Jquery General-->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.2 -->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/jquery/jQueryUI/jquery-ui-1.10.3.min.js" type="text/javascript"></script>



<!-----<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/kendo/js/kendo.drawing.min.js"></script>

<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/js/pako_deflate.min.js"></script>

<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/kendo/js/kendo.pdf.min.js"></script>----->

<!-- Bootstrap 3.3.2 JS -->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/js/bootstrap.min.js " type="text/javascript"></script>


<!-- jQuery Knob Chart -->

<!-- iCheck -->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/iCheck/icheck.min.js " type="text/javascript"></script>
<!-- Slimscroll -->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/slimScroll/jquery.slimscroll.min.js " type="text/javascript"></script>
<!-- FastClick -->

<!-- AdminLTE App -->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/admin/js/app.min.js " type="text/javascript"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->



<!--Notifications-->
<script type="text/javascript" src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/notifications/js/scriptgates.js" ></script>
<link href="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/notifications/css/MetroNotificationStyle.css" rel="stylesheet">

<!--Otros -->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript" ></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript" ></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript" ></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/knob/jquery.knob.js" type="text/javascript" ></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/daterangepicker/daterangepicker.js" type="text/javascript" ></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript" ></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript" ></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/admin/js/pages/dashboard.js" type="text/javascript" ></script>

<!--Kendo-->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/kendo/js/kendo.all.min.js"></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/kendo/js/underscore.js"></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/kendo/content/shared/js/console.js"></script>
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/kendo/content/shared/js/orders.js"></script>

<!-- AdminLTE for demo purposes-->
<script src="http://localhost/Gestionando/templates/metrouibyernestobonet/assets/admin/js/demo.js " type="text/javascript"></script>
<!-- JS de los componentes-->
<?php
// Añadiendo el js en el Layout del componente
$listjs = $this->_script;
if($listjs !=null) {
    if (isset($listjs)) {

        if (count($listjs[0]) == 1)
            foreach ($listjs as $js) {

                echo '<script src="' . $js . '" ></script>';
            }
        else {

            foreach ($listjs[0] as $js)
                echo '<script src="' . $js . '" ></script>';

        }

    }
}
?>
</body>

</html>
<?php

}
?>
