<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');

$componentbase = $this->_basePath;

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Reporte Anticipo Ejecutora</title>
    <script type="text/x-kendo-template" id="template_rep_anticipo_ejecutora">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Consecutivo:</label>#= consecutivo #</li>
                        <li><label>Programa:</label>#= programa #</li>
                        <li><label>Número Cuenta Bancaria:</label>#= numero_cuenta_bancaria #</li>
                        <li><label>Sucursal Créditos:</label>#= sucursal_creditos #</li>
                        <li><label>Jefe Proyecto:</label>#= persona #</li>
                        <li><label>Fecha Recibe:</label>#= fecha_recibe #</li>
                        <li><label>Nombre Recibe:</label>#= nombre_recibe #</li>
                        <li><label>Cargo Recibe:</label>#= cargo_recibe #</li>
                    </ul>
                </div>

            </div>
        </div>

    </script>
</head>
<body>
<div  >
    <section class="content-header">
        <h1>
            Repote Anticipo  a las Entidades Ejecutora
        </h1>
        <div class="btn-group">
            <ol class="breadcrumb">
                <button type="button" class="btn btn-success">Acciones <i class="fa fa-gears"></i></button>
                <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                    <span class="sr-only">Desplegar</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="#" title="PDF" id="export_pdf_anticipo_ejecutora" onclick=""><i class="icon ion-android-document"></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                </ul>

            </ol>
        </div>
    </section>
    </br>
    <div class="content box box-primary" id ="pdf_anticipo_ejecutora">
        <div id="gridselection_rep_anticipo_ejecutora"  style="width:100%"></div>
    </div>


</div>



</body>


