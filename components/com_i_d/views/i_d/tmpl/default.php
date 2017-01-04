
<?php
$componentbase =  $this->_basePath;         ?>
<html xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html"
	  xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Perfil de Proyecto </title>
	<script type="text/x-kendo-template" id="template_jefe_proyecto">
		<div class="tabstrip">

			<div>
				<div class="orders"></div>
			</div>
			<div>
				<div class='employee-details'>
					<ul>
						<li><label>Situación Laboral:</label>#= situacion_laboral #</li>
						<li> <label>Publicaciones:</label>#= publicaciones #</li>
						<li><label>Otros Aspectos:</label>#= otros_aspectos #</li>
						<li><label>Curriculum:</label>#= cv #</li>
					</ul>
				</div>
			</div>
		</div>

	</script>
	<script type="text/x-kendo-template" id="template_ejecutora">
		<div class="tabstrip">
			<div>
				<div class="orders"></div>
			</div>
			<div>
				<div class='employee-details'>
					<ul>
						<li><label>Plan CIT:</label>#= plan_CIT #</li>
						<li><label>CGD:</label>#= coeficiente_gastos_directos #</li>
					</ul>
				</div>
			</div>
		</div>

	</script>

	<script type="text/x-kendo-template" id="template_perfil">
		<div class="tabstrip">
			<div>
				<div class="orders"></div>
			</div>
			<div>
				<div class='employee-details'>
					<ul>
						<li><label>Tipo:</label>#= tipo_proyecto #</li>
						<li><label>Clasificación:</label>#= nombre_clasificacion #</li>
						<li><label>Otra Institución:</label>#= otra_institucion #</li>
						<li><label>Clientes:</label>#= clientes #</li>
						<li><label>Resumen:</label>#= resumen #</li>
						<li><label>Fecha Recepción:</label>#= fecha_recepcion #</li>
					</ul>
				</div>
			</div>
		</div>

	</script>

	<script type="text/x-kendo-template" id="template_innovacion">
		<div class="tabstrip">

			<div>
				<div class="orders"></div>
			</div>
			<div>
				<div class='employee-details'>
					<ul>
						<li><label>Fundamentación Tecnológica:</label>#= fundamentacion_tecnologica #</li>
						<li><label>Fundamentación Mercado:</label>#= fundamentacion_mercado #</li>
						<li><label>Aspectos Técnicos:</label>#= aspectos_tecncios #</li>
						<li><label>Aspectos Eco Mercado:</label>#= aspectos_eco_mercado #</li>
						<li><label>Capacidad Asimilación Desarrollo:</label>#= capacidad_asimilacion_desarrollo #</li>
						<li><label>Materias Primas Recursos Naturales:</label>#= mat_primas_recursos_naturales #</li>
						<li><label>Medio Ambiente:</label>#= medio_ambiente #</li>
						<li><label>Propiedad Intelectual:</label>#= propiedad_intelectual #</li>
						<li><label>Tecnlogías Constructivas:</label>#= tecnlogias_constructivas #</li>
						<li><label>Analisis Sostenibilidad Innovación:</label>#= analisis_sostenibilidad_innovacion #</li>
						<li><label>Otros Anexos:</label>#= otros_anexos #</li>
					</ul>
				</div>
			</div>
		</div>

	</script><script type="text/x-kendo-template" id="template_i_d">
		<div class="tabstrip">
			<div>
				<div class="orders"></div>
			</div>
			<div>
				<div class='employee-details'>
					<ul>
						<li><label>Antecedentes Justificación:</label>#= antecedentes_justificacion #</li>
						<li><label>Beneficiarios Directos:</label>#= beneficiarios_directos #</li>
						<li><label>Sostenibilidad Resultados Proyecto:</label>#= sostenibilidad_resultados_proyecto #</li>
						<li><label>Otros Anexos:</label>#= otros_anexos_i_d #</li>
					</ul>
				</div>
			</div>
		</div>

	</script>
