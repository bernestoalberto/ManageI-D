
<?php
	
$componentbase = $this->_basePath;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>        Reporte sobre las Deficiencias encontradas en los Proyectos Auditados </title>
    <script type="text/x-kendo-template" id="template_rep_deficiencias_proyectos">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Código Proyecto:</label>#= numero#</li>
                        <li><label>Documento:</label>#= documento #</li>
                        <li><label>Deficiencias/Evidencias:</label>#= deficiencias_evidencias #</li>
                </div>

            </div>
        </div>

    </script>

</head>
<body >

<div >



    <section class="content-header">
        <h1>
            Reporte sobre las Deficiencias encontradas en los Proyectos Auditados
        </h1>
        <ol class="breadcrumb">
            <div class="btn-group">
                <button type="button" class="btn btn-success">Acciones<i class="fa fa-gears"></i></button>
                <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                    <span class="caret"></span>
                    <span class="sr-only">Desplegar</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href= "#" title="PDF" id ="export_pdf_rep_deficiencias_proyectos" onclick=""><i class='icon ion-android-document'></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                </ul>
            </div>
        </ol>
    </section>
    </br>
    <div class="content box box-primary" id ="pdf_rep_deficiencias_proyectos">
        <div id="gridselection_rep_deficiencias_proyectos"  style="width:100%"></div>
    </div>

</div>




</body>