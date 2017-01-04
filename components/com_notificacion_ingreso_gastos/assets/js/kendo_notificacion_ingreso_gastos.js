/** * Created by Ernesto on .
 *Date:1/3/2016
 *Time:23:17 */
//Creando variables globales
var validator;
var Notificacion_ingreso_gastos={};
var message=""


//Creando los windows Dialogs
wnd_notificacion_ingreso_gastos = $("#notificacion_ingreso_gastos_window").kendoWindow({
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
		if(Notificacion_ingreso_gastos.oldElement!=null) {

			$('#etapa').val(Notificacion_ingreso_gastos.oldElement.etapa);
			$('#id_evaluacion').data("kendoDropDownList").value(Notificacion_ingreso_gastos.oldElement.id_evaluacion);
			$('#autorizo_registrar_ingreso').val(Notificacion_ingreso_gastos.oldElement.autorizo_registrar_ingreso);
			$('#autorizo_registrar_gasto').val(Notificacion_ingreso_gastos.oldElement.autorizo_registrar_gasto);
			$('#nombre_apellidos_secretario').val(Notificacion_ingreso_gastos.oldElement.nombre_apellidos_secretario);
			$('#fecha').val(Notificacion_ingreso_gastos.oldElement.fecha);
			$('#id_proyecto_notif').data("kendoDropDownList").value(Notificacion_ingreso_gastos.oldElement.id_proyecto_notif);
		}

		else
		{

			$('#id_evaluacion').data("kendoDropDownList").value('');
			$('#id_proyecto_notif').data("kendoDropDownList").value('');
		}
	}}).data("kendoWindow");



//Definir controladora
Notificacion_ingreso_gastos.oldElement=null;

