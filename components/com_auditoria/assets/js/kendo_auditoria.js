/** * Created by Ernesto on .
 *Date:1/9/2016
 *Time:20:51 */
//Creando variables globales
var validator;
var Auditoria={};
var message=""


//Creando los windows Dialogs
wnd_auditoria = $("#auditoria_window").kendoWindow({
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
		if(Auditoria.oldElement!=null) {

			$('#fecha_auditoria').val(Auditoria.oldElement.fecha_auditoria);
			$('#fecha_reunion_apertura').val(Auditoria.oldElement.fecha_reunion_apertura);
			$('#lugar_reunion_apertura').val(Auditoria.oldElement.lugar_reunion_apertura);
			$('#dia').val(Auditoria.oldElement.dia);
			$('#nombre_auditor').val(Auditoria.oldElement.nombre_auditor);
			$('#aspectos_evaluar').val(Auditoria.oldElement.aspectos_evaluar);
			$('#fecha_reunion_auditores').val(Auditoria.oldElement.fecha_reunion_auditores);
			$('#lugar_reunion_auditores').val(Auditoria.oldElement.lugar_reunion_auditores);
			$('#fecha_reunion_clausura').val(Auditoria.oldElement.fecha_reunion_clausura);
			$('#lugar_reunion_clausura').val(Auditoria.oldElement.lugar_reunion_clausura);
			$('#nombre_enterado').val(Auditoria.oldElement.nombre_enterado);
			$('#fecha_enterado').val(Auditoria.oldElement.fecha_enterado);
			$('#comunica').val(Auditoria.oldElement.comunica);
			$('#fecha_comunica').val(Auditoria.oldElement.fecha_comunica);
			$('#id_proyecto').data("kendoDropDownList").value(Auditoria.oldElement.id_proyecto);

		}

		else
		{

			$('#id_entidad').data("kendoDropDownList").value('');
		}
	}}).data("kendoWindow");



//Definir controladora
Auditoria.oldElement=null;
/*Data Source  Perfil_proyecto*/
var perfil_proyectodatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_proyecto&task=proyecto_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Perfil_proyecto*/
$("#id_proyecto").kendoDropDownList({
	dataTextField: "nombre_proyecto",
	dataValueField: "id_proyecto",
	dataSource: perfil_proyectodatasource,
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
/*Data Source  Perfil_proyecto*/

/*Date Picker  fecha_auditoria*/
$("#fecha_auditoria").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker:true,
	format: 'yyyy/MM/dd',
	showDropdowns:true,
	readonly:true,
	open:function(e){
	},
	change:function(e){
	},
	close:function(e){
	}
});
/*Date Picker  fecha_reunion_apertura*/
$("#fecha_reunion_apertura").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker:true,
	format: 'yyyy/MM/dd',
	showDropdowns:true,
	readonly:true,
	open:function(e){
	},
	change:function(e){
	},
	close:function(e){
	}
});
/*Date Picker  fecha_reunion_auditores*/
$("#fecha_reunion_auditores").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker:true,
	format: 'yyyy/MM/dd',
	showDropdowns:true,
	readonly:true,
	open:function(e){
	},
	change:function(e){
	},
	close:function(e){
	}
});
/*Date Picker  fecha_reunion_clausura*/
$("#fecha_reunion_clausura").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker:true,
	format: 'yyyy/MM/dd',
	showDropdowns:true,
	readonly:true,
	open:function(e){
	},
	change:function(e){
	},
	close:function(e){
	}
});
/*Date Picker  fecha_enterado*/
$("#fecha_enterado").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker:true,
	format: 'yyyy/MM/dd',
	showDropdowns:true,
	readonly:true,
	open:function(e){
	},
	change:function(e){
	},
	close:function(e){
	}
});
/*Date Picker  fecha_comunica*/
$("#fecha_comunica").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker:true,
	format: 'yyyy/MM/dd',
	showDropdowns:true,
	readonly:true,
	open:function(e){
	},
	change:function(e){
	},
	close:function(e){
	}
});
$("#dia").kendoNumericTextBox({
	min:1,
	max:31

});

