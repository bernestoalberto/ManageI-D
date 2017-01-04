
<?php
defined('_JEXEC') or die('acceso no autorizado');
JHtml::_('behavior.formvalidation');
$componentbase = $this->_basePath;      ?>
<html xmlns="http://www.w3.org/1999/html">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Contrato </title>
	<script type="text/x-kendo-template" id="template_financista">
		<div class="tabstrip">

			<div>
				<div class="orders"></div>
			</div>
			<div>
				<div class='employee-details'>
					<ul>
						<li><label>plan CIT:</label>#= plan_CIT #</li>
					</ul>
				</div>
			</div>
		</div>

	</script>
	<script type="text/x-kendo-template" id="template_contrato">
		<div class="tabstrip">

			<div>
				<div class="orders"></div>
			</div>
			<div>
				<div class='employee-details'>
					<ul>
						<li><label>resultado actividades:</label>#= resultado_actividades #</li>
						<li><label>forma entrega:</label>#= forma_entrega #</li>
						<li><label>cliente representante legal:</label>#= cliente_representante_legal #</li>
						<li><label>representante entidad ejecutora:</label>#= representante_entidad_ejecutora #</li>
					</ul>
				</div>
			</div>
		</div>

	</script>
</head>
<body class="skin-blue sidebar-mini">
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li ><a data-toggle="tab" href="#finance">Financista</a></li>
		<li class="active" ><a data-toggle="tab" href="#contract">Contrato</a></li>

	</ul>

	<div class="tab-content">

		<div id="finance" class="tab-pane ">
			<div>



				<section class="content-header">
					<h1>
						Gestionar Entidad Financista
					</h1>
					<ol class="breadcrumb">
						<div class="btn-group">

							<button class="btn btn-action" id="addbutton_financista" data-toggle='tooltip' title='financista_add' >
								<i class="fa fa-edit"></i> Nuevo
							</button>
							<button class="btn bg-red  btn-action" id="deletebutton_financista" data-toggle='tooltip' title='financista_delete' >
								<i class="fa fa-trash"></i> Eliminar
							</button>
						</div>
					</ol>
				</section>
				</br>
				<div class="content box box-primary">
					<div id="gridselection_financista"  style="width:100%"></div>
				</div>

				<div id="financista_window" style="display: none;" >

					<div class="box-gestionando box-primary">

						<div class="box-header">
							<button type="button" id="accionbtn_financistasave_exit" class="btn btn-primary">Guardar y Salir</button>
							<button type="button" id="accionbtn_financistasave_new" class="btn  btn-primary">Guardar y Crear</button>
						</div>

						<form role="form" method="post" id="financista_form" class="form-validate">
							<div class="form-group">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group margin" id= "div_id_entidad">
                                       	<span class="input-group-btn" title=" se define la entidad">
                                    <label for="id_entidad" class="btn-addons " style="padding-right: 5px;">Entidad*</label></span>
											<input class="form-control" value="" id="id_entidad" required  name="financista[id_entidad]"  placeholder="Inserte  id_entidad" type="text" >
											<div class="k-invalid-msg" data-for="id_entidad"></div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="input-group margin" id= "div_id_proyecto">
                                     	<span class="input-group-btn" title=" se define el Proyecto a financiar">
                                    <label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
											<input class="form-control" value="" id="id_proyecto" required  name="financista[id_proyecto]"  placeholder="Inserte  id_proyecto" type="text" />
											<div class="k-invalid-msg" data-for="id_proyecto"></div>
										</div>
									</div>
								</div>

								<div class="input-group margin" id= "div_cifra_planificada">
                                     	<span class="input-group-btn" title=" se define la Cifra Planificada">
                                    <label for="cifra_planificada" class="btn-addons " style="padding-right: 5px;">Cifra Planificada*</label></span>
									<input class="" value="" id="cifra_planificada" required  name="financista[cifra_planificada]"  placeholder="Inserte  cifra_planificada" type="text" >
									<div class="k-invalid-msg" data-for="cifra_planificada"></div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-md-10">
											<div class="input-group margin" id= "div_plan_CIT">
                                      	<span class="input-group-btn" title=" se define el Plan de Ciencia e Innovacion Tecnólogica">
                                    <label for="plan_CIT" class="btn-addons " style="padding-right: 5px;">Plan CIT*</label></span>
												<textarea class="form-control"  id="plan_CIT" required  name="financista[plan_CIT]"  placeholder="Inserte  plan_CIT"></textarea>
												<div class="k-invalid-msg" data-for="plan_CIT"></div>
											</div>
										</div>
									</div>
								</div>





								<input class="text-input"  value="" type="hidden" id="taskfinancista">
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
		<div id="contract" class="tab-pane active">
			<div >



				<section class="content-header">
					<h1>
						Gestionar Contrato
					</h1>
					<ol class="breadcrumb">
						<div class="btn-group">

							<button class="btn btn-action" id="addbutton_contrato" data-toggle='tooltip' title='contrato_add' >
								<i class="fa fa-edit"></i> Nuevo
							</button>
							<button class="btn bg-red  btn-action" id="deletebutton_contrato" data-toggle='tooltip' title='contrato_delete' >
								<i class="fa fa-trash"></i> Eliminar
							</button>
						</div>
					</ol>
				</section>
				</br>
				<div class="content box box-primary">
					<div id="gridselection_contrato"  style="width:100%"></div>
				</div>

				<div id="contrato_window" style="display: none;" >
					<div class="box-gestionando box-primary">

						<div class="box-header">
							<button type="button" id="accionbtn_contratosave_exit" class="btn btn-primary">Guardar y Salir</button>
							<button type="button" id="accionbtn_contratosave_new" class="btn btn-primary">Guardar y Crear</button>
						</div>

						<form role="form" method="post" id="contrato_form" class="form-validate">
							<div class="form-group">
								<div class="row">
									<div class="col-md-4">

										<div class="input-group margin" id= "div_id_proyecto">
                                    	<span class="input-group-btn" title=" se define el contrato">
                                    <label for="id_proyecto_contrato" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
											<input class="" value="" id="id_proyecto_contrato" required  name="contrato[id_proyecto_contrato]"  placeholder="Inserte  proyecto"  >
											<div class="k-invalid-msg" data-for="id_proyecto_contrato"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="row">
									<div class="col-md-4">
										<div class="input-group margin" id= "div_duracionInicio">
											<label for="duracionInicio" class="btn-addons " style="padding-right: 5px;">Duración Inicio*</label>
											<input class="" value="" id="duracionInicio" required  name="contrato[duracionInicio]"  placeholder="Inserte  duracionInicio" type="text" />
											<div class="k-invalid-msg" data-for="duracionInicio"></div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="input-group margin" id= "div_duracionFinal">
											<label for="duracionFinal" class="btn-addons " style="padding-right: 5px;">Duración Final*</label>
											<input class="" value="" id="duracionFinal" required  name="contrato[duracionFinal]"  placeholder="Inserte  duracionFinal" type="text" />
											<div class="k-invalid-msg" data-for="duracionFinal"></div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-md-4">
											<div class="input-group margin" id= "div_id_forma_entrega">
												<label for="id_forma_entrega" class="btn-addons " style="padding-right: 5px;">Forma Entrega*</label>
												<input class="" value="" id="id_forma_entrega" required  name="contrato[id_forma_entrega]"  placeholder="Inserte  id_forma_entrega"  >
												<div class="k-invalid-msg" data-for="id_forma_entrega"></div>
											</div>
										</div>
										<div class="col-md-4">
											<div class="input-group margin" id= "div_fechaEntrega">
												<label for="fechaEntrega" class="btn-addons " style="padding-right: 5px;">Fecha Entrega</label>
												<input class="" value="" id="fechaEntrega" required  name="contrato[fechaEntrega]"  placeholder="Inserte  fechaEntrega" type="text"  />
												<div class="k-invalid-msg" data-for="fechaEntrega"></div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-md-4">
												<div class="input-group margin" id= "div_cliente_representante_legal">
                                    	<span class="input-group-btn" title=" se define el cliente_representante_legal">
                                    <label for="cliente_representante_legal" class="btn-addons " style="padding-right: 5px;">Cliente*</label></span>
													<input class="form-control" value="" id="cliente_representante_legal" required  name="contrato[cliente_representante_legal]"  placeholder="Inserte  cliente_representante_legal" type="text" >
													<div class="k-invalid-msg" data-for="cliente_representante_legal"></div>
												</div>
											</div>
											<div class="col-md-4">
												<div class="input-group margin" id= "div_representante_entidad_ejecutora">
                                        	<span class="input-group-btn" title=" se define el representante_entidad_ejecutora">
                                    <label for="representante_entidad_ejecutora" class="btn-addons " style="padding-right: 5px;">Representante*</label></span>
													<input class="form-control" value="" id="representante_entidad_ejecutora" required  name="contrato[representante_entidad_ejecutora]"  placeholder="Inserte  representante_entidad_ejecutora" type="text" >
													<div class="k-invalid-msg" data-for="representante_entidad_ejecutora"></div>
												</div>
											</div>
										</div>


										<div class="input-group margin" id= "div_resultado_actividades">
									  	<span class="input-group-btn" title=" se define los beneficios, resultado de la ejecución del proyecto">
									<label for="resultado_actividades" class="btn-addons " style="padding-right: 5px;">Beneficios*</label></span>
											<textarea class="form-control" value="" id="resultado_actividades" required  name="contrato[resultado_actividades]"  placeholder="Inserte  los beneficios, resultado de la ejecución del proyecto"  ></textarea>
											<div class="k-invalid-msg" data-for="resultado_actividades"></div>
										</div>

										<input class="text-input"  value="" type="hidden" id="taskcontrato">
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