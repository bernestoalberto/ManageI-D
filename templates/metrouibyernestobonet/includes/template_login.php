<?php
/**
 * @package&nbsp;&nbsp;&nbsp;&nbsp; Joomla.Site
 * @subpackage&nbsp; Template.Your_New_template_name
 *
 * @copyright&nbsp;&nbsp; Copyright (C) 2005 - 2015 Joomquery.com.
 * @license&nbsp;&nbsp;&nbsp;&nbsp; GNU General Public License version 2 or later; see LICENSE.txt
 */
/*defined('_JEXEC') or die;
JHtml::_('behavior.keepalive');*/
$app    = JFactory::getApplication();
$message='';
if(isset($app->getUserState('users.login.form.data')['error']))
    $message=$app->getUserState('users.login.form.data')['error'];
$image = '/Gestionando/templates/metrouibyernestobonet/images/logos/2.jpg';
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> I+D+i</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="/Gestionando/templates/metrouibyernestobonet/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="/Gestionando/templates/metrouibyernestobonet/assets/font_awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="/Gestionando/templates/metrouibyernestobonet/assets/dist/css/admin.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="/Gestionando/templates/metrouibyernestobonet/assets/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-page">

<div class="login-box">

    <div class="login-logo">
        <i class = "icon ion-"></i>
        <img src="<?php echo $image; ?>"/>
    </div>    <!-- /.login-logo -->
    <div class="login-box-body">
        <?php if($message!='') {?>
            <div id="system-message-container">
                <div id="system-message">
                    <div class="alert alert-warning">
                        <a class="close" data-dismiss="alert">×</a>

                        <h4 class="alert-heading">Advertencia</h4>
                        <div>
                            <p class="alert-message">El usuario y contraseña no coinciden o usted aún no tiene una cuenta.</p>
                        </div>
                    </div>
                </div>
            </div>
        <?php }?>
        <p class="login-box-msg">Por favor identif&iacutequese</p>
        <form  id="loginForm" method="post" action="<?php echo JRoute::_('index.php?option=com_users&task=user.login');?>" class="form-validate form-horizontal well"   >
            <fieldset>
                <div class="form-group has-feedback">

            <span class="glyphicon glyphicon-user form-control-feedback" >
    </span>
                    <input type="text" class="form-control" name="username" placeholder="Usuario"
                           filter="username" 	required="true" validate="username"/>

                </div>
                <div class="form-group has-feedback">
                    <input type="password"  class="form-control" name="password" placeholder="Contraseña"
                           required="true" filter="raw"/>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>


                <button type="button" onclick="$('#loginForm').submit()"  class="btn btn-block btn-primary btn-lg">

                    Identificarse
                </button>

    </div>


    <?php echo JHtml::_('form.token'); ?>

    <strong><a href="http://www.mic.gov.cu" class="text-center"><?php  echo JText::_('MIC'.JFactory::getDate()->year);?></a></strong>

    </fieldset>


    </form>



</div>


<script src="/gestionando/templates/metrouibyernestobonet/js/login.js"></script>
<!-- jQuery 2.1.3 -->
<script src="/gestionando/templates/metrouibyernestobonet/assets/plugins/jQuery/jQuery-2.1.3.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="/gestionando/templates/metrouibyernestobonet/assets/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="/gestionando/templates/metrouibyernestobonet/assets/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>

</div>

</body>
</html>