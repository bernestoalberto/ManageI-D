<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');


if (!JFactory::getUser()->authorise('core.admin', 'com_users'))
{
    return JError::raiseWarning(404, JText::_('acceso no autorizado'));

}
$componentbase = $this->_basePath;

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Persona Grid</title>


</head>
<body>

<div>

    <div class="content box box-primary">
        <div id="gridselection_persona"  style="width:100%"></div>
</div>

<div id="persona_window" style="display: none;" >


<section class="content-header">
    <h1>
        Persona
    </h1>
</section>


 </div>

</div>