<?php

defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');
$componentbase = $this->_basePath;

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Convocatoria</title>

    <script type="text/x-kendo-template" id="template_programa">
        <div class="tabstrip">
            <div>
                <div class="orders"></div>
            </div>
            <div>
                <div class='employee-details'>
                    <ul>
                        <li><label>Secretario Programa:</label>#= secretarioprograma #</li>
                        <li><label>Objetivo General:</label>#= objetivoGeneral #</li>
                        <li><label>Grupo Expertos:</label>#= grupoExpertos #</li>
                        <li><label>Otras Entidades:</label>#= otras_entidades #</li>
                    </ul>
                </div>
            </div>
        </div>

    </script>
    <script type="text/x-kendo-template" id="template_convocatoria">
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
</head>
<body class="skin-blue sidebar-mini">
<div class="nav-tabs-custom">
    <ul class="nav nav-tabs">
        <li  ><a data-toggle="tab" href="#programa">Programa</a></li>
        <li class="active"><a data-toggle="tab" href="#convocatoria">Convocatoria</a></li>

    </ul>
    <div class="tab-content">

        <div id="programa" class="tab-pane ">
            <div  >
                <section class="content-header" >
                    <h1>
                        Gestionar Programa
                    </h1>



                    <div class="btn-group">
                        <ol class="breadcrumb">

                            <button class="btn btn-action" id="addbutton_programa" data-toggle='tooltip' title='programa_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_programa" data-toggle='tooltip' title='programa_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>

                        </ol>
                    </div>

                </section>
                </br>
                <div class="content box box-primary" id ="pdf_programa">
                    <div id="gridselection_programa"  style="width:100%"></div>
                </div>
                <div id="programa_window" style="display: none;" >
                    <div class="box-gestionando box-primary">
                        <div class="box-header">
                            <button type="button" id="accionbtn_programasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_programasave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>
                        <form  id="programa_form" method="post" >

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_programa">
                            <span class="input-group-btn" title=" se escoge el perfil de  programa para crear el programa.">
                			<label for="id_programa" class="btn-addons "  style="padding-right: 5px;">Perfil Programa*</label></span>
                                            <input class="text-input" value="" id="id_programa" required  name="programa[id_programa]"  placeholder="Elija  el  programa"
                                                   validationMessage="El programa escogido ya existe o no es valido "/>
                                            <div class="k-invalid-msg" data-for="id_programa"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_nombre">
                             <span class="input-group-btn" title=" se define el nombre del programa.">
                			<label for="nombre" class="btn-addons " style="padding-right: 5px;">Nombre*</label></span>
                                            <input class=""  id="nombre"  required name="programa[nombre]"  placeholder="Inserte el nombre" type="text" />
                                            <div class="k-invalid-msg" data-for="nombre"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_persona ">
                             <span class="input-group-btn" title=" se define el Jefe del programa.">
                			<label for="id_persona" class="btn-addons " style="padding-right: 5px;"> Jefe Programa*</label></span>
                                            <input class="" value="" id="id_persona" required  name="programa[id_persona]"  placeholder="Inserte el Jefe del programa" type="text" />
                                            <div class="k-invalid-msg" data-for="id_persona"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_secretarioprograma">
                             <span class="input-group-btn" title=" se define el secretario del programa.">
                			<label for="secretarioprograma" class="btn-addons " style="padding-right: 5px;"> Secretario*</label></span>
                                            <input class="" value="" id="secretarioprograma" required  name="programa[secretarioprograma]"  placeholder="Inserte el secretario del programa" type="text" />
                                            <div class="k-invalid-msg" data-for="secretarioprograma"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_entidad">
                                       <span class="input-group-btn" title=" se define la entidad ejecutora del programa.">
                			<label for="id_entidad"  class="btn-addons " style="padding-right: 5px;">Entidad*</label></span>
                                            <input class="" value="" id="id_entidad" required  name="programa[id_entidad]"  placeholder="Escoja la entidad"  />
                                            <div class="k-invalid-msg" data-for="id_entidad"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-10">
                                        <div class="input-group margin" id= "div_objetivoGeneral">
                                       <span class="input-group-btn" title=" se define el objetivo General.">
                			<label for="objetivoGeneral" class="btn-addons "  style="padding-right: 5px;">Objetivo*</label></span>
                            <textarea  class="form-control" value="" id="objetivoGeneral" required  name="programa[objetivoGeneral]" rows ="3" cols="63"
                                       placeholder="Inserte el objetivoGeneral"></textarea>
                                            <div class="k-invalid-msg" data-for="objetivoGeneral"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-10">
                                        <div class="input-group margin" id= "div_grupoExpertos">
                                       <span class="input-group-btn" title=" se define el grupo de Expertos.">
                			<label for="grupoExpertos" class="btn-addons "  style="padding-right: 5px;">Grupo Expertos*</label></span>
                                    <textarea  class="form-control" value="" id="grupoExpertos" required  name="programa[grupoExpertos]"  placeholder="Inserte el grupoExpertos"
                                               rows ="3" cols="63"></textarea>
                                            <div class="k-invalid-msg" data-for="grupoExpertos"></div>
                                        </div>
                                    </div>
                                </div>
                                <input class=""  value="" type="hidden" id="taskprograma">
                            </div>

                            <?php echo JHtml::_('form.token');  ?>
                        </form>

                    </div >
                    <div class="info-box bg-green" style="display: none" id="message-ok">
                        <span class="info-box-icon"><i class="fa fa-thumbs-o-up" style="font-size: 50px"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text">Accion realizada </br> correctamente </span>
                        </div><!-- /.info-box-content -->
                    </div>
                    <div class="info-box bg-red " style="z-index:1000000;display: none" id="message-error" >
                        <span class="info-box-icon"><i class="fa fa-frown-o" style="font-size: 50px"></i></span>
                        <div class="info-box-content">
                            <span class="info-box-text" style="font-size: 10px" id="text-error"> </span>
                        </div><!-- /.info-box-content -->
                    </div>
                </div>
            </div>
        </div>
        <div id="convocatoria" class="tab-pane active">
            <div  >
                <section class="content-header">
                    <h1>
                        Gestionar Convocatoria
                    </h1>
                    <div class="btn-group">
                        <ol class="breadcrumb">

                            <button class="btn btn-action" id="addbutton_convocatoria" data-toggle='tooltip' title='convocatoria_add' >
                                <i class="fa fa-edit"></i> Nuevo
                            </button>
                            <button class="btn bg-red  btn-action" id="deletebutton_convocatoria" data-toggle='tooltip' title='convocatoria_delete' >
                                <i class="fa fa-trash"></i> Eliminar
                            </button>

                        </ol>
                    </div>
                </section>
                </br>
                <div class="content box box-primary" id ="pdf_convocatoria">
                    <div id="gridselection_convocatoria"  style="width:100%"></div>
                </div>

                <div id="convocatoria_window" style="display: none;" >

                    <div class="box-gestionando box-primary">

                        <div class="box-header">
                            <button type="button" id="accionbtn_convocatoriasave_exit" class="btn btn-primary">Guardar y Salir</button>
                            <button type="button" id="accionbtn_convocatoriasave_new" class="btn  btn-primary">Guardar y Crear</button>
                        </div>

                        <form role="form" id="convocatoria_form" method="post" >
                            <div  class="form-group" >
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_id_convocatoria">
                                            <input class="text-input" value="" id="id_convocatoria" type="hidden"  name="convocatoria[id_convocatoria]"  />
                                        </div>

                                        <div class="input-group margin" id= "div_id_programa_convocatoria">
                              <span class="input-group-btn" title=" se define el programa.">
                			<label for="id_programa_convocatoria"  class="btn-addons " style="padding-right: 5px;">Programa*</label></span>
                                            <input class="text-input" value="" id="id_programa_convocatoria" required  name="convocatoria[id_programa_convocatoria]"  placeholder="Escoja el programa"  />
                                            <div class="k-invalid-msg" data-for="id_programa_convocatoria"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div  class="form-group" >
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_inicio">
                                 <span class="input-group-btn" title=" se define  el inicio de la convocatoria.">
                			<label for="inicio"   class="btn-addons " style="padding-right: 5px;">Inicio*</label></span>
                                            <input class="" value="" id="inicio" required  name="convocatoria[inicio]"  placeholder="Inserte el inicio de la convocatoria" type="text"/>
                                            <div class="k-invalid-msg" data-for="inicio"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="input-group margin" id= "div_cerrada">
                                 <span class="input-group-btn"  title=" se define  el  cierre de la convocatoria.">
                			<label for="cerrada"  class="btn-addons " style="padding-right: 5px;">Cierre*</label></span>
                                            <input class="" value="" id="cierre" required  name="convocatoria[cierre]"  placeholder="Inserte el cierre de la convocatoria" type="text"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div  class="input-group margin">
                          	<span class="input-group-btn" title=" se define la visibilidad de la convocatoria">
                			<label for="visibilidad" class="btn-addons " style="padding-right: 5px;">visibilidad*</label></span>

                                <ul class="fieldlist">


                                    <input type="radio" value="publica" name="convocatoria[visibilidad]" id="visibilidad1" class="k-radio" checked="checked">
                                    <label class="k-radio-label" for="visibilidad1">pública</label>

                                    <input type="radio"  value="privada" name="convocatoria[visibilidad]" id="visibilidad2" class="k-radio">
                                    <label class="k-radio-label" for="visibilidad2">privada</label>

                                </ul>
                            </div>
                            <div class="input-group margin" id= "div_texto">
                                 <span class="input-group-btn" title=" se define el texto.">
                			<label for="texto"  class="btn-addons " style="padding-right: 5px;">Texto*</label></span>
                                <textarea class="form-control" value="" id="texto" required  name="convocatoria[texto]"  placeholder="Inserte el texto" type="text" ></textarea>
                                <div class="k-invalid-msg" data-for="texto"></div>
                            </div>

                            <input class="text-input"  value="" type="hidden" id="taskconvocatoria">

                    </div>
                    <?php echo JHtml::_('form.token');  ?>
                    </form>
                </div>

                <div class="info-box bg-green" style="display: none" id="message-ok">
                    <span class="info-box-icon"><i class="fa fa-thumbs-o-up" style="font-size: 50px"></i></span>
                    <div class="info-box-content">
                        <span class="info-box-text">Accion realizada </br> correctamente </span>
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
    </div><!-- /.tab-content -->
</div>
</div><!-- /.tab-pane -->
</body>