<?php
defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');
$componentbase = $this->_basePath;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Anticipo </title>
    <script type="text/x-kendo-template" id="template_anticipo">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>ejecutor:</label>#= ejecutor #</li>
                        <li><label>cuenta bancaria:</label>#= cuenta_bancaria #</li>
                        <li><label>sucursal creditos:</label>#= sucursal_creditos #</li>
                        <li><label>código:</label>#= codigo #</li>
                        <li><label>secretario:</label>#= secretario #</li>
                        <li><label>fecha firma:</label>#= fecha_firma #</li>
                        <li><label>nombre recibe:</label>#= nombre_recibe #</li>
                        <li><label>cargo recibe:</label>#= cargo_recibe #</li>
                        <li><label>fecha recibe:</label>#= fecha_recibe #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>



    <script type="text/x-kendo-template" id="template_notify">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>programa:</label>#= programa #</li>
                        <li><label>cantidad anticipa:</label>#= cantidad_anticipa #</li>
                        <li><label>secretario:</label>#= secretario #</li>
                        <li><label>Fecha Firma:</label>#= fecha #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>

    <script type="text/x-kendo-template" id="template_oponencia">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>resultados programados:</label>#= resultados_programados #</li>
                        <li><label>conclusiones:</label>#= conclusiones #</li>
                        <li><label>recomendaciones:</label>#= recomendaciones #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>
    <script type="text/x-kendo-template" id="template_gep">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>programa:</label>#= programa #</li>
                        <li><label>código:</label>:</label>#= codigo #</li>
                        <li><label>evaluación objetivos:</label>:</label>#= evaluacion_objetivos #</li>
                        <li><label>evaluación resultados:</label>:</label>#= evaluacion_resultados #</li>
                        <li><label>evaluación actividades:</label>:</label>#= evaluacion_actividades #</li>
                        <li><label>observaciones:</label>#= observaciones #</li>
                        <li><label>anticipo:</label>#= anticipo #</li>
                        <li><label>gastos:</label>#= gastos #</li>
                        <li><label>conclusiones:</label>#= conclusiones #</li>
                        <li><label>recomendaciones:</label>#= recomendaciones #</li>
                        <li><label>nombre apellidos miembroGEP:</label>#= nombre_apellidos_miembroGEP #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>
    <script type="text/x-kendo-template" id="template_ejeucion_programa">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>nivel ejecucion presupuesto:</label>#= nivel_ejecucion_presupuesto #</li>
                        <li><label>principales dificultades:</label>#= principales_dificultades #</li>
                        <li><label>conclusiones recomendaciones:</label>#= conclusiones_recomendaciones #</li>
                        <li><label>nombre apellidos secretatio:</label>#= nombre_apellidos_secretatio #</li>
                        <li><label>nombre apellidos jefe:</label>#= nombre_apellidos_jefe #</li>
                        <li><label>cumplimiento objtvs propuestos:</label>#= cumplimiento_objtvs_propuestos #</li>
                        <li><label>cumplimiento resultados programados:</label>#= cumplimiento_resultados_programados #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>
