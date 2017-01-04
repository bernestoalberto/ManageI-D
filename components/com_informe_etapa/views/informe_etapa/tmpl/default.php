<?php
defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');
$componentbase = $this->_basePath;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Informe de Etapa</title>

    <script type="text/x-kendo-template" id="template_presupuesto">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Programa:</label>#= programa #</li>
                        <li><label>Código Proyecto:</label>#= codigo #</li>
                        <li><label>Calificación:</label>#= calificacion #</li>
                        <li><label>Fecha Inicio:</label>#= fecha_inicio #</li>
                        <li><label>Fecha Terminación:</label>#= fecha_terminacion #</li>

                    </ul>
                </div>
            </div>
        </div>

    </script>

    <script type="text/x-kendo-template" id="template_certify">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label> Otras Actividades Resultados:</label>#= a_r_dos #</li>
                        <li><label>Cumplimiento:</label>#= cumplimiento_dos #</li>
                        <li><label> Otras Actividades Resultados:</label>#= a_r_tres #</li>
                        <li><label>Cumplimiento Tres:</label>#= cumplimiento_tres #</li>
                        <li><label>Cantidad Anticipa:</label>#= cantidad_anticipa #</li>
                        <li><label>Gastos Incurridos:</label>#= gastos_incurridos #</li>
                        <li><label>Observaciones:</label>#= observaciones #</li>
                        <li><label>Presidente:</label>#= nombre_apellidos_presidente #</li>
                        <li><label>Fecha Certifica Presidente:</label>#= fecha_certifica_presidente #</li>
                        <li><label>Director:</label>#= nombre_apellidos_director #</li>
                        <li><label>Fecha Certifica Director:</label>#= fecha_certifica_director #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>

    <script type="text/x-kendo-template" id="template_etapa">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Programa:</label>#= programa #</li>
                        <li><label>Código Proyecto:</label>#= numero #</li>
                        <li><label>Cumplimiento Cronograma Actividades:</label>#= cumplimiento_cronograma_actividades #</li>
                        <li><label>Cumplimiento Resultados Programados:</label>#= cumplimiento_resultados_programados #</li>
                        <li><label>Jefe Proyecto:</label>#= jefe_proyecto #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>
