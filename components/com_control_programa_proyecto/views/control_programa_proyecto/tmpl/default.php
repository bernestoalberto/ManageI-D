
		<?php                                                   
				defined('_JEXEC') or die('acceso no autorizado');  
				JHtml::_('behavior.formvalidation');
				$componentbase = $this->_basePath;      ?>
				<html xmlns="http://www.w3.org/1999/html">                                  
				<head>                                                                                     
				    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">               
				    <title>Control Proyecto </title>
					<script type="text/x-kendo-template" id="template_control">
						<div class="tabstrip">

							<div>
								<div class="orders"></div>
							</div>
							<div>
								<div class='employee-details'>
									<ul>
										<li><label>Código:</label>#= codigo #</li>
										<li><label>Provincia:</label>#= provincia #</li>
										<li><label>Finacista:</label>#= finacista #</li>
										<li><label>Invitado:</label>#= invitado #</li>
										<li><label>Problema:</label>#= problema #</li>
										<li><label>Otros Aspectos:</label>#= otros_aspectos #</li>
										<li><label>Acuerdos Adoptados:</label>#= acuerdos_adoptados #</li>
										<li><label>Evaluador:</label>#= nombre_apellidos_evaluador #</li>
										<li><label>Fecha Firma Evaluador:</label>#= fecha_firma_evaluador #</li>
										<li><label>Evaluado:</label>#= nombre_apellidos_evaluado #</li>
										<li><label>Fecha Firma Evaluado:</label>#= fecha_firma_evaluado #</li>
									</ul>
								</div>
							</div>
						</div>

					</script>
				</head>                                                                                                      
				<body>                                                                                                         
				<div >



<section class="content-header">
    <h1>
   Control a  Proyecto
    </h1>
    <ol class="breadcrumb">
 <div class="btn-group">

        <button class="btn btn-action" id="addbutton_control_programa_proyecto" data-toggle='tooltip' title='control_programa_proyecto_add' >
            <i class="fa fa-edit"></i> Nuevo
        </button>
        <button class="btn bg-red  btn-action" id="deletebutton_control_programa_proyecto" data-toggle='tooltip' title='control_programa_proyecto_delete' >
            <i class="fa fa-trash"></i> Eliminar
        </button>
         </div> 
     </ol>
</section> 
  </br>
    <div class="content box box-primary">
        <div id="gridselection_control_programa_proyecto"  style="width:100%"></div>
</div>

<div id="control_programa_proyecto_window" style="display: none;" >

	<div class="box-gestionando box-primary">

       <div class="box-header">    
