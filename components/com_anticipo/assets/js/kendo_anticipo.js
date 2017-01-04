/** * Created by Ernesto on .
 *Date:1/4/2016  
 *Time:0:3 */
//Creando variables globales
	var validator;
	var Anticipo={};
	var message=""


	//Creando los windows Dialogs
	wnd_anticipo = $("#anticipo_window").kendoWindow({
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
        				if(Anticipo.oldElement!=null) {
							
				    			$('#cantidad_anticipa').val(Anticipo.oldElement.cantidad_anticipa);
				    			$('#nombre_apellidos_secretario').val(Anticipo.oldElement.nombre_apellidos_secretario);
				    			$('#fecha_recibe').val(Anticipo.oldElement.fecha_recibe);
				    			$('#cuenta_bancaria').val(Anticipo.oldElement.cuenta_bancaria);
				    			$('#sucursal_creditos').val(Anticipo.oldElement.sucursal_creditos);
				    			$('#nombre_recibe').val(Anticipo.oldElement.nombre_recibe);
				    			$('#cargo_recibe').val(Anticipo.oldElement.cargo_recibe);
				    			$('#id_proyecto').data("kendoDropDownList").value(Anticipo.oldElement.id_proyecto);
				    			$('#id_programa').data("kendoDropDownList").value(Anticipo.oldElement.id_programa);
							     $('#fecha_firma').val(Anticipo.oldElement.fecha_recibe);
						}

						else
						{

				    			$('#id_programa').data("kendoDropDownList").value('');
				    			$('#id_proyecto').data("kendoDropDownList").value('');

						}
			    }}).data("kendoWindow");



	//Definir controladora
	Anticipo.oldElement=null;

$("#cantidad_anticipa").kendoNumericTextBox({
	max:5000,
	min:100,
	format: "#.00 CUP",
	decimals: 3,
	step:50



});


		/*Data Source  Proyecto*/
	var proyectodatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_contrato&task=proyecto_combo_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Proyecto*/
		$("#id_proyecto").kendoDropDownList({
        dataTextField: "nombre_proyecto",
        dataValueField: "id_proyecto",
        dataSource: proyectodatasource,
        filter: "contains",
		 open: function(e) {

        },
		 change:function(e){
        },
        select: function(e){

        },
        close: function(e){
        },
        suggest: true,
        index: 3
    });

		/*Date Picker  fecha_recibe*/
		$("#fecha_recibe").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
		})
		;		/*Date Picker  $('#fecha_firma').*/
		$("#fecha_firma").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
		})
		;
	Anticipo.change = function onChange(arg) {
};
	Anticipo.change = function onDataBinding(arg) {
};
	Anticipo.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Anticipo.kgrid=this;
		}
	Anticipo.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Anticipo.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}





				function showInsert_anticipo() {
					Anticipo.oldElement=null;
					validator_anticipo.hideMessages();
		    		$('#anticipo_form')[0].reset();
		    		$('#taskanticipo').val('insert');
                   $('#accionbtn_anticiposave_exit').text('Guardar y Salir');         
		    		wnd_anticipo.title("Crear Anticipo");
                   $('#accionbtnanticipo_save_new').show();
		    		wnd_anticipo.center().open();
				}

//Mostrar Ventanas
				function showUpdate_anticipo(e) {
					validator_anticipo.hideMessages();
				    $('#anticipo_form')[0].reset();
				    var dataItem=Anticipo.finditem(e.id);
				    Anticipo.oldElement= dataItem;
				    $('#taskanticipo').val('update');
				    wnd_anticipo.title("Actualizar Anticipo");
                   $('#accionbtn_anticiposave_exit').text('Actualizar');                   
                   $('#accionbtn_anticiposave_new').hide();                                 
				    wnd_anticipo.center().open();
				}

