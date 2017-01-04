
<?php
if (!JFactory::getUser()->authorise('core.admin', 'com_users')) {
    return JError::raiseWarning(404, JText::_('acceso no autorizado'));
}
$componentbase = $this->baseurl.'/components/'.$this->component;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Certificación de Actividades y Resultados </title>

    <script type="text/x-kendo-template" id="template_certificn_actvs_resultds">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Número:</label>#= numero #</li>
                        <li><label>Programa:</label>#= programa #</li>
                        <li><label>Jefe Proyecto:</label>#= jefe_proyecto #</li>
                        <li><label>Actividades Resultados:</label>#= a_r_dos #</li>
                        <li><label>Cumplimiento:</label>#= cumplimiento_dos #</li>
                        <li><label>Actividades Resultados:</label>#= a_r_tres #</li>
                        <li><label>Cumplimiento:</label>#= cumplimiento_tres #</li>
                        <li><label>Gastos Incurridos (CUP):</label>#= gastos_incurridos #</li>
                        <li><label>Observaciones:</label>#= observaciones #</li>
                        <li><label>Presidente:</label>#= presidente #</li>
                        <li><label>Fecha Certifica Presidente:</label>#= fecha_certifica_presidente #</li>
                        <li><label>Director:</label>#= director #</li>
                        <li><label>Fecha Certifica Director:</label>#= fecha_certifica_director #</li>
                        <li><label>Anticipo (CUP):</label>#= anticipo #</li>
                        <li><label>Evaluación:</label>#= evaluacion #</li>
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
           Reportes sobre Certificación de Actividades y Resultados de los Proyectos de I+D+i
        </h1>
        <ol class="breadcrumb">
            <div class="btn-group">
                <button type="button" class="btn btn-success">Acciones<i class="fa fa-gears"></i></button>
                <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                    <span class="sr-only">Desplegar</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href= "#" title="PDF" id ="export_pdf_certificación" onclick=""><i class='icon ion-android-document'></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                </ul>
            </div>
        </ol>
    </section>
    </br>
    <div class="content box box-primary" id ="pdf_certificación">
        <div id="gridselection_certificación"  style="width:100%"></div>
    </div>

</div>




</body>