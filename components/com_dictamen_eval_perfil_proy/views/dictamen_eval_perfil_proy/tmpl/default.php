
		<?php

				$componentbase = $this->_basePath    ?>
				<html xmlns="http://www.w3.org/1999/html">
				<head>                                                                                     
				    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">               
				    <title>Dictámen Evaluativo del Perfil del Proyecto </title>


					<script type="text/x-kendo-template" id="template_dictamen">
						<div class="tabstrip">
							<div>
								<div class="orders"></div>
							</div>
							<div>
								<div class='employee-details'>
									<ul>
										<li><label>Observaciones:</label>#= observaciones #</li>
										<li><label>Conclusiones:</label>#= conclusiones #</li>
										<li><label>Recomendaciones:</label>#= recomendaciones #</li>
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
										Gestionar Dictámen Evaluativo del Perfil del Proyecto
									</h1>
									<ol class="breadcrumb">
										<div class="btn-group">

											<button class="btn btn-action" id="addbutton_dictamen_eval_perfil_proy" data-toggle='tooltip' title='dictamen_eval_perfil_proy_add' >
												<i class="fa fa-edit"></i> Nuevo
											</button>
											<button class="btn bg-red  btn-action" id="deletebutton_dictamen_eval_perfil_proy" data-toggle='tooltip' title='dictamen_eval_perfil_proy_delete' >
												<i class="fa fa-trash"></i> Eliminar
											</button>
										</div>
									</ol>
								</section>
								</br>
								<div class="content box box-primary">
									<div id="gridselection_dictamen_eval_perfil_proy"  style="width:100%"></div>
								</div>

								<div id="dictamen_eval_perfil_proy_window" style="display: none;" >

									<div class="box-gestionando box-primary">

										<div class="box-header">
											<button type="button" id="accionbtn_dictamen_eval_perfil_proysave_exit" class="btn btn-primary">Guardar y Salir</button>
											<button type="button" id="accionbtn_dictamen_eval_perfil_proysave_new" class="btn  btn-primary">Guardar y Crear</button>
										</div>

										<form role="form" method="post" id="dictamen_eval_perfil_proy_form" class="form-validate">
											<div class="form-group">
												<div class="row">
													<div class="col-md-4">


												<div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title=" se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
													<input class="form-control" value="" id="id_proyecto" required  name="dictamen_eval_perfil_proy[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
													<div class="k-invalid-msg" data-for="id_proyecto"></div>
												</div>
												</div>
													<div class="col-md-4">

												<div class="input-group margin" id= "div_id_evaluacion">
                          	<span class="input-group-btn" title=" se define lid_evaluacion">
                			<label for="id_evaluacion" class="btn-addons " style="padding-right: 5px;">Evaluación*</label></span>
													<input class="form-control" value="" id="id_evaluacion" required  name="dictamen_eval_perfil_proy[id_evaluacion]"  placeholder="Inserte  id_evaluacion"  >
													<div class="k-invalid-msg" data-for="id_evaluacion"></div>
												</div>
												</div>
												</div>
												<div class="form-group">
													<div class="row">
														<div class="col-md-4">

															<div class="input-group margin" id= "div_id_persona">
                          	<span class="input-group-btn" title=" se define lid_persona">
                			<label for="id_persona" class="btn-addons " style="padding-right: 5px;">Jefe Programa*</label></span>
																<input class="form-control" value="" id="id_persona" required  name="dictamen_eval_perfil_proy[id_persona]"  placeholder="Inserte  id_persona"  >
																<div class="k-invalid-msg" data-for="id_persona"></div>
															</div>
															</div>
														<div class="col-md-4">
												<div class="input-group margin" id= "div_fecha_evaluacion">
                          	<span class="input-group-btn" title=" se define lfecha_evaluacion">
                			<label for="fecha_evaluacion" class="btn-addons " style="padding-right: 5px;">Fecha Evaluación*</label></span>
													<input class="" value="" id="fecha_evaluacion" required  name="dictamen_eval_perfil_proy[fecha_evaluacion]"  placeholder="Inserte  fecha_evaluacion"  >
													<div class="k-invalid-msg" data-for="fecha_evaluacion"></div>
												</div>
												</div>
												</div>

													<div class="form-group">
														<div class="row">
															<div class="col-md-8">
												<div class="input-group margin" id= "div_criterio">
                          	<span class="input-group-btn" title=" se define lcriterio">
                			<label for="criterio" class="btn-addons " style="padding-right: 5px;">Criterio*</label></span>
													<textarea class="form-control" value="" id="criterio" required  name="dictamen_eval_perfil_proy[criterio]"  placeholder="Inserte  criterio"  ></textarea>
													<div class="k-invalid-msg" data-for="criterio"></div>
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
													<textarea class="form-control" value="" id="observaciones"   name="dictamen_eval_perfil_proy[observaciones]"  placeholder="Inserte  observaciones"></textarea>
													<div class="k-invalid-msg" data-for="observaciones"></div>
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
													<textarea class="form-control" value="" id="conclusiones" required  name="dictamen_eval_perfil_proy[conclusiones]"  placeholder="Inserte  conclusiones" ></textarea>
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
                			<label for="recomendaciones" class="btn-addons " style="padding-right: 5px;">Recomendaciones</label></span>
													<textarea class="form-control" value="" id="recomendaciones"   name="dictamen_eval_perfil_proy[recomendaciones]"  placeholder="Inserte  recomendaciones" ></textarea>
													<div class="k-invalid-msg" data-for="recomendaciones"></div>
												</div>
												</div>
												</div>
												</div>


												<input class="text-input"  value="" type="hidden" id="taskdictamen_eval_perfil_proy">
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


				</body>