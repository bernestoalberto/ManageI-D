
<?php
$componentbase = $this->_basePath;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Reportes sobre Dictmánen del Grupo de Expertos sobre Informe de Etapa </title>

    <script type="text/x-kendo-template" id="template_rep_grupo_exp">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>

                        <li><label>Número:</label>#= numero #</li>
                        <li><label>Evaluación Ojetivos:</label>#= evaluación_objetivos #</li>
                        <li><label>Evaluación Resultados:</label>#= evaluación_resultados #</li>
                        <li><label>Evaluación Actividades:</label>#= evaluación_actividades #</li>
                        <li><label>Observaciones:</label>#= observaciones #</li>
                        <li><label>Conclusiones:</label>#= conclusiones #</li>
                        <li><label>Recomendaciones:</label>#= recomendaciones #</li>
                        <li><label>Cumplimiento Cronograma Actividades:</label>#= cumplimiento_cronograma_actividades #</li>
                        <li><label>Cumplimiento Resultados Programados:</label>#= cumplimiento_resultados_programados #</li>

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
            Reportes sobre Dictmánen del Grupo de Expertos sobre Informe de Etapa
        </h1>
        <ol class="breadcrumb">
            <div class="btn-group">
                <button type="button" class="btn btn-success">Acciones<i class="fa fa-gears"></i></button>
                <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                    <span class="sr-only">Desplegar</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href= "#" title="PDF" id ="export_pdf_rep_grupo_exp" onclick=""><i class='icon ion-android-document'></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                </ul>
            </div>
        </ol>
    </section>
    </br>
    <div class="content box box-primary" id ="pdf_rep_grupo_exp">
        <div id="gridselection_rep_grupo_exp"  style="width:100%"></div>
    </div>

</div>




</body>