</head>
<body class="skin-blue sidebar-mini">
<div class="nav-tabs-custom">
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#anticipe">Anticipo</a></li>
        <li><a data-toggle="tab" href="#notify">Ingresos y Gastos</a></li>
        <li><a data-toggle="tab" href="#oponencia">Oponencia</a></li>
        <li><a data-toggle="tab" href="#dictamen">Dictámen GEP</a></li>
        <li><a data-toggle="tab" href="#exe_program">Ejecución Programa</a></li>

    </ul>
    <div class="tab-content">
        <div id="anticipe" class="tab-pane active">
            <div>


                <section class="content-header">
                    <h1>
                        Gestionar Anticipo
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_anticipo" data-toggle='tooltip' title='anticipo_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_anticipo" data-toggle='tooltip' title='anticipo_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_anticipo"  style="width:100%"></div>
                </div>

                <div id="anticipo_window" style="display: none;" >


                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_anticiposave_exit" class="btn  btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_anticiposave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="anticipo_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_anno">
                                    <span class="input-group-btn" title=" se define el año">
                                    <label for="anno" class="btn-addons " style="padding-right: 5px;">Año</label></span>
                                    <input class="form-control" value="<?php echo JFactory::getDate()->year; ?>" id="anno" readonly type="text" name="anticipo[anno]"   />
                                </div>
                                </div>
                                </div>
                                </div>

                                <div class="input-group margin" id= "div_id_mes">
                          	<span class="input-group-btn" title=" se define lid_mes">
                			<label for="id_mes" class="btn-addons " style="padding-right: 5px;">Etapa*</label></span>
                                    <ul class="fieldlist">

                                            <input type="radio" value="enero-marzo" name="anticipo[etapa]" id="etapa1" class="k-radio" checked="checked">
                                            <label class="k-radio-label" for="etapa1">Enero-Marzo</label>

                                            <input type="radio" value="abril-junio" name="anticipo[etapa]" id="etapa2" class="k-radio">
                                            <label class="k-radio-label" for="etapa2">Abril-Junio</label>

                                            <input type="radio" value="julio-septiembre" name="anticipo[etapa]" id="etapa3" class="k-radio">
                                            <label class="k-radio-label" for="etapa3">Julio-Septiembre</label>

                                            <input type="radio" value="octubre-diciembre" name="anticipo[etapa]" id="etapa4" class="k-radio">
                                            <label class="k-radio-label" for="etapa4">Octubre-Diciembre</label>


                                    </ul>


                                </div>


                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title=" se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
                                    <input class="form-control" value="" id="id_proyecto" required  name="anticipo[id_proyecto]"  placeholder="Inserte  el proyecto"  >
                                    <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                </div>
                                </div>
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_cantidad_anticipa">
                          	<span class="input-group-btn" title=" se define lcantidad_anticipa">
                			<label for="fecha_recibe" class="btn-addons " style="padding-right: 5px;">Cantidad Anticipa*</label></span>
                                    <input class="" value="" id="cantidad_anticipa" required  name="anticipo[cantidad_anticipa]"  placeholder="Inserte  cantidad_anticipa"  >
                                    <div class="k-invalid-msg" data-for="cantidad_anticipa"></div>
                                </div>
                                </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_nombre_recibe">
                          	<span class="input-group-btn" title=" se define lnombre_recibe">
                			<label for="nombre_recibe" class="btn-addons " style="padding-right: 5px;">Nombre Recibe*</label></span>
                                    <input class="form-control" value="" id="nombre_recibe" required  name="anticipo[nombre_recibe]"  placeholder="Inserte  nombre_recibe"  />
                                    <div class="k-invalid-msg" data-for="nombre_recibe"></div>


                                </div>
                                </div>
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_cargo_recibe">
                          	<span class="input-group-btn" title=" se define lcargo_recibe">
                			<label for="cargo_recibe" class="btn-addons " style="padding-right: 5px;">Cargo Recibe*</label></span>
                                    <input class="form-control" value="" id="cargo_recibe" required  name="anticipo[cargo_recibe]"  placeholder="Inserte  cargo_recibe"  />
                                    <div class="k-invalid-msg" data-for="cargo_recibe"></div>


                                </div>
                                </div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_fecha_recibe">
                          	<span class="input-group-btn" title=" se define lfecha_recibe">
                			<label for="fecha_recibe" class="btn-addons " style="padding-right: 5px;">Fecha Recibe*</label></span>
                                    <input class="" value="" id="fecha_recibe" required  name="anticipo[fecha_recibe]"  placeholder="Inserte  fecha_recibe"  >
                                    <div class="k-invalid-msg" data-for="fecha_recibe"></div>
                                </div>
                                </div>
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_fecha_firma">
                          	<span class="input-group-btn" title=" se define lfecha_firma">
                			<label for="fecha_firma" class="btn-addons " style="padding-right: 5px;">Fecha Firma*</label></span>
                                    <input class="" value="" id="fecha_firma" required  name="anticipo[fecha_firma]"  placeholder="Inserte  fecha_firma"  />
                                    <div class="k-invalid-msg" data-for="fecha_firma"></div>


                                </div>
                                </div>
                                </div>
                                </div>


                                <input class="text-input"  value="" type="hidden" id="taskanticipo">
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


        <div id="notify" class="tab-pane ">
            <div>



                <section class="content-header">
                    <h1>

                        Gestionar Notificación de Ingresos y Gastos
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_notificacion_ingreso_gastos" data-toggle='tooltip' title='notificacion_ingreso_gastos_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_notificacion_ingreso_gastos" data-toggle='tooltip' title='notificacion_ingreso_gastos_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_notificacion_ingreso_gastos"  style="width:100%"></div>
                </div>

                <div id="notificacion_ingreso_gastos_window" style="display: none;" >



                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_notificacion_ingreso_gastossave_exit" class="btn  btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_notificacion_ingreso_gastossave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="notificacion_ingreso_gastos_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_anno">
                                        <span class="input-group-btn" title=" se define el año">
                                    <label for="anno" class="btn-addons " style="padding-right: 5px;">Año</label></span>
                                    <input class="form-control" value="<?php echo JFactory::getDate()->year; ?>" id="annonotif" readonly type="text" name="notificacion_ingreso_gastos[anno]"   />
                                </div>
                                </div>
                                </div>
                                </div>


                                <div  class="demo-section k-content">
                          	<span class="input-group-btn" title=" se define lperiodo_evaluacion">
                			<label for="periodo_evaluacion" class="btn-addons " style="padding-right: 5px;">Período Evaluación*</label></span>

                                    <ul class="fieldlist">

                                            <input type="radio" value="enero-marzo" name="notificacion_ingreso_gastos[etapa]" id="etapa1n" class="k-radio" checked="checked">
                                            <label class="k-radio-label" for="etapa1n">Enero-Marzo</label>

                                            <input type="radio" value="abril-junio" name="notificacion_ingreso_gastos[etapa]" id="etapa2n" class="k-radio">
                                            <label class="k-radio-label" for="etapa2n">Abril-Junio</label>

                                            <input type="radio" value="julio-septiembre" name="notificacion_ingreso_gastos[etapa]" id="etapa3n" class="k-radio">
                                            <label class="k-radio-label" for="etapa3n">Julio-Septiembre</label>

                                            <input type="radio" value="octubre-diciembre" name="notificacion_ingreso_gastos[etapa]" id="etapa4n" class="k-radio">
                                            <label class="k-radio-label" for="etapa4n">Octubre-Diciembre</label>


                                    </ul>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title=" se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;"> Proyecto*</label></span>
                                    <input class="form-control" value="" id="id_proyecto_notif" required  name="notificacion_ingreso_gastos[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
                                    <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                </div>
                                </div>
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_id_evaluacion">
                          	<span class="input-group-btn" title=" se define lid_evaluacion">
                			<label for="id_evaluacion" class="btn-addons " style="padding-right: 5px;">Evaluación Ejecución*</label></span>
                                    <input class="form-control" value="" id="id_evaluacion" required  name="notificacion_ingreso_gastos[id_evaluacion]"  placeholder="Inserte  id_evaluacion"  >
                                    <div class="k-invalid-msg" data-for="id_evaluacion"></div>
                                </div>
                                </div>
                                </div>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_autorizo_registrar_ingreso">
                          	<span class="input-group-btn" title=" se define lautorizo_registrar_ingreso">
                			<label for="autorizo_registrar_ingreso" class="btn-addons " style="padding-right: 5px;">Autorizo Registrar Ingreso*</label></span>
                                    <input class="" value="" id="autorizo_registrar_ingreso" required  name="notificacion_ingreso_gastos[autorizo_registrar_ingreso]"  placeholder="Inserte  autorizo_registrar_ingreso" type="text" >
                                    <div class="k-invalid-msg" data-for="autorizo_registrar_ingreso"></div>
                                </div>
                                </div>
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_autorizo_registrar_gasto">
                          	<span class="input-group-btn" title=" se define lautorizo_registrar_gasto">
                			<label for="autorizo_registrar_gasto" class="btn-addons " style="padding-right: 5px;">Autorizo Registrar Gasto*</label></span>
                                    <input class="" value="" id="autorizo_registrar_gasto" required  name="notificacion_ingreso_gastos[autorizo_registrar_gasto]"  placeholder="Inserte  autorizo_registrar_gasto" type="text" >
                                    <div class="k-invalid-msg" data-for="autorizo_registrar_gasto"></div>
                                </div>
                                </div>
                                </div>

                                <div class="input-group margin" id= "div_fecha">
                          	<span class="input-group-btn" title=" se define lfecha">
                			<label for="fecha" class="btn-addons " style="padding-right: 5px;">Fecha Autotizo*</label></span>
                                    <input class="" value="" id="fecha" required  name="notificacion_ingreso_gastos[fecha]"  placeholder="Inserte  fecha"  >
                                    <div class="k-invalid-msg" data-for="fecha"></div>
                                </div>



                                <input class="text-input"  value="" type="hidden" id="tasknotificacion_ingreso_gastos">
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

        <div id="oponencia" class="tab-pane ">



            <div>



                <section class="content-header">
                    <h1>

                        Gestionar Oponencia sobre Informe Etapa
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_oponencia_informe_etapa" data-toggle='tooltip' title='oponencia_informe_etapa_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_oponencia_informe_etapa" data-toggle='tooltip' title='oponencia_informe_etapa_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_oponencia_informe_etapa"  style="width:100%"></div>
                </div>

                <div id="oponencia_informe_etapa_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_oponencia_informe_etapasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_oponencia_informe_etapasave_new" class="btn  btn-primary">Guardar y Crear</button>

                        </div>

                        <form role="form" method="post" id="oponencia_informe_etapa_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_anno">
                                        <span class="input-group-btn" title="Donde se define el año">
                                    <label for="anno" class="btn-addons" style="padding-right: 5px;">Año</label></span>
                                    <input class="form-control" value="<?php echo JFactory::getDate()->year; ?>" id="annonooponecia" readonly type="text" name="oponencia_informe_etapa[anno]"   />
                                </div>
                                </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_id_informe_etapa">
                          	<span class="input-group-btn" title=" se define lid_informe_etapa">
                			<label for="id_informe_etapa" class="btn-addons " style="padding-right: 5px;">Informe Etapa*</label></span>
                                    <input class="form-control" value="" id="id_informe_etapa" required  name="oponencia_informe_etapa[id_informe_etapa]"  placeholder="Inserte  id_informe_etapa"  >
                                    <div class="k-invalid-msg" data-for="id_informe_etapa"></div>
                                </div>
                                </div>

                                </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_fecha">
                          	<span class="input-group-btn" title=" se define lfecha">
                			<label for="fecha" class="btn-addons " style="padding-right: 5px;">Fecha Firma Oponencia*</label></span>
                                    <input class="" value="" id="fecha" required  name="oponencia_informe_etapa[fecha]"  placeholder="Inserte  fecha"  >
                                    <div class="k-invalid-msg" data-for="fecha"></div>
                                </div>
                                </div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                <div class="input-group margin" id= "div_resultados_programados">
                          	<span class="input-group-btn" title=" se define lresultados_programados">
                			<label for="resultados_programados" class="btn-addons " style="padding-right: 5px;">Resultados Programados*</label></span>
                                    <textarea class="form-control" value="" id="resultados_programados" required  name="oponencia_informe_etapa[resultados_programados]"  placeholder="Inserte  resultados_programados"></textarea>
                                    <div class="k-invalid-msg" data-for="resultados_programados"></div>
                                </div>
                                </div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                <div class="input-group margin" id= "div_conclusiones">
                          	<span class="input-group-btn" title=" se define lconclusiones">
                			<label for="conclusiones" class="btn-addons " style="padding-right: 5px;">Conclusiones*</label></span>
                                    <textarea class="form-control" value="" id="conclusiones" required  name="oponencia_informe_etapa[conclusiones]"  placeholder="Inserte  conclusiones" ></textarea>
                                    <div class="k-invalid-msg" data-for="conclusiones"></div>
                                </div>
                                </div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                <div class="input-group margin" id= "div_recomendaciones">
                          	<span class="input-group-btn" title=" se define lrecomendaciones">
                			<label for="recomendaciones" class="btn-addons " style="padding-right: 5px;">Recomendaciones*</label></span>
                                    <textarea class="form-control" value="" id="recomendaciones"   name="oponencia_informe_etapa[recomendaciones]"  placeholder="Inserte  recomendaciones"  ></textarea>
                                    <div class="k-invalid-msg" data-for="recomendaciones"></div>
                                </div>
                                </div>
                                </div>
                                </div>



                                <input class="text-input"  value="" type="hidden" id="taskoponencia_informe_etapa">
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
        <div id="dictamen" class="tab-pane ">

            <div>



                <section class="content-header">
                    <h1>
                        Gestionar Dictámen del Grupo Expertos sobre Informe de Etapa
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_dictamen_grupo_expertos_inf_etapa" data-toggle='tooltip' title='dictamen_grupo_expertos_inf_etapa_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_dictamen_grupo_expertos_inf_etapa" data-toggle='tooltip' title='dictamen_grupo_expertos_inf_etapa_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_dictamen_grupo_expertos_inf_etapa"  style="width:100%"></div>
                </div>

                <div id="dictamen_grupo_expertos_inf_etapa_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_dictamen_grupo_expertos_inf_etapasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_dictamen_grupo_expertos_inf_etapasave_new" class="btn  btn-primary">Guardar y Crear</button>

                        </div>

                        <form role="form" method="post" id="dictamen_grupo_expertos_inf_etapa_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_anno">
                          	<span class="input-group-btn" title=" se define lanno">
                			<label for="anno" class="btn-addons " style="padding-right: 5px;">Año</label></span>
                                    <input class="form-control" value="<?php echo JFactory::getDate()->year; ?>" id="annodge" readonly  name="dictamen_grupo_expertos_inf_etapa[anno]"   />
                                    <div class="k-invalid-msg" data-for="anno"></div>
                                </div>
                                </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_informe_etapa">
                          	<span class="input-group-btn" title=" se define lid_informe_etapa">
                			<label for="id_informe_etapa" class="btn-addons " style="padding-right: 5px;">Informe Etapa*</label></span>
                                            <input class="form-control" value="" id="id_informe_etap_gexp" required  name="dictamen_grupo_expertos_inf_etapa[id_informe_etapa]"  placeholder="Inserte  id_informe_etapa"  >
                                            <div class="k-invalid-msg" data-for="id_informe_etap_gexp"></div>
                                </div>
                                </div>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                            <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title=" se define el proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
                                                <input class="form-control" value="" id="id_proyecto_gexp" required  name="dictamen_grupo_expertos_inf_etapa[id_proyecto]"  placeholder="Inserte  proyecto" type="text"/>
                                                <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                </div>
                                </div>
                                        <div class="col-md-4">
                                        <div class="input-group margin" id= "div_evaluacion_objetivos">
                          	<span class="input-group-btn" title=" se define levaluacion_objetivos">
                			<label for="evaluacion_objetivos" class="btn-addons " style="padding-right: 5px;">Evaluación Objetivos*</label></span>
                                            <input class="form-control" value="" id="evaluacion_objetivos" required  name="dictamen_grupo_expertos_inf_etapa[evaluacion_objetivos]"  placeholder="Inserte  evaluacion_objetivos" type="text" >
                                            <div class="k-invalid-msg" data-for="evaluacion_objetivos"></div>
                                        </div>
                                </div>
                                </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                <div class="input-group margin" id= "div_evaluacion_resultados">
                          	<span class="input-group-btn" title=" se define levaluacion_resultados">
                			<label for="evaluacion_resultados" class="btn-addons " style="padding-right: 5px;">Evaluación Resultados*</label></span>
                                    <input class="form-control" value="" id="evaluacion_resultados" required  name="dictamen_grupo_expertos_inf_etapa[evaluacion_resultados]"  placeholder="Inserte  evaluacion_resultados" type="text" >
                                    <div class="k-invalid-msg" data-for="evaluacion_resultados"></div>
                                </div>
                                </div>
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_evaluacion_actividades">
                          	<span class="input-group-btn" title=" se define levaluacion_actividades">
                			<label for="evaluacion_actividades" class="btn-addons " style="padding-right: 5px;">Evaluación Actividades</label></span>
                                    <input class="form-control" value="" id="evaluacion_actividades" required  name="dictamen_grupo_expertos_inf_etapa[evaluacion_actividades]"  placeholder="Inserte  evaluacion_actividades" type="text" >
                                    <div class="k-invalid-msg" data-for="evaluacion_actividades"></div>
                                </div>
                                </div>
                                </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                <div class="input-group margin" id= "div_nombre_apellidos_miembroGEP">
                          	<span class="input-group-btn" title=" se define el nombre_apellidos_miembroGEP">
                			<label for="nombre_apellidos_miembroGEP" class="btn-addons " style="padding-right: 5px;">Nombre Miembro GEP*</label></span>
                                    <input type="text" class="form-control" value="" id="nombre_apellidos_miembroGEP" required  name="dictamen_grupo_expertos_inf_etapa[nombre_apellidos_miembroGEP]"  placeholder="Inserte  nombre_apellidos_miembroGEP"  >
                                    <div class="k-invalid-msg" data-for="nombre_apellidos_miembroGEP"></div>
                                </div>
                                </div>
                                        <div class="col-md-4">
                                <div class="input-group margin" id= "div_fecha_dictamen">
                          	<span class="input-group-btn" title=" se define la fecha_dictamen">
                			<label for="fecha_dictamen" class="btn-addons " style="padding-right: 5px;">Fecha Firma Dictámen*</label></span>
                                    <input class="" value="" id="fecha_dictamen" required  name="dictamen_grupo_expertos_inf_etapa[fecha_dictamen]"  placeholder="Inserte  fecha_dictamen"  >
                                    <div class="k-invalid-msg" data-for="fecha_dictamen"></div>
                                </div>
                                </div>
                                </div>
                                </div>

                                <div class="input-group margin" id= "div_conclusiones">
                          	<span class="input-group-btn" title=" se define lconclusiones">
                			<label for="conclusiones" class="btn-addons " style="padding-right: 5px;">Conclusiones*</label></span>
                                    <ul class="fieldlist">

                                            <input type="radio" value="Certificar" name="dictamen_grupo_expertos_inf_etapa[conclusiones]" id="certificado1" class="k-radio" checked="checked" >
                                            <label class="k-radio-label" for="certificado1">Certificar</label>

                                        <div class="pull-right"> <strong style="border-right-width: inherit">el informe</strong> </div>

                                            <input type="radio" value="No Certificar" name="dictamen_grupo_expertos_inf_etapa[conclusiones]" id="certificado2" class="k-radio">
                                            <label class="k-radio-label" for="certificado2">No Certificar</label>
                                       

                                    </ul>


                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">

                                <div class="input-group margin" id= "div_recomendaciones">
                          	<span class="input-group-btn" title=" se define lrecomendaciones">
                			<label for="recomendaciones" class="btn-addons " style="padding-right: 5px;">Recomendaciones</label></span>
                                    <textarea class="form-control" value="" id="recomendaciones"   name="dictamen_grupo_expertos_inf_etapa[recomendaciones]"  placeholder="Inserte  recomendaciones"  ></textarea>
                                    <div class="k-invalid-msg" data-for="recomendaciones"></div>
                                </div>
                                </div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">

                                        <div class="input-group margin" id= "div_observaciones">
                          	<span class="input-group-btn" title=" se define lobservaciones">
                			<label for="observaciones" class="btn-addons " style="padding-right: 5px;">Observaciones</label></span>
                                    <textarea class="form-control" value="" id="observaciones"   name="dictamen_grupo_expertos_inf_etapa[observaciones]"  placeholder="Inserte  observaciones" ></textarea>
                                    <div class="k-invalid-msg" data-for="observaciones"></div>
                                </div>
                                </div>
                                </div>
                                </div>


                                <input class="text-input"  value="" type="hidden" id="taskdictamen_grupo_expertos_inf_etapa">
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
        <div id="exe_program" class="tab-pane ">


            <div>



                <section class="content-header">
                    <h1>
                        Gestionar Informe de Ejecución del Programa
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_informe_ejecucion_programa" data-toggle='tooltip' title='informe_ejecucion_programa_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_informe_ejecucion_programa" data-toggle='tooltip' title='informe_ejecucion_programa_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_informe_ejecucion_programa"  style="width:100%"></div>
                </div>

                <div id="informe_ejecucion_programa_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_informe_ejecucion_programasave_exit" class="btn  btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_informe_ejecucion_programasave_new" class="btn btn-primary">Guardar y Crear</button>

                        </div>

                        <form role="form" method="post" id="informe_ejecucion_programa_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_etapa">
                          	<span class="input-group-btn" title=" se define letapa">
                			<label for="etapa" class="btn-addons " style="padding-right: 5px;">Etapa*</label></span>
                                    <ul class="fieldlist">

                                            <input type="radio" value="junio" name="informe_ejecucion_programa[etapa]" id="etapaE1" class="k-radio" checked="checked">
                                            <label class="k-radio-label" for="etapaE1">Junio</label>

                                            <input type="radio" value="diciembre" name="informe_ejecucion_programa[etapa]" id="etapaE2" class="k-radio">
                                            <label class="k-radio-label" for="etapaE2">Diciembre</label>
                                       

                                    </ul>
                                </div>
                                </div>
                                </div>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                <div class="input-group margin" id= "div_id_programa">
                          	<span class="input-group-btn" title=" se define lid_programa">
                			<label for="id_programa" class="btn-addons " style="padding-right: 5px;">Programa*</label></span>
                                    <input class="form-control" value="" id="id_programa_ejecucion" required  name="informe_ejecucion_programa[id_programa]"  placeholder="Inserte  id_programa"  >
                                    <div class="k-invalid-msg" data-for="id_programa_ejecucion"></div>
                                </div>
                                </div>
                                    <div class="col-md-4">

                            <div class="input-group margin" id= "div_fecha_informe">
                          	<span class="input-group-btn" title=" se define lfecha_informe">
                			<label for="fecha_informe" class="btn-addons " style="padding-right: 5px;">Fecha Informe*</label></span>
                                <input class="" value="" id="fecha_informe" required  name="informe_ejecucion_programa[fecha_informe]"  placeholder="Inserte  fecha_informe"  >
                                <div class="k-invalid-msg" data-for="fecha_informe"></div>
                            </div>
                            </div>
                            </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                <div class="input-group margin" id= "div_cumplimiento_objtvs_propuestos">
                          	<span class="input-group-btn" title=" se define lcumplimiento_objtvs_propuestos">
                			<label for="cumplimiento_objtvs_propuestos" class="btn-addons " style="padding-right: 5px;">Cumplimiento Objetivos Propuestos*</label></span>
                                    <textarea class="form-control" value="" id="cumplimiento_objtvs_propuestos" required  name="informe_ejecucion_programa[cumplimiento_objtvs_propuestos]"  placeholder="Inserte  cumplimiento_objtvs_propuestos"  ></textarea>
                                    <div class="k-invalid-msg" data-for="cumplimiento_objtvs_propuestos"></div>
                                </div>
                                </div>
                                </div>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">
                                <div class="input-group margin" id= "div_cumplimiento_resultados_programados">
                          	<span class="input-group-btn" title=" se define lcumplimiento_resultados_programados">
                			<label for="cumplimiento_resultados_programados" class="btn-addons " style="padding-right: 5px;">Cumplimiento Resultados Programados*</label></span>
                                    <textarea class="form-control" value="" id="cumplimiento_resultados_programados" required  name="informe_ejecucion_programa[cumplimiento_resultados_programados]"  placeholder="Inserte  cumplimiento_resultados_programados"  ></textarea>
                                    <div class="k-invalid-msg" data-for="cumplimiento_resultados_programados"></div>
                                </div>
                                </div>
                                </div>
                                </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                <div class="input-group margin" id= "div_nivel_ejecucion_presupuesto">
                          	<span class="input-group-btn" title=" se define lnivel_ejecucion_presupuesto">
                			<label for="nivel_ejecucion_presupuesto" class="btn-addons " style="padding-right: 5px;">Nivel Ejecución Presupuesto*</label></span>
                                    <textarea class="form-control" value="" id="nivel_ejecucion_presupuesto" required  name="informe_ejecucion_programa[nivel_ejecucion_presupuesto]"  placeholder="Inserte  nivel_ejecucion_presupuesto" type="text" ></textarea>
                                    <div class="k-invalid-msg" data-for="nivel_ejecucion_presupuesto"></div>
                                </div>
                                </div>
                                </div>
                                </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                <div class="input-group margin" id= "div_principales_dificultades">
                          	<span class="input-group-btn" title=" se define lprincipales_dificultades">
                			<label for="principales_dificultades" class="btn-addons " style="padding-right: 5px;">Principales Dificultades*</label></span>
                                    <textarea class="form-control" value="" id="principales_dificultades" required  name="informe_ejecucion_programa[principales_dificultades]"  placeholder="Inserte  principales_dificultades" ></textarea>
                                    <div class="k-invalid-msg" data-for="principales_dificultades"></div>
                                </div>
                                </div>
                                </div>
                                </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">
                                <div class="input-group margin" id= "div_conclusiones_recomendaciones">
                          	<span class="input-group-btn" title=" se define lconclusiones_recomendaciones">
                			<label for="conclusiones_recomendaciones" class="btn-addons " style="padding-right: 5px;">Conclusiones Recomendaciones*</label></span>
                                    <textarea class="form-control" value="" id="conclusiones_recomendaciones" required  name="informe_ejecucion_programa[conclusiones_recomendaciones]"  placeholder="Inserte  conclusiones_recomendaciones"></textarea>
                                    <div class="k-invalid-msg" data-for="conclusiones_recomendaciones"></div>
                                </div>
                                </div>
                                </div>
                                </div>



                                <input class="text-input"  value="" type="hidden" id="taskinforme_ejecucion_programa">
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