/** * Created by Ernesto on .
 *Date:12/27/2015  
 *Time:0:49 */
//Creando variables globales
	var validator;
	var Dictamen_eval_perfil_proy={};
	var message=""


	//Creando los windows Dialogs
	wnd_dictamen_eval_perfil_proy = $("#dictamen_eval_perfil_proy_window").kendoWindow({
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
        				if(Dictamen_eval_perfil_proy.oldElement!=null) {
							
				    			$('#id_proyecto').data("kendoDropDownList").value(Dictamen_eval_perfil_proy.oldElement.id_proyecto);
				    			$('#criterio').val(Dictamen_eval_perfil_proy.oldElement.criterio);
				    			$('#id_evaluacion').data("kendoDropDownList").value(Dictamen_eval_perfil_proy.oldElement.id_evaluacion);
				    			$('#observaciones').val(Dictamen_eval_perfil_proy.oldElement.observaciones);
				    			$('#conclusiones').val(Dictamen_eval_perfil_proy.oldElement.conclusiones);
				    			$('#recomendaciones').val(Dictamen_eval_perfil_proy.oldElement.recomendaciones);
				    			$('#fecha_evaluacion').val(Dictamen_eval_perfil_proy.oldElement.fecha_evaluacion);
				    			$('#id_persona').data("kendoDropDownList").value(Dictamen_eval_perfil_proy.oldElement.id_persona);
						}

						else
						{
				    			$('#id_evaluacion').data("kendoDropDownList").value('');
				    			$('#id_proyecto').data("kendoDropDownList").value('');
				    			$('#id_persona').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Dictamen_eval_perfil_proy.oldElement=null;
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
		/*Data Source  Perfil_proyecto*/
	var perfil_proyectodatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_perfil_proyecto&task=perfil_proyecto_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Perfil_proyecto*/
		$("#id_proyecto").kendoDropDownList({
        dataTextField: "titulo_proyecto",
        dataValueField: "id_proyecto",
        dataSource: perfil_proyectodatasource,
        filter: "contains",
		 open: function(e) {
            valid = false;
        },
		 change:function(e){
            var data = $("#id_proyecto").data("kendoDropDownList").value();


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
		/*Data Source  Perfil_proyecto*/
	var personadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_convocatoria&task=jefe_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Perfil_proyecto*/
		$("#id_persona").kendoDropDownList({
        dataTextField: "nombre",
        dataValueField: "id_persona",
        dataSource: personadatasource,
        filter: "contains",
		 open: function(e) {
            valid = false;
        },
		 change:function(e){
  /*          var i=0;
            valid=false;
            while(i<this.options.dataSource._data.length)
            {
                var elem=this.options.dataSource._data[i];
                if(elem.id_persona== $("#id_persona").val())
                	{
                  		i= this.options.dataSource._data.length;
                    	valid=true;
                	}
               	i++;
            	}
            	if (!valid) this.value('');*/
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
		/*Date Picker  fecha_evaluacion*/
		$("#fecha_evaluacion").kendoDateTimePicker({
			value: kendo.date.today(),

			open:function(e){
			},
			change:function(e){
			var datepick = $("#fecha_evaluacion").data("kendoDateTimePicker").value();
				valid = true;
				var today = kendo.date.today();

				if(datepick < today){
					alert('La fecha escogida debe ser igual o mayor que hoy');
					message ="La fecha escogida debe ser igual o mayor que la fecha de  hoy";
                return $("#fecha_evaluacion").data("kendoDateTimePicker").value('');
				}
			},
			close:function(e){
			}
	});		
	Dictamen_eval_perfil_proy.change = function onChange(arg) {
};
	Dictamen_eval_perfil_proy.change = function onDataBinding(arg) {
};
	Dictamen_eval_perfil_proy.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Dictamen_eval_perfil_proy.kgrid=this;
		}
	Dictamen_eval_perfil_proy.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Dictamen_eval_perfil_proy.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



				function showInsert_dictamen_eval_perfil_proy() {
					Dictamen_eval_perfil_proy.oldElement=null;
					validator_dictamen_eval_perfil_proy.hideMessages();
		    		$('#dictamen_eval_perfil_proy_form')[0].reset();
		    		$('#taskdictamen_eval_perfil_proy').val('insert');
		    		$('#id_proyecto').data("kendoDropDownList").enable();
		    		$('#id_persona').data("kendoDropDownList").enable();
                   $('#accionbtn_dictamen_eval_perfil_proysave_exit').text('Guardar y Salir');
		    		wnd_dictamen_eval_perfil_proy.title("Crear Dictámen Evaluativo del Perfil del Proyecto");
                   $('#accionbtndictamen_eval_perfil_proy_save_new').show();
		    		wnd_dictamen_eval_perfil_proy.center().open();
				}

//Mostrar Ventanas
				function showUpdate_dictamen_eval_perfil_proy(e) {
					validator_dictamen_eval_perfil_proy.hideMessages();
				    $('#dictamen_eval_perfil_proy_form')[0].reset();
				    var dataItem=Dictamen_eval_perfil_proy.finditem(e.id);
				    Dictamen_eval_perfil_proy.oldElement= dataItem;
					$('#id_proyecto').data("kendoDropDownList").readonly();
					$('#id_persona').data("kendoDropDownList").readonly();
				    $('#taskdictamen_eval_perfil_proy').val('update');
				    wnd_dictamen_eval_perfil_proy.title("Actualizar Dictámen Evaluativo del Perfil de Proyecto");
                   $('#accionbtn_dictamen_eval_perfil_proysave_exit').text('Actualizar');                   
                   $('#accionbtn_dictamen_eval_perfil_proysave_new').hide();                                 
				    wnd_dictamen_eval_perfil_proy.center().open();
				}

//Eliminar elemento
function delete_element_dictamen_eval_perfil_proy(e)
{
    var dataItem=Dictamen_eval_perfil_proy.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Dictamen_eval_perfil_proy?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_dictamen_eval_perfil_proy&task=dictamen_eval_perfil_proy_delete_one",
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
                    Dictamen_eval_perfil_proy.gridDataSource.read();
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
	validator_dictamen_eval_perfil_proy=$("#dictamen_eval_perfil_proy_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Dictamen_eval_perfil_proy.oldElement==null)
                    		{
								if (input.is("[id=id_proyecto]")) {
									value = $('#id_proyecto').data('kendoDropDownList').value();


									while (i < Dictamen_eval_perfil_proy.gridDataSource._data.length) {
										var elem = Dictamen_eval_perfil_proy.gridDataSource._data[i];
										if (elem.id_proyecto == value) {
											found = true;
											message = "El proyecto seleccionado  ya ha sido dictaminado";
											i = Dictamen_eval_perfil_proy.gridDataSource._data.length;
											return $('#id_proyecto').data('kendoDropDownList').value('');
										}
										i++;
									}

								}
								if (input.is("[id=criterio]")) {
									value = $('#criterio').val();
									var size = value.length;

									if (size > 60) {
										found = true;
										message = "El criterio ingresado no debe exceder los 60 caracteres";
										return $('#criterio').val('');
									}
								}
									if (input.is("[id=Observaciones]")) {
									value = $('#criterio').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="La(s) Observaciones ingresada(s) no debe exceder los 100 caracteres";
										return $('#Observaciones').val('');
									}




								}
								if (input.is("[id=Conclusiones]")) {
									value = $('#Conclusiones').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="La(s) Conclusiones ingresada(s) no debe exceder los 100 caracteres";
										return $('#Conclusiones').val('');
									}
								}
								if (input.is("[id=Recomendaciones]")) {
									value = $('#Recomendaciones').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="La(s) Recomendaciones ingresada(s) no debe exceder los 100 caracteres";
										return $('#Recomendaciones').val('');
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
	Dictamen_eval_perfil_proy.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_dictamen_eval_perfil_proy&task=dictamen_eval_perfil_proy_json_list",
                dataType: "json"
            }
        },
     change: function(e){
	console.clear();        
                      },
       schema:{
			model:{
				fields:{
						id_dictamen:{type:"number"},
						id_proyecto:{type:"number"},
					    titulo_proyecto:{type:"string"},
						criterio:{type:"string"},
						id_evaluacion:{type:"number"},
						observaciones:{type:"string"},
						conclusiones:{type:"string"},
						recomendaciones:{type:"string"},
						fecha_evaluacion:{type:"date"},
						id_persona:{type:"number"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_dictamen_eval_perfil_proy").kendoGrid({
	        dataSource: Dictamen_eval_perfil_proy.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		 detailTemplate: kendo.template($("#template_dictamen").html()),
	        sortable: true,
	        change: Dictamen_eval_perfil_proy.change,
			 groupable:true,
			resizable: true,
	        dataBound: Dictamen_eval_perfil_proy.dataBound,
	        dataBinding: Dictamen_eval_perfil_proy.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_dictamen_eval_perfil_proy' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_dictamen",
					template:'<div id="item" data-text="#: id_dictamen#">#: id_dictamen#</div>',
	                title: "ID",
	                width: '5%',
					type:"number",
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
	                field: "titulo_proyecto",
	                title: "Proyecto",
					template:'<div id="item" data-text="#: titulo_proyecto#">#: titulo_proyecto#</div>',
	                width: '10%',
					type:"string"
				}
			,

	            {
	                field: "criterio",
					template:'<div id="item" data-text="#: criterio#">#: criterio#</div>',
	                title: "Criterio",
	                width: '7%',
					type:"string",
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
	                width: '10%',
					type:"string"
				}
			,

	            {
	                field: "observaciones",
					template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
	                title: "Observaciones",
	                width: '7%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "conclusiones",
					template:'<div id="item" data-text="#: conclusiones#">#: conclusiones#</div>',
	                title: "Conclusiones",
	                width: '7%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "recomendaciones",
					template:'<div id="item" data-text="#: recomendaciones#">#: recomendaciones#</div>',
	                title: "Recomendaciones",
	                width: '7%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_evaluacion",
	                title: "Fecha Evaluación",
	                width: '15%',
					type:"datetime",
	            	format:"{0:dd-MM-yyyy}"
	            }
				,


				{
					field: "id_persona",
					title: "ID",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
					width: '5%',
					type:"number",
					hidden:true
				},
				{
					field: "JefePrograma",
					title: "Jefe Programa",
					template:'<div id="item" data-text="#: JefePrograma#">#: JefePrograma#</div>',
					width: '12%',
					type:"string"
				},
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_dictamen_eval_perfil_proy(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_dictamen_eval_perfil_proy(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_dictamen_eval_perfil_proy').click(function () {
        var c = this.checked;
        $('#gridselection_dictamen_eval_perfil_proy :checkbox').prop('checked',c);
    });
    $('#accionbtn_dictamen_eval_perfil_proysave_exit').click(function()
			    {
					if (validator_dictamen_eval_perfil_proy.validate())
                    {

                      var fd = new FormData(document.querySelector("#dictamen_eval_perfil_proy_form"));                                                                                                                                     
                      var  url="?option=com_dictamen_eval_perfil_proy&task=dictamen_eval_perfil_proy_add"; 
	        			if($('#taskdictamen_eval_perfil_proy').val()=="update")
							{
                       var olditem=JSON.stringify(Dictamen_eval_perfil_proy.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_dictamen_eval_perfil_proy&task=dictamen_eval_perfil_proy_update";
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
	                					Dictamen_eval_perfil_proy.gridDataSource.read();
                                       $('#dictamen_eval_perfil_proy_form')[0].reset();
            	                					wnd_dictamen_eval_perfil_proy.close();
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
    $('#accionbtn_dictamen_eval_perfil_proysave_new').click(function()
			    {
					if (validator_dictamen_eval_perfil_proy.validate())
                    {

                       var fd = new FormData(document.querySelector("#dictamen_eval_perfil_proy_form")); 
	        			 var url="?option=com_dictamen_eval_perfil_proy&task=dictamen_eval_perfil_proy_add"; 
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
                                       showInsert_dictamen_eval_perfil_proy();           
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

    $('#cancelbtn_dictamen_eval_perfil_proy').click(function(){
        $('#dictamen_eval_perfil_proy_form')[0].reset();
           Dictamen_eval_perfil_proy.gridDataSource.read();                       
        wnd_dictamen_eval_perfil_proy.close();
    });

    $('#addbutton_dictamen_eval_perfil_proy').click(function(){
        showInsert_dictamen_eval_perfil_proy();
    });
    $('#deletebutton_dictamen_eval_perfil_proy').click(function(){
        var checkbox_checked=$('#gridselection_dictamen_eval_perfil_proy .check_row:checked');

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
                      var dataItem=Dictamen_eval_perfil_proy.finditem($(this).attr('id'));
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
                        url:"?option=com_dictamen_eval_perfil_proy&task=dictamen_eval_perfil_proy_delete_one", 
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
                            Dictamen_eval_perfil_proy.gridDataSource.read();
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
