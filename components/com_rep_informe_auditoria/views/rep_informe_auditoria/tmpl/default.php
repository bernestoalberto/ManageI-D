<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');

$componentbase = $this->_basePath;

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Repote Informe Auditoria </title>
    <script type="text/x-kendo-template" id="template_rep_informe_auditoria">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Personal Entrevistado:</label>#= personal_entrevistado #</li>
                        <li><label> Opinión Equipo Auditor:</label>#= opinion_equipo_auditor #</li>
                        <li><label>Elaborado Por:</label>#= elaborado_por #</li>
                        <li><label>Objetivos :</label>#= objetivos #</li>
                        <li><label>Alcance:</label>#= alcance #</li>
                        <li><label>Observaciones:</label>#= observaciones #</li>
                        <li><label>No Conformidades Detectadas:</label>#= no_conformidades_detectadas #</li>
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
                        Repote Informe Auditoria
                    </h1>
                    <div class="btn-group">
                        <ol class="breadcrumb">
                            <button type="button" class="btn btn-success">Acciones <i class="fa fa-gears"></i></button>
                            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Desplegar</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#" title="PDF" id="export_pdf_rep_informe_auditoria" onclick=""><i class="icon ion-android-document"></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                            </ul>

                        </ol>
                    </div>
                </section>
                </br>
                <div class="content box box-primary" id ="pdf_rep_informe_auditoria">
                    <div id="gridselection_rep_informe_auditoria"  style="width:100%"></div>
                </div>


            </div>



</body>


