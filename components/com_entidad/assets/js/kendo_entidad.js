/** * Created by Ernesto on .
 *Date:12/10/2015  
 *Time:10:12 */
//Creando variables globales
	var validator;
	var Entidad={};
	var message=""


	//Creando los windows Dialogs
	wnd_entidad = $("#entidad_window").kendoWindow({
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
        				if(Entidad.oldElement!=null) {
							
				    			$('#nombre').val(Entidad.oldElement.nombre);
				    			$('#id_provincia').data("kendoDropDownList").value(Entidad.oldElement.id_provincia);
				    			$('#telefono').val(Entidad.oldElement.telefono);
				    			$('#direccion').val(Entidad.oldElement.direccion);
				    			$('#correo').val(Entidad.oldElement.correo);
				    			$('#paginaweb').val(Entidad.oldElement.paginaweb);
				    			$('#vision').val(Entidad.oldElement.vision);
				    			$('#mision').val(Entidad.oldElement.mision);
						}

						else
						{
				    			$('#id_provincia').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");

$("#telefono").kendoNumericTextBox({
	format: "537-#",
	maxLength:10

});


	//Definir controladora
	Entidad.oldElement=null;
		/*Data Source  Provincia*/
	var provinciadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url: "?option=com_provincia&task=provincia_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Provincia*/
		$("#id_provincia").kendoDropDownList({
        dataTextField: "nombre_provincia",
        dataValueField: "id_provincia",
        dataSource: provinciadatasource,
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
                if(elem.id_provincia== $("#id_provincia").val())
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
	Entidad.change = function onChange(arg) {
};
	Entidad.change = function onDataBinding(arg) {
};
	Entidad.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Entidad.kgrid=this;
		}
	Entidad.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Entidad.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



				function showInsert_entidad() {
					Entidad.oldElement=null;
					validator_entidad.hideMessages();
		    		$('#entidad_form')[0].reset();
		    		$('#taskentidad').val('insert');
		    		wnd_entidad.title("Insertar Entidad");
                   $('#accionbtn_entidadsave_new').show();
		    		wnd_entidad.center().open();
				}

//Mostrar Ventanas
				function showUpdate_entidad(e) {
					validator_entidad.hideMessages();
				    $('#entidad_form')[0].reset();
				    var dataItem=Entidad.finditem(e.id);
				    Entidad.oldElement= dataItem;
				    $('#taskentidad').val('update');
				    wnd_entidad.title("Actualizar Entidad");
					$('#accionbtn_entidadsave_exit').text("Actualizar");
                   $('#accionbtn_entidadsave_new').hide();
				    wnd_entidad.center().open();
				}

//Eliminar elemento
function delete_element_entidad(e)
{
    var dataItem=Entidad.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Entidad?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_entidad&task=entidad_delete_one",
                data:{
                    array:JSON.stringify(array)
                },
                success:function(response){
					if(response.success==true)
					{
						$.smallBox({
							title: "<span class='fa fa-trash-o'></span>Eliminar Entidad",
							content:"<p class='fg-white'>Entidad eliminada correctamente</p>" ,
							color: "#00a65a",
							timeout: 4000
						})
					}
					else{
						$.smallBox({
							title: "<span class='fa fa-trash-o'></span>Eliminar Entidad",
							content:"<p class='fg-white'>Error al eliminar la Entidad</p>" ,
							color: "#9E162E",
							timeout: 4000
						})

					}
                    Entidad.gridDataSource.read();
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
	validator_entidad=$("#entidad_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Entidad.oldElement==null)
                    		{




								if(input.is("[id=nombre]")) {
									value=$('#nombre').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El nombre  ingresado no debe exceder los 25 caracteres";
										return $('#nombre').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.nombre==value)
										{
											found=true;
											message="Ya existe una entidad con este nombre";
											i=Entidad.gridDataSource._data.length;
											return $('#nombre').val('');
										}
										i++;
									}
								}
	                                if(input.is("[id=telefono]")) {
									value=$('#telefono').val();

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.telefono==value)
										{
											found=true;
											message="Ya existe un telefono asi";
											i=Entidad.gridDataSource._data.length;
											return $('#telefono').val('');
										}
										i++;
									}
								}
	                               if(input.is("[id=correo]")) {
									value=$('#correo').val();
									   var size = value.length;
									   if(size > 25){
										   found=true;
										   message="El correo  ingresado no debe exceder los 25 caracteres";
										   return $('#correo').val('');
									   }
									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.correo==value)
										{
											found=true;
											message="Ya existe un correo definido";
											i=Entidad.gridDataSource._data.length;
											return $('#correo').val('');
										}
										i++;
									}
								}    if(input.is("[id=direccion]")) {
									value=$('#direccion').val();
								var size = value.length;
								if(size > 50){
									found=true;
									message="la dirección  ingresado no debe exceder los 50 caracteres";
									return $('#direccion').val('');
								}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.direccion==value)
										{
											found=true;
											message="Ya existe una direccion con este asi";
											i=Entidad.gridDataSource._data.length;
											return $('#direccion').val('');
										}
										i++;
									}
								}
								if(input.is("[id=sitioWeb]")) {
								value=$('#sitioWeb').val();
								var size = value.length;
								if(size > 25){
									found=true;
									message="El sitioWeb  ingresado no debe exceder los 25 caracteres";
									return $('#sitioWeb').val('');
								}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.sitioWeb==value)
										{
											found=true;
											message="Ya existe un sitioWeb con este nombre";
											i=Entidad.gridDataSource._data.length;
											return $('#sitioWeb').val('');
										}
										i++;
									}
								}

								if(input.is("[id=vision]")) {
									value=$('#vision').val();
									var size = value.length;
									if(size > 50){
										found=true;
										message="La vision  ingresada no debe exceder los 50 caracteres";
										return $('#sitioWeb').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.vision==value)
										{
											found=true;
											message="Ya existe un vision con este nombre";
											i=Entidad.gridDataSource._data.length;
											return $('#vision').val('');
										}
										i++;
									}
								}
								if(input.is("[id=mision]")) {
									value=$('#mision').val();
									var size = value.length;
									if(size > 50){
										found=true;
										message="La mision  ingresada no debe exceder los 50 caracteres";
										return $('#mision').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.mision==value)
										{
											found=true;
											message="Ya existe una mision";
											i=Entidad.gridDataSource._data.length;
											return $('#mision').val('');
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
	Entidad.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url: "?opton=com_entidad&task=entidad_json_list",
                dataType: "json"
            }
        },
		change: function(e){
			console.clear();
		},
       schema:{
			model:{
				fields:{
						id_entidad:{type:"number"},
						nombre:{type:"string"},
						id_provincia:{type:"string"},
					     telefono:{type:"number"},
						direccion:{type:"string"},
						correo:{type:"string"},
						paginaweb:{type:"string"},
						vision:{type:"string"},
						mision:{type:"string"}

				}
			}
 		},
        pageSize: 12
    });
 $("#gridselection_entidad").kendoGrid({
	        dataSource: Entidad.gridDataSource,
	        height: 890,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
			 groupable:true,
	        sortable: true,
	        change: Entidad.change,
			resizable: true,
	        dataBound: Entidad.dataBound,
	        dataBinding: Entidad.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [
	            {	                
					field: "",
	                title: "",
	                width: '2%',
	                headerTemplate: "<input class='' id='all_check_entidad' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_entidad",
					template:'<div id="item" data-text="#: id_entidad#">#: id_entidad#</div>',
	                title: "Id",
	                width: '3%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "nombre",
					template:'<div id="item" data-text="#: nombre#">#: nombre#</div>',
	                title: "Nombre",
	                width: '7%',
					type:"string"
	            }
				,

	            {
	                field: "id_provincia",
	                title: "id_provincia",
					template:'<div id="item" data-text="#: id_provincia#">#: id_provincia#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}

			,     {
	                field: "provincia",
	                title: "Provincia",
					template:'<div id="item" data-text="#: provincia#">#: provincia#</div>',
	                width: '5%',
					type:"string"
				}

			,

	            {
	                field: "telefono",
					template:'<div id="item" data-text="#: telefono#">#: telefono#</div>',
	                title: "Telefono",
	                width: '7%',
					type:"number"
	            }
				,

	            {
	                field: "direccion",
					template:'<div id="item" data-text="#: direccion#">#: direccion#</div>',
	                title: "Dirección",
	                width: '7%',
					type:"string"
	            }
				,

	            {
	                field: "correo",
					template:'<div id="item" data-text="#: correo#">#: correo#</div>',
	                title: "Correo",
	                width: '7%',
					type:"string"
	            }
				,

	            {
	                field: "paginaweb",
					template:'<div id="item" data-text="#: paginaWeb#">#: paginaWeb#</div>',
	                title: "Sitio Web",
	                width: '7%',
					type:"string"
	            }
				,

	            {
	                field: "vision",
					template:'<div id="item" data-text="#: vision#">#: vision#</div>',
	                title: "Visión",
	                width: '7%',
					type:"string"
	            }
				,

	            {
	                field: "mision",
					template:'<div id="item" data-text="#: mision#">#: mision#</div>',
	                title: "Misión",
	                width: '7%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_entidad(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_entidad(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_entidad').click(function () {
        var c = this.checked;
        $('#gridselection_entidad :checkbox').prop('checked',c);
    });
    $('#accionbtn_entidadsave_exit').click(function()
			    {
					if (validator_entidad.validate())
                    {

						var fd = new FormData(document.querySelector("#entidad_form"));
	        			 var url="?option=com_entidad&task=entidad_add ";
	        			if($('#taskentidad').val()=="update")
							{
                       var olditem=JSON.stringify(Entidad.oldElement);
                        fd.append('olditem',olditem);
				       var url="?option=com_entidad&task=entidad_update";
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
                        					});
                    					}
                    						else
                    					{
                                               $('#text-error').html(response.message);
                        						$.smallBox({
                            						title: '',
                            						content:$('#message-error').html(),
                            						color: "#BA0916",
                            						timeout: 6000
                        						});
                    					}
	                					Entidad.gridDataSource.read();
                                       $('#entidad_form')[0].reset();
								   wnd_entidad.close();
	            			}


	        			});
					}
					else {
						$.smallBox({
							title: "Error",
							content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
							color: "#9E162E",
							timeout: 4000
						})
					}});
    $('#accionbtn_entidadsave_new').click(function()
			    {
					if (validator_entidad.validate())
                    {

						var fd = new FormData(document.querySelector("#entidad_form"));
	        			 var url="?option=com_entidad&task=entidad_add";
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
                                       showInsert_entidad();           
	            			}
	        			});
					}

					else {
						$.smallBox({
							title: "Error",
							content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
							color: "#9E162E",
							timeout: 4000
						})
					}
				});

    $('#cancelbtn_entidad').click(function(){
        $('#entidad_form')[0].reset();
		Entidad.gridDataSource.read();
        wnd_entidad.close();
    });

    $('#addbutton_entidad').click(function(){
        showInsert_entidad();
    });
    $('#deletebutton_entidad').click(function(){
        var checkbox_checked=$('#gridselection_entidad .check_row:checked');

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
                      var dataItem=Entidad.finditem($(this).attr('id'));
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
                        url:"?option=com_entidad&task=entidad_delete_one",
                        data:{
                            array:JSON.stringify(array)
                        },
                        success:function(response){
							if(response.success==true)
							{
								var message='El elemento fue eliminado con exito';
								$.smallBox({
									title: '',
									content: $('#message-ok').html(),
									color: "#00A65A",
									timeout: 6000
								});
							}
							else
							{
								$('#text-error').html(response.message);
								$.smallBox({
									title: '',
									content:$('#message-error').html(),
									color: "#BA0916",
									timeout: 6000
								});
							}
                            Entidad.gridDataSource.read();
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
