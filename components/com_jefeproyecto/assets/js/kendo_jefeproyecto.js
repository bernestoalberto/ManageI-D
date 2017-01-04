/** * Created by Ernesto on .
 *Date:12/16/2015
 *Time:11:35 */
//Creando variables globales
	var validator;
	var Jefeproyecto={};
	var message=""


	//Creando los windows Dialogs
	wnd_jefeproyecto = $("#jefeproyecto_window").kendoWindow({
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
        				if(Jefeproyecto.oldElement!=null) {

				    			$('#id_persona').data("kendoDropDownList").value(Jefeproyecto.oldElement.id_persona);
				    			$('#titulo_obtenido').val(Jefeproyecto.oldElement.titulo_obtenido);
				    			$('#situacion_laboral').val(Jefeproyecto.oldElement.situacion_laboral);
				    			$('#publicaciones').val(Jefeproyecto.oldElement.publicaciones);
				    			$('#otros_aspectos').val(Jefeproyecto.oldElement.otros_aspectos);
				    			$('#presupuesto_anual').val(Jefeproyecto.oldElement.presupuesto_anual);
				    			if(Jefeproyecto.oldElement.id_categoria==-1)
				    			       Jefeproyecto.oldElement.id_categoria='';
				    			$('#id_categoria').data("kendoDropDownList").value(Jefeproyecto.oldElement.id_categoria);
				    			if(Jefeproyecto.oldElement.id_grado==-1)
				    			       Jefeproyecto.oldElement.id_grado='';
				    			$('#id_grado').data("kendoDropDownList").value(Jefeproyecto.oldElement.id_grado);
				    			$('#cv').val(Jefeproyecto.oldElement.cv);

						}

						else
						{
				    			$('#id_categoria').data("kendoDropDownList").value('');
				    			$('#id_grado').data("kendoDropDownList").value('');
				    			$('#id_persona').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");


$("#presupuesto_anual").kendoNumericTextBox({
	format: "c",
	decimals: 3,
	min:1000,
	step:50,
	max:50000

});
	//Definir controladora
	Jefeproyecto.oldElement=null;
		/*Data Source  Cat_cientifica*/
	var cat_cientificadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_cat_cientifica&task=cat_cientifica_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Cat_cientifica*/
		$("#id_categoria").kendoDropDownList({
        dataTextField: "categoria",
        dataValueField: "id_categoria",
        dataSource: cat_cientificadatasource,
        filter: "contains",
		 open: function(e) {
            valid = false;
        },
		 change:function(e){
           /* var i=0;
            valid=false;
            while(i<this.options.dataSource._data.length)
            {
                var elem=this.options.dataSource._data[i];
                if(elem.id_categoria== $("#id_categoria").val())
                	{
                  		i= this.options.dataSource._data.length;
                    	valid=true;
                	}
               	i++;
            	}
            	if (!valid) this.value('');*/
        },
        select: function(e){
         //  valid = true;
        },
        close: function(e){
            // if no valid selection - clear input
            //if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
		/*Data Source  Grado_cientifico*/
	var grado_cientificodatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_grado_cientifico&task=grado_cientifico_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Grado_cientifico*/
		$("#id_grado").kendoDropDownList({
        dataTextField: "grado",
        dataValueField: "id_grado",
        dataSource: grado_cientificodatasource,
        filter: "contains",
		 open: function(e) {
           // valid = false;
        },
		 change:function(e){
     /*       var i=0;
            valid=false;
            while(i<this.options.dataSource._data.length)
            {
                var elem=this.options.dataSource._data[i];
                if(elem.id_grado== $("#id_grado").val())
                	{
                  		i= this.options.dataSource._data.length;
                    	valid=true;
                	}
               	i++;
            	}
            	if (!valid) this.value('');*/
        },
        select: function(e){
           // valid = true;
        },
        close: function(e){
            // if no valid selection - clear input
         //   if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });

		/*Data Source  Persona*/
	var personadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_jefeproyecto&task=personasdisponibles_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Persona*/
		$("#id_persona").kendoDropDownList({
        dataTextField: "nombre",
        dataValueField: "id_persona",
        dataSource: personadatasource,
        filter: "contains",
		 open: function(e) {
       //     valid = false;
        },
		 change:function(e){

        },
        select: function(e){
         //   valid = true;
        },
        close: function(e){
            // if no valid selection - clear input
           // if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
	Jefeproyecto.change = function onChange(arg) {
};
	Jefeproyecto.change = function onDataBinding(arg) {
};
	Jefeproyecto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Jefeproyecto.kgrid=this;
		}
	Jefeproyecto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Jefeproyecto.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}


/*

		$("#export_pdf").click(function() {
    kendo.drawing.drawDOM($("#este"))
        .then(function(group) {
            return kendo.drawing.exportPDF(group, {
               paperSize: "auto",
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
           });
       })
       .done(function() {
           kendo.saveAs({
               dataURI: Jefeproyecto.gridDataSource,
               fileName: "jefeproyecto.pdf",
               proxyURL: "+"
           });
       });
});
*/


				function showInsert_jefeproyecto() {
					Jefeproyecto.oldElement=null;
					validator_jefeproyecto.hideMessages();
		    		$('#jefeproyecto_form')[0].reset();
		    		$('#taskjefeproyecto').val('insert');
                   $('#accionbtn_jefeproyectosave_exit').text('Guardar y Salir');
					//$('#id_persona').data("kendoDropDownList").enable();
		    		wnd_jefeproyecto.title("Crear Jefe de Proyecto");
                   $('#accionbtnjefeproyecto_save_new').show();
		    		wnd_jefeproyecto.center().open();
				}

//Mostrar Ventanas
				function showUpdate_jefeproyecto(e) {
					validator_jefeproyecto.hideMessages();
				    $('#jefeproyecto_form')[0].reset();
				    var dataItem=Jefeproyecto.finditem(e.id);
				    Jefeproyecto.oldElement= dataItem;
				    $('#taskjefeproyecto').val('update');
					$('#id_persona').data("kendoDropDownList").readonly();
				    wnd_jefeproyecto.title("Actualizar Jefe de Proyecto");
                   $('#accionbtn_jefeproyectosave_exit').text('Actualizar');
                   $('#accionbtn_jefeproyectosave_new').hide();
				    wnd_jefeproyecto.center().open();
				}

//Eliminar elemento
function delete_element_jefeproyecto(e)
{
    var dataItem=Jefeproyecto.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Jefeproyecto?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_jefeproyecto&task=jefeproyecto_delete_one",
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
                    Jefeproyecto.gridDataSource.read();
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
	validator_jefeproyecto=$("#jefeproyecto_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Jefeproyecto.oldElement==null)
                    		{

								if(input.is("[id=id_persona]")) {
								 	value=$('#id_persona').data('kendoDropDownList').value();

								 	while (i < Jefeproyecto.gridDataSource._data.length) {
                                		var elem=Jefeproyecto.gridDataSource._data[i];
                                	 if(elem.id_persona.toUpperCase().trim()==value.toUpperCase().trim())
                                		{
                                    		found=true;
											message="La persona seleccionada es jefeproyecto  en un proyecto ";
                                    		i=Jefeproyecto.gridDataSource._data.length;
											return $('#id_persona').data("kendoDropDownList").value('');
		                                }
                                		i++;
                            		}
								}
								if(input.is("[id=publicaciones]")) {
									var value = $('#publicaciones').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="La(s) publicaciones ingresadas no debe exceder los 250 caracteres";
										return $('#publicaciones').val('');
									}
								}
								if(input.is("[id=otros_aspectos]")) {
								var value = $('#otros_aspectos').val();
								var size = value.length;

								if(size > 250){
									found=true;
									message="El(los) otros_aspectos ingresado(s) no debe exceder los 250 caracteres";
									return $('#otros_aspectos').val('');
								}
							}
								if(input.is("[id=titulo_obtenido]")) {
									var value = $('#titulo_obtenido').val();
									var size = value.length;

									if(size > 60){
										found=true;
										message="El titulo_obtenido ingresado no debe exceder los 60 caracteres";
										return $('#titulo_obtenido').val('');
									}
								}
								if(input.is("[id=situacion_laboral]")) {
								var value = $('#situacion_laboral').val();
								var size = value.length;

								if(size > 100){
									found=true;
									message="La situacion_laboral ingresada no debe exceder los 100 caracteres";
									return $('#situacion_laboral').val('');
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
	Jefeproyecto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_jefeproyecto&task=jefeproyecto_json_list",
                dataType: "json"
            }
        },
  change: function(e){
	console.clear();
                      },
       schema:{
			model:{
				fields:{
					    id_persona:{type:"string"},
						titulo_obtenido:{type:"string"},
						situacion_laboral:{type:"string"},
						publicaciones:{type:"string"},
						otros_aspectos:{type:"string"},
						presupuesto_anual:{type:"number"},
						id_categoria:{type:"string"},
						id_grado:{type:"string"},
						cv:{type:"string"}


				}
			}
 		},
        pageSize: 12
    });
	  $("#gridselection_jefeproyecto").kendoGrid({
	        dataSource: Jefeproyecto.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		  detailTemplate: kendo.template($("#template_jefe_proyecto").html()),
	        sortable: true,
			 groupable:true,
	        change: Jefeproyecto.change,
			resizable: true,
	        dataBound: Jefeproyecto.dataBound,
	        dataBinding: Jefeproyecto.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_jefeproyecto' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,
				{
					field: "id_persona",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
					title: "nombre",
					width: '6%',
					type:"number",
					hidden:true

				}

,
				{
					field: "nombre",
					template:'<div id="item" data-text="#: nombre#">#: nombre#</div>',
					title: "Nombre",
					width: '12%',
					type:"string",


				},
	            {
	                field: "titulo_obtenido",
					template:'<div id="item" data-text="#: titulo_obtenido#">#: titulo_obtenido#</div>',
	                title: "Titulo",
	                width: '10%',
					type:"string"
	            }
				,

	            {
	                field: "situacion_laboral",
					template:'<div id="item" data-text="#: situacion_laboral#">#: situacion_laboral#</div>',
	                title: "Situacion_laboral",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "publicaciones",
					template:'<div id="item" data-text="#: publicaciones#">#: publicaciones#</div>',
	                title: "Publicaciones",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "otros_aspectos",
					template:'<div id="item" data-text="#: otros_aspectos#">#: otros_aspectos#</div>',
	                title: "Otros Aspectos",
	                width: '6%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "presupuesto_anual",
					template:'<div id="item" data-text="#: presupuesto_anual#">#: presupuesto_anual#</div>',
	                title: "Presupuesto Anual (CUP)",
	                width: '25%',
					type:"number"
	            }
				,

	            {
	                field: "id_categoria",
	                title: "categoria ",
					template:'<div id="item" data-text="#: id_categoria#">#: id_categoria#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,
				{
					field: "categoria",
					title: "Categoria ",
					template:'<div id="item" data-text="#: categoria#">#: categoria#</div>',
					width: '10%',
					type:"string",
				}
					,

	            {
	                field: "id_grado",
	                title: "grado",
					template:'<div id="item" data-text="#: id_grado#">#: id_grado#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,
				{
					field: "grado",
					title: "Grado",
					template:'<div id="item" data-text="#: grado#">#: grado#</div>',
					width: '10%',
					type:"string"

				},
				{
					field: "cv",
					title: "cv",
					template:'<div id="item" data-text="#: cv#"><a href="#:cv#" class="list bg-encabezado fg-white"></div>',
					width: '10%',
					type:"string",
					hidden:true

				},
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_jefeproyecto(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_jefeproyecto(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_jefeproyecto').click(function () {
        var c = this.checked;
        $('#gridselection_jefeproyecto :checkbox').prop('checked',c);
    });
    $('#accionbtn_jefeproyectosave_exit').click(function()
			    {
					if (validator_jefeproyecto.validate())
                    {

                      var fd = new FormData(document.querySelector("#jefeproyecto_form"));
                      var  url="?option=com_jefeproyecto&task=jefeproyecto_add";
	        			if($('#taskjefeproyecto').val()=="update")
							{
                       var olditem=JSON.stringify(Jefeproyecto.oldElement);
                       fd.append('olditem',olditem);
				var  url="?option=com_jefeproyecto&task=jefeproyecto_update";
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
	                					Jefeproyecto.gridDataSource.read();
                                       $('#jefeproyecto_form')[0].reset();
            	                					wnd_jefeproyecto.close();
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
    $('#accionbtn_jefeproyectosave_new').click(function()
			    {
					if (validator_jefeproyecto.validate())
                    {

                       var fd = new FormData(document.querySelector("#jefeproyecto_form"));
	        			 var url="?option=com_jefeproyecto&task=jefeproyecto_add";
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
                                       showInsert_jefeproyecto();
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

    $('#cancelbtn_jefeproyecto').click(function(){
        $('#jefeproyecto_form')[0].reset();
           Jefeproyecto.gridDataSource.read();
        wnd_jefeproyecto.close();
    });

    $('#addbutton_jefeproyecto').click(function(){
        showInsert_jefeproyecto();
    });
    $('#deletebutton_jefeproyecto').click(function(){
        var checkbox_checked=$('#gridselection_jefeproyecto .check_row:checked');

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
                      var dataItem=Jefeproyecto.finditem($(this).attr('id'));
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
						url:"?option=com_jefeproyecto&task=jefeproyecto_delete_one",
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
							Jefeproyecto.gridDataSource.read();
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