Auditoria.change = function onChange(arg) {
};
Auditoria.change = function onDataBinding(arg) {
};
Auditoria.dataBound=function onDataBound(arg) {
	var dataarray=this._data;
	var i=0;
	$('#all_check').prop('checked',false);
	Auditoria.kgrid=this;
}
Auditoria.finditem=function(uid){
	var dataItem=null;
	dataItem=$.map(Auditoria.gridDataSource._data,function(val,index){
		if(val.uid==uid)
		{
			return val;
		}
	});
	return dataItem[0];
}



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
					dataURI: Auditoria.gridDataSource,
					fileName: "auditoria.pdf",
					proxyURL: "+"
				});
			});
});


function showInsert_auditoria() {
	Auditoria.oldElement=null;
	validator_auditoria.hideMessages();
	$('#auditoria_form')[0].reset();
	$('#id_proyecto').data("kendoDropDownList").enable();
	$('#taskauditoria').val('insert');
	$('#accionbtn_auditoriasave_exit').text('Guardar y Salir');
	wnd_auditoria.title("Insertar Auditoria");
	$('#accionbtnauditoria_save_new').show();
	wnd_auditoria.center().open();
}

//Mostrar Ventanas
function showUpdate_auditoria(e) {
	validator_auditoria.hideMessages();
	$('#auditoria_form')[0].reset();
	var dataItem=Auditoria.finditem(e.id);
	Auditoria.oldElement= dataItem;
	$('#taskauditoria').val('update');
	$('#id_proyecto').data("kendoDropDownList").readonly();
	wnd_auditoria.title("Actualizar Auditoria");
	$('#accionbtn_auditoriasave_exit').text('Actualizar');
	$('#accionbtn_auditoriasave_new').hide();
	wnd_auditoria.center().open();
}