</head>
<body class="skin-blue sidebar-mini">
<div class="nav-tabs-custom">
    <ul class="nav nav-tabs">
        <li ><a data-toggle="tab" href="#certify">Actividades Resultados</a></li>
        <li ><a data-toggle="tab" href="#contro_exe_pre">Presupuesto</a></li>
        <li class="active"><a data-toggle="tab" href="#infrm_etapa">Etapa</a></li>
    </ul>
    <div class="tab-content">


        <div id="certify" class="tab-pane  ">
            <div >



                <section class="content-header">
                    <h1>

                        Gestionar Certificación de Actividades y Resultados
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_certificacion_activdades_resultados" data-toggle='tooltip' title='certificacion_activdades_resultados_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_certificacion_activdades_resultados" data-toggle='tooltip' title='certificacion_activdades_resultados_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_certificacion_activdades_resultados"  style="width:100%"></div>
                </div>

                <div id="certificacion_activdades_resultados_window" style="display: none;" >



                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_certificacion_activdades_resultadossave_exit" class="btn  btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_certificacion_activdades_resultadossave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="certificacion_activdades_resultados_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">


                                        <div class="input-group margin" id= "div_anno">
                                          <span class="input-group-btn" title="Donde se define el año">
                                    <label for="anno" class="btn-addons" style="padding-right: 5px;">Año</label></span>
                                            <input class="form-control" value="<?php echo JFactory::getDate()->year; ?>" id="annocertif" readonly type="text" name="certificacion_activdades_resultados[anno]"   />
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_gastos_incurridos">
                          	<span class="input-group-btn" title="Donde se define lgastos_incurridos">
                			<label for="gastos_incurridos" class="btn-addons" style="padding-right: 5px;">Gastos Incurridos*</label></span>
                                            <input class="" value="" id="gastos_incurridos" required  name="certificacion_activdades_resultados[gastos_incurridos]"  placeholder="Inserte  gastos_incurridos" type="text" >
                                            <div class="k-invalid-msg" data-for="gastos_incurridos"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                            <div class="input-group margin" id= "div_id_proyecto_certif">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons" style="padding-right: 5px;">Proyecto*</label></span>
                                                <input class="form-control"  id="id_proyecto_certif" required  name="certificacion_activdades_resultados[id_proyecto]"  placeholder="Escoja el  proyecto"  >
                                                <div class="k-invalid-msg" data-for="id_proyecto_certif"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_id_evaluacion">
                          	<span class="input-group-btn" title="Donde se define lid_evaluacion">
                			<label for="id_evaluacion" class="btn-addons" style="padding-right: 5px;">Evaluación*</label></span>
                                                <input class="form-control" value="" id="id_evaluacion" required  name="certificacion_activdades_resultados[id_evaluacion]"  placeholder="Inserte  id_evaluacion"  >
                                                <div class="k-invalid-msg" data-for="id_evaluacion"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div  class="input-group margin">
                          	<span class="input-group-btn" title="Donde se define lperiodo_evaluacion">
                			<label for="periodo_evaluacion" class="btn-addons" style="padding-right: 5px;">Período Evaluación*</label></span>

                                    <ul class="fieldlist">


                                        <input type="radio" value="enero-marzo" name="certificacion_activdades_resultados[periodo_evaluacion_cert]" id="etapa11" class="k-radio" checked="checked">
                                        <label class="k-radio-label" for="etapa11">Enero-Marzo</label>

                                        <input type="radio"  value="abril-junio" name="certificacion_activdades_resultados[periodo_evaluacion_cert]" id="etapa22" class="k-radio">
                                        <label class="k-radio-label" for="etapa22">Abril-Junio</label>

                                        <input type="radio" value="julio-septiembre" name="certificacion_activdades_resultados[periodo_evaluacion_cert]" id="etapa33" class="k-radio">
                                        <label class="k-radio-label" for="etapa33">Julio-Septiembre</label>

                                        <input type="radio" value="octubre-diciembre" name="certificacion_activdades_resultados[periodo_evaluacion_cert]" id="etapa44" class="k-radio">
                                        <label class="k-radio-label" for="etapa44">Octubre-Diciembre</label>

                                    </ul>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="input-group margin" id= "div_actividades_resultados">
                          	<span class="input-group-btn" title="Donde se define lactividades_resultados">
                			<label for="actividades_resultados" class="btn-addons" style="padding-right: 5px;">Actividades Resultados*</label></span>
                                                <textarea class="form-control" value="" id="actividades_resultados" required  name="certificacion_activdades_resultados[actividades_resultados]"  placeholder="Inserte  actividades_resultados" ></textarea>
                                                <div class="k-invalid-msg" data-for="actividades_resultados"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="input-group margin" id= "div_cumplimiento">
                          	<span class="input-group-btn" title="Donde se define lcumplimiento">
                			<label for="cumplimiento" class="btn-addons" style="padding-right: 5px;">Cumplimiento*</label></span>
                                    <ul class="fieldlist">

                                        <input type="radio" value="cumplido" name="certificacion_activdades_resultados[cumplimiento]" id="eval1" class="k-radio" checked="checked" >
                                        <label class="k-radio-label" for="eval1">Cumplido</label>

                                        <input type="radio" value="incumplido" name="certificacion_activdades_resultados[cumplimiento]" id="eval2" class="k-radio">
                                        <label class="k-radio-label" for="eval2">Incumplido</label>

                                    </ul>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="input-group margin" id= "div_a_r_dos">
                          	<span class="input-group-btn" title="Donde se define lactividades_resultados">
                			<label for="a_r_dos" class="btn-addons" style="padding-right: 5px;">Actividades Resultados</label></span>
                                                <textarea class="form-control" value="" id="a_r_dos"   name="certificacion_activdades_resultados[a_r_dos]"  placeholder="Inserte  actividades_resultados" ></textarea>
                                                <div class="k-invalid-msg" data-for="a_r_dos"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="input-group margin" id= "div_cumplimiento_dos">
                          	<span class="input-group-btn" title="Donde se define lcumplimiento">
                			<label for="cumplimiento_dos" class="btn-addons" style="padding-right: 5px;">Cumplimiento</label></span>
                                    <ul class="fieldlist">

                                        <input type="radio" value="cumplido" name="certificacion_activdades_resultados[cumplimiento_dos]" id="eval3" class="k-radio" checked="checked" >
                                        <label class="k-radio-label" for="eval3">Cumplido</label>

                                        <input type="radio" value="incumplido" name="certificacion_activdades_resultados[cumplimiento_dos]" id="eval4" class="k-radio">
                                        <label class="k-radio-label" for="eval4">Incumplido</label>

                                    </ul>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="input-group margin" id= "div_a_r_tres">
                          	<span class="input-group-btn" title="Donde se define lactividades_resultados">
                			<label for="a_r_tres" class="btn-addons" style="padding-right: 5px;">Actividades Resultados</label></span>
                                                <textarea class="form-control" value="" id="a_r_tres"   name="certificacion_activdades_resultados[a_r_tres]"  placeholder="Inserte  actividades_resultados" ></textarea>
                                                <div class="k-invalid-msg" data-for="a_r_tres"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="input-group margin" id= "div_cumplimiento_tres">
                          	<span class="input-group-btn" title="Donde se define lcumplimiento">
                			<label for="cumplimiento_tres" class="btn-addons" style="padding-right: 5px;">Cumplimiento</label></span>
                                    <ul class="fieldlist">

                                        <input type="radio" value="cumplido" name="certificacion_activdades_resultados[cumplimiento_tres]" id="eval5" class="k-radio" checked="checked" >
                                        <label class="k-radio-label" for="eval5">Cumplido</label>

                                        <input type="radio" value="incumplido" name="certificacion_activdades_resultados[cumplimiento_tres]" id="eval6" class="k-radio">
                                        <label class="k-radio-label" for="eval6">Incumplido</label>

                                    </ul>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                            <div class="input-group margin" id= "div_nombre_apellidos_presidente">
                          	<span class="input-group-btn" title="Donde se define lnombre_apellidos_presidente">
                			<label for="nombre_apellidos_presidente" class="btn-addons" style="padding-right: 5px;">Presidente*</label></span>
                                                <input class="form-control" value="" id="nombre_apellidos_presidente" required  name="certificacion_activdades_resultados[nombre_apellidos_presidente]"  placeholder="Inserte  nombre_apellidos_presidente" type="text" >
                                                <div class="k-invalid-msg" data-for="nombre_apellidos_presidente"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_fecha_certifica_presidente">
                          	<span class="input-group-btn" title="Donde se define lfecha_certifica_presidente">
                			<label for="fecha_certifica_presidente" class="btn-addons" style="padding-right: 5px;">Fecha Certifica Presidente*</label></span>
                                                <input class="" value="" id="fecha_certifica_presidente" required  name="certificacion_activdades_resultados[fecha_certifica_presidente]"  placeholder="Inserte  fecha_certifica_presidente"  >
                                                <div class="k-invalid-msg" data-for="fecha_certifica_presidente"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                            <div class="input-group margin" id= "div_nombre_apellidos_director">
                          	<span class="input-group-btn" title="Donde se define lnombre_apellidos_director">
                			<label for="nombre_apellidos_director" class="btn-addons" style="padding-right: 5px;">Director*</label></span>
                                                <input class="form-control" value="" id="nombre_apellidos_director" required  name="certificacion_activdades_resultados[nombre_apellidos_director]"  placeholder="Inserte  nombre_apellidos_director" type="text" >
                                                <div class="k-invalid-msg" data-for="nombre_apellidos_director"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_fecha_certifica_director">
                          	<span class="input-group-btn" title="Donde se define lfecha_certifica_director">
                			<label for="fecha_certifica_director" class="btn-addons" style="padding-right: 5px;">Fecha Certifica Director*</label></span>
                                                <input class="" value="" id="fecha_certifica_director" required  name="certificacion_activdades_resultados[fecha_certifica_director]"  placeholder="Inserte  fecha_certifica_director"  >
                                                <div class="k-invalid-msg" data-for="fecha_certifica_director"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="input-group margin" id= "div_observaciones">
                          	<span class="input-group-btn" title="Donde se define lobservaciones">
                			<label for="observaciones" class="btn-addons" style="padding-right: 5px;">Observaciones</label></span>
                                                <textarea class="form-control" value="" id="observaciones"  name="certificacion_activdades_resultados[observaciones]"  placeholder="Inserte  observaciones" ></textarea>
                                                <div class="k-invalid-msg" data-for="observaciones"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <input class="text-input"  value="" type="hidden" id="taskcertificacion_activdades_resultados">
                            </div>
                            <?php echo JHtml::_('form.token');  ?>
                        </form>
                    </div>
                </div>
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

        </div> <!---fin de tab---->

        <div id="contro_exe_pre" class="tab-pane ">
            <div>



                <section class="content-header">
                    <h1>
                        Control y Ejecución del Presupuesto de los Proyectos
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_control_ejecucion_presupuesto" data-toggle='tooltip' title='control_ejecucion_presupuesto_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_control_ejecucion_presupuesto" data-toggle='tooltip' title='control_ejecucion_presupuesto_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_control_ejecucion_presupuesto"  style="width:100%"></div>
                </div>

                <div id="control_ejecucion_presupuesto_window" style="display: none;" >
                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_control_ejecucion_presupuestosave_exit" class="btn  btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_control_ejecucion_presupuestosave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="control_ejecucion_presupuesto_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_anno">
                          	<span class="input-group-btn" title="Donde se define lanno">
                			<label for="anno" class="btn-addons" style="padding-right: 5px;">Año</label></span>
                                            <input class="form-control" value="<?php echo JFactory::getDate()->year; ?>" id="annocep" readonly  name="control_ejecucion_presupuesto[anno]"   />
                                            <div class="k-invalid-msg" data-for="anno"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="input-group margin" id= "div_etapa">
                          	<span class="input-group-btn" title="Donde se define letapa">
                			<label for="etapa" class="btn-addons" style="padding-right: 5px;">Etapa*</label></span>
                                <ul class="fieldlist">

                                    <input type="radio" value="enero-marzo" name="control_ejecucion_presupuesto[etapa]" id="etapa1c" class="k-radio" checked="checked">
                                    <label class="k-radio-label" for="etapa1c">Enero-Marzo</label>

                                    <input type="radio" value="abril-junio" name="control_ejecucion_presupuesto[etapa]" id="etapa2c" class="k-radio">
                                    <label class="k-radio-label" for="etapa2c">Abril-Junio</label>

                                    <input type="radio" value="julio-septiembre" name="control_ejecucion_presupuesto[etapa]" id="etapa3c" class="k-radio">
                                    <label class="k-radio-label" for="etapa3c">Julio-Septiembre</label>

                                    <input type="radio" value="octubre-diciembre" name="control_ejecucion_presupuesto[etapa]" id="etapa4c" class="k-radio">
                                    <label class="k-radio-label" for="etapa4c">Octubre-Diciembre</label>


                                </ul>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons" style="padding-right: 5px;">Proyecto*</label></span>
                                            <input class="form-control" value="" id="id_proyecto_control_ejecucion_presupuesto" required  name="control_ejecucion_presupuesto[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
                                            <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_inicio">
                          	<span class="input-group-btn" title="Donde se define lfecha_inicio">
                			<label for="fecha_inicio" class="btn-addons" style="padding-right: 5px;">Fecha Inicio*</label></span>
                                            <input class="" value="" id="fecha_inicio" required  name="control_ejecucion_presupuesto[fecha_inicio]"  placeholder="Inserte  fecha_inicio"  >
                                            <div class="k-invalid-msg" data-for="fecha_inicio"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_terminacion">
                          	<span class="input-group-btn" title="Donde se define lfecha_terminacion">
                			<label for="fecha_terminacion" class="btn-addons" style="padding-right: 5px;">Fecha Culminación*</label></span>
                                            <input class="" value="" id="fecha_terminacion"   name="control_ejecucion_presupuesto[fecha_terminacion]"  placeholder="Inserte  fecha_terminacion(Llenar cuando culmine el proyecto)"  >
                                            <div class="k-invalid-msg" data-for="fecha_terminacion"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>





                            <input class="text-input"  value="" type="hidden" id="taskcontrol_ejecucion_presupuesto">
                    </div>
                    <?php echo JHtml::_('form.token');  ?>
                    </form>
                </div>
            </div>
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
    <div id="infrm_etapa" class="tab-pane active">
        <div >



            <section class="content-header">
                <h1>
                    Gestionar Informe de Etapa del Proyecto
                </h1>
                <ol class="breadcrumb">
                    <div class="btn-group">

                        <button class="btn btn-action" id="addbutton_informe_etapa" data-toggle='tooltip' title='informe_etapa_add' >
                            <i class="fa fa-edit"></i> Nuevo
                        </button>
                        <button class="btn bg-red  btn-action" id="deletebutton_informe_etapa" data-toggle='tooltip' title='informe_etapa_delete' >
                            <i class="fa fa-trash"></i> Eliminar
                        </button>
                    </div>
                </ol>
            </section>
            </br>
            <div class="content box box-primary">
                <div id="gridselection_informe_etapa"  style="width:100%"></div>
            </div>

            <div id="informe_etapa_window" style="display: none;" >
                <div class="box-gestionando box-primary">

                    <div class="box-header">
                        <button type="button" id="accionbtn_informe_etapasave_exit" class="btn  btn-primary">Guardar y Salir</button>
                        <button type="button" id="accionbtn_informe_etapasave_new" class="btn  btn-primary">Guardar y Crear</button>
                    </div>

                    <form role="form" method="post" id="informe_etapa_form" class="form-validate">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group margin" id= "div_anno">
                          	<span class="input-group-btn" title="Donde se define lanno">
                			<label for="anno" class="btn-addons" style="padding-right: 5px;">Año</label></span>
                                        <input class="form-control" value="<?php echo JFactory::getDate()->year; ?>" id="annoie" readonly  name="informe_etapa[anno]"   />
                                        <div class="k-invalid-msg" data-for="anno"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="input-group margin" id= "div_etapa">
                          	<span class="input-group-btn" title="Donde se define letapa">
                			<label for="etapa" class="btn-addons" style="padding-right: 5px;">Etapa*</label></span>
                            <ul class="fieldlist">

                                <input type="radio" value="mayo" name="informe_etapa[etapa]" id="etapar1" class="k-radio" checked="checked">
                                <label class="k-radio-label" for="etapar1">Mayo</label>

                                <input type="radio" value="octubre" name="informe_etapa[etapa]" id="etapar2" class="k-radio">
                                <label class="k-radio-label" for="etapar2">Octubre</label>


                            </ul>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define el proyecto">
                			<label for="id_proyecto" class="btn-addons" style="padding-right: 5px;">Proyecto*</label></span>
                                        <input class="form-control" value="" id="id_proyecto_informe_etapa" required  name="informe_etapa[id_proyecto]"  placeholder="Inserte  proyecto" type="text"/>
                                        <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="input-group margin" id= "div_cumplimiento_cronograma_actividades">
                          	<span class="input-group-btn" title="Donde se define lcumplimiento_cronograma_actividades">
                			<label for="cumplimiento_cronograma_actividades" class="btn-addons" style="padding-right: 5px;">Cumplimiento Cronograma Actividades*</label></span>
                                        <textarea class="form-control" value="" id="cumplimiento_cronograma_actividades" required  name="informe_etapa[cumplimiento_cronograma_actividades]"  placeholder="Inserte  cumplimiento_cronograma_actividades" ></textarea>
                                        <div class="k-invalid-msg" data-for="cumplimiento_cronograma_actividades"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="input-group margin" id= "div_cumplimiento_resultados_programados">
                          	<span class="input-group-btn" title="Donde se define lcumplimiento_resultados_programados">
                			<label for="cumplimiento_resultados_programados" class="btn-addons" style="padding-right: 5px;">Cumplimiento Resultados Programados*</label></span>
                                        <textarea class="form-control" value="" id="cumplimiento_resultados_programados" required  name="informe_etapa[cumplimiento_resultados_programados]"  placeholder="Inserte  cumplimiento_resultados_programados" type="text" ></textarea>
                                        <div class="k-invalid-msg" data-for="cumplimiento_resultados_programados"></div>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <input class="text-input"  value="" type="hidden" id="taskinforme_etapa">
                </div>
                <?php echo JHtml::_('form.token');  ?>
                </form>
            </div>
        </div>
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
</div>
</body>