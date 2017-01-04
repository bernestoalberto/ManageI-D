/** * Created by Ernesto on .
 *Date:12/27/2015  
 *Time:0:49 */
//Creando variables globales
	var validator;
	var Contrato={};
	var message=""


	//Creando los windows Dialogs
	wnd_contrato = $("#contrato_window").kendoWindow({
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
        				if(Contrato.oldElement!=null) {
							
				    			$('#resultado_actividades').val(Contrato.oldElement.resultado_actividades);
				    			$('#duracionInicio').data('kendoDatePicker').value(Contrato.oldElement.duracioninicio);
				    			$('#duracionFinal').data('kendoDatePicker').value(Contrato.oldElement.duracionfinal);
				    			$('#id_forma_entrega').data("kendoDropDownList").value(Contrato.oldElement.id_forma_entrega);
				    			$('#fechaEntrega').data('kendoDatePicker').value(Contrato.oldElement.fechaentrega);
				    			$('#cliente_representante_legal').val(Contrato.oldElement.cliente_representante_legal);
				    			$('#representante_entidad_ejecutora').val(Contrato.oldElement.representante_entidad_ejecutora);
				    			$('#id_proyecto_contrato').data("kendoDropDownList").value(Contrato.oldElement.id_proyecto_contrato);
						}

						else
						{
				    			$('#id_forma_entrega').data("kendoDropDownList").value('');
				    			$('#id_proyecto_contrato').data("kendoDropDownList").value('');

						}
			    }}).data("kendoWindow");



	//Definir controladora
	Contrato.oldElement=null;
		/*Data Source  Forma_entrega*/
	var forma_entregadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_forma_entrega&task=forma_entrega_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Forma_entrega*/
		$("#id_forma_entrega").kendoDropDownList({
        dataTextField: "informe",
        dataValueField: "id_forma_entrega",
        dataSource: forma_entregadatasource,
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
                if(elem.id_forma_entrega== $("#id_forma_entrega").val())
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
		/*Data Source  Proyecto*/
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
		$("#id_proyecto_contrato").kendoDropDownList({
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
            // if no valid selection - clear input
            if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });


		/*Date Picker  duracionInicio*/
		$("#duracionInicio").kendoDatePicker({
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
		/*Date Picker  duracionFinal*/
		$("#duracionFinal").kendoDatePicker({
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
		/*Date Picker  fechaEntrega*/
		$("#fechaEntrega").kendoDatePicker({
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

	Contrato.change = function onChange(arg) {
};
	Contrato.change = function onDataBinding(arg) {
};
	Contrato.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Contrato.kgrid=this;
		}
	Contrato.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Contrato.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}

$('#addbutton_contrato').click(function(){
	showInsert_contrato();
});


				function showInsert_contrato() {
					Contrato.oldElement=null;
					validator_contrato.hideMessages();
					$('#contrato_form')[0].reset();
					$('#taskcontrato').val('insert');
					$('#accionbtn_contratosave_exit').text('Guardar y Salir');
					wnd_contrato.title("Insertar Contrato");
					$('#id_proyecto_contrato').data('kendoDropDownList').enable();
					$('#accionbtncontrato_save_new').show();
					wnd_contrato.center().open();
				}

//Mostrar Ventanas
				function showUpdate_contrato(e) {
					validator_contrato.hideMessages();
				    $('#contrato_form')[0].reset();
				    var dataItem=Contrato.finditem(e.id);
					$('#id_proyecto_contrato').data('kendoDropDownList').readonly();
				    Contrato.oldElement= dataItem;
				    $('#taskcontrato').val('update');
				    wnd_contrato.title("Actualizar Contrato");
                   $('#accionbtn_contratosave_exit').text('Actualizar');                   
                   $('#accionbtn_contratosave_new').hide();                                 
				    wnd_contrato.center().open();
				}

//Eliminar elemento
function delete_element_contrato(e)
{
    var dataItem=Contrato.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Contrato?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_contrato&task=contrato_delete_one",
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
                    Contrato.gridDataSource.read();
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
	validator_contrato=$("#contrato_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Contrato.oldElement==null)
                    		{

								if(input.is("[id=id_proyecto_contrato]")) {
								 	value=$('#id_proyecto_contrato').data('kendoDropDownList').value();

								 	while (i < Contrato.gridDataSource._data.length) {
                                		var elem=Contrato.gridDataSource._data[i];
                                	 if(elem.id_proyecto_contrato==value)
                                		{
                                    		found=true;
											message="Existe un contrato con este proyecto";
                                    		i=Contrato.gridDataSource._data.length;
											return $('#id_proyecto_contrato').data('kendoDropDownList').value('');
		                                }
                                		i++;
                            		}
								}
								if(input.is("[id=duracionFinal]")) {
								var	inicio = $("#duracionInicio").data('kendoDatePicker').value();
								var	final = $("#duracionFinal").data('kendoDatePicker').value();
								if(inicio > final){
									message = "La fecha final debe ser posterior a la fecha inicial";
									return $('#duracionFinal').data('kendoDatePicker').value('');
                            		}
								}
								if(input.is("[id=fechaEntrega]")) {
								var	inicio = $("#duracionInicio").data('kendoDatePicker').value();
								var	entrega = $("#fechaEntrega").data('kendoDatePicker').value();
								if(inicio < entrega){
									message = "La fecha de  entrega debe ser anterior a la fecha inicial";
									return $('#fechaEntrega').data('kendoDatePicker').value('');
                            		}
								}
								if(input.is("[id=resultado_actividades]")) {
									var value = $('#resultado_actividades').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El(los) resultado o actividades ingresado(as) no debe exceder los 100 caracteres";
										return $('#resultado_actividades').val('');
									}
								}
								if(input.is("[id=cliente_representante_legal]")) {
									var value = $('#cliente_representante_legal').val();
									var size = value.length;

									if(size > 50){
										found=true;
										message="El cliente_representante_legal ingresado(as) no debe exceder los 50 caracteres";
										return $('#cliente_representante_legal').val('');
									}
								}
								if(input.is("[id=representante_entidad_ejecutora]")) {
									var value = $('#representante_entidad_ejecutora').val();
									var size = value.length;

									if(size > 50){
										found=true;
										message="El representante_entidad_ejecutora ingresado(as) no debe exceder los 50 caracteres";
										return $('#representante_entidad_ejecutora').val('');
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
	Contrato.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_contrato&task=contrato_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },
       schema:{
			model:{
				fields:{
						id_contrato:{type:"number"},
						resultado_actividades:{type:"string"},
						duracioninicio:{type:"date"},
						duracionfinal:{type:"date"},
						id_forma_entrega:{type:"number"},
						fechaentrega:{type:"date"},
						cliente_representante_legal:{type:"string"},
						representante_entidad_ejecutora:{type:"string"},
						id_proyecto_contrato:{type:"number"}


				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_contrato").kendoGrid({
	        dataSource: Contrato.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		 detailTemplate: kendo.template($("#template_contrato").html()),
	        sortable: true,
		    groupable:true,
	        change: Contrato.change,
			resizable: true,
	        dataBound: Contrato.dataBound,
	        dataBinding: Contrato.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [
	            {	                
					field: "",
	                title: "",
	                width: '5%',
	                headerTemplate: "<input class='' id='all_check_contrato' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_contrato",
					template:'<div id="item" data-text="#: id_contrato#">#: id_contrato#</div>',
	                title: "Consecutivo",
	                width: '15%',
					type:"number",
	            	hidden:false
	            }
				,

	            {
	                field: "resultado_actividades",
					template:'<div id="item" data-text="#: resultado_actividades#">#: resultado_actividades#</div>',
	                title: "Resultado Actividades",
	                width: '25%',
					type:"string",
					hidden:true
	            }
				,

	            {

	                field: "duracionInicio",
	                title: "Inicio",
	                width: '15%',
					format:"{0:dd-MM-yyyy}",
					type:"date"
	            }
				,

	            {
	                field: "duracionFinal",
	                title: "Fin",
	                width: '15%',
					format:"{0:dd-MM-yyyy}",
					type:"date"
	            }
				,

	            {
	                field: "id_forma_entrega",
	                title: "ID",
					template:'<div id="item" data-text="#: id_forma_entrega#">#: id_forma_entrega#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,   {
	                field: "forma_entrega",
	                title: "Forma Entrega",
					template:'<div id="item" data-text="#: forma_entrega#">#: forma_entrega#</div>',
	                width: '20%',
					type:"string",
					hidden:true
				}
			,
				{
					field: "fechaEntrega",
					title: "Fecha Entrega",
					width: '15%',
					format:"{0:dd-MM-yyyy}",
					type:"date",
					hidden:true
				}
				,
	            {
	                field: "id_proyecto_contrato",
	                title: "id_proyecto_contrato",
					template:'<div id="item" data-text="#: id_proyecto_contrato#">#: id_proyecto_contrato#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,    {
	                field: "proyecto",
	                title: "Proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
	                width: '15%',
					type:"string"
				}
			,    {
	                field: "jefe_proyecto",
	                title: "Jefe Proyecto",
					template:'<div id="item" data-text="#: jefe_proyecto#">#: jefe_proyecto#</div>',
	                width: '20%',
					type:"string"
				}
			,
			/*	{
	                field: "financista",
					template:'<div id="item" data-text="#: financista#">#: financista#</div>',
	                title: "Financista",
	                width: '20%',
					type:"string"
	            }
				,*/

	            {
	                field: "cliente_representante_legal",
					template:'<div id="item" data-text="#: cliente_representante_legal#">#: cliente_representante_legal#</div>',
	                title: "Cliente Representante Legal",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "representante_entidad_ejecutora",
					template:'<div id="item" data-text="#: representante_entidad_ejecutora#">#: representante_entidad_ejecutora#</div>',
	                title: "ejecutor",
	                width: '30%',
					type:"string",
					hidden:true
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_contrato(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_contrato(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });


/*Acciones de los botones*/

    $('#all_check_contrato').click(function () {
        var c = this.checked;
        $('#gridselection_contrato :checkbox').prop('checked',c);
    });
    $('#accionbtn_contratosave_exit').click(function()
			    {
					if (validator_contrato.validate())
                    {

                      var fd = new FormData(document.querySelector("#contrato_form"));                                                                                                                                     
                      var  url="?option=com_contrato&task=contrato_add"; 
	        			if($('#taskcontrato').val()=="update")
							{
                       var olditem=JSON.stringify(Contrato.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				        var  url="?option=com_contrato&task=contrato_update";
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
	                					Contrato.gridDataSource.read();
                                       $('#contrato_form')[0].reset();
            	                					wnd_contrato.close();
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
    $('#accionbtn_contratosave_new').click(function()
			    {
					if (validator_contrato.validate())
                    {

                       var fd = new FormData(document.querySelector("#contrato_form")); 
	        			 var url="?option=com_contrato&task=contrato_add"; 
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
                                       showInsert_contrato();           
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

    $('#deletebutton_contrato').click(function(){
        var checkbox_checked=$('#gridselection_contrato .check_row:checked');

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
                      var dataItem=Contrato.finditem($(this).attr('id'));
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
                        url:"?option=com_contrato&task=contrato_delete_one", 
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
                            Contrato.gridDataSource.read();
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
