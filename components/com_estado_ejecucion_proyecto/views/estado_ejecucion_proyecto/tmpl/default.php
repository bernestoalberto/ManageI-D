<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');

$componentbase = $this->_basePath;

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Estado Ejecución</title>

</head>
<body class="skin-blue sidebar-mini">
<div class="nav-tabs-custom">
    <ul class="nav nav-tabs">
        <li ><a data-toggle="tab" href="#prioridad">Prioridad</a></li>
        <li  ><a data-toggle="tab" href="#indics">Indicador Impacto</a></li>
        <li  ><a data-toggle="tab" href="#entities">Entidad</a></li>
        <li><a data-toggle="tab" href="#provincia">Provincia</a></li>
        <li><a data-toggle="tab" href="#degree">Grado Científico</a></li>
        <li><a data-toggle="tab" href="#catek">Categoria Científica</a></li>
        <li><a data-toggle="tab" href="#clasify">Clasificación</a></li>
        <li><a data-toggle="tab" href="#typeproy">Tipo Proyecto</a></li>
        <li  ><a data-toggle="tab" href="#eval">Evaluación</a></li>
        <li ><a data-toggle="tab" href="#delivery">Forma Entrega</a></li>
        <li class="active"><a data-toggle="tab" href="#state">Estado Ejecución</a></li>
        <li ><a data-toggle="tab" href="#problems">Problema Detectado</a></li>

    </ul>
    <div class="tab-content">
        <div id="prioridad" class="tab-pane ">
            <div >

                <section class="content-header">
                    <h3>
	<span class = "step size-32">
                        Gestionar Prioridad </h3>
                    <ol class="breadcrumb">

                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_prioridad" data-toggle='tooltip' title='' >
                                <i class="icon ion-android-add-circle"></i> Definir</button>

                            <button class="btn bg-red  btn-action" id="deletebutton_prioridad"  data-toggle='tooltip' title='provincia_delete'>
                                <i class="fa fa-trash"></i>  Eliminar</button>
                        </div>


                    </ol>
                </section>
                </br>

                <div class="content box box-primary" id ="pdf_prioridad">

                    <div id="gridselection_prioridad" style="width:100%"></div>
                </div>

                <div id="prioridad_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">

                            <button type="button" id="prioridad_save_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="prioridad_save_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" id="prioridad_form" class="form-validate" method="post">
                            <div class="box-body">

                                <div class="input-group margin" id="div_problema">
                			<span class="input-group-btn" title="Se define el problema a resolver para un programa o un proyecto no asociado a programa.">
                		        <label class="btn-addons "  style="padding-right: 5px;">Problema*</label>
            				</span>
            				<textarea  id="problema" required  name="prioridad[problema]" class="form-control"
                                       placeholder="Introduzca el problema"  rows ="3" cols="63"></textarea>
                                    <div class="k-invalid-msg" data-for="problema"></div>
                                </div>


                                <input class="text-input"  value="" type="hidden" id="taskprioridad">
                            </div>
                            <?php echo JHtml::_('form.token'); ?>
                        </form>
                    </div>



                </div>
            </div>

        </div><!-- /.tab-pane -->
        <div id="indics" class="tab-pane ">

            <div >

                <section class="content-header">
                    <h1>
                        Indicadores de Impacto
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_indicadores_impacto" data-toggle='tooltip' title='indicadores_impacto' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_indicadores_impacto"  data-toggle='tooltip' title='provincia_delete'>
                                <i class="fa fa-trash"></i>  Eliminar</button>

                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_indicadores_impacto"  style="width:100%"></div>
                </div>

                <div id="indicadores_impacto_window" style="display: none;" >

                    <div class="box-gestionando box-primary">
                        <div class="box-header" pull="left" >

                            <button type="button" id="accionbtn_save_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_save_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" id="indicadores_impacto_form" class="form-validate" method="post">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_indicador">
                                                	<span class="input-group-btn" title=" se define el indicador de impacto.">
                                                <label class="btn-addons" style="padding-right: 5px;">Indicador*</label></span>
                                    <input class="form-control" value="" id="indicador" required  name="indicadores_impacto[indicador]"
                                           placeholder="defina el indicador de impacto" type="text"  />
                                    <div class="k-invalid-msg" data-for="indicador"></div>
                                </div>

                                <input class="text-input"  value="" type="hidden" id="taskindicadores_impacto"/>

                            </div>
                            <?php echo JHtml::_('form.token'); ?>
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
                        <span class="info-box-text" style="font-size: 10px" id="text-error">Error al realizar la operacion </span>
                    </div><!-- /.info-box-content -->
                </div>
            </div>
        </div>
        <div id="entities" class="tab-pane " >
            <div >
                <section class="content-header">
                    <h1>
                        Gestionar Entidad
                    </h1>

                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_entidad" data-toggle='tooltip' title='entidad' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>

                            <button class="btn bg-red  btn-action" id="deletebutton_entidad"  data-toggle='tooltip' title='provincia_delete'>
                                <i class="fa fa-trash"></i>  Eliminar</button>

                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_entidad"  style="width:100%"></div>
                </div>

                <div id="entidad_window" style="display: none;" >
                    <div class="box-gestionando box-primary">
                        <div class="box-header" pull="left" >

                            <button type="button" id="accionbtn_entidadsave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_entidadsave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" id="entidad_form" class="form-validate" method="post">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_nombre">
                        	<span class="input-group-btn" title=" se define el nombre.">
                       <label for="nombre"  style="padding-right: 5px;" class="btn-addons ">Nombre*</label></span>
                                            <input class="form-control" value="" id="nombre" required  name="entidad[nombre]"  placeholder=" Ingrese el nombre" type="text" />
                                            <div class="k-invalid-msg" data-for="nombre"   validationMessage="Inserte el nombre"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_provincia">
                       	<span class="input-group-btn" title=" se define la provincia.">
                       <label for="id_provincia"  style="padding-right: 5px;" class="btn-addons ">Provincia*</label></span>
                                            <input class="form-control" value="" id="id_provincia" required  name="entidad[id_provincia]"  placeholder=" Escoja la provincia"
                                                   validationMessage="Escoja una provincia"/>
                                            <div class="k-invalid-msg" data-for="id_provincia"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="input-group margin" id= "div_telefono">
                            <span class="input-group-btn" title=" se define el telefono.">
                			<label   style="padding-right: 5px;" class="btn-addons ">Telefono</label></span>
                                    <input class="" value="" id="telefono"   name="entidad[telefono]"  placeholder="inserte el telefono" type="text"
                                           required    validationMessage="Inserte un telefono fijo"/>
                                    <div class="k-invalid-msg" data-for="telefono"></div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">

                                            <div class="input-group margin" id= "div_correo">
                            <span class="input-group-btn" title=" se define el correo electrónico.">
                			<label  style="padding-right: 5px;" class="btn-addons ">Correo*</label></span>
                                                <input class="form-control" value="" id="correo" required  name="entidad[correo]"  placeholder="e.g. myname@example.net" type="email"
                                                       data-email-msg="formato de correo no valido"/>
                                                <div class="k-invalid-msg" data-for="correo"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="input-group margin" id= "div_paginaWeb">
                       	<span class="input-group-btn" title=" se define el sitioWeb.">
                       <label for="paginaWeb"  style="padding-right: 5px;"class="btn-addons ">Sitio Web</label></span>
                                                <input class="form-control" value="" id="paginaWeb"   name="entidad[paginaWeb]"  placeholder=" Ingrese  el sitioWeb" type="text"
                                                       validationMessage="Inserte un sitio web"/>
                                                <div class="k-invalid-msg" data-for="paginaWeb"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="input-group margin" id= "div_direccion">
                            <span class="input-group-btn" title=" se define el direccion.">
                			<label   style="padding-right: 5px;" class="btn-addons ">Dirección*</label></span>
                                    <textarea class="form-control" value="" id="direccion"  required  name="entidad[direccion]"  placeholder="inserte la direccion"
                                              validationMessage="Inserte una direccion" ></textarea>
                                                    <div class="k-invalid-msg" data-for="direccion"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="input-group margin" id= "div_vision">
                       	<span class="input-group-btn" title=" se define la vision.">
                       <label for="vision"  style="padding-right: 5px;"class="btn-addons ">Visión</label></span>
                                                    <textarea class="form-control" value="" id="vision"   name="entidad[vision]"  placeholder=" Ingrese la vision" ></textarea>
                                                    <div class="k-invalid-msg" data-for="vision"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="input-group margin" id= "div_mision">
                       	<span class="input-group-btn" title=" se define la mision.">
                       <label for="mision"  style="padding-right: 5px;"class="btn-addons ">Misión</label></span>
                                                    <textarea class="form-control" value="" id="mision"   name="entidad[mision]"  placeholder=" Ingrese la mision" ></textarea>
                                                    <div class="k-invalid-msg" data-for="mision"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <input class="form-control"  value="" type="hidden" id="taskentidad">
                                </div>

                                <?php echo JHtml::_('form.token');?>
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
        </div>
        <div id="provincia" class="tab-pane ">

            <div >
                <section class="content-header">
                    <h1>
                        Gestionar Provincia
                    </h1>

                    <ol class="breadcrumb">
                        <div class="btn-group" pull="left">
                            <button class="btn btn-action" id="addbutton_provincia" data-toggle='tooltip' title='provincia_add' >
                                <i class="fa fa-edit"></i> Nueva</button>

                            <button class="btn bg-red  btn-action" id="deletebutton_provincia"  data-toggle='tooltip' title='provincia_delete'>
                                <i class="fa fa-trash"></i>  Eliminar</button>
                        </div>

                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_provincia"  style="width:100%"></div>
                </div>

                <div id="provincia_window" style="display: none;" >
                    <div class="box-gestionando box-primary">
                        <div class="box-header">

                            <button type="button" id="accionbtn_provinciasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_provinciasave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" id="provincia_form" method="post" class="form-validate">
                            <div class="box-body">

                                <div class="input-group margin" id= "div_id_provincia">
                       	<span class="input-group-btn" title=" se define la provincia.">
                       <label for="nombre_provincia"  style="padding-right: 5px;" class="btn-addons ">Provincia*</label></span>
                                    <input class="form-control" value="" id="nombre_provincia" required  name="provincia[nombre_provincia]"  placeholder=" Ingrese la provincia"
                                           validationMessage="Inserte una provincia"/>
                                    <div class="k-invalid-msg" data-for="nombre_provincia"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskprovincia">


                            </div>
                            <?php  echo JHtml::_('form.token');  ?>
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
        </div>
        <div id="degree" class="tab-pane ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Grado Científico
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_grado_cientifico" data-toggle='tooltip' title='grado_cientifico_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_grado_cientifico" data-toggle='tooltip' title='grado_cientifico_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_grado_cientifico"  style="width:100%"></div>
                </div>

                <div id="grado_cientifico_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_grado_cientificosave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_grado_cientificosave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="grado_cientifico_form" class="form-validate">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_grado">
                          	<span class="input-group-btn" title=" se define lgrado">
                			<label for="grado" class="btn-addons " style="padding-right: 5px;">Grado*</label></span>
                                    <input class="form-control" value="" id="grado" required  name="grado_cientifico[grado]"  placeholder="Inserte  grado" type="text" >
                                    <div class="k-invalid-msg" data-for="grado"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskgrado_cientifico">
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
        <div id="catek" class="tab-pane ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Categoria Científica
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_cat_cientifica" data-toggle='tooltip' title='cat_cientifica_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_cat_cientifica" data-toggle='tooltip' title='cat_cientifica_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_cat_cientifica"  style="width:100%"></div>
                </div>

                <div id="cat_cientifica_window" style="display: none;" >



                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_cat_cientificasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_cat_cientificasave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="cat_cientifica_form" class="form-validate">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_categoria">
                          	<span class="input-group-btn" title=" se define lcategoria">
                			<label for="categoria" class="btn-addons " style="padding-right: 5px;">Categoria*</label></span>
                                    <input class="form-control" value="" id="categoria" required  name="cat_cientifica[categoria]"  placeholder="Inserte  categoria" type="text" >
                                    <div class="k-invalid-msg" data-for="categoria"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskcat_cientifica">
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
        <div id="clasify" class="tab-pane ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Clasificación
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_clasificacion" data-toggle='tooltip' title='clasificacion_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_clasificacion" data-toggle='tooltip' title='clasificacion_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_clasificacion"  style="width:100%"></div>
                </div>

                <div id="clasificacion_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_clasificacionsave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_clasificacionsave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="clasificacion_form" class="form-validate">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_nombre_clasificacion">
                          	<span class="input-group-btn" title=" se define lnombre_clasificacion">
                			<label for="nombre_clasificacion" class="btn-addons " style="padding-right: 5px;">Nombre Clasificación*</label></span>
                                    <input class="form-control" value="" id="nombre_clasificacion" required  name="clasificacion[nombre_clasificacion]"  placeholder="Inserte  nombre_clasificacion" type="text" >
                                    <div class="k-invalid-msg" data-for="nombre_clasificacion"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskclasificacion">
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

        <div id="typeproy" class="tab-pane ">
            <div >
                <section class="content-header">
                    <h1>
                        Gestionar Tipo de Proyecto
                    </h1>
                    <ol class="breadcrumb">
                        <button class="btn btn-action" id="addbutton_tipo_proyecto" data-toggle='tooltip' title='tipo_proyecto_add' >
                            <i class="fa fa-edit"></i> Nuevo
                        </button>
                        <button class="btn bg-red  btn-action" id="deletebutton_tipo_proyecto" data-toggle='tooltip' title='tipo_proyecto_delete' >
                            <i class="fa fa-trash"></i> Eliminar
                        </button>

                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_tipo_proyecto"  style="width:100%"></div>
                </div>

                <div id="tipo_proyecto_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_tipo_proyectosave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_tipo_proyectosave_new" class="btn btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="tipo_proyecto_form" class="form-validate">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_tipo">
                          	<span class="input-group-btn" title=" se define ltipo">
                			<label for="tipo" class="btn-addons " style="padding-right: 5px;">Tipo*</label></span>
                                    <input class="form-control" value="" id="tipo" required  name="tipo_proyecto[tipo]"  placeholder="Inserte  tipo" type="text" >
                                    <div class="k-invalid-msg" data-for="tipo"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="tasktipo_proyecto">
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

        <div id="eval" class="tab-pane ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Evaluación
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_evaluacion" data-toggle='tooltip' title='evaluacion_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_evaluacion" data-toggle='tooltip' title='evaluacion_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_evaluacion"  style="width:100%"></div>
                </div>

                <div id="evaluacion_window" style="display: none;" >


                    <section class="content-header">
                        <h1>
                            Evaluación
                        </h1>
                    </section>
                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_evaluacionsave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_evaluacionsave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="evaluacion_form" class="form-validate">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_evaluacion">
                          	<span class="input-group-btn" title=" se define levaluacion">
                			<label for="evaluacion" class="btn-addons " style="padding-right: 5px;">Evaluación*</label></span>
                                    <input class="form-control" value="" id="evaluacion" required  name="evaluacion[evaluacion]"  placeholder="Inserte  evaluacion" type="text" >
                                    <div class="k-invalid-msg" data-for="evaluacion"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskevaluacion">
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
        <div id="delivery" class="tab-pane ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Forma de Entrega
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">

                            <button class="btn btn-action" id="addbutton_forma_entrega" data-toggle='tooltip' title='forma_entrega_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_forma_entrega" data-toggle='tooltip' title='forma_entrega_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_forma_entrega"  style="width:100%"></div>
                </div>

                <div id="forma_entrega_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_forma_entregasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_forma_entregasave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="forma_entrega_form" class="form-validate">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_informe">
                          	<span class="input-group-btn" title=" se define linforme">
                			<label for="informe" class="btn-addons " style="padding-right: 5px;">Informe*</label></span>
                                    <input class="form-control" value="" id="informe" required  name="forma_entrega[informe]"  placeholder="Inserte  informe" type="text" >
                                    <div class="k-invalid-msg" data-for="informe"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskforma_entrega">
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
        <div id="state" class="tab-pane active">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Estado Ejecución del Proyecto
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_estado_ejecucion_proyecto" data-toggle='tooltip' title='estado_ejecucion_proyecto_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_estado_ejecucion_proyecto" data-toggle='tooltip' title='estado_ejecucion_proyecto_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_estado_ejecucion_proyecto"  style="width:100%"></div>
                </div>

                <div id="estado_ejecucion_proyecto_window" style="display: none;" >
                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_estado_ejecucion_proyectosave_exit" class="btn  btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_estado_ejecucion_proyectosave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="estado_ejecucion_proyecto_form" class="form-validate">
                            <div class="box-body">
                                <div class="input-group margin" id= "div_id_estado_ejecucion_proyecto">

                                    <input class="form-control" value="" id="id_estado_ejecucion_proyecto"   name="estado_ejecucion_proyecto[id_estado_ejecucion_proyecto]" type="hidden" />
                                </div>


                                <div class="input-group margin" id= "div_nombre_estado_ejecucion_proyecto">
                          	<span class="input-group-btn" title=" se define el estado de ejecucion del proyecto">
                			<label for="nombre_estado_ejecucion_proyecto" class="btn-addons " style="padding-right: 5px;">Estado_Ejecución*</label></span>
                                    <input class="form-control" value="" id="nombre_estado_ejecucion_proyecto" required  name="estado_ejecucion_proyecto[nombre_estado_ejecucion_proyecto]"  placeholder="Inserte  nombre_estado_ejecucion_proyecto" type="text" >
                                    <div class="k-invalid-msg" data-for="nombre_estado_ejecucion_proyecto"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskestado_ejecucion_proyecto">
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
        <div id="problems" class="tab-pane  ">
            <div >



                <section class="content-header">
                    <h1>
                        Gestionar Problemas Detectados
                    </h1>
                    <ol class="breadcrumb">
                        <div class="btn-group">
                            <button class="btn btn-action" id="addbutton_problemas_detectados" data-toggle='tooltip' title='problemas_detectados_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_problemas_detectados" data-toggle='tooltip' title='problemas_detectados_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>
                        </div>
                    </ol>
                </section>
                </br>
                <div class="content box box-primary">
                    <div id="gridselection_problemas_detectados"  style="width:100%"></div>
                </div>

                <div id="problemas_detectados_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_problemas_detectadossave_exit" class="btn  btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_problemas_detectadossave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" method="post" id="problemas_detectados_form" class="form-validate">
                            <div class="box-body">


                                <div class="input-group margin" id= "div_problema">
                          	<span class="input-group-btn" title=" se define lproblema">
                			<label for="problema" class="btn-addons " style="padding-right: 5px;">Problema*</label></span>
                                    <textarea class="form-control" value="" id="problema" required  name="problemas_detectados[problema]"  placeholder="Inserte  problema"  ></textarea>
                                    <div class="k-invalid-msg" data-for="problema"></div>
                                </div>

                                <input class="form-control"  value="" type="hidden" id="taskproblemas_detectados">
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