//Eliminar elemento
function delete_element_anticipo(e)
{
    var dataItem=Anticipo.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Anticipo?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
		if(a=="Aceptar")
		{
			$.ajax({
				type: "POST",
				url:"?option=com_anticipo&task=anticipo_delete_one",
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
					Anticipo.gridDataSource.read();
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
	validator_anticipo=$("#anticipo_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Anticipo.oldElement==null){

								if(input.is("[id=fecha_recibe]")) {
									var	inicio = $("#fecha_recibe").data('kendoDatePicker').value();
									var	final = $("#fecha_firma").data('kendoDatePicker').value();
									if(final!=null&& inicio > final){
										message = "La fecha de recepcion debe ser superior a la fecha de firma";
										return $('#fecha_recibe').data('kendoDatePicker').value('');
									}
								}
								if(input.is("[id=fecha_firma]")) {
									var	inicio = $("#fecha_recibe").data('kendoDatePicker').value();
									var	entrega = $("#fecha_firma").data('kendoDatePicker').value();
									if(inicio!=null&&inicio > entrega){
										message = "La fecha de  firma debe  ser posterior a la fecha recepcion";
										return $('#fecha_firma').data('kendoDatePicker').value('');
									}
								}
								if(input.is("[id=id_proyecto]")) {
									var	etapa ;
									var	anno = $("#anno").val();
									value = $("#id_proyecto").data('kendoDropDownList').value();
									if ($('#etapa1').prop("checked") ) {
										etapa = "enero-marzo";

									}
									else if ($('#etapa2').prop("checked")) {
										etapa = "abril-junio";

									}
									else if ($('#etapa3').prop("checked")) {
										etapa = "julio-septiembre";
									}
									else{
										etapa = "octubre-diciembre";
									}
									while (i < Anticipo.gridDataSource._data.length) {
										var elem=Anticipo.gridDataSource._data[i];
										if(elem.etapa==etapa && elem.anno==anno && elem.id_proyecto==value)
										{
											found=true;
											message = "Ya  se anticipo dinero a este proyecto para esta etapa y año";
											i=Anticipo.gridDataSource._data.length;
											return $('#id_proyecto').data('kendoDropDownList').value('');
										}
										i++;
									}



								}
							if(input.is("[id=nombre_recibe]")) {
									 value = $('#nombre_recibe').val();
									var size = value.length;

									if(size > 35){
										found=true;
										message="El texto ingresado no debe exceder los 35 caracteres";
										return $('#nombre_recibe').val('');
									}
								}

								if(input.is("[id=cargo_recibe]")) {
									 value = $('#cargo_recibe').val();
									var size = value.length;

									if(size > 35){
										found=true;
										message="El cargo de la persona que recibe ingresado no debe exceder los 35 caracteres";
										return $('#cargo_recibe').val('');

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
	Anticipo.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_anticipo&task=anticipo_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
					id_anticipo:{type:"number"},
					id_programa:{type:"number"},
					programa:{type:"string"},
					id_proyecto:{type:"number"},
					proyecto:{type:"string"},
					anno:{type:"number"},
					etapa:{type:"string"},
					cantidad_anticipa:{type:"number"},
					ejecutor:{type:"string"},
					cuenta_bancaria:{type:"number"},
					sucursal_creditos:{type:"string"},
					codigo:{type:"number"},
					id_persona:{type:"number"},
					secretario:{type:"string"},
					fecha_firma:{type:"date"},
					nombre_recibe:{type:"string"},
					cargo_recibe:{type:"string"},
					fecha_recibe:{type:"date"},



				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_anticipo").kendoGrid({
	        dataSource: Anticipo.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 detailTemplate: kendo.template($("#template_anticipo").html()),
	        sortable: true,
			 groupable:true,
	        change: Anticipo.change,
			resizable: true,
	        dataBound: Anticipo.dataBound,
	        dataBinding: Anticipo.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_anticipo' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_anticipo",
					template:'<div id="item" data-text="#: id_anticipo#">#: id_anticipo#</div>',
	                title: "Consecutivo",
	                width: '8%',
					type:"number"
	            }
				,
				{
	                field: "id_programa",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,
				{
	                field: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
	                title: "Programa",
	                width: '10%',
					type:"string"
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
					field: "proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
					title: "Proyecto",
					width: '10%',
					type:"string",
					hidden:false
				}
				,

				{
					field: "anno",
					title: "Año",
					template:'<div id="item" data-text="#: anno#">#: anno#</div>',
					width: '8%',
					type:"number"
				}
				,

				{
					field: "etapa",
					title: "Etapa",
					template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
					width: '8%',
					type:"string"
				}
				,

	            {
	                field: "cantidad_anticipa",
					template:'<div id="item" data-text="#: cantidad_anticipa#">#: cantidad_anticipa#</div>',
	                title: "Anticipo(CUP)",
	                width: '12%',
					type:"number"
	            }
				,

	            {
	                field: "ejecutor",
					template:'<div id="item" data-text="#: ejecutor#">#: ejecutor#</div>',
	                title: "Autorizado a",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

				{
	                field: "cuenta_bancaria",
					template:'<div id="item" data-text="#: cuenta_bancaria#">#: cuenta_bancaria#</div>',
	                title: "Cuenta_Bancaria",
	                width: '10%',
					type:"number",
					hidden:true
	            }
				,	{
	                field: "sucursal_creditos",
					template:'<div id="item" data-text="#: sucursal_creditos#">#: sucursal_creditos#</div>',
	                title: "Sucursal_Creditos",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,	{
	                field: "codigo",
					template:'<div id="item" data-text="#: codigo#">#: codigo#</div>',
	                title: "codigo",
	                width: '10%',
					type:"number",
					hidden:true
	            }
				,
				{
	                field: "secretario",
					template:'<div id="item" data-text="#: secretario#">#: secretario#</div>',
	                title: "Secretario_Programa",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_firma",
	                title: "Fecha_Firma",
	                width: '8%',
					type:"date",
					format:"{0:dd-MM-yyyy}",
					hidden:true
				}
				,  {
	                field: "nombre_recibe",
	                title: "Recibe",
	                width: '10%',
					type:"string",
					hidden:true
				}
				,  {
	                field: "cargo_recibe",
	                title: "Cargo",
	                width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "fecha_recibe",
					title: "Fecha_recibe",
					width: '5%',
					type:"date",
					format:"{0:dd-MM-yyyy}",
					hidden:true
				}
				,


				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_anticipo(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_anticipo(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_anticipo').click(function () {
        var c = this.checked;
        $('#gridselection_anticipo :checkbox').prop('checked',c);
    });
    $('#accionbtn_anticiposave_exit').click(function()
			    {
					if (validator_anticipo.validate()) {


                      var fd = new FormData(document.querySelector("#anticipo_form"));                                                                                                                                     
                      var  url="?option=com_anticipo&task=anticipo_add"; 
	        			if($('#taskanticipo').val()=="update")
							{
                       var olditem=JSON.stringify(Anticipo.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_anticipo&task=anticipo_update";
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
	                					Anticipo.gridDataSource.read();
                                       $('#anticipo_form')[0].reset();
            	                					wnd_anticipo.close();
	            			}
	        			});
					}
	else {
						$.smallBox({
							title: "Error",
							content: "<p class='fg-white'>Por favor llene todos los campos</p>",
							color: "9162E",
							timeout: 4000
						});
					}});
    $('#accionbtn_anticiposave_new').click(function()
			    {
					if (validator_anticipo.validate())
                    {

                       var fd = new FormData(document.querySelector("#anticipo_form")); 
	        			 var url="?option=com_anticipo&task=anticipo_add"; 
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
                                       showInsert_anticipo();           
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

    $('#cancelbtn_anticipo').click(function(){
        $('#anticipo_form')[0].reset();
           Anticipo.gridDataSource.read();                       
        wnd_anticipo.close();
    });

    $('#addbutton_anticipo').click(function(){
        showInsert_anticipo();
    });
    $('#deletebutton_anticipo').click(function(){
        var checkbox_checked=$('#gridselection_anticipo .check_row:checked');

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
                      var dataItem=Anticipo.finditem($(this).attr('id'));
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
						url:"?option=com_anticipo&task=anticipo_delete_one",
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
							Anticipo.gridDataSource.read();
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
