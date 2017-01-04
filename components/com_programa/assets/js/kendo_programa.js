/** * Created by Ernesto on .
 *Date:12/12/2015
 *Time:6:42 */
//Creando variables globales
	var validator;
	var Programa={};
	var message=""


	//Creando los windows Dialogs
	wnd_programa = $("#programa_window").kendoWindow({
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
        				if(Programa.oldElement!=null)   {

				    			$('#id_programa').data("kendoDropDownList").value(Programa.oldElement.id_programa);
				    			$('#nombre').val(Programa.oldElement.nombre);
				    			$('#secretarioprograma').data("kendoDropDownList").value(Programa.oldElement.secretarioprograma);
				    			$('#objetivoGeneral').val(Programa.oldElement.objetivogeneral);
				    			$('#grupoExpertos').val(Programa.oldElement.grupoexpertos);
				    			$('#otras_entidades').val(Programa.oldElement.otras_entidades);
				    			$('#id_entidad').data("kendoDropDownList").value(Programa.oldElement.id_entidad);
				    		//	$('#id_persona').data("kendoDropDownList").value(Programa.oldElement.id_persona);
						}

						else
						{
				    			$('#id_entidad').data("kendoDropDownList").value('');
				    			$('#id_programa').data("kendoDropDownList").value('');

				    			//$('#id_persona').data("kendoDropDownList").value('');
				    			$('#secretarioprograma').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Programa.oldElement=null;
		/*Data Source  Entidad*/
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
		$("#id_entidad").kendoDropDownList({
        dataTextField: "nombre",
        dataValueField: "id_entidad",
        dataSource: entidaddatasource,
        filter: "contains",
		 open: function(e) {
          //  valid = false;
        },
		 change:function(e){
/*            var i=0;
            valid=false;
            while(i<this.options.dataSource._data.length)
            {
                var elem=this.options.dataSource._data[i];
                if(elem.id_entidad== $("#id_entidad").val())
                	{
                  		i= this.options.dataSource._data.length;
                   // 	valid=true;
                	}
               	i++;
            	}
            	//if (!valid) this.value('');*/
        },
			select: function(e){
         //   valid = true;


        },
        close: function(e){
            // if no valid selection - clear input
         //   if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
		/*Data Source  Perfil_programa*/
	var perfil_programadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_perfil_programa&task=profile_filtro_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Perfil_programa pk*/
	$("#id_programa").kendoDropDownList({
        dataTextField: "denominacion",
        dataValueField: "id_programa",
        dataSource: perfil_programadatasource,
        filter: "contains",
		 open: function(e) {
            //valid = true;
        },
		 change:function(e){
			// valid = true;


          //  	if (!valid) this.value('');
        },
        select: function(e){

			//valid = true;



        },
        close: function(e){
            // if no valid selection - clear input
         //   if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
var personadatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_persona&task=persona_json_list",
			dataType: "json"
		}
	}
});
$("#export_pdf_programa").click(function() {
	$('#addbutton_programa').hide();
	$('#deletebutton_programa').hide();

	kendo.drawing.drawDOM($("#pdf_programa"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				$('#addbutton_programa').show();
				$('#deletebutton_programa').show();
				kendo.saveAs({
					dataURI: data,
					fileName: "Progama.pdf",
					proxyURL: ""
				});
			});
});

/*ComboBox  secretario programa*/
$("#secretarioprograma").kendoDropDownList({
	dataTextField: "nombre",
	dataValueField: "id_persona",
	dataSource: personadatasource,
	filter: "contains",
	open: function(e) {
		//valid = true;
	},
	change:function(e){
	//	valid=true;


	},
	select: function(e){
	//		valid = true;


	},
	close: function(e){
		// if no valid selection - clear input
		//if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});
		/*Data Source  jefe programa*/

		/*ComboBox  Persona*/
		$("#id_persona").kendoDropDownList({
        dataTextField: "nombre",
        dataValueField: "id_persona",
        dataSource: personadatasource,
        filter: "contains",
		 open: function(e) {
            //valid = true;
        },
		 change:function(e) {
			 //valid = true;


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
	Programa.change = function onChange(arg) {
};
	Programa.change = function onDataBinding(arg) {
};
	Programa.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Programa.kgrid=this;
		}
	Programa.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Programa.gridDataSource._data,function(value,index){
        if(value.uid==uid)
        {
            return value;
        }
    });
    return dataItem[0];
}




				function showInsert_programa() {
					Programa.oldElement=null;
					validator_programa.hideMessages();
		    		$('#programa_form')[0].reset();
		    		$('#taskprograma').val('insert');
		    		wnd_programa.title("Crear Programa");
					$("#id_programa").data("kendoDropDownList").enable() ;
					$("#secretarioprograma").data("kendoDropDownList").value('') ;
					//$("#id_persona").data("kendoDropDownList").value('') ;
					$("#id_entidad").data("kendoDropDownList").value('') ;
					$('#accionbtn_programasave_exit').text('Guardar y Salir');
                   $('#accionbtn_programasave_new').show();
		    		wnd_programa.center().open();
				}

//Mostrar Ventanas
				function showUpdate_programa(e) {
					validator_programa.hideMessages();
				    $('#programa_form')[0].reset();
				    var dataItem=Programa.finditem(e.id);
				    Programa.oldElement= dataItem;

				    $('#taskprograma').val('update');
				    wnd_programa.title("Actualizar Programa");
                   $('#accionbtn_programasave_exit').text('Actualizar');
                   $('#accionbtn_programasave_new').hide();
					$("#id_programa").data("kendoDropDownList").readonly() ;
				    wnd_programa.center().open();

				}

//Eliminar elemento
function delete_element_programa(e)
{
    var dataItem=Programa.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Programa?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_programa&task=programa_delete_one",
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
					Programa.gridDataSource.read();
                }

            });
        }
        else
            close();
    })
}
//On load
$(function() {
	validator_programa=$("#programa_form").kendoValidator({

			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Programa.oldElement==null)
                    		{

								if(input.is("[id=id_programa]") && $('#taskprograma').val('insert')) {

								 	value=$('#id_programa').data('kendoDropDownList').value();

								 	while (i < Programa.gridDataSource._data.length) {
                                		var elem=Programa.gridDataSource._data[i];
                                	 if(elem.id_programa==value)
                                		{
											found=true;
											message ='El programa a definir ya existe';
                                    		i=Programa.gridDataSource._data.length;
											return $('#id_programa').data('kendoDropDownList').value('');
		                                }
                                		i++;

                            		}

									return !found;

								}	if(input.is("[id=id_entidad]")) {

								 	value=$('#id_entidad').data('kendoDropDownList').value();

								 	while (i < Programa.gridDataSource._data.length) {
                                		var elem=Programa.gridDataSource._data[i];
                                	 if(elem.id_entidad==value)
                                		{
											found=true;
											message ='La entidad seleccionada esta ejecutando un programa';
                                    		i=Programa.gridDataSource._data.length;
											return $('#id_entidad').data('kendoDropDownList').value('');
		                                }
                                		i++;

                            		}

									return !found;

								}
								if(input.is("[id=secretarioprograma]")) {
									var valueS = $('#secretarioprograma').data('kendoDropDownList').value();
									var valueJ = $('#id_persona').data('kendoDropDownList').value();


									while (i < Programa.gridDataSource._data.length) {
										 elem = Programa.gridDataSource._data[i];
										if (elem.secretarioprograma == valueS || elem.id_persona == valueS ) {
											found = true;
											message = 'La persona seleccionada ejerce actualmente de jefe o secretario en otro programa';
											return $('#secretarioprograma').data('kendoDropDownList').value('');


										}
										i++;


									}
								 if (valueJ==valueS){
										found=true;
										message ='El secretario debe ser diferente al jefe del programa';
									 return $('#secretarioprograma').data('kendoDropDownList').value('');



									}
									return !found;

								}

								if(input.is("[id=id_persona]")) {
									 valueS = $('#secretarioprograma').data('kendoDropDownList').valueOf();
									 valueJ = $('#id_persona').data('kendoDropDownList').valueOf();
									if (valueJ==valueS){
										found=true;
										message ='El jefe debe ser diferente al secretario del programa';
										return $('#id_persona').data('kendoDropDownList').value('');



									}

								 	while (i < Programa.gridDataSource._data.length) {
                                		 elem=Programa.gridDataSource._data[i];
                                	 if(elem.secretarioprograma==valueJ || elem.id_persona == valueJ)
                                		{
                                    		found=true;
											message="La persona seleccionada ejerce actualmente de jefe o secretario en otro programa";
                                    		i=Programa.gridDataSource._data.length;
											return $('#id_persona').data('kendoDropDownList').value('');

		                                }
                                		i++;
                            		}
									if(input.is("[id=objetivoGeneral]")) {
										var value = $('#objetivoGeneral').val();
										var size = value.length;

										if(size > 250){
											found=true;
											message="El objetivoGeneral ingresado no debe exceder los 250 caracteres";
											return $('#objetivoGeneral').val('');
										}
									}
									if(input.is("[id=grupoExpertos]")) {
										var value = $('#grupoExpertos').val();
										var size = value.length;

										if(size > 250){
											found=true;
											message="El grupoExpertos ingresado no debe exceder los 250 caracteres";
											return $('#grupoExpertos').val('');
										}
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
	Programa.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_programa&task=programa_json_list",
                dataType: "json"
            }
        },
     change: function(e){
	console.clear();
                      },
       schema:{
			model:{
				fields:{
						id_programa:{type:"string"},
						nombre:{type:"string"},
						secretarioprograma:{type:"string"},
						objetivogeneral:{type:"string"},
						grupoexpertos:{type:"string"},
					otras_entidades:{type:"string"},
						id_entidad:{type:"string"},
						id_persona:{type:"string"}

				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_programa").kendoGrid({
	        dataSource: Programa.gridDataSource,
	        height: 500,
	        sortable: true,
			 groupable:true,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_programa").html()),
	        change: Programa.change,
			resizable: true,
	        dataBound: Programa.dataBound,
	        dataBinding: Programa.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_programa' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_programa",
	                title: "Id",
					template:'<div id="item" data-text="#: id_programa#">#:id_programa#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				},
				{
					field: "denominacion",
					title: "Denominación",
					template:'<div id="item" data-text="#: denominacion#">#: denominacion#</div>',
					width: '12%',
					type:"string"
				}

			,

	            {
	                field: "nombre",
					template:'<div id="item" data-text="#: nombre#">#: nombre#</div>',
	                title: "Nombre",
	                width: '9%',
					type:"string"
	            }
				,

	            {
	                field: "secretarioprograma",
					template:'<div id="item" data-text="#: secretarioprograma#">#: secretarioprograma#</div>',
	                title: "Secretario",
	                width: '9%',
					type:"number",
					hidden:true
	            }
				,  {
					field: "nombre_secre",
					template:'<div id="item" data-text="#: nombre_secre#">#: nombre_secre#</div>',
					title: "Secretario",
					width: '9%',
					type:"string"
				},

	            {
	                field: "objetivogeneral",
					template:'<div id="item" data-text="#: objetivoGeneral#">#: objetivoGeneral#</div>',
	                title: "Objetivo General",
	                width: '12%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "grupoexpertos",
					template:'<div id="item" data-text="#: grupoExpertos#">#: grupoExpertos#</div>',
	                title: "Grupo Expertos",
	                width: '12%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "id_entidad",
	                title: "E.Ejecutora",
					template:'<div id="item" data-text="#: id_entidad#">#: id_entidad#</div>',
	                width: '10%',
					type:"number",
					hidden:true
				},
	           {
		         field: "otras_entidades",
				  template:'<div id="item" data-text="#: otras_entidades#">#: otras_entidades#</div>',
			     title: "Otras Entidades",
			     width: '12%',
			     type:"string",
				   hidden:true
	         }

			,  {
					field: "nombre_entidad",
					title: "E.Gestionadora",
					template:'<div id="item" data-text="#: nombre_entidad#">#: nombre_entidad#</div>',
					width: '10%',
					type:"string",
					hidden:false
				},
	            {
	                field: "id_persona",
	                title: "Jefe",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
	                width: '12%',
					type:"number",
					hidden:true
				}
			,
				{
					field: "nombre_jefe",
					title: "Jefe",
					template:'<div id="item" data-text="#: nombre_jefe#">#: nombre_jefe#</div>',
					width: '12%',
					type:"string"
				},
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_programa(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_programa(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '8%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_programa').click(function () {
        var c = this.checked;
        $('#gridselection_programa :checkbox').prop('checked',c);
    });
    $('#accionbtn_programasave_exit').click(function()
			    {
					if (validator_programa.validate())
                    {

                      var fd = new FormData(document.querySelector("#programa_form"));

                      var  url="?option=com_programa&task=programa_add";
	        			if($('#taskprograma').val()=="update")
							{
								var olditem=JSON.stringify(Programa.oldElement);

								fd.append('olditem',olditem);

								var  url="?option=com_programa&task=programa_update";
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
	                					Programa.gridDataSource.read();
                                       $('#programa_form')[0].reset();
            	                					wnd_programa.close();
	            			}
	        			});
					}
					else {
	$.smallBox({
		title: "<span class='step size 32'><p class='icon ion-alert'>Error</p></span>",
		content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
		color: "#9162E",
		timeout: 4000
	});
}
	    });
    $('#accionbtn_programasave_new').click(function()
			    {
					if (validator_programa.validate())
                    {

                       var fd = new FormData(document.querySelector("#programa_form"));
	        			 var url="?option=com_programa&task=programa_add";
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
                                       showInsert_programa();
	            			}
	        			});
					}
					else {
	$.smallBox({
		title: "Error",
		content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
		color: "#9162E",
		timeout: 4000
	});
}
	    });

    $('#cancelbtn_programa').click(function(){
        $('#programa_form')[0].reset();
           Programa.gridDataSource.read();
        wnd_programa.close();
    });
/*	$('#refrescar').click(function(){
		$('#programa_form')[0].reset();
    });*/

    $('#addbutton_programa').click(function(){
        showInsert_programa();
    });
    $('#deletebutton_programa').click(function(){
        var checkbox_checked=$('#gridselection_programa .check_row:checked');

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
                      var dataItem=Programa.finditem($(this).attr('id'));
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
                        url:"?option=com_programa&task=programa_delete_one",
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
                            Programa.gridDataSource.read();
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
