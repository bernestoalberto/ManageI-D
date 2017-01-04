/** * Created by Ernesto on .
 *Date:12/15/2015
 *Time:13:20 */
//Creando variables globales
var validator;
var Ejecutora={};
var message=""


//Creando los windows Dialogs
wnd_ejecutora = $("#ejecutora_window").kendoWindow({
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
		if(Ejecutora.oldElement!=null) {

			$('#id_entidad').data("kendoDropDownList").value(Ejecutora.oldElement.id_entidad);
			$('#numero_cuenta_bancaria').val(Ejecutora.oldElement.numero_cuenta_bancaria);
			$('#sucursal_creditos').val(Ejecutora.oldElement.sucursal_creditos);
			$('#cifra_planificada').val(Ejecutora.oldElement.cifra_planificada);
			$('#plan_CIT').val(Ejecutora.oldElement.plan_CIT);
			$('#coeficiente_gastos_directos').val(Ejecutora.oldElement.coeficiente_gastos_directos);
			$('#id_programa').data("kendoDropDownList").value(Ejecutora.oldElement.id_programa);
			//$('#id_persona_ejecutora').data("kendoDropDownList").value(Ejecutora.oldElement.id_persona);
		}

		else
		{
			//$('#id_persona_ejecutora').data("kendoDropDownList").value('');
			$('#id_entidad').data("kendoDropDownList").value('');
			$('#id_programa').data("kendoDropDownList").value('');

		}
	}}).data("kendoWindow");


$('#numero_cuenta_bancaria').kendoNumericTextBox({
	maxLength:13,
	format: "a"


});
$('#cifra_planificada').kendoNumericTextBox({
	format: "c",
	decimals: 3,
	min:1000,
	step:50,
	max:50000

});
$('#coeficiente_gastos_directos').kendoNumericTextBox({
	decimals: 3,
	step:0.1,
	min:0.1


});
//Definir controladora
Ejecutora.oldElement=null;

/*Data Source  Entidad*/
var entidaddatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_entidad&task=entidad_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Entidad*/
$("#id_entidad").kendoDropDownList({
	dataTextField: "nombre",
	dataValueField: "id_entidad",
	dataSource: entidaddatasource,
	filter: "contains",
	open: function(e) {
		valid = false;
	},
	change:function(e){

	},
	select: function(e){

	},
	close: function(e){
		// if no valid selection - clear input

	},
	suggest: true,
	index: 3
});



Ejecutora.change = function onChange(arg) {
};
Ejecutora.change = function onDataBinding(arg) {
};
Ejecutora.dataBound=function onDataBound(arg) {
	var dataarray=this._data;
	var i=0;
	$('#all_check').prop('checked',false);
	Ejecutora.kgrid=this;
}
Ejecutora.finditem=function(uid){
	var dataItem=null;
	dataItem=$.map(Ejecutora.gridDataSource._data,function(val,index){
		if(val.uid==uid)
		{
			return val;
		}
	});
	return dataItem[0];
}

function showInsert_ejecutora() {
	Ejecutora.oldElement=null;
	validator_ejecutora.hideMessages();
	$('#ejecutora_form')[0].reset();
	$('#taskejecutora').val('insert');
	$('#accionbtn_ejecutorasave_exit').text('Guardar y Salir');
	//$('#id_entidad').data("kendoDropDownList").enable();
	wnd_ejecutora.title("Insertar la Entidad Ejecutora");
	$('#accionbtnejecutora_save_new').show();
	wnd_ejecutora.center().open();
}

//Mostrar Ventanas
function showUpdate_ejecutora(e) {
	validator_ejecutora.hideMessages();
	$('#ejecutora_form')[0].reset();
	var dataItem=Ejecutora.finditem(e.id);
	Ejecutora.oldElement= dataItem;
	$('#taskejecutora').val('update');
	$('#id_entidad').data("kendoDropDownList").readonly();
	wnd_ejecutora.title("Actualizar la Entidad Ejecutora");
	$('#accionbtn_ejecutorasave_exit').text('Actualizar');
	$('#accionbtn_ejecutorasave_new').hide();
	wnd_ejecutora.center().open();
}