</head>
<body class="skin-blue sidebar-mini">
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li ><a data-toggle="tab" href="#jboss">JefeProyecto</a></li>
		<li><a data-toggle="tab" href="#executor">Ejecutora</a></li>
		<li  ><a data-toggle="tab" href="#profile">Perfiles</a></li>
		<li><a data-toggle="tab" href="#innovation">Innovación</a></li>
		<li class="active"><a data-toggle="tab" href="#in_de">I+D</a></li>

	</ul>

	<div class="tab-content">
		<div id="jboss" class="tab-pane ">
			<section class="content-header">
				<h1>
					Jefe de Proyecto
				</h1>
				<ol class="breadcrumb">
					<div class="btn-group">
						<button class="btn btn-action" id="addbutton_jefeproyecto" data-toggle='tooltip' title='jefeproyecto_add' >
							<i class="fa fa-edit"></i> Nuevo
						</button>
						<button class="btn bg-red  btn-action" id="deletebutton_jefeproyecto" data-toggle='tooltip' title='jefeproyecto_delete' >
							<i class="fa fa-trash"></i> Eliminar
						</button>
					</div>
				</ol>
			</section>
			</br>
			<div class="content box box-primary" id ="este">
				<div id="gridselection_jefeproyecto"  style="width:100%"></div>
			</div>

			<div id="jefeproyecto_window" style="display: none;" >



				<div class="box-gestionando box-primary">

					<div class="box-header">
						<button type="button" id="accionbtn_jefeproyectosave_exit" class="btn btn-primary">Guardar y Salir</button>
						<button type="button" id="accionbtn_jefeproyectosave_new" class="btn  btn-primary">Guardar y Crear</button>
					</div>

					<form role="form" method="post" id="jefeproyecto_form" class="form-validate">
						<div class="form-group">
							<div class="row">
								<div class="col-md-4">
									<div class="input-group margin" id= "div_id_persona">
                          	<span class="input-group-btn" title=" se define el id_persona">
                			<label for="id_persona" class="btn-addons " style="padding-right: 5px;">Nombre*</label></span>
										<input class="form-control" value="" id="id_persona" required  name="jefeproyecto[id_persona]"  placeholder="Escoja la persona" />
										<div class="k-invalid-msg" data-for="id_persona"></div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="input-group margin" id= "div_titulo_obtenido">
                          	<span class="input-group-btn" title=" se define ltitulo_obtenido">
                			<label for="titulo_obtenido" class="btn-addons " style="padding-right: 5px;">Titulo*</label></span>
										<input class="form-control" value="" id="titulo_obtenido" required  name="jefeproyecto[titulo_obtenido]"  placeholder="Inserte  titulo_obtenido"
											   type="text"/>
										<div class="k-invalid-msg" data-for="titulo_obtenido"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-4">
									<div class="input-group margin" id= "div_situacion_laboral">
                          	<span class="input-group-btn" title=" se define lsituacion_laboral">
                			<label for="situacion_laboral" class="btn-addons " style="padding-right: 5px;">Situación Laboral*</label></span>
										<input class="form-control" value="" id="situacion_laboral" required  name="jefeproyecto[situacion_laboral]"  placeholder="Inserte  situacion_laboral" type="text" >
										<div class="k-invalid-msg" data-for="situacion_laboral"></div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="input-group margin" id= "div_presupuesto_anual">
                          	<span class="input-group-btn" title=" se define lpresupuesto_anual">
                			<label for="presupuesto_anual" class="btn-addons " style="padding-right: 5px;">Presupuesto Anual*</label></span>
										<input class="" value="" id="presupuesto_anual" required  name="jefeproyecto[presupuesto_anual]"  placeholder="Inserte  presupuesto_anual" type="text" >
										<div class="k-invalid-msg" data-for="presupuesto_anual"></div>
									</div>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-md-4">


									<div class="input-group margin" id= "div_id_categoria">
                          	<span class="input-group-btn" title=" se define lid_categoria">
                			<label for="id_categoria" class="btn-addons " style="padding-right: 5px;">Categoria*</label></span>
										<input class="form-control" value="" id="id_categoria" required  name="jefeproyecto[id_categoria]"  placeholder="Inserte  id_categoria"  >
										<div class="k-invalid-msg" data-for="id_categoria"></div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="input-group margin" id= "div_id_grado">
                          	<span class="input-group-btn" title=" se define lid_grado">
                			<label for="id_grado" class="btn-addons " style="padding-right: 5px;">Grado*</label></span>
										<input class="form-control" value="" id="id_grado" required  name="jefeproyecto[id_grado]"  placeholder="Inserte  id_grado"  >
										<div class="k-invalid-msg" data-for="id_grado"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-4">
									<div class="input-group margin" id= "div_cv">
                          	<span class="input-group-btn" title=" se define el curriculum vitae">
                			<label for="cv" class="btn-addons " style="padding-right: 5px;">Curriculum</label></span>
										<input   id="cv"  value="" type="file" name="jefeproyecto[cv]" />
										<div class="k-invalid-msg" data-for="cv"></div>
									</div>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="row">
								<div class="col-md-8">
									<div class="input-group margin" id= "div_publicaciones">
                          	<span class="input-group-btn" title=" se define lpublicaciones">
                			<label for="publicaciones" class="btn-addons " style="padding-right: 5px;">Publicaciones*</label></span>
										<textarea class="form-control" value="" id="publicaciones" required  name="jefeproyecto[publicaciones]"  placeholder="Inserte  publicaciones"  ></textarea>
										<div class="k-invalid-msg" data-for="publicaciones"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-md-8">

									<div class="input-group margin" id= "div_otros_aspectos">
                          	<span class="input-group-btn" title=" se define lotros_aspectos">
                			<label for="otros_aspectos" class="btn-addons " style="padding-right: 5px;">Otros Aspectos</label></span>
										<textarea class="form-control" value="" id="otros_aspectos"   name="jefeproyecto[otros_aspectos]"  placeholder="Inserte  otros_aspectos" ></textarea>
										<div class="k-invalid-msg" data-for="otros_aspectos"></div>
									</div>
								</div>
							</div>


							<input class="text-input"  value="" type="hidden" id="taskjefeproyecto">
						</div>
						<?php echo JHtml::_('form.token');  ?>
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
		</div><!-----end tab----->
		<div id="executor" class="tab-pane ">
			<div >



				<section class="content-header">
					<h1>
						Entidad Ejecutora
					</h1>
					<ol class="breadcrumb">
						<div class="btn-group">

							<button class="btn btn-action" id="addbutton_ejecutora" data-toggle='tooltip' title='ejecutora_add' >
								<i class="fa fa-edit"></i> Nuevo
							</button>
							<button class="btn bg-red  btn-action" id="deletebutton_ejecutora" data-toggle='tooltip' title='ejecutora_delete' >
								<i class="fa fa-trash"></i> Eliminar
							</button>
						</div>
					</ol>
				</section>
				</br>
				<div class="content box box-primary">
					<div id="gridselection_ejecutora"  style="width:100%"></div>
				</div>

				<div id="ejecutora_window" style="display: none;" >


					<div class="box-gestionando box-primary">

						<div class="box-header">
							<button type="button" id="accionbtn_ejecutorasave_exit" class="btn btn-primary">Guardar y Salir</button>
							<button type="button" id="accionbtn_ejecutorasave_new" class="btn  btn-primary">Guardar y Crear</button>
						</div>

						<form role="form" method="post" id="ejecutora_form" class="form-validate">
							<div class="form-group">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group margin" id= "div_id_entidad">
                          	<span class="input-group-btn" title=" se define id_entidad">
                			<label for="id_entidad" class="btn-addons " style="padding-right: 5px;">Entidad*</label></span>
											<input class="form-control" value="" id="id_entidad" required  name="ejecutora[id_entidad]"  placeholder="Escoja  id_entidad"  >
											<div class="k-invalid-msg" data-for="id_entidad"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group margin" id= "div_numero_cuenta_bancaria">
                          	<span class="input-group-btn" title=" se define lnumero_cuenta_bancaria">
                			<label for="numero_cuenta_bancaria" class="btn-addons " style="padding-right: 5px;">Cuenta Bancaria*</label></span>
											<input class="" value="" id="numero_cuenta_bancaria" required  name="ejecutora[numero_cuenta_bancaria]"  maxlength="13" placeholder="Inserte  numero_cuenta_bancaria" type="number" >
											<div class="k-invalid-msg" data-for="numero_cuenta_bancaria"></div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="input-group margin" id= "div_sucursal_creditos">
                          	<span class="input-group-btn" title=" se define lsucursal_creditos">
                			<label for="sucursal_creditos" class="btn-addons " style="padding-right: 5px;">Sucursal Créditos*</label></span>
											<input class="form-control" value="" id="sucursal_creditos" required  name="ejecutora[sucursal_creditos]"  placeholder="Inserte  sucursal_creditos" type="text" >
											<div class="k-invalid-msg" data-for="sucursal_creditos"></div>
										</div>
									</div>
								</div>
							</div>

							<div class="form-group">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group margin" id= "div_cifra_planificada">
                          	<span class="input-group-btn" title=" se define lcifra_planificada">
                			<label for="cifra_planificada" class="btn-addons " style="padding-right: 5px;">Cifra Planificada*</label></span>
											<input class="" value="" id="cifra_planificada" required  name="ejecutora[cifra_planificada]"  placeholder="Inserte  cifra_planificada" type="text" >
											<div class="k-invalid-msg" data-for="cifra_planificada"></div>
										</div>
									</div>
									<div class="col-md-4">

										<div class="input-group margin" id= "div_coeficiente_gastos_directos">
                          	<span class="input-group-btn" title=" se define el coeficiente_gastos_directos">
                			<label for="coeficiente_gastos_directos" class="btn-addons " style="padding-right: 5px;">CGD*</label></span>
											<input class="" value="" id="coeficiente_gastos_directos" required  name="ejecutora[coeficiente_gastos_directos]"  placeholder="Inserte  coeficiente_gastos_directos" type="text" >
											<div class="k-invalid-msg" data-for="coeficiente_gastos_directos"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<div class="col-md-8">
										<div class="input-group margin" id= "div_plan_CIT">
                          	<span class="input-group-btn" title=" se define lplan_CIT">
                			<label for="plan_CIT" class="btn-addons " style="padding-right: 5px;">Plan CIT*</label></span>
											<textarea class="form-control" value="" id="plan_CIT" required  name="ejecutora[plan_CIT]"  placeholder="Inserte  plan_CIT"  ></textarea>
											<div class="k-invalid-msg" data-for="plan_CIT"></div>
										</div>
									</div>
								</div>


								<input class="text-input"  value="" type="hidden" id="taskejecutora">
							</div>
							<?php echo JHtml::_('form.token');  ?>
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

		</div><!-----end tab----->



		<div id="profile" class="tab-pane ">
			<div >



				<section class="content-header">
					<h1>
						Gestionar Perfil de Proyecto
					</h1>
					<ol class="breadcrumb">
						<div class="btn-group">

							<button class="btn btn-action" id="addbutton_perfil_proyecto" data-toggle='tooltip' title='perfil_proyecto_add' >
								<i class="fa fa-edit"></i> Nuevo
							</button>
							<button class="btn bg-red  btn-action" id="deletebutton_perfil_proyecto" data-toggle='tooltip' title='perfil_proyecto_delete' >
								<i class="fa fa-trash"></i> Eliminar
							</button>
						</div>
					</ol>
				</section>
				</br>
				<div class="content box box-primary">
					<div id="gridselection_perfil_proyecto"  style="width:100%"></div>
				</div>

				<div id="perfil_proyecto_window" style="display: none;" >

					<div class="box-gestionando box-primary">

						<div class="box-header">
							<button type="button" id="accionbtn_perfil_proyectosave_exit" class="btn btn-primary">Guardar y Salir</button>
							<button type="button" id="accionbtn_perfil_proyectosave_new" class="btn btn-primary">Guardar y Crear</button>
						</div>

						<form role="form" method="post" id="perfil_proyecto_form" class="form-validate">
							<div class="box-body">

								<div class="form-group">
									<div class="row">
										<div class="col-md-4">
											<div class="input-group margin" id= "div_titulo_proyecto">
                          	<span class="input-group-btn" title=" se define ltitulo_proyecto">
                			<label for="titulo_proyecto" class="btn-addons " style="padding-right: 5px;">Titulo*</label></span>
												<input class="form-control" value="" id="titulo_proyecto" required  name="perfil_proyecto[titulo_proyecto]"  placeholder="Inserte  titulo_proyecto" type="text" >
												<div class="k-invalid-msg" data-for="titulo_proyecto"></div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="input-group margin" id= "div_id_persona">
                          	<span class="input-group-btn" title=" se define lid_persona">
                			<label for="id_persona" class="btn-addons " style="padding-right: 5px;">Jefe Proyecto*</label></span>
												<input class="form-control" value="" id="id_persona_jefe" required  name="perfil_proyecto[id_persona]"  placeholder="Inserte  id_persona"  >
												<div class="k-invalid-msg" data-for="id_persona"></div>
											</div>
										</div>
									</div>
								</div>

								<div class="form-group">
									<div class="row">
										<div class="col-md-4">


											<div class="input-group margin" id= "div_id_tipo_proyecto">
                          	<span class="input-group-btn" title=" se define lid_tipo_proyecto">
                			<label for="id_tipo_proyecto" class="btn-addons " style="padding-right: 5px;">Tipo*</label></span>
												<input class="form-control" value="" id="id_tipo_proyecto" required  name="perfil_proyecto[id_tipo_proyecto]"  placeholder="Inserte  id_tipo_proyecto"  >
												<div class="k-invalid-msg" data-for="id_tipo_proyecto"></div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="input-group margin" id= "div_id_clasificacion">
                          	<span class="input-group-btn" title=" se define lid_clasificacion">
                			<label for="id_clasificacion" class="btn-addons " style="padding-right: 5px;">Clasificación*</label></span>
												<input class="form-control" value="" id="id_clasificacion" required  name="perfil_proyecto[id_clasificacion]"  placeholder="Inserte  id_clasificacion"  >
												<div class="k-invalid-msg" data-for="id_clasificacion"></div>
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
												<input class="form-control" value="" id="id_programa" required  name="perfil_proyecto[id_programa]"  placeholder="Inserte  id_programa"  >
												<div class="k-invalid-msg" data-for="id_programa"></div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="input-group margin" id="div_id_prioridad">
									<span class="input-group-btn" title=" se define el problema a resolver por el proyecto no asociado a programa">
									<label class="btn-addons "  style="padding-right: 5px;">Problema*</label></span>
												<input type="text" value="" id="id_prioridad"   name="perfil_proyecto[id_prioridad]" placeholder="Escoja la prioridad" class="form-control"/>
												<div class="k-invalid-msg" data-for="id_prioridad"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-md-4">
											<div class="input-group margin" id= "div_clientes">
                          	<span class="input-group-btn" title=" se define lclientes">
                			<label for="clientes" class="btn-addons " style="padding-right: 5px;">Clientes*</label></span>
												<input class="form-control" value="" id="clientes" required  name="perfil_proyecto[clientes]"  placeholder="Inserte  clientes" type="text" >
												<div class="k-invalid-msg" data-for="clientes"></div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="input-group margin" id= "div_duracion">
                          	<span class="input-group-btn" title=" se define la duración en años">
                			<label for="duracion" class="btn-addons " style="padding-right: 5px;">Duración*</label></span>
												<input class="" value="" id="duracion" required  name="perfil_proyecto[duracion]"  placeholder="Inserte  duracion" type="text" >
												<div class="k-invalid-msg" data-for="duracion"></div>
											</div>
										</div>
									</div>
								</div>

								<div class="form-group">
									<div class="row">
										<div class="col-md-4">

											<div class="input-group margin" id= "div_presupuesto_total">
                          	<span class="input-group-btn" title=" se define lpresupuesto_total">
                			<label for="presupuesto_total" class="btn-addons " style="padding-right: 5px;">Presupuesto*</label></span>
												<input class="" value="" id="presupuesto_total" required  name="perfil_proyecto[presupuesto_total]"  placeholder="Inserte  presupuesto_total" type="text" >
												<div class="k-invalid-msg" data-for="presupuesto_total"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-md-4">

											<div class="input-group margin" id= "div_id_entidad">
                          	<span class="input-group-btn" title=" se define lid_entidad">
                			<label for="id_entidad" class="btn-addons " style="padding-right: 5px;">Entidad Ejecutora*</label></span>
												<input class="form-control" value="" id="id_entidad_ejecutora" required  name="perfil_proyecto[id_entidad]"  placeholder="Inserte  id_entidad"  >
												<div class="k-invalid-msg" data-for="id_entidad"></div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="input-group margin" id= "div_otra_institucion">
                          	<span class="input-group-btn" title=" se define lotra_institucion">
                			<label for="otra_institucion" class="btn-addons " style="padding-right: 5px;">Otra Entidad</label></span>
												<input class="" value="" id="otra_institucion"   name="perfil_proyecto[otra_institucion]"  placeholder="Inserte  otra_institucion" type="text" >
												<div class="k-invalid-msg" data-for="otra_institucion"></div>
											</div>

										</div>
									</div>
								</div>

								<div class="form-group">
									<div class="row">
										<div class="col-md-8">
											<div class="input-group margin" id= "div_resumen">
                          	<span class="input-group-btn" title=" se define lresumen">
                			<label for="resumen" class="btn-addons " style="padding-right: 5px;">Resumen*</label></span>
												<textarea class="form-control" value="" id="resumen" required  name="perfil_proyecto[resumen]"  placeholder="Inserte  resumen"  ></textarea>
												<div class="k-invalid-msg" data-for="resumen"></div>
											</div>
										</div>
									</div>
								</div>

								<input class="text-input"  value="" type="hidden" id="taskperfil_proyecto">
							</div>
							<?php echo JHtml::_('form.token');  ?>
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
		</div><!-----end tab----->


		<div id="innovation" class="tab-pane">
			<div >



				<section class="content-header">
					<h1>
						Gestionar Proyecto de  Innovación
					</h1>
					<ol class="breadcrumb">
						<div class="btn-group">
							<button class="btn btn-action" id="addbutton_innovacion" data-toggle='tooltip' title='innovacion_add' >
								<i class="fa fa-edit"></i> Nuevo
							</button>
							<button class="btn bg-red  btn-action" id="deletebutton_innovacion" data-toggle='tooltip' title='innovacion_delete' >
								<i class="fa fa-trash"></i> Eliminar
							</button>
						</div>
					</ol>
				</section>
				</br>
				<div class="content box box-primary">
					<div id="gridselection_innovacion"  style="width:100%"></div>
				</div>

				<div id="innovacion_window" style="display: none;" >

					<div class="box-gestionando box-primary">

						<div class="box-header">
							<button type="button" id="accionbtn_innovacionsave_exit" class="btn btn-primary">Guardar y Salir</button>
							<button type="button" id="accionbtn_innovacionsave_new" class="btn btn-primary">Guardar y Crear</button>
						</div>

						<form  method="post" id="innovacion_form"  >
							<div class="form-group">
								<div class="row">
									<div class="col-md-4">

										<div class="input-group margin" id= "div_id_proyecto">
								<span class="input-group-btn" title=" se define proyecto">
                			<label for="id_proyecto"  class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
											<input class="text-input" value="" id="id_proyecto_innovacion" required  name="innovacion[id_proyecto]" placeholder="id_proyecto"  />
											<div class="k-invalid-msg" data-for="id_proyecto">			 				</div>
										</div>
									</div>

									<div class="col-md-4">
										<div class="input-group margin" id= "div_otros_anexos">
                          	<span class="input-group-btn" title=" se define lotros_anexos">
                			<label for="otros_anexos" class="btn-addons " style="padding-right: 5px;">Otros Anexos</label></span>
											<input   id="otros_anexos"  value="" type="file" name="innovacion[otros_anexos]" />
											<div class="k-invalid-msg" data-for="otros_anexos"></div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-md-8">
											<div class="input-group margin" id= "div_problema_resolver">
                          	<span class="input-group-btn" title=" se define lproblema_resolver">
                			<label for="problema_resolver" class="btn-addons " style="padding-right: 5px;">Problema Resolver*</label></span>
												<textarea class="form-control" value="" id="problema_resolver" required  name="innovacion[problema_resolver]"  placeholder="Inserte  problema_resolver" ></textarea
												<div class="k-invalid-msg" data-for="problema_resolver"></div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-md-8">
												<div class="input-group margin" id= "div_fundamentacion_tecnologica">
                          	<span class="input-group-btn" title=" se define lfundamentacion_tecnologica">
                			<label for="fundamentacion_tecnologica" class="btn-addons " style="padding-right: 5px;">Fundamentación Tecnológica*</label></span>
													<textarea class="form-control" value="" id="fundamentacion_tecnologica"   name="innovacion[fundamentacion_tecnologica]"  placeholder="Inserte  fundamentacion_tecnologica"></textarea>
													<div class="k-invalid-msg" data-for="fundamentacion_tecnologica"></div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="row">
												<div class="col-md-8">

													<div class="input-group margin" id= "div_fundamentacion_mercado">
                          	<span class="input-group-btn" title=" se define lfundamentacion_mercado">
                			<label for="fundamentacion_mercado" class="btn-addons " style="padding-right: 5px;">Fundamentación Mercado*</label></span>
														<textarea class="form-control" value="" id="fundamentacion_mercado"   name="innovacion[fundamentacion_mercado]"  placeholder="Inserte  fundamentacion_mercado"></textarea>
														<div class="k-invalid-msg" data-for="fundamentacion_mercado"></div>
													</div>
												</div>
											</div>

											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_aspectos_tecncios">
                          	<span class="input-group-btn" title=" se define laspectos_tecncios">
                			<label for="aspectos_tecncios" class="btn-addons " style="padding-right: 5px;">Aspectos Técnicos*</label></span>
															<textarea class="form-control" value="" id="aspectos_tecncios" required  name="innovacion[aspectos_tecncios]"  placeholder="Inserte  aspectos_tecncios" ></textarea>
															<div class="k-invalid-msg" data-for="aspectos_tecncios"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">

														<div class="input-group margin" id= "div_aspectos_eco_mercado">
                          	<span class="input-group-btn" title=" se define laspectos_eco_mercado">
                			<label for="aspectos_eco_mercado" class="btn-addons " style="padding-right: 5px;">Aspectos Eco Mercado*</label></span>
															<textarea class="form-control" value="" id="aspectos_eco_mercado" required  name="innovacion[aspectos_eco_mercado]"  placeholder="Inserte  aspectos_eco_mercado" ></textarea>
															<div class="k-invalid-msg" data-for="aspectos_eco_mercado"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_capacidad_asimilacion_desarrollo">
                          	<span class="input-group-btn" title=" se define lcapacidad_asimilacion_desarrollo">
                			<label for="capacidad_asimilacion_desarrollo" class="btn-addons " style="padding-right: 5px;">Capacidad Asimilación Desarrollo*</label></span>
															<textarea class="form-control" value="" id="capacidad_asimilacion_desarrollo" required  name="innovacion[capacidad_asimilacion_desarrollo]"  placeholder="Inserte  capacidad_asimilacion_desarrollo" ></textarea>
															<div class="k-invalid-msg" data-for="capacidad_asimilacion_desarrollo"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_energia">
                          	<span class="input-group-btn" title=" se define lenergia">
                			<label for="energia" class="btn-addons " style="padding-right: 5px;">Energía</label></span>
															<textarea class="form-control" value="" id="energia" required  name="innovacion[energia]"  placeholder="Inserte  energia" ></textarea
															<div class="k-invalid-msg" data-for="energia"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_mat_primas_recursos_naturales">
                          	<span class="input-group-btn" title=" se define lmat_primas_recursos_naturales">
                			<label for="mat_primas_recursos_naturales" class="btn-addons " style="padding-right: 5px;">MatP Recrsos Natrals*</label></span>
															<textarea class="form-control" value="" id="mat_primas_recursos_naturales" required  name="innovacion[mat_primas_recursos_naturales]"  placeholder="Inserte  mat_primas_recursos_naturales" ></textarea>
															<div class="k-invalid-msg" data-for="mat_primas_recursos_naturales"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_calidad">
                          	<span class="input-group-btn" title=" se define lcalidad">
                			<label for="calidad" class="btn-addons " style="padding-right: 5px;">Calidad*</label></span>
															<textarea class="form-control" value="" id="calidad" required  name="innovacion[calidad]"  placeholder="Inserte  calidad" ></textarea
															<div class="k-invalid-msg" data-for="calidad"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_medio_ambiente">
                          	<span class="input-group-btn" title=" se define lmedio_ambiente">
                			<label for="medio_ambiente" class="btn-addons " style="padding-right: 5px;">Medio Ambiente*</label></span>
															<textarea class="form-control" value="" id="medio_ambiente" required  name="innovacion[medio_ambiente]"  placeholder="Inserte  medio_ambiente" ></textarea>
															<div class="k-invalid-msg" data-for="medio_ambiente"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_propiedad_intelectual">
                          	<span class="input-group-btn" title=" se define lpropiedad_intelectual">
                			<label for="propiedad_intelectual" class="btn-addons " style="padding-right: 5px;">Propiedad Intelectual*</label></span>
															<textarea class="form-control" value="" id="propiedad_intelectual" required  name="innovacion[propiedad_intelectual]"  placeholder="Inserte  propiedad_intelectual" ></textarea>
															<div class="k-invalid-msg" data-for="propiedad_intelectual"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_tecnlogias_constructivas">
                          	<span class="input-group-btn" title=" se define ltecnlogias_constructivas">
                			<label for="tecnlogias_constructivas" class="btn-addons " style="padding-right: 5px;">Tecnlogías Constructivas*</label></span>
															<textarea class="form-control" value="" id="tecnlogias_constructivas" required  name="innovacion[tecnlogias_constructivas]"  placeholder="Inserte  tecnlogias_constructivas" ></textarea>
															<div class="k-invalid-msg" data-for="tecnlogias_constructivas"></div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<div class="col-md-8">
														<div class="input-group margin" id= "div_analisis_sostenibilidad_innovacion">
                          	<span class="input-group-btn" title=" se define lanalisis_sostenibilidad_innovacion">
                			<label for="analisis_sostenibilidad_innovacion" class="btn-addons " style="padding-right: 5px;">Analisis Sostenibilidad Innovación*</label></span>
															<textarea class="form-control" value="" id="analisis_sostenibilidad_innovacion" required  name="innovacion[analisis_sostenibilidad_innovacion]"  placeholder="Inserte  analisis_sostenibilidad_innovacion" ></textarea>
															<div class="k-invalid-msg" data-for="analisis_sostenibilidad_innovacion"></div>
														</div>
													</div>
												</div>
											</div>

											<input class="input-group margin" class="form-control" value="" type="hidden" id="taskinnovacion"/>
										</div>
										<?php echo JHtml::_('form.token');  ?>
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
		</div><!-----end tab----->
		<div id="in_de" class="tab-pane active">
			<div >



				<section class="content-header">
					<h1>
						Gestionar Proyecto de I+D
					</h1>
					<ol class="breadcrumb">
						<div class="btn-group">
							<button class="btn btn-action" id="addbutton_i_d" data-toggle='tooltip' title='i_d_add' >
								<i class="fa fa-edit"></i> Nuevo
							</button>
							<button class="btn bg-red  btn-action" id="deletebutton_i_d" data-toggle='tooltip' title='i_d_delete' >
								<i class="fa fa-trash"></i> Eliminar
							</button>
						</div>
					</ol>
				</section>
				</br>
				<div class="content box box-primary">
					<div id="gridselection_i_d"  style="width:100%"></div>
				</div>

				<div id="i_d_window" style="display: none;" >

					<div class="box-gestionando box-primary">

						<div class="box-header">
							<button type="button" id="accionbtn_i_dsave_exit" class="btn btn-primary">Guardar y Salir</button>
							<button type="button" id="accionbtn_i_dsave_new" class="btn btn-primary">Guardar y Crear</button>
						</div>

						<form role="form" method="post" id="i_d_form" class="form-validate">
							<div class="form-group">
								<div class="row">
									<div class="col-md-4">


										<div class="input-group margin" id= "div_id_proyecto">
                            <span class="input-group-btn" title=" se define el proyecto">
                			<label for="id_proyecto"  style="padding-right: 5px;" class="btn-addons ">Proyecto</label></span>
											<input class="form-control" value="" id="id_proyecto_i_d" required  name="i_d[id_proyecto]" placeholder="id_proyecto"  />
											<div class="k-invalid-msg" data-for="id_proyecto">			 				</div>
										</div>
									</div>
								</div>
							</div>

							<div class="form-group">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group margin" id= "div_clientes">
                          	<span class="input-group-btn" title=" se define lclientes">
                			<label for="clientes" class="btn-addons " style="padding-right: 5px;">Clientes*</label></span>
											<input class="form-control" value="" id="clientes" required  name="i_d[clientes]"  placeholder="Inserte  clientes" type="text" />
											<div class="k-invalid-msg" data-for="clientes"></div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="input-group margin" id= "div_otros_anexos">
                          	<span class="input-group-btn" title=" se define lotros_anexos">
                			<label for="otros_anexos_i_d" class="btn-addons " style="padding-right: 5px;">Otros Anexos</label></span>
											<input   id="otros_anexos_i_d"  value="" type="file" name="i_d[otros_anexos_i_d]" />
											<div class="k-invalid-msg" data-for="otros_anexos_i_d"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<div class="col-md-8">

										<div class="input-group margin" id= "div_antecedentes_justificacion">
                          	<span class="input-group-btn" title=" se define lantecedentes_justificacion">
                			<label for="antecedentes_justificacion" class="btn-addons " style="padding-right: 5px;">Antecedentes Justificación*</label></span>
											<textarea class="form-control" value="" id="antecedentes_justificacion" required  name="i_d[antecedentes_justificacion]"  placeholder="Inserte  antecedentes_justificacion" ></textarea>
											<div class="k-invalid-msg" data-for="antecedentes_justificacion"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<div class="col-md-8">
										<div class="input-group margin" id= "div_beneficiarios_directos">
                          	<span class="input-group-btn" title=" se define lbeneficiarios_directos">
                			<label for="beneficiarios_directos" class="btn-addons " style="padding-right: 5px;">Beneficiarios Directos*</label></span>
											<textarea class="form-control" value="" id="beneficiarios_directos" required  name="i_d[beneficiarios_directos]"  placeholder="Inserte  beneficiarios_directos" ></textarea>
											<div class="k-invalid-msg" data-for="beneficiarios_directos"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<div class="col-md-8">

										<div class="input-group margin" id= "div_sostenibilidad_resultados_proyecto">
                          	<span class="input-group-btn" title=" se define lsostenibilidad_resultados_proyecto">
                			<label for="sostenibilidad_resultados_proyecto" class="btn-addons " style="padding-right: 5px;">Sostenibilidad Resultados Proyecto*</label></span>
											<textarea class="form-control" value="" id="sostenibilidad_resultados_proyecto" required  name="i_d[sostenibilidad_resultados_proyecto]"  placeholder="Inserte  sostenibilidad_resultados_proyecto"  ></textarea>
											<div class="k-invalid-msg" data-for="sostenibilidad_resultados_proyecto"></div>
										</div>
									</div>
								</div>
							</div>


							<input class="text-input"  value="" type="hidden" id="taski_d">
					</div>
					<?php echo JHtml::_('form.token');  ?>
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
	</div><!-----end tab----->


</div><!-----nav-tabs-custom----->

</body>