<button type="button" id="accionbtn_control_programa_proyectosave_exit" class="btn btn-primary">Guardar y Salir</button>
<button type="button" id="accionbtn_control_programa_proyectosave_new" class="btn btn-primary">Guardar y Crear</button>
</div>

           <form role="form" method="post" id="control_programa_proyecto_form" class="form-validate">
			   <div class="form-group">
				   <div class="row">
					   <div class="col-md-4">
									<div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">
                			<label for="id_proyecto" class="btn-addons " style="padding-right: 5px;">Proyecto*</label></span>
										<input class="form-control" value="" id="id_proyecto" required  name="control_programa_proyecto[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
										<div class="k-invalid-msg" data-for="id_proyecto"></div>
									</div>
									</div>
					   <div class="col-md-4">
									<div class="input-group margin" id= "div_id_estado_ejecucion_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_estado_ejecucion_proyecto">
                			<label for="id_estado_ejecucion_proyecto" class="btn-addons " style="padding-right: 5px;">Estado Ejecución Proyecto*</label></span>
										<input class="form-control" value="" id="id_estado_ejecucion_proyecto" required  name="control_programa_proyecto[id_estado_ejecucion_proyecto]"  placeholder="Inserte  id_estado_ejecucion_proyecto"  >
										<div class="k-invalid-msg" data-for="id_estado_ejecucion_proyecto"></div>
									</div>
									</div>

									</div>
				   <div class="form-group">
					   <div class="row">
				   <div class="col-md-4">
					   <div class="input-group margin" id= "div_fecha_control">
                          	<span class="input-group-btn" title="Donde se define lfecha_control">
                			<label for="fecha_control" class="btn-addons " style="padding-right: 5px;">Fecha Control*</label></span>
						   <input class="" value="" id="fecha_control" required  name="control_programa_proyecto[fecha_control]"  placeholder="Inserte  fecha_control"  >
						   <div class="k-invalid-msg" data-for="fecha_control"></div>
					   </div>
					   </div>
					   </div>
					   </div>
				   <div class="form-group">
					   <div class="row">
						   <div class="col-md-4">

									<div class="input-group margin" id= "div_participante">
                          	<span class="input-group-btn" title="Donde se define lparticipante">
                			<label for="participante" class="btn-addons " style="padding-right: 5px;">Participante*</label></span>
										<input class="form-control" value="" id="participante" required  name="control_programa_proyecto[participante]"  placeholder="Inserte  participante" type="text" >
										<div class="k-invalid-msg" data-for="participante"></div>
									</div>
									</div>
						   <div class="col-md-4">
									<div class="input-group margin" id= "div_id_problema_detectado">
                          	<span class="input-group-btn" title="Donde se define lid_problema_detectado">
                			<label for="id_problema_detectado" class="btn-addons " style="padding-right: 5px;">Problema Detectado*</label></span>
										<input class="form-control" value="" id="id_problema_detectado" required  name="control_programa_proyecto[id_problema_detectado]"  placeholder="Inserte  id_problema_detectado"  >
										<div class="k-invalid-msg" data-for="id_problema_detectado"></div>
									</div>
									</div>
									</div>

					   <div class="form-group">
						   <div class="row">
							   <div class="col-md-4">

									<div class="input-group margin" id= "div_nombre_apellidos_evaluador">
                          	<span class="input-group-btn" title="Donde se define lnombre_apellidos_evaluador">
                			<label for="nombre_apellidos_evaluador" class="btn-addons " style="padding-right: 5px;">Evaluador*</label></span>
										<input class="form-control" value="" id="nombre_apellidos_evaluador" required  name="control_programa_proyecto[nombre_apellidos_evaluador]"  placeholder="Inserte  nombre_apellidos_evaluador" type="text" >
										<div class="k-invalid-msg" data-for="nombre_apellidos_evaluador"></div>
									</div>
									</div>
							   <div class="col-md-4">
									<div class="input-group margin" id= "div_fecha_firma_evaluador">
                          	<span class="input-group-btn" title="Donde se define lfecha_firma_evaluador">
                			<label for="fecha_firma_evaluador" class="btn-addons " style="padding-right: 5px;">Fecha Firma Evaluador*</label></span>
										<input class="" value="" id="fecha_firma_evaluador" required  name="control_programa_proyecto[fecha_firma_evaluador]"  placeholder="Inserte  fecha_firma_evaluador"  >
										<div class="k-invalid-msg" data-for="fecha_firma_evaluador"></div>
									</div>
									</div>
									</div>
						   <div class="form-group">
							   <div class="row">
								   <div class="col-md-4">
									<div class="input-group margin" id= "div_nombre_apellidos_evaluado">
                          	<span class="input-group-btn" title="Donde se define lnombre_apellidos_evaluado">
                			<label for="nombre_apellidos_evaluado" class="btn-addons " style="padding-right: 5px;">Evaluado*</label></span>
										<input class="form-control" value="" id="nombre_apellidos_evaluado" required  name="control_programa_proyecto[nombre_apellidos_evaluado]"  placeholder="Inserte  nombre_apellidos_evaluado" type="text" >
										<div class="k-invalid-msg" data-for="nombre_apellidos_evaluado"></div>
									</div>
									</div>
								   <div class="col-md-4">
									<div class="input-group margin" id= "div_fecha_firma_evaluado">
                          	<span class="input-group-btn" title="Donde se define lfecha_firma_evaluado">
                			<label for="fecha_firma_evaluado" class="btn-addons " style="padding-right: 5px;">Fecha Firma Evaluado*</label></span>
										<input class="" value="" id="fecha_firma_evaluado" required  name="control_programa_proyecto[fecha_firma_evaluado]"  placeholder="Inserte  fecha_firma_evaluado"  >
										<div class="k-invalid-msg" data-for="fecha_firma_evaluado"></div>
									</div>
									</div>
									</div>
							   <div class="form-group">
								   <div class="row">
									   <div class="col-md-9">
					   <div class="input-group margin" id= "div_acuerdos_adoptados">
                          	<span class="input-group-btn" title="Donde se define lacuerdos_adoptados">
                			<label for="acuerdos_adoptados" class="btn-addons " style="padding-right: 5px;">Acuerdos Adoptados*</label></span>
						   <textarea class="form-control" value="" id="acuerdos_adoptados" required  name="control_programa_proyecto[acuerdos_adoptados]"  placeholder="Inserte  acuerdos_adoptados"  ></textarea>
						   <div class="k-invalid-msg" data-for="acuerdos_adoptados"></div>
					   </div>
					   </div>
					   </div>
					   </div>
							   <div class="form-group">
								   <div class="row">
									   <div class="col-md-9">
					   <div class="input-group margin" id= "div_otros_aspectos">
                          	<span class="input-group-btn" title="Donde se define lotros_aspectos">
                			<label for="otros_aspectos" class="btn-addons " style="padding-right: 5px;">Otros Aspectos</label></span>
						   <textarea class="form-control" value="" id="otros_aspectos"   name="control_programa_proyecto[otros_aspectos]"  placeholder="Inserte  otros_aspectos"  ></textarea>
						   <div class="k-invalid-msg" data-for="otros_aspectos"></div>
					   </div>
									   </div>
								   </div>
							   </div>





                	<input class="text-input"  value="" type="hidden" id="taskcontrol_programa_proyecto">
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
