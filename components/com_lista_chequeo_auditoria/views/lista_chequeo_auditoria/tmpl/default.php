<?php
defined('_JEXEC') or die('acceso no autorizado');

$componentbase = $this->_basePath;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>PLAN DE Auditoria</title>
    <script type="text/x-kendo-template" id="template_plan_auditoria">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Programa:</label>#= programa #</li>
                        <li><label>Objetivos Alcance:</label>#= objetivos_alcance #</li>
                        <li><label>Director Entidad:</label>#= director_entidad #</li>
                        <li><label>Equipo Auditor:</label>#= equipo_auditor #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>
    <script type="text/x-kendo-template" id="template_programa_auditoria">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Dia:</label>#= dia #</li>
                        <li><label>Aspectos Evaluar:</label>#= aspectos_evaluar#</li>
                        <li><label>Fecha Reunión Apertura:</label>#= fecha_reunion_apertura #</li>
                        <li><label>Lugar Reunión apertura:</label>#= lugar_reunion_apertura #</li>
                        <li><label>Fecha Reunión Auditores:</label>#= fecha_reunion_auditores #</li>
                        <li><label>Lugar Reunión Auditores:</label>#= lugar_reunion_auditores #</li>
                        <li><label>Fecha Reunión Clausura:</label>#= fecha_reunion_clausura #</li>
                        <li><label>Lugar Reunión Clausura:</label>#= lugar_reunion_clausura #</li>
                        <li><label>Comunica:</label>#= comunica #</li>
                        <li><label>Fecha Comunica:</label>#= fecha_comunica #</li>
                        <li><label>Programa:</label>#= programa #</li>
                        <li><label>Enterado:</label>#= nombre_enterado #</li>
                        <li><label> Auditor:</label>#= nombre_auditor #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>
    <script type="text/x-kendo-template" id="template_lista_chequeo">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Texto:</label>#= texto #</li>

                    </ul>
                </div>
            </div>
        </div>

    </script>
    <script type="text/x-kendo-template" id="template_evidencias_objetivas">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Deficiencias Evidencias:</label>#= deficiencias_evidencias #</li>
                        <li><label>Documento:</label>#= documento #</li>


                    </ul>
                </div>
            </div>
        </div>

    </script>
    <script type="text/x-kendo-template" id="template_informe_auditoria">
        <div class="tabstrip">

            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Objetivos:</label>#= objetivos #</li>
                        <li><label>Alcance:</label>#= alcance #</li>
                        <li><label>Auditor Lider:</label>#= auditor_lider #</li>
                        <li><label>Equipo Auditor:</label>#= equipo_auditor #</li>
                        <li><label>Documentación Revisada:</label>#= documentacion_revisada #</li>
                        <li><label>Personal Entrevistado:</label>#= personal_entrevistado #</li>
                        <li><label>Opinión Equipo Auditor:</label>#= opinion_equipo_auditor #</li>
                        <li><label>No Conformidades Detectadas:</label>#= no_conformidades_detectadas #</li>
                        <li><label>Observaciones:</label>#= observaciones #</li>
                        <li><label>Elaborado por:</label>#= elaborado_por #</li>

                    </ul>
                </div>
            </div>
        </div>

    </script>