//Eliminar elemento
function delete_element_ejecutora(e)
{
	var dataItem=Ejecutora.finditem(e.id);
	var array=[];
	array.push(dataItem);
	$.MetroMessageBox({
		title: "<span class='fa fa-trash-o'></span> Eliminar ",
		content: "<p class='fg-white'>Desea eliminar este Ejecutora?</p> ",
		NormalButton: "#232323",
		ActiveButton: "#008a00 ",
		buttons: " [Cancelar][Aceptar]"
	}, function (a) {
		if(a=="Aceptar")
		{
			$.ajax({
				type: "POST",
				url:"?option=com_ejecutora&task=ejecutora_delete_one",
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
					Ejecutora.gridDataSource.read();
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
	validator_ejecutora=$("#ejecutora_form").kendoValidator({
				rules:{
					unique: function(input) {
						var found=false;
						var value=input.val();
						var i=0;
						if(Ejecutora.oldElement==null)
						{

							if(input.is("[id=id_entidad]")) {
								value=$('#id_entidad').data('kendoDropDownList').text();

								while (i < Ejecutora.gridDataSource._data.length) {
									var elem=Ejecutora.gridDataSource._data[i];
									if(elem.nombre.toUpperCase().trim()==value.toUpperCase().trim())
									{
										found=true;
										message="Existe un Entdidad Ejecutora con este nombre";
										i=Ejecutora.gridDataSource._data.length;
										return $('#id_entidad').data('kendoDropDownList').value('');
									}
									i++;
								}
							}
							if(input.is("[id=numero_cuenta_bancaria]")) {
								value=$('#numero_cuenta_bancaria').val();

								while (i < Ejecutora.gridDataSource._data.length) {
									var elem=Ejecutora.gridDataSource._data[i];
									if(elem.numero_cuenta_bancaria ==value)
									{
										found=true;
										message="El id_tipo_proyecto de cuenta escogido ya esta en uso";
										i=Ejecutora.gridDataSource._data.length;
										return $('#numero_cuenta_bancaria').val('');

									}
									i++;
								}
							}
							if(input.is("[id=sucursal_creditos]")) {
								var value = $('#sucursal_creditos').val();
								var size = value.length;

								if(size > 250){
									found=true;
									message="La sucursal de creditos ingresadas no debe exceder los 250 caracteres";
									return $('#sucursal_creditos').val('');
								}
							}
							if(input.is("[id=plan_CIT]")) {
								var value = $('#plan_CIT').val();
								var size = value.length;

								if(size > 250){
									found=true;
									message="El plan_CIT ingresado no debe exceder los 250 caracteres";
									return $('#plan_CIT').val('');
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
	Ejecutora.gridDataSource = new kendo.data.DataSource({
		transport: {
			read: {
				type:'POST',
				url:"?option=com_ejecutora&task=ejecutora_json_list",
				dataType: "json"
			}
		},
		/*    change: function(e){
		 console.clear();
		 },*/
		schema:{
			model:{
				fields:{
					id_entidad:{type:"number"},
					numero_cuenta_bancaria:{type:"number"},
					sucursal_creditos:{type:"string"},
					cifra_planificada:{type:"number"},
					plan_cit:{type:"string"},
					coeficiente_gastos_directos:{type:"number"},
					id_programa:{type:"string"},
					id_persona:{type:"string"}

				}
			}
		},
		pageSize: 12
	});
	$("#export_pdf").click(function() {
		kendo.drawing.drawDOM($(".content-wrapper"))
				.then(function() {
					return kendo.drawing.exportPDF({
						paperSize: "auto",
						margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
					});
				})
				.done(function() {
					kendo.saveAs({
						dataURI: Ejecutora.gridDataSource,
						fileName: "ejecutora.pdf",
						proxyURL: ""
					});
				});
	});
	$("#gridselection_ejecutora").kendoGrid({
		dataSource: Ejecutora.gridDataSource,
		height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		sortable: true,
		groupable:true,
		change: Ejecutora.change,
		resizable: true,
		dataBound: Ejecutora.dataBound,
		dataBinding: Ejecutora.dataBinding,
		detailTemplate: kendo.template($("#template_ejecutora").html()),
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
				headerTemplate: "<input class='' id='all_check_ejecutora' type='checkbox'/>",
				template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
				hidden:false
			}
			,
			{
				field: "id_entidad",
				title: "id",
				template:'<div id="item" data-text="#: id_entidad#">#: id_entidad#</div>',
				width: '6%',
				type:"number",
				hidden:true
			}
			,

			{
				field: "nombre",
				title: "Nombre",
				template:'<div id="item" data-text="#: nombre#">#:nombre#</div>',
				width: '8%',
				type:"string",
				hidden:false
			}
			,


			{
				field: "numero_cuenta_bancaria",
				template:'<div id="item" data-text="#: numero_cuenta_bancaria#">#: numero_cuenta_bancaria#</div>',
				title: "Cuenta Bancaria",
				width: '10%',
				type:"number"
			}
			,

			{
				field: "sucursal_creditos",
				template:'<div id="item" data-text="#: sucursal_creditos#">#: sucursal_creditos#</div>',
				title: "Sucursal",
				width: '10%',
				type:"string"
			}
			,

			{
				field: "cifra_planificada",
				template:'<div id="item" data-text="#: cifra_planificada#">#: cifra_planificada#</div>',
				title: "Cifra Planificada",
				width: '10%',
				type:"number"
			}
			,

			{
				field: "plan_CIT",
				template:'<div id="item" data-text="#: plan_CIT#">#: plan_CIT#</div>',
				title: "Plan CIT",
				width: '10%',
				type:"string",
				hidden:true
			}
			,

			{
				field: "coeficiente_gastos_directos",
				template:'<div id="item" data-text="#: coeficiente_gastos_directos#">#: coeficiente_gastos_directos#</div>',
				title: "CGD",
				width: '10%',
				type:"number",
				hidden:true
			}
			,

			{
				template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_ejecutora(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
				"<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_ejecutora(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
				name:'edit',
				headerTemplate: "<p>Acciones</p>",
				width: '10%'
			}
		]
	});

	/*Acciones de los botones*/

	$('#all_check_ejecutora').click(function () {
		var c = this.checked;
		$('#gridselection_ejecutora :checkbox').prop('checked',c);
	});
	$('#accionbtn_ejecutorasave_exit').click(function()
	{
		if (validator_ejecutora.validate())
		{

			var fd = new FormData(document.querySelector("#ejecutora_form"));
			var  url="?option=com_ejecutora&task=ejecutora_add";
			if($('#taskejecutora').val()=="update")
			{
				var olditem=JSON.stringify(Ejecutora.oldElement);
				fd.append('olditem',olditem);
				var  url="?option=com_ejecutora&task=ejecutora_update";
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
					Ejecutora.gridDataSource.read();
					$('#ejecutora_form')[0].reset();
					wnd_ejecutora.close();
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
	$('#accionbtn_ejecutorasave_new').click(function()
	{
		if (validator_ejecutora.validate())
		{

			var fd = new FormData(document.querySelector("#ejecutora_form"));
			var url="?option=com_ejecutora&task=ejecutora_add";
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
					showInsert_ejecutora();
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

	$('#cancelbtn_ejecutora').click(function(){
		$('#ejecutora_form')[0].reset();
		Ejecutora.gridDataSource.read();
		wnd_ejecutora.close();
	});

	$('#addbutton_ejecutora').click(function(){
		showInsert_ejecutora();
	});
	$('#deletebutton_ejecutora').click(function(){
		var checkbox_checked=$('#gridselection_ejecutora .check_row:checked');

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
						var dataItem=Ejecutora.finditem($(this).attr('id'));
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
						url:"?option=com_ejecutora&task=ejecutora_delete_one",
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
							Ejecutora.gridDataSource.read();
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
