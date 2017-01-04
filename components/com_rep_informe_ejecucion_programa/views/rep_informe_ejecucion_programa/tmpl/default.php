
<?php

$componentbase = $this->_basePath;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Reportes sobre Informe de Ejecución del Programa </title>

    <script type="text/x-kendo-template" id="template_rep_informe_ejecucion_programa">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Objetivo General:</label>#= objetivoGeneral #</li>
                        <li><label>Nivel Ejecución Presupuesto:</label>#= nivel_ejecucion_presupuesto #</li>
                        <li><label>Principales Dificultades:</label>#= principales_dificultades #</li>
                        <li><label>Conclusiones Recomendaciones:</label>#= recomendaciones #</li>
                        <li><label>Fecha Informe:</label>#= fecha_informe #</li>
                        <li><label>Cumplimiento Objetivos Propuestos:</label>#= cumplimiento_objtvs_propuestos #</li>
                        <li><label>Cumplimiento Objetivos Propuestos:</label>#= evaluacion_objetivos #</li>
                        <li><label>Cumplimiento Resultados Programados:</label>#= cumplimiento_resultados_programados #</li>
                        <li><label>Evaluación Resultados:</label>#= evaluacion_resultados #</li>
                        <li><label>Conclusiones del Grupo Expertos:</label>#= conclusiones_grupo_exp #</li>
                        <li><label>Evaluación Actividades:</label>#= evaluacion_actividades #</li>
                        <li><label>Observaciones:</label>#= observaciones #</li>
                        <li><label>Fecha Dictámen:</label>#= fecha_dictamen #</li>
                        <li><label>Recomendaciones:</label>#= recomendaciones #</li>
                        <li><label>Secretario del Programa:</label>#= secretario_programa #</li>

                    </ul>
                </div>

            </div>
        </div>

    </script>
</head>
<body >

<div >



    <section class="content-header">
        <h1>
            Reportes sobre Informe de Ejecución del Programa
        </h1>
        <ol class="breadcrumb">
            <div class="btn-group">
                <button type="button" class="btn btn-success">Acciones<i class="fa fa-gears"></i></button>
                <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                    <span class="sr-only">Desplegar</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href= "#" title="PDF" id ="export_pdf_ejecucion_programa" onclick=""><i class='icon ion-android-document'></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                </ul>
            </div>
        </ol>
    </section>
    </br>
    <div class="content box box-primary" id ="pdf_ejecucion_programa">
        <div id="gridselection_informe_ejecucion_programa"  style="width:100%"></div>
    </div>

</div>




</body>