//Eliminar elemento
function delete_element_auditoria(e)
{
	var dataItem=Auditoria.finditem(e.id);
	var array=[];
	array.push(dataItem);
	$.MetroMessageBox({
		title: "<span class='fa fa-trash-o'></span> Eliminar ",
		content: "<p class='fg-white'>Desea eliminar este Auditoria?</p> ",
		NormalButton: "#232323",
		ActiveButton: "#008a00 ",
		buttons: " [Cancelar][Aceptar]"
	}, function (a) {
		if(a=="Aceptar")
		{
			$.ajax({
				type: "POST",
				url:"?option=com_auditoria&task=auditoria_delete_one",
				data:{
					array:JSON.stringify(array)
				},
				success:function(response){
					if(response.success==true) {                               	var message='El elemento fue eliminado con exito';
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
					Auditoria.gridDataSource.read();
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
	validator_auditoria=$("#auditoria_form").kendoValidator({
				rules:{
					unique: function(input) {
						var found=false;
						var value=input.val();
						var i=0;
						if(Auditoria.oldElement==null)
						{


							if(input.is("[id=fecha_reunion_clausura]")) {
								var	inicio = $("#fecha_reunion_auditores").data('kendoDatePicker').value();
								var	final = $("#fecha_reunion_clausura").data('kendoDatePicker').value();
								if(inicio > final){
									message = "La fecha reunion_clausura debe ser posterior a la fecha reunion_auditores";
									return $('#fecha_cumplimiento').data('kendoDatePicker').value('');
								}
							}
							if(input.is("[id=fecha_enterado]")) {
								var	inicio = $("#fecha_comunica").data('kendoDatePicker').value();
								var	final = $("#fecha_enterado").data('kendoDatePicker').value();
								if(inicio > final){
									message = "La fecha enterado debe ser posterior a la fecha comunica";
									return $('#fecha_cumplimiento').data('kendoDatePicker').value('');
								}
							}
							if(input.is("[id=lugar_reunion_apertura]")) {
								var value = $('#lugar_reunion_apertura').val();
								var size = value.length;

								if(size > 50){
									found=true;
									message="El lugar_reunion_apertura ingresado no debe exceder los 50 caracteres";
									return $('#lugar_reunion_apertura').val('');
								}
							}
							if(input.is("[id=nombre_auditor]")) {
								var value = $('#nombre_auditor').val();
								var size = value.length;

								if(size > 50){
									found=true;
									message="El nombre_auditor ingresado no debe exceder los 50 caracteres";
									return $('#nombre_auditor').val('');
								}

							}
							if(input.is("[id=aspectos_evaluar]")) {
								var value = $('#aspectos_evaluar').val();
								var size = value.length;

								if(size > 250){
									found=true;
									message="Los aspectos_evaluar ingresado no debe exceder los 250 caracteres";
									return $('#aspectos_evaluar').val('');
								}

							}
							if(input.is("[id=lugar_reunion_auditores]")) {
								var value = $('#lugar_reunion_auditores').val();
								var size = value.length;

								if(size > 250){
									found=true;
									message="El lugar_reunion_auditores ingresado no debe exceder los 250 caracteres";
									return $('#lugar_reunion_auditores').val('');
								}

							}
							if(input.is("[id=lugar_reunion_clausura]")) {
								var value = $('#lugar_reunion_clausura').val();
								var size = value.length;

								if(size > 250){
									found=true;
									message="El lugar_reunion_clausura ingresado no debe exceder los 250 caracteres";
									return $('#lugar_reunion_clausura').val('');
								}

							}
							if(input.is("[id=comunica]")) {
								var value = $('#comunica').val();
								var size = value.length;

								if(size > 50){
									found=true;
									message="La persona que comunica ingresada no debe exceder los 50 caracteres";
									return $('#comunica').val('');
								}

							}
							if(input.is("[id=nombre_enterado]")) {
								var value = $('#nombre_enterado').val();
								var size = value.length;

								if(size > 50){
									found=true;
									message="El nombre_enterado que comunica ingresada no debe exceder los 50 caracteres";
									return $('#nombre_enterado').val('');
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
	Auditoria.gridDataSource = new kendo.data.DataSource({
		transport: {
			read: {
				type:'POST',
				url:"?option=com_auditoria&task=auditoria_json_list",
				dataType: "json"
			}
		},
		change: function(e){
			console.clear();
		},
		schema:{
			model:{
				fields:{
					id_programa_auditoria:{type:"number"},
					id_programa:{type:"number"},
					programa:{type:"string"},
					id_proyecto:{type:"number"},
					proyecto:{type:"string"},
					id_entidad:{type:"number"},
					entidad:{type:"string"},
					fecha_auditoria:{type:"date"},
					fecha_reunion_apertura:{type:"date"},
					lugar_reunion_apertura:{type:"string"},
					dia:{type:"number"},
					nombre_auditor:{type:"string"},
					aspectos_evaluar:{type:"string"},
					fecha_reunion_auditores:{type:"date"},
					lugar_reunion_auditores:{type:"string"},
					fecha_reunion_clausura:{type:"date"},
					lugar_reunion_clausura:{type:"string"},
					nombre_enterado:{type:"string"},
					fecha_enterado:{type:"date"},
					comunica:{type:"string"},
					fecha_comunica:{type:"date"}

				}
			}
		},
		pageSize: 12
	});
	$("#gridselection_auditoria").kendoGrid({
		dataSource: Auditoria.gridDataSource,
		height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		groupable:true,
		detailTemplate: kendo.template($("#template_programa_auditoria").html()),
		sortable: true,
		change: Auditoria.change,
		resizable: true,
		dataBound: Auditoria.dataBound,
		dataBinding: Auditoria.dataBinding,
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
				headerTemplate: "<input class='' id='all_check_auditoria' type='checkbox'/>",
				template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
				hidden:false
			}
			,

			{
				field: "id_programa_auditoria",
				template:'<div id="item" data-text="#: id_programa_auditoria#">#: id_programa_auditoria#</div>',
				title: "Id_programa_auditoria",
				width: '5%',
				type:"number",
				hidden:true
			}
			,

			{
				field: "fecha_auditoria",
				title: "Fecha Auditoria",
				width: '10%',
				type:"date",
				format:"{0:dd-MM-yyyy}"
			}
			,

			{
				field: "fecha_reunion_apertura",
				title: "Fecha Reunión Apertura",
				width: '10%',
				type:"date",
				format:"{0:dd-MM-yyyy}"	,
				hidden:true
			}
			,

			{
				field: "lugar_reunion_apertura",
				template:'<div id="item" data-text="#: lugar_reunion_apertura#">#: lugar_reunion_apertura#</div>',
				title: "Lugar Reunión Apertura",
				width: '7%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "dia",
				template:'<div id="item" data-text="#: dia#">#: dia#</div>',
				title: "Dia",
				width: '5%',
				type:"number",
				hidden:true
			}
			,

			{
				field: "nombre_auditor",
				template:'<div id="item" data-text="#: nombre_auditor#">#: nombre_auditor#</div>',
				title: "Nombre Auditor",
				width: '10%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "aspectos_evaluar",
				template:'<div id="item" data-text="#: aspectos_evaluar#">#: aspectos_evaluar#</div>',
				title: "Aspectos Evaluar",
				width: '15%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "fecha_reunion_auditores",
				title: "Fecha Reunión Auditores",
				width: '10%',
				type:"date",
				format:"{0:dd-MM-yyyy}"	,
				hidden:true
			}
			,

			{
				field: "lugar_reunion_auditores",
				template:'<div id="item" data-text="#: lugar_reunion_auditores#">#: lugar_reunion_auditores#</div>',
				title: "Lugar Reunión Auditores",
				width: '10%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "fecha_reunion_clausura",
				title: "Fecha Reunión Clausura",
				width: '10%',
				type:"date",
				format:"{0:dd-MM-yyyy}"	,
				hidden:true
			}
			,

			{
				field: "lugar_reunion_clausura",
				template:'<div id="item" data-text="#: lugar_reunion_clausura#">#: lugar_reunion_clausura#</div>',
				title: "Lugar Reunión Clausura",
				width: '10%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "nombre_enterado",
				template:'<div id="item" data-text="#: nombre_enterado#">#: nombre_enterado#</div>',
				title: "Nombre Enterado",
				width: '10%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "fecha_enterado",
				title: "Fecha Enterado",
				width: '10%',
				type:"date",
				format:"{0:dd-MM-yyyy}"
			}
			,

			{
				field: "comunica",
				template:'<div id="item" data-text="#: comunica#">#: comunica#</div>',
				title: "Comunica",
				width: '10%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "fecha_comunica",
				title: "Fecha Comunica",
				width: '10%',
				type:"date",
				format:"{0:dd-MM-yyyy}"	,
				hidden:true
			}
			,

			{
				field: "id_proyecto",
				title: "ID",
				template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
				width: '5%',
				type:"number",
				hidden:true
			}
			,
			{
				field: "proyecto",
				title: "Proyecto",
				template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
				width: '10%',
				type:"string"
			}
			,        {
				field: "programa",
				title: "Programa",
				template:'<div id="item" data-text="#: programa#">#: programa#</div>',
				width: '10%',
				type:"string",
				hidden:true
			}
			,        {
				field: "entidad",
				title: "Entidad",
				template:'<div id="item" data-text="#: entidad#">#: entidad#</div>',
				width: '10%',
				type:"string"
			}
			,
			{
				template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_auditoria(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='ion-edit'></i></div>" +
				"<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_auditoria(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
				name:'edit',
				headerTemplate: "<p>Acciones</p>",
				width: '10%'
			}
		]
	});

	/*Acciones de los botones*/

	$('#all_check_auditoria').click(function () {
		var c = this.checked;
		$('#gridselection_auditoria :checkbox').prop('checked',c);
	});
	$('#accionbtn_auditoriasave_exit').click(function()
	{
		if (validator_auditoria.validate())
		{

			var fd = new FormData(document.querySelector("#auditoria_form"));
			var  url="?option=com_auditoria&task=auditoria_add";
			if($('#taskauditoria').val()=="update")
			{
				var olditem=JSON.stringify(Auditoria.oldElement);
				fd.append('olditem',olditem);
				var  url="?option=com_auditoria&task=auditoria_update";
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
					Auditoria.gridDataSource.read();
					$('#auditoria_form')[0].reset();
					wnd_auditoria.close();
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
	$('#accionbtn_auditoriasave_new').click(function()
	{
		if (validator_auditoria.validate())
		{

			var fd = new FormData(document.querySelector("#auditoria_form"));
			var url="?option=com_auditoria&task=auditoria_add";
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
					showInsert_auditoria();
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

	$('#cancelbtn_auditoria').click(function(){
		$('#auditoria_form')[0].reset();
		Auditoria.gridDataSource.read();
		wnd_auditoria.close();
	});

	$('#addbutton_auditoria').click(function(){
		showInsert_auditoria();
	});
	$('#deletebutton_auditoria').click(function(){
		var checkbox_checked=$('#gridselection_auditoria .check_row:checked');

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
						var dataItem=Auditoria.finditem($(this).attr('id'));
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
						url:"?option=com_auditoria&task=auditoria_delete_one",
						data:{
							array:JSON.stringify(array)
						},
						success:function(response){
							if(response.success==true) {                               	var message='El elemento fue eliminado con exito';
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
							Auditoria.gridDataSource.read();
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
