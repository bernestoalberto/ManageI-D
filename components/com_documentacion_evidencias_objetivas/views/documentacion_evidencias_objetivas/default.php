
		<?php                                                   
				defined('_JEXEC') or die('acceso no autorizado');  
				JHtml::_('behavior.formvalidation');                
				if (!JFactory::getUser()->authorise('core.admin', 'com_users')) { 
				    return JError::raiseWarning(404, JText::_('acceso no autorizado'));  
				}                                                                           
				$componentbase = $this->baseurl.'/components/'.$this->component;      ?>      
				<html xmlns="http://www.w3.org/1999/html">                                  
				<head>                                                                                     
				    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">               
				    <title>Documentacion_evidencias_objetivas Grid</title>                                                                 
				</head>                                                                                                      
				<body>                                                                                                         
				<div class="content-wrapper">	



<section class="content-header">
    <h1>
        <i class="fa fa-circle-o"></i>
  Gestionar Documentacion_evidencias_objetivas
    </h1>
    <ol class="breadcrumb">
 <div class="btn-group">
 <button type="button" class="btn btn-success">Herramientas <i class="fa fa-gears"></i></button> 
<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">               
<span class="caret"></span>                                                                                                  
 <span class="sr-only">Desplegar</span>                                                                                       
 </button> 
<ul class="dropdown-menu" role="menu">            
<li><a href="/gestionando/index.php?tmpl="component&amp;print="1"&amp;page="title="Imprimir"+onclick="window.print();return false;"> 
<i class='icon ion-printer'></i><?php  echo JText::_( 'Imprimir');?></a></li> 
<li><a href= "" title="PDF" id ="export_pdf+" onclick=""><i class='icon ion-android-document'></i> <?php  echo JText::_('Exportar a PDF');?></a></li>     
<li><a href= "+" title="Image" id ="export_img" onclick=""><i class=' ion-android-color-palette'></i> <?php  echo JText::_('Exportar a Imagen');?></a></li>  
<li><a href= "" title="SVG+" id ="export_svg" onclick=""><i class='icon ion-android-clipboard'></i> <?php  echo JText::_('Exportar a SVG');?></a></li>      
<li><a href="" title="Excel"onclick=""><i class="icon ion-social-buffer"></i> <?php  echo JText::_('Exportar a Excel');?></a></li> 
 </ul>
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
        <i class="fa fa-circle-o"></i>
        Documentacion_evidencias_objetivas
    </h1>
</section>
	<div class="box-gestionando box-primary">

       <div class="box-header">    
<button type="button" id="accionbtn_documentacion_evidencias_objetivassave_exit" class="btn btn-primary">Guardar y Salir</button>  
<button type="button" id="accionbtn_documentacion_evidencias_objetivassave_new" class="btn btn-primary">Guardar y Crear</button>    
<button type="button" id="cancelbtn_documentacion_evidencias_objetivas" class="btn bg-red btn-primary">Cancelar</button>                    
</div>

           <form role="form" method="post" id="documentacion_evidencias_objetivas_form" class="form-validate">
					            <div class="box-body">


                        <div class="input-group margin" id= "div_nombre_auditor">
                          	<span class="input-group-btn" title="Donde se define lnombre_auditor">                              
                			<label for="nombre_auditor" class="btn-addons btn-danger" style="padding-right: 5px;">nombre_auditor</label></span>  
            				<input class="form-control" value="" id="nombre_auditor" required  name="documentacion_evidencias_objetivas[nombre_auditor]"  placeholder="Inserte  nombre_auditor" type="text" >
            				<div class="k-invalid-msg" data-for="nombre_auditor"></div>
                        </div>

                        <div class="input-group margin" id= "div_nombre_auditado">
                          	<span class="input-group-btn" title="Donde se define lnombre_auditado">                              
                			<label for="nombre_auditado" class="btn-addons btn-danger" style="padding-right: 5px;">nombre_auditado</label></span>  
            				<input class="form-control" value="" id="nombre_auditado" required  name="documentacion_evidencias_objetivas[nombre_auditado]"  placeholder="Inserte  nombre_auditado" type="text" >
            				<div class="k-invalid-msg" data-for="nombre_auditado"></div>
                        </div>

                        <div class="input-group margin" id= "div_deficiencias_evidencias">
                          	<span class="input-group-btn" title="Donde se define ldeficiencias_evidencias">                              
                			<label for="deficiencias_evidencias" class="btn-addons btn-danger" style="padding-right: 5px;">deficiencias_evidencias</label></span>  
            				<input class="form-control" value="" id="deficiencias_evidencias" required  name="documentacion_evidencias_objetivas[deficiencias_evidencias]"  placeholder="Inserte  deficiencias_evidencias" type="text" >
            				<div class="k-invalid-msg" data-for="deficiencias_evidencias"></div>
                        </div>

                        <div class="input-group margin" id= "div_fecha_recogida_info">
                          	<span class="input-group-btn" title="Donde se define lfecha_recogida_info">                              
                			<label for="fecha_recogida_info" class="btn-addons btn-danger" style="padding-right: 5px;">fecha_recogida_info</label></span>  
            				<input class="form-control" value="" id="fecha_recogida_info" required  name="documentacion_evidencias_objetivas[fecha_recogida_info]"  placeholder="Inserte  fecha_recogida_info"  >
            				<div class="k-invalid-msg" data-for="fecha_recogida_info"></div>
                        </div>

                        <div class="input-group margin" id= "div_documento">
                          	<span class="input-group-btn" title="Donde se define ldocumento">                              
                			<label for="documento" class="btn-addons btn-danger" style="padding-right: 5px;">documento</label></span>  
            				<input class="form-control" value="" id="documento" required  name="documentacion_evidencias_objetivas[documento]"  placeholder="Inserte  documento" type="text" >
            				<div class="k-invalid-msg" data-for="documento"></div>
                        </div>

                        <div class="input-group margin" id= "div_id_programa">
                          	<span class="input-group-btn" title="Donde se define lid_programa">                              
                			<label for="id_programa" class="btn-addons btn-danger" style="padding-right: 5px;">id_programa</label></span>  
            				<input class="form-control" value="" id="id_programa" required  name="documentacion_evidencias_objetivas[id_programa]"  placeholder="Inserte  id_programa"  >
            				<div class="k-invalid-msg" data-for="id_programa"></div>
                        </div>

                        <div class="input-group margin" id= "div_id_proyecto">
                          	<span class="input-group-btn" title="Donde se define lid_proyecto">                              
                			<label for="id_proyecto" class="btn-addons btn-danger" style="padding-right: 5px;">id_proyecto</label></span>  
            				<input class="form-control" value="" id="id_proyecto" required  name="documentacion_evidencias_objetivas[id_proyecto]"  placeholder="Inserte  id_proyecto"  >
            				<div class="k-invalid-msg" data-for="id_proyecto"></div>
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
        <span class="info-box-text">Accion realizada </br> correctamente </span>
    </div><!-- /.info-box-content -->
</div>
<div class="info-box bg-red" style="display: none" id="message-error">
    <span class="info-box-icon"><i class="fa fa-frown-o" style="font-size: 50px"></i></span>
    <div class="info-box-content">
        <span class="info-box-text" style="font-size: 10px" id="text-error"> </span>
    </div><!-- /.info-box-content -->
</div>
