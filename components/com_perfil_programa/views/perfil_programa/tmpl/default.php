<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');
$componentbase = $this->_basePath;

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Perfil Programa </title>
    <script type="text/x-kendo-template" id="template_perfil_programa">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Fundamentación:</label>#= fundamentacion #</li>
                        <li><label>Objetivo Especifico:</label>#= objetivo_especifico #</li>
                        <li><label>Problema:</label>#= problema #</li>
                        <li><label>Principales Resultados:</label>#= principalesResultados #</li>
                        <li><label>Potencial Humano:</label>#= potencialHumano #</li>
                        <li><label>Otro:</label>#= otro #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>

</head>
<body class="skin-blue sidebar-mini">

<div>
    <section class="content-header">
        <h1>
	<span class = "step size-32">
                        Gestionar  Perfil del Programa </h1>
        <ol class="breadcrumb">

            <div class="btn-group">
                <button class="btn btn-action" id="addbutton_Perfil_programa" data-toggle='tooltip' title='' >
                    <i class="icon ion-android-add-circle"></i> Crear</button>

                <button class="btn bg-red  btn-action" id="deletebutton_Perfil_programa"  data-toggle='tooltip' title='provincia_delete'>
                    <i class="fa fa-trash"></i>  Eliminar</button>
            </div>


        </ol>
    </section>
    </br>

    <div class="content box box-primary" id ="pdf_perfil_programa">
        <div id="gridselection_Perfil_programa" style="width:100%"></div>
    </div>

    <div id="Perfil_programa_window" style="display: none;" width="700">

        <div class="box-gestionando box-primary">

            <div class="box-header">

                <button type="button" id="accionbtn_save_exit" class="btn  btn-primary">Guardar y Salir</button>
                <button type="button" id="accionbtn_save_new" class="btn btn-primary">Guardar y Crear</button>
            </div>

            <form role="form" id="perfil_programa_form" method="post">

                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group margin " id="div_presupuesto">
                                <label class="btn-addons "  style="padding-right: 5px;">Presupuesto*</label>
                                <input type="text" value="" id="presupuesto" required  name="perfil_programa[presupuesto]" placeholder="Introduzca el presupuesto"
                                       class="form-control"/>
                                <div class="k-invalid-msg" data-for="presupuesto"></div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group margin " id="div_plazoEjecucion">
                                <label class="btn-addons "  style="padding-right: 5px;">Plazo Ejecución*</label>
                                <input type="number" value=""  id="plazoEjecucion"  required="required"  name="perfil_programa[plazoEjecucion]"
                                       placeholder="Introduzca el plazo de Ejecución"
                                       class="form-control "/>
                                <div class="k-invalid-msg" data-for="plazoEjecucion"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group margin" id="div_numero_proyectos">
                                <label class="btn-addons "  style="padding-right: 5px;">Cantidad Proyectos*</label>
                                <input type="text" value="" id="numero_proyectos"   name="perfil_programa[numero_proyectos]"
                                       placeholder="Introduzca el numero de proyectos" class="form-control"/>
                                <div class="k-invalid-msg" data-for="numero_proyectos"></div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group margin" id="div_id_prioridad">
                                <label class="btn-addons "  style="padding-right: 5px;">Problema*</label>
                                <input type="text" value="" style="width: 100% !important" id="id_prioridad" required  name="perfil_programa[id_prioridad]" placeholder="Escoja la prioridad" class="form-control"/>
                                <div class="k-invalid-msg" data-for="id_prioridad"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group margin" id="div_id_indicador">
                                <label class="btn-addons "  style="padding-right: 5px;">Indicador*</label>
                                <input type="text" value=""   id="id_indicador" required  name="perfil_programa[id_indicador]" placeholder="Escoja el indicador"
                                       class="text-input form-control"/>
                                <div class="k-invalid-msg" data-for="id_indicador"></div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group margin" id= "div_archivo">
                                <label for="archivo" class="btn-addons " style="padding-right: 5px;">Adjuntar Archivo*</label>
                                <input   id="archivo"  value="" type="file" name="perfil_programa[archivo]" />
                                <div class="k-invalid-msg" data-for="archivo"></div>
                            </div>
                        </div>
                    </div>


                    <input class="text-input"  value="" type="hidden" id="taskPerfil_programa">
                </div>
                <div class="form-group">
                    <div class="input-group margin" id="div_denominacion">
                        <label class="btn-addons "  style="padding-right: 5px;">Denominación*</label>
            				<textarea  id="denominacion" required  name="perfil_programa[denominacion]" class="form-control"
                                       placeholder="Introduzca la denominacion"  rows ="3" cols="63"></textarea>
                        <div class="k-invalid-msg" data-for="denominaci&oacute;n"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group margin" id="div_fundamentacion">
                        <label class="btn-addons "  style="padding-right: 5px;">Fundamentación*</label>
            				<textarea   id="fundamentacion" required  name="perfil_programa[fundamentacion]" class="form-control"
                                        placeholder="Introduzca la fundamentacion"  rows ="3" cols="63"></textarea>
                        <div class="k-invalid-msg" data-for="fundamentacion"></div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group margin" id="div_objetivo_especifico">
                                <label class="btn-addons "  style="padding-right: 5px;">Objetivos*</label>
            				<textarea   id="objetivo_especifico" required  name="perfil_programa[objetivo_especifico]" class="form-control"
                                        placeholder="Introduzca el(los) objetivo(s)_especifico(s)"  rows ="3" cols="63"></textarea>
                                <div class="k-invalid-msg" data-for="objetivo_especifico"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group margin" id="div_principalesResultados">
                                <label class="btn-addons "  style="padding-right: 5px;">Resultados*</label>
            				<textarea  id="principalesResultados" required  name="perfil_programa[principalesResultados]" class="form-control"
                                       placeholder="Introduzca los principalesResultados"  rows ="3" cols="63"></textarea>
                                <div class="k-invalid-msg" data-for="principalesResultados"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group margin" id="div_potencialHumano">
                                <label class="btn-addons "  style="padding-right: 5px;">Potencial Humano*</label>
                        <textarea   id="potencialHumano" required  name="perfil_programa[potencialHumano]" class="form-control"
                                    placeholder="Introduzca el potencialHumano"  rows ="3" cols="63"></textarea>
                                <div class="k-invalid-msg" data-for="potencialHumano"></div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group margin" id="div_otro">
                                <label class="btn-addons "  style="padding-right: 5px;">Otro</label>
            				<textarea   id="otro"   name="perfil_programa[otro]"
                                        placeholder="Introduzca  otra informacion" rows ="3" cols="63" class="form-control"></textarea>
                                <div class="k-invalid-msg" data-for="otro"></div>
                            </div>
                        </div>
                    </div>
                    <input class="text-input"  value="" type="hidden" id="taskperfil_programa">
                </div>
                <?php echo JHtml::_('form.token'); ?>
            </form>
        </div>

        <div class="info-box bg-green" style="display: none" id="message-ok">

            <span class="info-box-icon"><i class="fa fa-thumbs-o-up" style="font-size: 50px"></i></span>
            <div class="info-box-content">
                <span class="info-box-text">Acción realizada </br> correctamente </span>
            </div><!-- /.info-box-content -->
        </div>
        <div class="info-box bg-red" style="display: none" id="message-error">
            <span class="info-box-icon"><i class="fa fa-frown-o" style="font-size: 50px"></i></span>
            <div class="info-box-content">
                <span class="info-box-text" style="font-size: 10px" id="text-error"> </span>
            </div><!-- /.info-box-content -->
        </div>

    </div>
</div>




</body>


