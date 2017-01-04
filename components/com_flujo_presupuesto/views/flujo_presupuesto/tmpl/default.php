<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');

$componentbase = $this->_basePath;
?>
<!DOCTYPE html>
<html>
<head>
    <title>Flujo del Presupuesto</title>
      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    
    
</head>

<body>
            <section class="content-header">

                    <ol class="breadcrumb">
         <div class="btn-group">
                            <button type="button" class="btn btn-success">Herramientas <i class='fa fa-gears'></i></button>
                            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Desplegar</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a  title="PDF" id ="export_pdf" ><i class='icon ion-android-document'></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
                                <li><a href= "" title="Image" id ="export_img" onclick=""><i class=' ion-android-color-palette'></i> <?php  echo JText::_('Exportar a Imagen');?></a></li>
                            

                            </ul>


          </div>


                    </ol>
                </section>
            </br>
            </br>
    
    <div id="reporte_grafico">
    <div class="demo-section k-content wide">
        <form role="form" id="flujo_presupuesto_form" class="form-validate" method="post">
            <!---  <button class="btn btn-action" id="graficar" data-toggle='tooltip' title='' >
                 <i class="icon ion-connection-bars"></i> Graficar</button>
             &nbsp;---->
			 
                                <div class="input-group margin" id="div_problema">
			 <span class="input-group-btn" title="Se define el proyecto .">
                		        <label class="btn-addons "  style="padding-right: 5px;">Proyecto*</label>
            				</span>
             <input type="text"  id="proyecto" required name="flujo_presupuesto[proyecto]"  placeholder="Escoja el proyecto" class="text-input"/>
			 <span class="input-group-btn" title="Se define el  año .">
                		        <label class="btn-addons "  style="padding-right: 5px;">Año*</label>
            				</span>
             <input type="text"  id="anno" required name="flujo_presupuesto[anno]"  placeholder="Escoja el año" class="text-input"/>
            <!---  <input type="text"  id="anno" required name="flujo_presupuesto[anno]"  placeholder="Escoja el a�o" class="text-input"/>--->
			</div>
       </form>
      <div id="chart"></div>

  </div>

      </body>