$("#fecha").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker: true,
	format: 'yyyy/MM/dd',
	showDropdowns: true
});
/*Data Source  Evaluacion*/
var evaluaciondatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_evaluacion&task=evaluacion_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Evaluacion*/
$("#id_evaluacion").kendoDropDownList({
	dataTextField: "evaluacion",
	dataValueField: "id_evaluacion",
	dataSource: evaluaciondatasource,
	filter: "contains",
	open: function(e) {
		valid = false;
	},
	change:function(e){
		var i=0;
		valid=false;
		while(i<this.options.dataSource._data.length)
		{
			var elem=this.options.dataSource._data[i];
			if(elem.id_evaluacion== $("#id_evaluacion").val())
			{
				i= this.options.dataSource._data.length;
				valid=true;
			}
			i++;
		}
		if (!valid) this.value('');
	},
	select: function(e){
		valid = true;
	},
	close: function(e){
		// if no valid selection - clear input
		if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});
/*Data Source  Programa*/
var proyectodatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_proyecto&task=proyecto_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Proyecto*/
$("#id_proyecto_notif").kendoDropDownList({
	dataTextField: "nombre_proyecto",
	dataValueField: "id_proyecto",
	dataSource: proyectodatasource,
	filter: "contains",
	open: function(e) {
		valid = false;
	},
	change:function(e){

	},
	select: function(e){
		valid = true;
	},
	close: function(e){

	},
	suggest: true,
	index: 3
});
Notificacion_ingreso_gastos.change = function onChange(arg) {
};
Notificacion_ingreso_gastos.change = function onDataBinding(arg) {
};
Notificacion_ingreso_gastos.dataBound=function onDataBound(arg) {
	var dataarray=this._data;
	var i=0;
	$('#all_check').prop('checked',false);
	Notificacion_ingreso_gastos.kgrid=this;
}
Notificacion_ingreso_gastos.finditem=function(uid){
	var dataItem=null;
	dataItem=$.map(Notificacion_ingreso_gastos.gridDataSource._data,function(val,index){
		if(val.uid==uid)
		{
			return val;
		}
	});
	return dataItem[0];
}

$("#autorizo_registrar_ingreso").kendoNumericTextBox({
	max:500000,
	min:100,
	format: "#.00 CUP",
	decimals: 3,
	step:50



});

$("#autorizo_registrar_gasto").kendoNumericTextBox({
	max:500000,
	min:100,
	format: "#.00 CUP",
	decimals: 3,
	step:50



});



$("#export_pdf").click(function() {
	kendo.drawing.drawDOM($("#wrapperc"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function() {
				kendo.saveAs({
					dataURI: data,
					fileName: "notificacion_ingreso_gastos.pdf",
					proxyURL: "+"
				});
			});
});


function showInsert_notificacion_ingreso_gastos() {
	Notificacion_ingreso_gastos.oldElement=null;
	validator_notificacion_ingreso_gastos.hideMessages();
	$('#notificacion_ingreso_gastos_form')[0].reset();
	$('#tasknotificacion_ingreso_gastos').val('insert');
	$('#accionbtn_notificacion_ingreso_gastossave_exit').text('Guardar y Salir');
	wnd_notificacion_ingreso_gastos.title("Insertar Notificación de Ingresos y Gastos");
	$('#accionbtnnotificacion_ingreso_gastos_save_new').show();
	wnd_notificacion_ingreso_gastos.center().open();
}

//Mostrar Ventanas
function showUpdate_notificacion_ingreso_gastos(e) {
	validator_notificacion_ingreso_gastos.hideMessages();
	$('#notificacion_ingreso_gastos_form')[0].reset();
	var dataItem=Notificacion_ingreso_gastos.finditem(e.id);
	Notificacion_ingreso_gastos.oldElement= dataItem;
	$('#tasknotificacion_ingreso_gastos').val('update');
	wnd_notificacion_ingreso_gastos.title("Actualizar Notificación de Ingresos y Gastos");
	$('#accionbtn_notificacion_ingreso_gastossave_exit').text('Actualizar');
	$('#accionbtn_notificacion_ingreso_gastossave_new').hide();
	wnd_notificacion_ingreso_gastos.center().open();
}

//Eliminar elemento
function delete_element_notificacion_ingreso_gastos(e)
{
	var dataItem=Notificacion_ingreso_gastos.finditem(e.id);
	var array=[];
	array.push(dataItem);
	$.MetroMessageBox({
		title: "<span class='fa fa-trash-o'></span> Eliminar ",
		content: "<p class='fg-white'>Desea eliminar este Notificacion_ingreso_gastos?</p> ",
		NormalButton: "#232323",
		ActiveButton: "#008a00 ",
		buttons: " [Cancelar][Aceptar]"
	}, function (a) {
		if(a=="Aceptar")
		{
			$.ajax({
				type: "POST",
				url:"?option=com_notificacion_ingreso_gastos&task=notificacion_ingreso_gastos_delete_one",
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
					Notificacion_ingreso_gastos.gridDataSource.read();
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
	validator_notificacion_ingreso_gastos=$("#notificacion_ingreso_gastos_form").kendoValidator({
				rules:{
					unique: function(input) {
						var found=false;
						var value=input.val();
						var i=0;
						if(Notificacion_ingreso_gastos.oldElement==null)
						{

							/*	if(input.is("[id=autorizo_registrar_gasto]")) {
							 ingreso=$('#autorizo_registrar_ingreso').data('kendoNumericTextBox').value();
							 gasto=$('#autorizo_registrar_gasto').data('kendoNumericTextBox').value();


							 if(ingreso<gasto)
							 {
							 found=true;
							 message="El gasto debe ser menor que el ingreso";
							 return $('#autorizo_registrar_gasto').data('kendoNumericTextBox').value('');
							 }

							 }*/
							if(input.is("[id=id_proyecto_notif]")) {
								value = $('#id_proyecto_notif').data('kendoDropDownList').value();
								var anno = $('#annonotif').val();
								var periodo;

								if ($('#etapa1n').prop("checked")) {
									periodo = $('#etapa1n').val();

								}
								else if ($('#etapa2n').prop("checked")) {
									periodo = $('#etapa2n').val();

								}
								else if ($('#etapa3n').prop("checked") ) {
									periodo = $('#etapa3n').val();
								}
								else{
									periodo = $('#etapa4n').val();
								}
								while (i < Notificacion_ingreso_gastos.gridDataSource._data.length) {
									var elem = Notificacion_ingreso_gastos.gridDataSource._data[i];
									if (elem.id_proyecto==value&& elem.etapa== periodo && elem.anno==anno)
									{
										found=true;
										message="Existe una notificación de ingresos y gastos para esta etapa, año y proyecto";
										i=Notificacion_ingreso_gastos.gridDataSource._data.length;
										return $('#id_proyecto_notif').data('kendoDropDownList').value('');
									}
									i++;
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
	Notificacion_ingreso_gastos.gridDataSource = new kendo.data.DataSource({
		transport: {
			read: {
				type:'POST',
				url:"?option=com_notificacion_ingreso_gastos&task=notificacion_ingreso_gastos_json_list",
				dataType: "json"
			}
		},
		change: function(e){
			//console.clear();
		},
		schema:{
			model:{
				fields:{
					id_notif_ingresos_gastos:{type:"number"},
					anno:{type:"number"},
					etapa:{type:"string"},
					id_anticipo:{type:"number"},
					cantidad_anticipa:{type:"number"},
					id_evaluacion:{type:"number"},
					evaluacion:{type:"string"},
					autorizo_registrar_ingreso:{type:"number"},
					autorizo_registrar_gasto:{type:"number"},
					fecha:{type:"date"},
					id_proyecto_notif:{type:"number"},
					proyecto:{type:"string"},
					id_programa:{type:"number"},
					programa:{type:"string"},
					nombre_apellidos_secretario:{type:"number"},
					secretario:{type:"string"}


				}
			}
		},
		pageSize: 12
	});
	$("#gridselection_notificacion_ingreso_gastos").kendoGrid({
		dataSource: Notificacion_ingreso_gastos.gridDataSource,
		height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_notify").html()),
		groupable:true,
		sortable: true,
		change: Notificacion_ingreso_gastos.change,
		resizable: true,
		dataBound: Notificacion_ingreso_gastos.dataBound,
		dataBinding: Notificacion_ingreso_gastos.dataBinding,
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
				headerTemplate: "<input class='' id='all_check_notificacion_ingreso_gastos' type='checkbox'/>",
				template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
				hidden:false
			}
			,

			{
				field: "id_notif_ingresos_gastos",
				template:'<div id="item" data-text="#: id_notif_ingresos_gastos#">#: id_notif_ingresos_gastos#</div>',
				title: "Id",
				width: '5%',
				type:"number",
				hidden:true
			}
			,   {
				field: "anno",
				template:'<div id="item" data-text="#: anno#">#: anno#</div>',
				title: "Año",
				width: '10%',
				type:"number",
				hidden:false
			}
			,

			{
				field: "id_programa",
				template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
				title: "id_programa",
				width: '5%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "programa",
				template:'<div id="item" data-text="#: programa#">#: programa#</div>',
				title: "programa",
				width: '20%',
				type:"string",
				hidden:true
			}
			,
			{
				field: "id_proyecto_notif",
				template:'<div id="item" data-text="#: id_proyecto_notif#">#: id_proyecto_notif#</div>',
				title: "id_proyecto_notif",
				width: '5%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "proyecto",
				template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
				title: "Proyecto",
				width: '20%',
				type:"string"
			}
			,

			{
				field: "etapa",
				template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
				title: "Etapa",
				width: '12%',
				type:"string"
			}
			,

			{
				field: "id_anticipo",
				title: "ID",
				template:'<div id="item" data-text="#: id_anticipo#">#: id_anticipo#</div>',
				width: '5%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "cantidad_anticipa",
				title: "Anticipo(CUP)",
				template:'<div id="item" data-text="#: cantidad_anticipa#">#: cantidad_anticipa#</div>',
				width: '15%',
				type:"number",
				hidden:true
			}
			,

			{
				field: "id_evaluacion",
				title: "ID",
				template:'<div id="item" data-text="#: id_evaluacion#">#: id_evaluacion#</div>',
				width: '5%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "evaluacion",
				title: "Evaluación",
				template:'<div id="item" data-text="#: evaluacion#">#: evaluacion#</div>',
				width: '15%',
				type:"string"
			}
			,

			{
				field: "autorizo_registrar_ingreso",
				template:'<div id="item" data-text="#: autorizo_registrar_ingreso#">#: autorizo_registrar_ingreso#</div>',
				title: "Ingreso(CUP)",
				width: '15%',
				type:"number"
			}
			,

			{
				field: "autorizo_registrar_gasto",
				template:'<div id="item" data-text="#: autorizo_registrar_gasto#">#: autorizo_registrar_gasto#</div>',
				title: "Gasto(CUP)",
				width: '15%',
				type:"number"
			}
			,

			{
				field: "nombre_apellidos_secretario",
				template:'<div id="item" data-text="#: nombre_apellidos_secretario#">#: nombre_apellidos_secretario#</div>',
				title: "Nombre_apellidos_secretario",
				width: '7%',
				type:"number",
				hidden:true
			}
			,  {
				field: "secretario",
				template:'<div id="item" data-text="#: secretario#">#: secretario#</div>',
				title: "Secretario",
				width: '10%',
				type:"number",
				hidden:true
			}
			,

			{
				field: "fecha",
				title: "Fecha_Firma",
				width: '7%',
				type:"date",
				format:"{0:dd-MM-yyyy}",
				hidden:true
			}
			,
			{
				template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_notificacion_ingreso_gastos(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
				"<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_notificacion_ingreso_gastos(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
				name:'edit',
				headerTemplate: "<p>Acciones</p>",
				width: '10%'
			}
		]
	});

	/*Acciones de los botones*/

	$('#all_check_notificacion_ingreso_gastos').click(function () {
		var c = this.checked;
		$('#gridselection_notificacion_ingreso_gastos :checkbox').prop('checked',c);
	});
	$('#accionbtn_notificacion_ingreso_gastossave_exit').click(function()
	{
		if (validator_notificacion_ingreso_gastos.validate())
		{

			var fd = new FormData(document.querySelector("#notificacion_ingreso_gastos_form"));
			var  url="?option=com_notificacion_ingreso_gastos&task=notificacion_ingreso_gastos_add";
			if($('#tasknotificacion_ingreso_gastos').val()=="update")
			{
				var olditem=JSON.stringify(Notificacion_ingreso_gastos.oldElement);
				fd.append('olditem',olditem);
				var  url="?option=com_notificacion_ingreso_gastos&task=notificacion_ingreso_gastos_update";
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
					Notificacion_ingreso_gastos.gridDataSource.read();
					$('#notificacion_ingreso_gastos_form')[0].reset();
					wnd_notificacion_ingreso_gastos.close();
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
	$('#accionbtn_notificacion_ingreso_gastossave_new').click(function()
	{
		if (validator_notificacion_ingreso_gastos.validate())
		{

			var fd = new FormData(document.querySelector("#notificacion_ingreso_gastos_form"));
			var url="?option=com_notificacion_ingreso_gastos&task=notificacion_ingreso_gastos_add";
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
					showInsert_notificacion_ingreso_gastos();
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

	$('#cancelbtn_notificacion_ingreso_gastos').click(function(){
		$('#notificacion_ingreso_gastos_form')[0].reset();
		Notificacion_ingreso_gastos.gridDataSource.read();
		wnd_notificacion_ingreso_gastos.close();
	});

	$('#addbutton_notificacion_ingreso_gastos').click(function(){
		showInsert_notificacion_ingreso_gastos();
	});
	$('#deletebutton_notificacion_ingreso_gastos').click(function(){
		var checkbox_checked=$('#gridselection_notificacion_ingreso_gastos .check_row:checked');

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
						var dataItem=Notificacion_ingreso_gastos.finditem($(this).attr('id'));
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
						url:"?option=com_notificacion_ingreso_gastos&task=notificacion_ingreso_gastos_delete_one",
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
							Notificacion_ingreso_gastos.gridDataSource.read();
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
