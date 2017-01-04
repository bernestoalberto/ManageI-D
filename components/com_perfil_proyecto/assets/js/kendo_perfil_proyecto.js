/** * Created by Ernesto on .
 *Date:12/20/2015
 *Time:6:17 */
//Creando variables globales
var validator;
var Perfil_proyecto={};
var Perfil_programa={};
var message=""

Perfil_programa.finditem=function(uid){
	var dataItem=null;
	dataItem=$.map(Perfil_programa.gridDataSource._data,function(val,index){
		if(val.uid==uid)
		{
			return val;
		}
	});
	return dataItem[0];
}
Perfil_programa.gridDataSource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url: "?option=com_perfil_programa&task=perfil_programa_json_list",
			dataType: "json"
		}
	},
	change: function(e){
		console.clear();
	},

	schema:{
		model:{
			fields:{
				id_programa:{type:"number"},
				denominacion:{type:"string"},
				fundamentacion:{type:"string"},
				objetivo_especifico:{type:"string"},
				principalesResultados:{type:"string"},
				potencialHumano:{type:"string"},
				presupuesto:{type:"number"},
				plazoEjecucion:{type:"number"},
				otro:{type:"string"},
				numero_proyectos:{type:"number"},
				id_prioridad:{type:"string"},
				id_indicador:{type:"string"}

			}
		}
	},
});
//Creando los windows Dialogs
wnd_perfil_proyecto = $("#perfil_proyecto_window").kendoWindow({
	modal: true,
	visible: false,
	resizable: false,
	width: '75%',
	heigth:400,
	animation : {
		open: {
			effects: 'expand:vertical'
		},
		close: {
			effects:'expand:vertical',
			reverse: true
		}
	},
	activate:function(e){
		if(Perfil_proyecto.oldElement!=null) {

			$('#titulo_proyecto').val(Perfil_proyecto.oldElement.titulo_proyecto);
			$('#id_tipo_proyecto').data("kendoDropDownList").value(Perfil_proyecto.oldElement.id_tipo_proyecto);
			$('#id_clasificacion').data("kendoDropDownList").value(Perfil_proyecto.oldElement.id_clasificacion);
			$('#id_prioridad').data("kendoDropDownList").value(Perfil_proyecto.oldElement.id_prioridad);
			$('#clientes').val(Perfil_proyecto.oldElement.clientes);
			$('#duracion').val(Perfil_proyecto.oldElement.duracion);
			$('#otra_institucion').val(Perfil_proyecto.oldElement.otra_institucion);
			$('#presupuesto_total').val(Perfil_proyecto.oldElement.presupuesto_total);
			$('#resumen').val(Perfil_proyecto.oldElement.resumen);
			$('#fecha_recepcion').val(Perfil_proyecto.oldElement.fecha_recepcion);
			$('#id_entidad_ejecutora').data("kendoDropDownList").value(Perfil_proyecto.oldElement.id_entidad);
			$('#id_programa').data("kendoDropDownList").value(Perfil_proyecto.oldElement.id_programa);
			$('#id_persona_jefe').data("kendoDropDownList").value(Perfil_proyecto.oldElement.id_persona);
		}

		else
		{
			$('#id_tipo_proyecto').data("kendoDropDownList").value('');
			$('#id_clasificacion').data("kendoDropDownList").value('');
			$('#id_entidad_ejecutora').data("kendoDropDownList").value('');
			$('#id_persona_jefe').data("kendoDropDownList").value('');
			$('#id_programa').data("kendoDropDownList").value('');
		}
	}}).data("kendoWindow");



