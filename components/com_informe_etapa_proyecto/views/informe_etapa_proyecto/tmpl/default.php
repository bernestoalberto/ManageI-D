<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');
$componentbase = $this->_basePath;

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title> Reporte Informe Etapa Proyecto </title>
    <script type="text/x-kendo-template" id="template_informe_etapa_proyecto">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Período Evaluación:</label>#= periodo_evaluacion_cert #</li>
                        <li><label>Actividades Resultados:</label>#= actividades_resultados #</li>
                        <li><label>Cumplimiento:</label>#= cumplimiento #</li>

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
            Repote Informe Etapa Proyecto
        </h1>
        <div class="btn-group">
            <ol class="breadcrumb">
                <button type="button" class="btn btn-success">Acciones <i class="fa fa-gears"></i></button>
                <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                    <span class="sr-only">Desplegar</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="#" title="PDF" id="export_pdf_inf_report_proyecto"><i class="icon ion-android-document"></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                </ul>

            </ol>
        </div>
    </section>
    </br>
    <div class="content box box-primary" id ="pdf_inf_report_proyecto">
        <div id="gridselection_informe_etapa_proyecto"  style="width:100%"></div>
    </div>


</div>



</body>