</head>
<body class="skin-blue sidebar-mini">
<div class="nav-tabs-custom">
    <ul class="nav nav-tabs">
        <li ><a data-toggle="tab" href="#plan">Planificación AUDITORIA</a></li>
        <li ><a data-toggle="tab" href="#prog">Programa AUDITORIA</a></li>
        <li class="active"><a data-toggle="tab" href="#lista">LISTA CHEQUEO</a></li>
        <li><a data-toggle="tab" href="#proof">EVIDENCIAS OBJETIVAS</a></li>
        <li><a data-toggle="tab" href="#report">INFORME AUDITORIA</a></li>

    </ul>
    <div class="tab-content">
        <div id="plan" class="tab-pane ">

            <section class="content-header">
                <h1>
                    Gestionar Plan de Auditoria
                </h1>
                <ol class="breadcrumb">
                    <div class="btn-group">
                        <button class="btn btn-action" id="addbutton_plan_auditoria" data-toggle='tooltip' title='plan_auditoria_add' >
                            <i class="fa fa-edit"></i> Nuevo
                        </button>
                        <button class="btn bg-red  btn-action" id="deletebutton_plan_auditoria" data-toggle='tooltip' title='plan_auditoria_delete' >
                            <i class="fa fa-trash"></i> Eliminar
                        </button>
                    </div>
                </ol>
            </section>
            </br>
            <div class="content box box-primary">
                <div id="gridselection_plan_auditoria"  style="width:100%"></div>
            </div>

            <div id="plan_auditoria_window" style="display: none;" >


                <section class="content-header">
                    <h1>
                        Plan de Auditoria
                    </h1>
                </section>
                <div class="box-gestionando box-primary">

                    <div class="box-header">
                        <button type="button" id="accionbtn_plan_auditoriasave_exit" class="btn btn-primary">Guardar y Salir</button>
                        <button type="button" id="accionbtn_plan_auditoriasave_new" class="btn btn-primary">Guardar y Crear</button>
                    </div>

                    <form role="form" method="post" id="plan_auditoria_form" class="form-validate">
                        <div class="box-body">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
                                            <input class="form-control" value="" id="id_proyecto" required  name="plan_auditoria[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
                                            <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_plan">
                          	<span class="input-group-btn" title="Donde se define lfecha_plan">
                			<label for="fecha_plan" class="btn-addons " style="padding-right: 5px;">Fecha Plan*</label></span>
                                            <input class="form-control" value="" id="fecha_plan" required  name="plan_auditoria[fecha_plan]"  placeholder="Inserte  fecha_plan"  >
                                            <div class="k-invalid-msg" data-for="fecha_plan"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_cumplimiento">
                          	<span class="input-group-btn" title="Donde se define lfecha_cumplimiento">
                			<label for="fecha_cumplimiento" class="btn-addons " style="padding-right: 5px;">Fecha Cumplimiento*</label></span>
                                            <input class="form-control" value="" id="fecha_cumplimiento" required  name="plan_auditoria[fecha_cumplimiento]"  placeholder="Inserte  fecha_cumplimiento"  >
                                            <div class="k-invalid-msg" data-for="fecha_cumplimiento"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_director_entidad">
                          	<span class="input-group-btn" title="Donde se define ldirector_entidad">
                			<label for="director_entidad" class="btn-addons " style="padding-right: 5px;">Director Entidad*</label></span>
                                                <input class="form-control" value="" id="director_entidad" required  name="plan_auditoria[director_entidad]"  placeholder="Inserte  director_entidad" type="text" >
                                                <div class="k-invalid-msg" data-for="director_entidad"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="input-group margin" id= "div_objetivos_alcance">
                          	<span class="input-group-btn" title="Donde se define lobjetivos_alcance">
                			<label for="objetivos_alcance" class="btn-addons " style="padding-right: 5px;">Objetivos Alcance*</label></span>
                                                <textarea class="form-control" value="" id="objetivos_alcance" required  name="plan_auditoria[objetivos_alcance]"  placeholder="Inserte  objetivos_alcance"></textarea>
                                                <div class="k-invalid-msg" data-for="objetivos_alcance"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="input-group margin" id= "div_equipo_auditor">
                          	<span class="input-group-btn" title="Donde se define lequipo_auditor">
                			<label for="equipo_auditor" class="btn-addons " style="padding-right: 5px;">Equipo Auditor*</label></span>
                                                <textarea class="form-control" value="" id="equipo_auditor" required  name="plan_auditoria[equipo_auditor]"  placeholder="Inserte  equipo_auditor" ></textarea>
                                                <div class="k-invalid-msg" data-for="equipo_auditor"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input class="text-input"  value="" type="hidden" id="taskplan_auditoria">
                        </div>
                        <?php echo JHtml::_('form.token');  ?>
                    </form>
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
        <div id="prog" class="tab-pane  ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar    Programa  Auditoria
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_auditoria" data-toggle='tooltip' title='auditoria_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_auditoria" data-toggle='tooltip' title='auditoria_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_auditoria"  style="width:100%"></div>
                </div>

                <div id="auditoria_window" style="display: none;" >


                    <section class="content-header">
                        <h1>
                            Programa  Auditoria
                        </h1>
                    </section>
                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_auditoriasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_auditoriasave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="auditoria_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">

                                        <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
                                            <input class="form-control" value="" id="id_proyecto" required  name="auditoria[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
                                            <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_auditoria">
                          	<span class="input-group-btn" title="Donde se define lfecha_auditoria">
                			<label for="fecha_auditoria" class="btn-addons " style="padding-right: 5px;">Fecha Auditoria*</label></span>
                                            <input class="form-control" value="" id="fecha_auditoria" required  name="auditoria[fecha_auditoria]"  placeholder="Inserte  fecha_auditoria"  >
                                            <div class="k-invalid-msg" data-for="fecha_auditoria"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">

                                        <div class="input-group margin" id= "div_lugar_reunion_apertura">
                          	<span class="input-group-btn" title="Donde se define llugar_reunion_apertura">
                			<label for="lugar_reunion_apertura" class="btn-addons " style="padding-right: 5px;">Lugar Reunión Apertura*</label></span>
                                            <input class="form-control" value="" id="lugar_reunion_apertura" required  name="auditoria[lugar_reunion_apertura]"  placeholder="Inserte  lugar_reunión_apertura" type="text" >
                                            <div class="k-invalid-msg" data-for="lugar_reunion_apertura"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_reunion_apertura">
                          	<span class="input-group-btn" title="Donde se define lfecha_reunion_apertura">
                			<label for="fecha_reunion_apertura" class="btn-addons " style="padding-right: 5px;">Fecha Reunión Apertura*</label></span>
                                            <input class="form-control" value="" id="fecha_reunion_apertura" required  name="auditoria[fecha_reunion_apertura]"  placeholder="Inserte  fecha_reunión_apertura"  >
                                            <div class="k-invalid-msg" data-for="fecha_reunion_apertura"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_nombre_auditor">
                          	<span class="input-group-btn" title="Donde se define lnombre_auditor">
                			<label for="nombre_auditor" class="btn-addons " style="padding-right: 5px;">Nombre Auditor*</label></span>
                                                <input class="form-control" value="" id="nombre_auditor" required  name="auditoria[nombre_auditor]"  placeholder="Inserte  nombre_auditor" type="text" >
                                                <div class="k-invalid-msg" data-for="nombre_auditor"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_dia">
                          	<span class="input-group-btn" title="Donde se define ldia">
                			<label for="dia" class="btn-addons " style="padding-right: 5px;">Dia*</label></span>
                                                <input class="form-control" value="" id="dia"   name="auditoria[dia]"  placeholder="Inserte  dia" type="text" >
                                                <div class="k-invalid-msg" data-for="dia"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                            <div class="input-group margin" id= "div_lugar_reunion_auditores">
                          	<span class="input-group-btn" title="Donde se define llugar_reunion_auditores">
                			<label for="lugar_reunion_auditores" class="btn-addons " style="padding-right: 5px;">Lugar Reunión Auditores*</label></span>
                                                <input class="form-control" value="" id="lugar_reunion_auditores"   name="auditoria[lugar_reunion_auditores]"  placeholder="Inserte  lugar_reunión_auditores" type="text" >
                                                <div class="k-invalid-msg" data-for="lugar_reunion_auditores"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_fecha_reunion_auditores">
                          	<span class="input-group-btn" title="Donde se define lfecha_reunion_auditores">
                			<label for="fecha_reunion_auditores" class="btn-addons " style="padding-right: 5px;">Fecha Reunión Auditores*</label></span>
                                                <input class="form-control" value="" id="fecha_reunion_auditores" required  name="auditoria[fecha_reunion_auditores]"  placeholder="Inserte  fecha_reunión_auditores"  >
                                                <div class="k-invalid-msg" data-for="fecha_reunion_auditores"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                            <div class="input-group margin" id= "div_lugar_reunion_clausura">
                          	<span class="input-group-btn" title="Donde se define llugar_reunion_clausura">
                			<label for="lugar_reunion_clausura" class="btn-addons " style="padding-right: 5px;">Lugar Reunión Clausura*</label></span>
                                                <input class="form-control" value="" id="lugar_reunion_clausura" required  name="auditoria[lugar_reunion_clausura]"  placeholder="Inserte  lugar_reunión_clausura" type="text" >
                                                <div class="k-invalid-msg" data-for="lugar_reunion_clausura"></div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_fecha_reunion_clausura">
                          	<span class="input-group-btn" title="Donde se define lfecha_reunion_clausura">
                			<label for="fecha_reunion_clausura" class="btn-addons " style="padding-right: 5px;">Fecha Reunión Clausura*</label></span>
                                                <input class="form-control" value="" id="fecha_reunion_clausura" required  name="auditoria[fecha_reunion_clausura]"  placeholder="Inserte  fecha_reunión_clausura"  >
                                                <div class="k-invalid-msg" data-for="fecha_reunion_clausura"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                            <div class="input-group margin" id= "div_nombre_enterado">
                          	<span class="input-group-btn" title="Donde se define lnombre_enterado">
                			<label for="nombre_enterado" class="btn-addons " style="padding-right: 5px;">Nombre Enterado*</label></span>
                                                <input class="form-control" value="" id="nombre_enterado" required  name="auditoria[nombre_enterado]"  placeholder="Inserte  nombre_enterado" type="text" >
                                                <div class="k-invalid-msg" data-for="nombre_enterado"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_fecha_enterado">
                          	<span class="input-group-btn" title="Donde se define lfecha_enterado">
                			<label for="fecha_enterado" class="btn-addons " style="padding-right: 5px;">Fecha Enterado*</label></span>
                                                <input class="form-control" value="" id="fecha_enterado" required  name="auditoria[fecha_enterado]"  placeholder="Inserte  fecha_enterado"  >
                                                <div class="k-invalid-msg" data-for="fecha_enterado"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_comunica">
                          	<span class="input-group-btn" title="Donde se define lcomunica">
                			<label for="comunica" class="btn-addons " style="padding-right: 5px;">Comunica*</label></span>
                                                <input class="form-control" value="" id="comunica" required  name="auditoria[comunica]"  placeholder="Inserte  comunica" type="text" >
                                                <div class="k-invalid-msg" data-for="comunica"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_fecha_comunica">
                          	<span class="input-group-btn" title="Donde se define lfecha_comunica">
                			<label for="fecha_comunica" class="btn-addons " style="padding-right: 5px;">Fecha Comunica*</label></span>
                                                <input class="form-control" value="" id="fecha_comunica" required  name="auditoria[fecha_comunica]"  placeholder="Inserte  fecha_comunica"  >
                                                <div class="k-invalid-msg" data-for="fecha_comunica"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">

                                            <div class="input-group margin" id= "div_aspectos_evaluar">
                          	<span class="input-group-btn" title="Donde se define laspectos_evaluar">
                			<label for="aspectos_evaluar" class="btn-addons " style="padding-right: 5px;">Aspectos Evaluar*</label></span>
                                                <textarea class="form-control" value="" id="aspectos_evaluar" required  name="auditoria[aspectos_evaluar]"  placeholder="Inserte  aspectos_evaluar" ></textarea>
                                                <div class="k-invalid-msg" data-for="aspectos_evaluar"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <input class="text-input"  value="" type="hidden" id="taskauditoria">
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
        <div id="lista" class="tab-pane active">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar  Lista  Chequeo de Auditoria
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_lista_chequeo_auditoria" data-toggle='tooltip' title='lista_chequeo_auditoria_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_lista_chequeo_auditoria" data-toggle='tooltip' title='lista_chequeo_auditoria_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_lista_chequeo_auditoria"  style="width:100%"></div>
                </div>

                <div id="lista_chequeo_auditoria_window" style="display: none;" >


                    <section class="content-header">
                        <h1>
                            Lista  Chequeo de Auditoria
                        </h1>
                    </section>
                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_lista_chequeo_auditoriasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_lista_chequeo_auditoriasave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="lista_chequeo_auditoria_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_nombre_auditor">
                          	<span class="input-group-btn" title="Donde se define lnombre_auditor">
                			<label for="nombre_auditor" class="btn-addons " style="padding-right: 5px;">Nombre Auditor*</label></span>
                                            <input class="form-control" value="" id="nombre_auditor" required  name="lista_chequeo_auditoria[nombre_auditor]"  placeholder="Inserte  nombre_auditor" type="text" >
                                            <div class="k-invalid-msg" data-for="nombre_auditor"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="input-group margin" id= "div_actividad_proceso_evaluar">
                          	<span class="input-group-btn" title="Donde se define lactividad_proceso_evaluar">
                			<label for="actividad_proceso_evaluar" class="btn-addons " style="padding-right: 5px;">Actividad Proceso Evaluar*</label></span>
                                            <input class="form-control" value="" id="actividad_proceso_evaluar" required  name="lista_chequeo_auditoria[actividad_proceso_evaluar]"  placeholder="Inserte  actividad_proceso_evaluar" type="text" >
                                            <div class="k-invalid-msg" data-for="actividad_proceso_evaluar"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">

                                            <div class="input-group margin" id= "div_requisitos_evaluar">
                          	<span class="input-group-btn" title="Donde se define lrequisitos_evaluar">
                			<label for="requisitos_evaluar" class="btn-addons " style="padding-right: 5px;">Requisitos Evaluar*</label></span>
                                                <textarea class="form-control" value="" id="requisitos_evaluar" required  name="lista_chequeo_auditoria[requisitos_evaluar]"  placeholder="Inserte  requisitos_evaluar" ></textarea>
                                                <div class="k-invalid-msg" data-for="requisitos_evaluar"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-8">

                                            <div class="input-group margin" id= "div_observaciones">
                          	<span class="input-group-btn" title="Donde se define lobservaciones">
                			<label for="observaciones" class="btn-addons " style="padding-right: 5px;">Observaciones</label></span>
                                                <textarea class="form-control" value="" id="observaciones"   name="lista_chequeo_auditoria[observaciones]"  placeholder="Inserte  observaciones" ></textarea>
                                                <div class="k-invalid-msg" data-for="observaciones"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <input class="text-input"  value="" type="hidden" id="tasklista_chequeo_auditoria">
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
        <div id="proof" class="tab-pane ">

            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Documentación de Evidencias Objetivas
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_documentacion_evidencias_objetivas" data-toggle='tooltip' title='documentacion_evidencias_objetivas_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_documentacion_evidencias_objetivas" data-toggle='tooltip' title='documentacion_evidencias_objetivas_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_documentacion_evidencias_objetivas"  style="width:100%"></div>
                </div>

                <div id="documentacion_evidencias_objetivas_window" style="display: none;" >


                    <section class="content-header">
                        <h1>
                            Documentación de Evidencias Objetivas
                        </h1>
                    </section>
                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_documentacion_evidencias_objetivassave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_documentacion_evidencias_objetivassave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="documentacion_evidencias_objetivas_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">

                                        <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
                                            <input class="form-control" value="" id="id_proyecto" required  name="documentacion_evidencias_objetivas[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
                                            <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_recogida_info">
                          	<span class="input-group-btn" title="Donde se define lfecha_recogida_info">
                			<label for="fecha_recogida_info" class="btn-addons " style="padding-right: 5px;">Fecha Recogida Info*</label></span>
                                            <input class="form-control" value="" id="fecha_recogida_info" required  name="documentacion_evidencias_objetivas[fecha_recogida_info]"  placeholder="Inserte  fecha_recogida_info"  >
                                            <div class="k-invalid-msg" data-for="fecha_recogida_info"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_documento">
                          	<span class="input-group-btn" title="Donde se define ldocumento">
                			<label for="documento" class="btn-addons " style="padding-right: 5px;">Documento*</label></span>
                                            <input class="form-control" value="" id="documento" required  name="documentacion_evidencias_objetivas[documento]"  placeholder="Inserte  documento" type="text" >
                                            <div class="k-invalid-msg" data-for="documento"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">

                                        <div class="input-group margin" id= "div_nombre_auditor">
                          	<span class="input-group-btn" title="Donde se define lnombre_auditor">
                			<label for="nombre_auditor" class="btn-addons " style="padding-right: 5px;">Nombre Auditor*</label></span>
                                            <input class="form-control" value="" id="nombre_auditor" required  name="documentacion_evidencias_objetivas[nombre_auditor]"  placeholder="Inserte  nombre_auditor" type="text" >
                                            <div class="k-invalid-msg" data-for="nombre_auditor"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_nombre_auditado">
                          	<span class="input-group-btn" title="Donde se define lnombre_auditado">
                			<label for="nombre_auditado" class="btn-addons " style="padding-right: 5px;">Nombre Auditado*</label></span>
                                            <input class="form-control" value="" id="nombre_auditado" required  name="documentacion_evidencias_objetivas[nombre_auditado]"  placeholder="Inserte  nombre_auditado" type="text" >
                                            <div class="k-invalid-msg" data-for="nombre_auditado"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="input-group margin" id= "div_deficiencias_evidencias">
                          	<span class="input-group-btn" title="Donde se define ldeficiencias_evidencias">
                			<label for="deficiencias_evidencias" class="btn-addons " style="padding-right: 5px;">Deficiencias Evidencias*</label></span>
                                            <textarea class="form-control" value="" id="deficiencias_evidencias" required  name="documentacion_evidencias_objetivas[deficiencias_evidencias]"  placeholder="Inserte  deficiencias_evidencias" ></textarea>
                                            <div class="k-invalid-msg" data-for="deficiencias_evidencias"></div>
                                        </div>
                                    </div>
                                </div>


                                <input class="text-input"  value="" type="hidden" id="taskdocumentacion_evidencias_objetivas">
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
        <div id="report" class="tab-pane ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Informe Auditoria
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_informe_auditoria" data-toggle='tooltip' title='informe_auditoria_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_informe_auditoria" data-toggle='tooltip' title='informe_auditoria_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_informe_auditoria"  style="width:100%"></div>
                </div>

                <div id="informe_auditoria_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_informe_auditoriasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_informe_auditoriasave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="informe_auditoria_form" class="form-validate">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">

                                        <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
                                            <input class="form-control" value="" id="id_proyecto" required  name="informe_auditoria[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
                                            <div class="k-invalid-msg" data-for="id_proyecto"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_fecha_confeccion">
                          	<span class="input-group-btn" title="Donde se define lfecha_confeccion">
                			<label for="fecha_confeccion" class="btn-addons " style="padding-right: 5px;">Fecha Confección*</label></span>
                                            <input class="form-control" value="" id="fecha_confeccion" required  name="informe_auditoria[fecha_confeccion]"  placeholder="Inserte  fecha_confeccion"  >
                                            <div class="k-invalid-msg" data-for="fecha_confeccion"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">

                                        <div class="input-group margin" id= "div_auditor_lider">
                          	<span class="input-group-btn" title="Donde se define lauditor_lider">
                			<label for="auditor_lider" class="btn-addons " style="padding-right: 5px;">Auditor Lider*</label></span>
                                            <input type="text" class="form-control" value="" id="auditor_lider" required  name="informe_auditoria[auditor_lider]"  placeholder="Inserte  auditor_lider"/>
                                            <div class="k-invalid-msg" data-for="auditor_lider"></div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">

                                        <div class="input-group margin" id= "div_elaborado_por">
                          	<span class="input-group-btn" title="Donde se define lelaborado_por">
                			<label for="elaborado_por" class="btn-addons " style="padding-right: 5px;">Elaborado Por*</label></span>
                                            <input class="form-control" value="" id="elaborado_por" required  name="informe_auditoria[elaborado_por]"  placeholder="Inserte  elaborado_por" type="text" >
                                            <div class="k-invalid-msg" data-for="elaborado_por"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">


                                        <div class="input-group margin" id= "div_objetivos">
                          	<span class="input-group-btn" title="Donde se define lobjetivos">
                			<label for="objetivos" class="btn-addons " style="padding-right: 5px;">Objetivos*</label></span>
                                            <textarea class="form-control" value="" id="objetivos" required  name="informe_auditoria[objetivos]"  placeholder="Inserte  objetivos"  ></textarea>
                                            <div class="k-invalid-msg" data-for="objetivos"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                        <div class="input-group margin" id= "div_alcance">
                          	<span class="input-group-btn" title="Donde se define lalcance">
                			<label for="alcance" class="btn-addons " style="padding-right: 5px;">Alcance*</label></span>
                                            <textarea class="form-control" value="" id="alcance" required  name="informe_auditoria[alcance]"  placeholder="Inserte  alcance"  ></textarea>
                                            <div class="k-invalid-msg" data-for="alcance"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="input-group margin" id= "div_equipo_auditor">
                          	<span class="input-group-btn" title="Donde se define lequipo_auditor">
                			<label for="equipo_auditor" class="btn-addons " style="padding-right: 5px;">Equipo Auditor*</label></span>
                                            <textarea class="form-control" value="" id="equipo_auditor" required  name="informe_auditoria[equipo_auditor]"  placeholder="Inserte  equipo_auditor" ></textarea>
                                            <div class="k-invalid-msg" data-for="equipo_auditor"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                        <div class="input-group margin" id= "div_documentacion_revisada">
                          	<span class="input-group-btn" title="Donde se define ldocumentacion_revisada">
                			<label for="documentacion_revisada" class="btn-addons " style="padding-right: 5px;">Documentación Revisada*</label></span>
                                            <textarea class="form-control" value="" id="documentacion_revisada" required  name="informe_auditoria[documentacion_revisada]"  placeholder="Inserte  documentacion_revisada"></textarea>
                                            <div class="k-invalid-msg" data-for="documentacion_revisada"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                        <div class="input-group margin" id= "div_personal_entrevistado">
                          	<span class="input-group-btn" title="Donde se define lpersonal_entrevistado">
                			<label for="personal_entrevistado" class="btn-addons " style="padding-right: 5px;">Personal Entrevistado*</label></span>
                                            <textarea class="form-control" value="" id="personal_entrevistado" required  name="informe_auditoria[personal_entrevistado]"  placeholder="Inserte  personal_entrevistado" ></textarea>
                                            <div class="k-invalid-msg" data-for="personal_entrevistado"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                        <div class="input-group margin" id= "div_opinion_equipo_auditor">
                          	<span class="input-group-btn" title="Donde se define lopinion_equipo_auditor">
                			<label for="opinion_equipo_auditor" class="btn-addons " style="padding-right: 5px;">Opinión Equipo Auditor*</label></span>
                                            <textarea class="form-control" value="" id="opinion_equipo_auditor" required  name="informe_auditoria[opinion_equipo_auditor]"  placeholder="Inserte  opinion_equipo_auditor" ></textarea>
                                            <div class="k-invalid-msg" data-for="opinion_equipo_auditor"></div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-8">

                                        <div class="input-group margin" id= "div_observaciones">
                          	<span class="input-group-btn" title="Donde se define lobservaciones">
                			<label for="observaciones" class="btn-addons " style="padding-right: 5px;">Observaciones Recomendaciones</label></span>
                                            <textarea class="form-control" value="" id="observaciones"   name="informe_auditoria[observaciones]"  placeholder="Inserte  observaciones" ></textarea>
                                            <div class="k-invalid-msg" data-for="observaciones"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>





                            <input class="text-input"  value="" type="hidden" id="taskinforme_auditoria">
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

</body>