//Definir controladora
Perfil_proyecto.oldElement=null;
$("#duracion").kendoNumericTextBox({
	max:5,
	format: "# año(s)",
	min:1



});$("#presupuesto_total").kendoNumericTextBox({
	max:2500000,
	min:1000,
	format: "#.00 CUP",
	decimals: 3,
	step:50



});
/*Data Source  Tipo_proyecto*/
var tipo_proyectodatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_tipo_proyecto&task=tipo_proyecto_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Tipo_proyecto*/
$("#id_tipo_proyecto").kendoDropDownList({
	dataTextField: "tipo",
	dataValueField: "id_tipo_proyecto",
	dataSource: tipo_proyectodatasource,
	filter: "contains",
	open: function(e) {
		valid = false;
	},
	change:function(e){

		if(1== $("#id_tipo_proyecto").data("kendoDropDownList").value())
		{
			$("#id_prioridad").data("kendoDropDownList").readonly();
			$("#id_prioridad").data("kendoDropDownList").value('');
			$("#id_programa").data("kendoDropDownList").enable();
			$("#presupuesto_total").data('kendoNumericTextBox').enable();

		}
		else if(2== $("#id_tipo_proyecto").data("kendoDropDownList").value())
		{
			$("#id_prioridad").data("kendoDropDownList").enable();
			$("#id_programa").data("kendoDropDownList").readonly();
			$("#id_programa").data("kendoDropDownList").value('4');
			$("#presupuesto_total").data('kendoNumericTextBox').editable(true);

		}
		else{
			$("#id_programa").data("kendoDropDownList").readonly();
			$("#id_prioridad").data("kendoDropDownList").enable();
			$("#presupuesto_total").data('kendoNumericTextBox').enable();

		}




	},
	select: function(e){
		valid = true;
	},
	close: function(e){
	},
	suggest: true,
	index: 3
});
/*Data Source  Clasificacion*/
var clasificaciondatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_clasificacion&task=clasificacion_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Clasificacion*/
$("#id_clasificacion").kendoDropDownList({
	dataTextField: "nombre_clasificacion",
	dataValueField: "id_clasificacion",
	dataSource: clasificaciondatasource,
	filter: "contains",
	open: function(e) {
	},
	change:function(e){

	},
	close: function(e){
	},
	suggest: true,
	index: 3
});
var entidaddatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_ejecutora&task=ejecutora_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Entidad*/
$("#id_entidad_ejecutora").kendoDropDownList({
	dataTextField: "nombre",
	dataValueField: "id_entidad",
	dataSource: entidaddatasource,
	filter: "contains",
	open: function(e) {
		//  valid = false;
	},
	change:function(e){

	},
	select: function(e){
		//  valid = true;
	},
	close: function(e){
		// if no valid selection - clear input
		// if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});
/*Data Source  Jefeproyecto*/
var jefeproyectodatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_jefeproyecto&task=jefeproyecto_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Jefeproyecto*/
$("#id_persona_jefe").kendoDropDownList({
	dataTextField: "nombre",
	dataValueField: "id_persona",
	dataSource: jefeproyectodatasource,
	filter: "contains",
	open: function(e) {
		// valid = false;
	},
	change:function(e){

	},
	select: function(e){
		//valid = true;
	},
	close: function(e){
		// if no valid selection - clear input
		//  if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});
/*Data Source  Programa*/
var programadatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_convocatoria&task=programa_json_list",
			dataType: "json"
		}
	},
	schema:{
		model:{
			fields:{
				id_programa:{type:"string"},
				nombre:{type:"string"},
				secretarioprograma:{type:"string"},
				objetivogeneral:{type:"string"},
				grupoexpertos:{type:"string"},
				id_entidad:{type:"string"},
				id_prioridad:{type:"number"},
				id_persona:{type:"string"},
				presupuesto:{type:"number"}
			}
		}
	},
});
/*ComboBox  Programa*/
$("#id_programa").kendoDropDownList({
	dataTextField: "nombre",
	dataValueField: "id_programa",
	dataSource: programadatasource,
	filter: "contains",
	open: function(e) {
		//    valid = false;
	},
	change:function(e){
		var i=0;
		valid=false;
		var elem=null;
		while(i<this.options.dataSource._data.length)
		{
			elem=this.options.dataSource._data[i];
			if(elem.id_programa== $("#id_programa").val())
			{
				i= this.options.dataSource._data.length;
				valid=true;
			}
			i++;
		}
		if(elem!=null)
		{
			$("#presupuesto_total").data('kendoNumericTextBox').max(elem.presupuesto);
			$("#presupuesto_total").data('kendoNumericTextBox').value(elem.presupuesto);
			$("#presupuesto_total").data('kendoNumericTextBox').readonly();

		}
		if (!valid) this.value('');
	},
	select: function(e){
		//   valid = true;
	},
	close: function(e){
		// if no valid selection - clear input
		//     if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});

Perfil_proyecto.change = function onChange(arg) {
};
Perfil_proyecto.change = function onDataBinding(arg) {
};
Perfil_proyecto.dataBound=function onDataBound(arg) {
	var dataarray=this._data;
	var i=0;
	$('#all_check').prop('checked',false);
	Perfil_proyecto.kgrid=this;
}
Perfil_proyecto.finditem=function(uid){
	var dataItem=null;
	dataItem=$.map(Perfil_proyecto.gridDataSource._data,function(val,index){
		if(val.uid==uid)
		{
			return val;
		}
	});
	return dataItem[0];
}




var prioridaddatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url: "?option=com_prioridad&task=prioridad_json_list",
			dataType: "json"
		}
	}
});

/*ComboBox  Prioridad*/
$("#id_prioridad").kendoDropDownList ({
	dataTextField: "problema",
	dataValueField: "id_prioridad",
	dataSource: prioridaddatasource,
	editable:'false',
	filter: "contains",
	open: function(e) {
		valid = true;
	},
	change:function(e){

		//  if (!valid) this.value('');
	},
	select: function(e){
		valid = true;
	},
	close: function(e){
		// if no valid selection - clear input
		//    if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});

function showInsert_perfil_proyecto() {
	Perfil_proyecto.oldElement=null;
	validator_perfil_proyecto.hideMessages();
	$('#perfil_proyecto_form')[0].reset();
	$('#taskperfil_proyecto').val('insert');
	$('#accionbtn_perfil_proyectosave_exit').text('Guardar y Salir');
	wnd_perfil_proyecto.title("Crear Perfil de Proyecto");
	$('#accionbtnperfil_proyecto_save_new').show();
	wnd_perfil_proyecto.center().open();
}

//Mostrar Ventanas
function showUpdate_perfil_proyecto(e) {
	validator_perfil_proyecto.hideMessages();
	$('#perfil_proyecto_form')[0].reset();
	var dataItem=Perfil_proyecto.finditem(e.id);
	Perfil_proyecto.oldElement= dataItem;
	$('#taskperfil_proyecto').val('update');
	wnd_perfil_proyecto.title("Actualizar Perfil de Proyecto");
	$('#accionbtn_perfil_proyectosave_exit').text('Actualizar');
	$('#accionbtn_perfil_proyectosave_new').hide();
	wnd_perfil_proyecto.center().open();
}

//Eliminar elemento
function delete_element_perfil_proyecto(e)
{
	var dataItem=Perfil_proyecto.finditem(e.id);
	var array=[];
	array.push(dataItem);
	$.MetroMessageBox({
		title: "<span class='fa fa-trash-o'></span> Eliminar ",
		content: "<p class='fg-white'>Desea eliminar este Perfil_proyecto?</p> ",
		NormalButton: "#232323",
		ActiveButton: "#008a00 ",
		buttons: " [Cancelar][Aceptar]"
	}, function (a) {
		if(a=="Aceptar")
		{
			$.ajax({
				type: "POST",
				url:"?option=com_perfil_proyecto&task=perfil_proyecto_delete_one",
				data:{
					array:JSON.stringify(array)
				},
				success:function(response){
					if(response.success==true) {
						var message='El elemento fue eliminado con exito';
						$.smallBox({
							title: '',
							content: $('#message-ok').html(),
							color: "#00A65A",
							timeout: 6000
						});
					}
					else{
						$('#text-error').html(response.message);
						$.smallBox({
							title: '',
							content:$('#message-error').html(),
							color: "#BA0916",
							timeout: 6000
						});
					}
					Perfil_proyecto.gridDataSource.read();
				}
				//error:problemas
			});
		}
		else
			close();
	})
}
//On load
$(function() {
	validator_perfil_proyecto=$("#perfil_proyecto_form").kendoValidator({
				rules:{
					unique: function(input) {
						var found = false;
						var value = input.val();
						var i = 0;
						if (Perfil_proyecto.oldElement == null) {

							if (input.is("[id=id_entidad_ejecutora]")) {
								value = $('#id_entidad_ejecutora').data('kendoDropDownList').value();

								while (i < Perfil_proyecto.gridDataSource._data.length) {
									var elem = Perfil_proyecto.gridDataSource._data[i];
									if (elem.id_entidad == value ||elem.otra_institucion == value ) {
										found = true;
										message = "La entidad ejecutora seleccionada está actualmente ejecutando un proyecto";
										i = Perfil_proyecto.gridDataSource._data.length;
										return $('#id_entidad_ejecutora').data('kendoDropDownList').value('');
									}
									i++;
								}


							}
							if (input.is("[id=id_persona_jefe]")) {
								value = $('#id_persona_jefe').data('kendoDropDownList').value();


								while (i < Perfil_proyecto.gridDataSource._data.length) {
									var elem = Perfil_proyecto.gridDataSource._data[i];
									if (elem.id_persona == value) {
										found = true;
										message = "La persona seleccionada ya ejerce como jefe de proyecto";
										i = Perfil_proyecto.gridDataSource._data.length;
										return $('#id_persona_jefe').data('kendoDropDownList').value('');
									}
									i++;
								}



							}
							if (input.is("[id=titulo_proyecto]")) {
								value = $('#titulo_proyecto').val();


								while (i < Perfil_proyecto.gridDataSource._data.length) {
									var elem = Perfil_proyecto.gridDataSource._data[i];
									if (elem.titulo_proyecto == value) {
										found = true;
										message = "El titulo seleccionado ya esta definido por otro perfil";
										i = Perfil_proyecto.gridDataSource._data.length;
										return $('#titulo_proyecto').val('');
									}
									i++;
								}
								var size = value.length;

								if(size > 50){
									found=true;
									message="El titulo del proyecto  ingresado no debe exceder los 50 caracteres";
									return $('#titulo_proyecto').val('');
								}

							}
							if (input.is("[id=presupuesto_total]")) {
								value = $('#presupuesto_total').val();
								var idp = $('#id_programa').data('kendoDropDownList').value();
								var elem = Perfil_programa.finditem(idp);
								if(elem.presupuesto!=null) {
									if (elem.presupuesto < value) {
										found = true;
										alert(elem.presupuesto);
										message = "El presupuesto debe ser menor que ";
										return $('#presupuesto_total').val('');
									}
								}
							}
							if (input.is("[id=clientes]")) {
								var value = $('#clientes').val();
								var size = value.length;

								if(size > 50){
									found=true;
									message="El(los) clientes ingresada no debe exceder los 50 caracteres";
									return $('#clientes').val('');
								}
							}
							if (input.is("[id=resumen]")) {
								var value = $('#resumen').val();
								var size = value.length;

								if(size > 800){
									found=true;
									message="El resumen ingresado no debe exceder los 800 caracteres";
									return $('#resumen').val('');
								}
							}
							return !found;


						}


						return true;
					}
				},
				messages: {
					unique: function(input) {
						return message;
					},
					required:"Este campo necesita un valor"
				}

			}
	).data("kendoValidator");
	Perfil_proyecto.gridDataSource = new kendo.data.DataSource({
		transport: {
			read: {
				type:'POST',
				url:"?option=com_perfil_proyecto&task=perfil_proyecto_json_list",
				dataType: "json"
			}
		},
		change: function(e){
			//console.clear();
		},
		schema:{
			model:{
				fields:{
					id_proyecto:{type:"number"},
					titulo_proyecto:{type:"string"},
					id_tipo_proyecto:{type:"number"},
					id_clasificacion:{type:"number"},
					id_entidad:{type:"number"},
					clientes:{type:"string"},
					duracion:{type:"number"},
					presupuesto_total:{type:"number"},
					resumen:{type:"string"},
					fecha_recepcion:{type:"date"},
					id_prioridad:{type:"number"},
					problema:{type:"string"},
					id_programa:{type:"number"},
					id_persona:{type:"number"},
					otra_institucion:{type:"string"}


				}
			}
		},
		pageSize: 12
	});
	$("#gridselection_perfil_proyecto").kendoGrid({
		dataSource: Perfil_proyecto.gridDataSource,
		height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_perfil").html()),
		groupable:true,
		sortable: true,
		change: Perfil_proyecto.change,
		resizable: true,
		dataBound: Perfil_proyecto.dataBound,
		dataBinding: Perfil_proyecto.dataBinding,
		pageable: {
			buttonCount: 5,
			refresh: true,
			pageSizes: [2,10,20,30,50,100]
		},
		columns: [
			{
				field: "",
				title: "",
				width: '3%',
				headerTemplate: "<input class='' id='all_check_perfil_proyecto' type='checkbox'/>",
				template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
				hidden:false
			}
			,

			{
				field: "id_proyecto",
				template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
				title: "Id",
				width: '5%',
				type:"number",
				hidden:true
			}
			,

			{
				field: "titulo_proyecto",
				template:'<div id="item" data-text="#: titulo_proyecto#">#: titulo_proyecto#</div>',
				title: "Titulo",
				width: '10%',
				type:"string"
			}
			,

			{
				field: "id_tipo_proyecto",
				title: "ID",
				template:'<div id="item" data-text="#: id_tipo_proyecto#">#: id_tipo_proyecto#</div>',
				width: '3%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "tipo_proyecto",
				title: "Tipo",
				template:'<div id="item" data-text="#: tipo_proyecto#">#: tipo_proyecto#</div>',
				width: '8%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "id_clasificacion",
				title: "ID",
				template:'<div id="item" data-text="#: id_clasificacion#">#: id_clasificacion#</div>',
				width: '3%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "nombre_clasificacion",
				title: "clasificacion",
				template:'<div id="item" data-text="#: nombre_clasificacion#">#: nombre_clasificacion#</div>',
				width: '12%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "id_prioridad",
				template:'<div id="item" data-text="#: id_prioridad#">#: id_prioridad#</div>',
				title: "id_prioridad",
				width: '3%',
				type:"number",
				hidden:true
			},
			{
				field: "problema",
				template:'<div id="item" data-text="#: problema#">#: problema#</div>',
				title: "problema",
				width: '8%',
				type:"string",
				hidden:true
			},

			{
				field: "nombre_entidad",
				title: "Ejecutora",
				template:'<div id="item" data-text="#: nombre_entidad#">#: nombre_entidad#</div>',
				width: '12%',
				type:"string"
			},

			{
				field: "clientes",
				template:'<div id="item" data-text="#: clientes#">#: clientes#</div>',
				title: "Clientes",
				width: '8%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "duracion",
				template:'<div id="item" data-text="#: duracion#">#: duracion#</div>',
				title: "Duración(años)",
				width: '15%',
				type:"number"
			}
			,

			{
				field: "presupuesto_total",
				template:'<div id="item" data-text="#: presupuesto_total#">#: presupuesto_total#</div>',
				title: "Presupuesto(CUP)",
				width: '15%',
				type:"string"
			}
			,

			{
				field: "resumen",
				template:'<div id="item" data-text="#: resumen#">#: resumen#</div>',
				title: "Resumen",
				width: '10%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "fecha_recepcion",
				title: "Recepcion",
				width: '10%',
				type:"date",
				format:"{0:dd-MM-yyyy}"	,
				hidden:true
			}
			,

			{
				field: "id_entidad",
				title: "ID",
				template:'<div id="item" data-text="#: id_entidad#">#: id_entidad#</div>',
				width: '3%',
				type:"number",
				hidden:true
			}

			, {
				field: "id_programa",
				title: "id_programa",
				template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
				width: '3%',
				type:"number",
				hidden:true
			}

			,{
				field: "nombre_programa",
				title: "Programa",
				template:'<div id="item" data-text="#: nombre_programa#">#: nombre_programa#</div>',
				width: '12%',
				type:"string"
			}

			,
			{
				field: "id_persona",
				title: "id_persona",
				template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
				width: '3%',
				type:"number",
				hidden:true
			}
			,	{
				field: "otra_institucion",
				title: "otra_institucion",
				template:'<div id="item" data-text="#: otra_institucion#">#: otra_institucion#</div>',
				width: '3%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "nombre_persona",
				title: "JefeProyecto",
				template:'<div id="item" data-text="#: nombre_persona#">#: nombre_persona#</div>',
				width: '12%',
				type:"string"
			}
			,
			{
				template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_perfil_proyecto(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
				"<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_perfil_proyecto(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
				name:'edit',
				headerTemplate: "<p>Acciones</p>",
				width: '10%'
			}
		]
	});

	/*Acciones de los botones*/

	$('#all_check_perfil_proyecto').click(function () {
		var c = this.checked;
		$('#gridselection_perfil_proyecto :checkbox').prop('checked',c);
	});
	$('#accionbtn_perfil_proyectosave_exit').click(function()
	{
		if (validator_perfil_proyecto.validate())
		{

			var fd = new FormData(document.querySelector("#perfil_proyecto_form"));

			var  url="?option=com_perfil_proyecto&task=perfil_proyecto_add";

			if($('#taskperfil_proyecto').val()=="update")
			{
				var olditem=JSON.stringify(Perfil_proyecto.oldElement);
				fd.append('olditem',olditem);
				var  url="?option=com_perfil_proyecto&task=perfil_proyecto_update";
			}
			$.ajax({
				type: "POST",
				url:url,
				data:fd,
				cache: false,
				processData: false,
				contentType: false,
				success:function(response){
					if(response.success==true)
					{
						var message='El elemento fue insertado con exito'
						if($('#taskusuario').val()=='update')
							message='El elemento fue actualizado con exito'
						$.smallBox({
							title: '',
							content: $('#message-ok').html(),
							color: "#00A65A",
							timeout: 6000
						})
					}
					else
					{
						$('#text-error').html(response.message);
						$.smallBox({
							title: '',
							content:$('#message-error').html(),
							color: "#BA0916",
							timeout: 6000
						})
					}
					Perfil_proyecto.gridDataSource.read();
					$('#perfil_proyecto_form')[0].reset();
					wnd_perfil_proyecto.close();
				}
			});
		}   else {
			$.smallBox({
				title: "Error",
				content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
				color: "9162E",
				timeout: 4000
			});
		}
	});
	$('#accionbtn_perfil_proyectosave_new').click(function()
	{
		if (validator_perfil_proyecto.validate())
		{

			var fd = new FormData(document.querySelector("#perfil_proyecto_form"));
			var url="?option=com_perfil_proyecto&task=perfil_proyecto_add";
			$.ajax({
				type: "POST",
				url:url,
				data:fd,
				cache: false,
				processData: false,
				contentType: false,
				success:function(response){
					if(response.success==true)
					{
						var message='El elemento fue insertado con exito'
						if($('#taskusuario').val()=='update')
							message='El elemento fue actualizado con exito'
						$.smallBox({
							title: '',
							content: $('#message-ok').html(),
							color: "#00A65A",
							timeout: 6000
						})
					}
					else
					{
						$('#text-error').html(response.message);
						$.smallBox({
							title: '',
							content:$('#message-error').html(),
							color: "#BA0916",
							timeout: 6000
						})
					}
					showInsert_perfil_proyecto();
				}
			});
		}   else {
			$.smallBox({
				title: "Error",
				content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
				color: "#9162E",
				timeout: 4000
			});
		}
	});

	$('#cancelbtn_perfil_proyecto').click(function(){
		$('#perfil_proyecto_form')[0].reset();
		Perfil_proyecto.gridDataSource.read();
		wnd_perfil_proyecto.close();
	});

	$('#addbutton_perfil_proyecto').click(function(){
		showInsert_perfil_proyecto();
	});
	$('#deletebutton_perfil_proyecto').click(function(){
		var checkbox_checked=$('#gridselection_perfil_proyecto .check_row:checked');

		if(checkbox_checked.length==0)
		{

			$.smallBox({
				title: "<span class='fa fa-trash-o'></span>     Eliminar Elemento ",
				content: "<p>Debe seleccionar al menos un elemento a eliminar</p>",
				color: "#F2092A",
				timeout: 1000,
				top:10
			})
		}
		else {
			var array=[];
			checkbox_checked.each(function(){
						var dataItem=Perfil_proyecto.finditem($(this).attr('id'));
						array.push(dataItem);
					}
			);
			$.MetroMessageBox({
				title: "<span class='fa fa-trash-o'></span> Eliminar ",
				content: "<p class='fg-white'>Desea eliminar los elementos seleccionados?</p> ",
				NormalButton: "#232323",
				ActiveButton: "#008a00 ",
				buttons: " [Cancelar][Aceptar]"
			}, function (a) {
				if(a=="Aceptar")
				{
					$.ajax({
						type: "POST",
						url:"?option=com_perfil_proyecto&task=perfil_proyecto_delete_one",
						data:{
							array:JSON.stringify(array)
						},
						success:function(response){
							if(response.success==true) {
								var message='El elemento fue eliminado con exito';
								$.smallBox({
									title: '',
									content: $('#message-ok').html(),
									color: "#00A65A",
									timeout: 6000
								});
							}
							else{
								$('#text-error').html(response.message);
								$.smallBox({
									title: '',
									content:$('#message-error').html(),
									color: "#BA0916",
									timeout: 6000
								});
							}
							Perfil_proyecto.gridDataSource.read();
						}
						//error:problemas
					});
				}
				else
					close();
			})
		}
	});
});
