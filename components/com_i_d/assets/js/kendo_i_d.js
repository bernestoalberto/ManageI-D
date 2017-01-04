/** * Created by Ernesto on .
 *Date:12/27/2015  
 *Time:0:49 */
//Creando variables globales
	var validator;
	var I_d={};
	var message=""


	//Creando los windows Dialogs
	wnd_i_d = $("#i_d_window").kendoWindow({
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
        				if(I_d.oldElement!=null) {
							
				    			$('#id_proyecto_i_d').data("kendoDropDownList").value(I_d.oldElement.id_proyecto);
				    			$('#antecedentes_justificacion').val(I_d.oldElement.antecedentes_justificacion);
				    			$('#beneficiarios_directos').val(I_d.oldElement.beneficiarios_directos);
				    			$('#clientes').val(I_d.oldElement.clientes);
				    			$('#sostenibilidad_resultados_proyecto').val(I_d.oldElement.sostenibilidad_resultados_proyecto);
				    			$('#otros_anexos_i_d').val(I_d.oldElement.otros_anexos_i_d);
						}

						else
						{
				    			$('#id_proyecto_i_d').data("kendoDropDownList").value('');

						}
			    }}).data("kendoWindow");



	//Definir controladora
	I_d.oldElement=null;
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
		$("#id_proyecto_i_d").kendoDropDownList({
        dataTextField: "nombre_proyecto",
        dataValueField: "id_proyecto",
        dataSource: proyectodatasource,
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
                if(elem.id_proyecto== $("#id_proyecto_i_d").val())
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
	I_d.change = function onChange(arg) {
};
	I_d.change = function onDataBinding(arg) {
};
	I_d.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    I_d.kgrid=this;
		}
	I_d.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(I_d.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}




				function showInsert_i_d() {
					I_d.oldElement=null;
					validator_i_d.hideMessages();
		    		$('#i_d_form')[0].reset();
		    		$('#taski_d').val('insert');
					//$('#id_proyecto_i_d').data('kendoDropDownList').enable();
                   $('#accionbtn_i_dsave_exit').text('Guardar y Salir');         
		    		wnd_i_d.title("Crear Proyecto de  I+D");
                   $('#accionbtni_d_save_new').show();
		    		wnd_i_d.center().open();
				}

//Mostrar Ventanas
				function showUpdate_i_d(e) {
					validator_i_d.hideMessages();
				    $('#i_d_form')[0].reset();
				    var dataItem=I_d.finditem(e.id);
				    I_d.oldElement= dataItem;
				    $('#taski_d').val('update');
					//$('#id_proyecto_i_d').data('kendoDropDownList').readonly();
				    wnd_i_d.title("Actualizar Proyecto de  I+D");
                   $('#accionbtn_i_dsave_exit').text('Actualizar');                   
                   $('#accionbtn_i_dsave_new').hide();                                 
				    wnd_i_d.center().open();
				}

//Eliminar elemento
function delete_element_i_d(e)
{
    var dataItem=I_d.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este I_d?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_i_d&task=i_d_delete_one",
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
	$('#text-error').html(result.message);             
	$.smallBox({                                       
		title: '',                                      
		content:$('#message-error').html(),              
		color: "#BA0916",                                
		timeout: 6000                                     
	});                                                    
}                                                         
                    I_d.gridDataSource.read();
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
	validator_i_d=$("#i_d_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(I_d.oldElement==null)
                    		{

								if(input.is("[id=id_proyecto_i_d]")) {
								 	value=$('#id_proyecto_i_d').data('kendoDropDownList').value();

								 	while (i < I_d.gridDataSource._data.length) {
                                		var elem=I_d.gridDataSource._data[i];
                                	 if(elem.id_proyecto==value)
                                		{
                                    		found=true;
											message="Existe un proyecto de i+d con este proyecto";
                                    		i=I_d.gridDataSource._data.length;
											return 	$('#id_proyecto_i_d').data('kendoDropDownList').value('');
		                                }
                                		i++;
                            		}
								}
								if(input.is("[id=antecedentes_justificacion]")) {
									var value = $('#antecedentes_justificacion').val();
									var size = value.length;

									if(size > 80){
										found=true;
										message="Los antecedentes o justificación ingresado no debe exceder los 80 caracteres";
										return $('#antecedentes_justificacion').val('');
									}
								}
								if(input.is("[id=beneficiarios_directos]")) {
									var value = $('#beneficiarios_directos').val();
									var size = value.length;

									if(size > 80){
										found=true;
										message="Los beneficiarios_directosingresado no debe exceder los 80 caracteres";
										return $('#beneficiarios_directos').val('');
									}
								}
	                              	if(input.is("[id=clientes]")) {
									var value = $('#clientes').val();
									var size = value.length;

									if(size > 80){
										found=true;
										message="Los clientes no debe exceder los 80 caracteres";
										return $('#clientes').val('');
									}
								}
								if(input.is("[id=sostenibilidad_resultados_proyecto]")) {
									var value = $('#sostenibilidad_resultados_proyecto').val();
									var size = value.length;

									if(size > 80){
										found=true;
										message="La sostenibilidad_resultados_proyecto no debe exceder los 80 caracteres";
										return $('#sostenibilidad_resultados_proyecto').val('');
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
	I_d.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_i_d&task=i_d_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_proyecto:{type:"number"},
						antecedentes_justificacion:{type:"string"},
						beneficiarios_directos:{type:"string"},
						clientes:{type:"string"},
						sostenibilidad_resultados_proyecto:{type:"string"},
						id_persona:{type:"number"},
					otros_anexos_i_d:{type:"string"}

				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_i_d").kendoGrid({
	        dataSource: I_d.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		 detailTemplate: kendo.template($("#template_i_d").html()),
			 groupable:true,
	        sortable: true,
	        change: I_d.change,
			resizable: true,
	        dataBound: I_d.dataBound,
	        dataBinding: I_d.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_i_d' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,
				{
					field: "id_proyecto",
					template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
					title: "id",
					width: '3%',
					type:"number",
					hidden:true
				}
				,
				{
					field: "proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
					title: "Proyecto",
					width: '8%',
					type:"string"
				}
				,
				{
					field: "id_persona",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
					title: "id",
					width: '3%',
					type:"number",
					hidden:true
				}
				,

				{
					field: "jefeproyecto",
					template:'<div id="item" data-text="#: jefeproyecto#">#: jefeproyecto#</div>',
					title: "JefeProyecto",
					width: '8%',
					type:"string"
				}
				,

	            {
	                field: "antecedentes_justificacion",
					template:'<div id="item" data-text="#: antecedentes_justificacion#">#: antecedentes_justificacion#</div>',
	                title: "Antecedentes_justificacion",
	                width: '11%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "beneficiarios_directos",
					template:'<div id="item" data-text="#: beneficiarios_directos#">#: beneficiarios_directos#</div>',
	                title: "Beneficiarios_directos",
	                width: '11%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "clientes",
					template:'<div id="item" data-text="#: clientes#">#: clientes#</div>',
	                title: "Clientes",
	                width: '11%',
					type:"string"
	            }
				,

	            {
	                field: "sostenibilidad_resultados_proyecto",
					template:'<div id="item" data-text="#: sostenibilidad_resultados_proyecto#">#: sostenibilidad_resultados_proyecto#</div>',
	                title: "Sostenibilidad_resultados_proyecto",
	                width: '11%',
					type:"string",
					hidden:true
	            }
				,
				{
					field: "otros_anexos_i_d",
					template:'<div id="item" data-text="#: otros_anexos_i_d#">#: otros_anexos_i_d#</div>',
					title: "Otros Anexos",
					width: '8%',
					type:"string",
					hidden:true
				},
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_i_d(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_i_d(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });
	function detailInit(e) {
		var detailRow = e.detailRow;

		detailRow.find(".tabstrip").kendoTabStrip({
			animation: {
				open: { effects: "fadeIn" }
			}
		});

		detailRow.find(".orders").kendoGrid({
			dataSource: {
				transport: {
					read: {
						type:'POST',
						url: "?option=com_i_d&task=i_d_json_list",
						dataType: "json"
					}
				},
				height: 200,
				serverPaging: true,
				serverSorting: true,
				serverFiltering: true,
				pageSize: 1,
				filter: { field: "id_proyecto", operator: "eq", value: e.data.id_proyecto }
			},
			scrollable: false,
			sortable: true,
			pageable: true,
			columns: [
				{ field: "antecedentes_justificacion", title:"antecedentes_justificacion", width: "70px" },
				{ field: "beneficiarios_directos", title:"beneficiarios_directos", width: "110px" },
				{ field: "sostenibilidad_resultados_proyecto", title:"sostenibilidad_resultados_proyecto" }
			]
		});
	}

/*Acciones de los botones*/

    $('#all_check_i_d').click(function () {
        var c = this.checked;
        $('#gridselection_i_d :checkbox').prop('checked',c);
    });
    $('#accionbtn_i_dsave_exit').click(function()
			    {
					if (validator_i_d.validate())
                    {

                      var fd = new FormData(document.querySelector("#i_d_form"));                                                                                                                                     
                      var  url="?option=com_i_d&task=i_d_add"; 
	        			if($('#taski_d').val()=="update")
							{
                       var olditem=JSON.stringify(I_d.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_i_d&task=i_d_update";
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
	                					I_d.gridDataSource.read();
                                       $('#i_d_form')[0].reset();
            	                					wnd_i_d.close();
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
    $('#accionbtn_i_dsave_new').click(function()
			    {
					if (validator_i_d.validate())
                    {

                       var fd = new FormData(document.querySelector("#i_d_form")); 
	        			 var url="?option=com_i_d&task=i_d_add"; 
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
                                       showInsert_i_d();           
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

    $('#cancelbtn_i_d').click(function(){
        $('#i_d_form')[0].reset();
           I_d.gridDataSource.read();                       
        wnd_i_d.close();
    });

    $('#addbutton_i_d').click(function(){
        showInsert_i_d();
    });
    $('#deletebutton_i_d').click(function(){
        var checkbox_checked=$('#gridselection_i_d .check_row:checked');

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
                      var dataItem=I_d.finditem($(this).attr('id'));
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
                        url:"?option=com_i_d&task=i_d_delete_one", 
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
							I_d.gridDataSource.read();
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
