
//Creando variables globales
	var validator;
	var Indicadores_impacto={};
	var message=""


	//Creando los windows Dialogs
	wnd_indicadores_impacto = $("#indicadores_impacto_window").kendoWindow({
			        modal: true,
			        visible: false,
			        resizable: false,
			        width: '45%',
					heigth:100,
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
        				if(Indicadores_impacto.oldElement!=null) {
							
				    			$('#indicador').val(Indicadores_impacto.oldElement.indicador);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Indicadores_impacto.oldElement=null;
	Indicadores_impacto.change = function onChange(arg) {
};
	Indicadores_impacto.change = function onDataBinding(arg) {
};
	Indicadores_impacto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Indicadores_impacto.kgrid=this;
		}
	Indicadores_impacto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Indicadores_impacto.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



				function showInsert_indicadores_impacto() {
					Indicadores_impacto.oldElement=null;
					validator_indicadores_impacto.hideMessages();
		    		$('#indicadores_impacto_form')[0].reset();
		    		$('#taskindicadores_impacto').val('insert');
		    		wnd_indicadores_impacto.title("Crear Indicador de Impacto");
					$('#accionbtn_save_new').show();
					$('#accionbtn_save_exit').text("Guardar y Salir");
		    		wnd_indicadores_impacto.center().open();
				}

//Mostrar Ventanas
				function showUpdate_indicadores_impacto(e) {
					validator_indicadores_impacto.hideMessages();
				    $('#indicadores_impacto_form')[0].reset();
				    var dataItem=Indicadores_impacto.finditem(e.id);
				    Indicadores_impacto.oldElement= dataItem;
				    $('#taskindicadores_impacto').val('update');
				    wnd_indicadores_impacto.title("Actualizar Indicador de Impacto");
					$('#accionbtn_save_new').hide();
					$('#accionbtn_save_exit').text("Actualizar");
				    wnd_indicadores_impacto.center().open();
				}

//Eliminar elemento
function delete_element_indicadores_impacto(e)
{
    var dataItem=Indicadores_impacto.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar el Indicador?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                url:"?option=com_indicadores_impacto&task=indicadores_impacto_delete_one",
                data:{
                    array:JSON.stringify(array)
                },
                success:function(response){
                    if(!response.success==true)
                    {
                        $.smallBox({
                            title: "Indicador de Impacto",
                            content:"<p class='fg-white'> No se ha podido eliminar el indicador</p>",
                            color: "#9E162E",
                            timeout: 4000
                        })
                    }
					else{
						$.smallBox({
							title: "Indicador de Impacto",
							content: "<p class='fg-white'> Se ha  eliminado correctamente el indicador</p>",
							color: "#00a65a",
							timeout: 4000
						})
					}
                    Indicadores_impacto.gridDataSource.read();
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
	validator_indicadores_impacto=$("#indicadores_impacto_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Indicadores_impacto.oldElement==null)
                    		{
								if(input.is("[id=indicador]")) {
									var value = $('#indicador').val();
									var size = value.length;

									while (i < Indicadores_impacto.gridDataSource._view.length) {
										var elem=Indicadores_impacto.gridDataSource._view[i];
										if(elem.indicador==value)
										{
											found=true;
											message="Ya esta indicador esta definido";
											i=Indicadores_impacto.gridDataSource._view.length;
											return $('#indicador').val('');
										}
										i++;
									}

									if(size > 25){
										found=true;
										message="El indicador  ingresado no debe exceder los 25 caracteres";
										return $('#indicador').val('');
									}
								}
							return !found;
						}
						else
						{
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
	Indicadores_impacto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url: "?option=com_indicadores_impacto&task=indicadores_impacto_json_list",
                dataType: "json"
            }
        },
		change: function(e){
			console.clear();
		},
       schema:{
			model:{
				fields:{
						id_indicador:{type:"number"},
						indicador:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
 $("#gridselection_indicadores_impacto").kendoGrid({
	        dataSource: Indicadores_impacto.gridDataSource,
	        height: 500,
				columnMenu: true,
				filterable: {
					mode: "row"
				},
	        sortable: true,
		     groupable:true,
	        change: Indicadores_impacto.change,
			resizable: true,
	        dataBound: Indicadores_impacto.dataBound,
	        dataBinding: Indicadores_impacto.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_indicadores_impacto' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",

	            }
				,

	            {
	                field: "id_indicador",
					template:'<div id="item" data-text="#: id_indicador#">#: id_indicador#</div>',
	                title: "Id",
	                width: '10%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "indicador",
					template:'<div id="item" data-text="#: indicador#">#: indicador#</div>',
	                title: "Indicador",
	                width: '85%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_indicadores_impacto(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_indicadores_impacto(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '20%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_indicadores_impacto').click(function () {
        var c = this.checked;
        $('#gridselection_indicadores_impacto :checkbox').prop('checked',c);
    });
    $('#accionbtn_save_exit').click(function()
			    {
					if (validator_indicadores_impacto.validate())
                    {
						var fd = new FormData(document.querySelector("#indicadores_impacto_form"));

	        			var url="?option=com_indicadores_impacto&task=indicadores_impacto_add";
	        			if($('#taskindicadores_impacto').val()=="update")
							{
								var olditem=JSON.stringify(Indicadores_impacto.oldElement);
								fd.append('olditem',olditem);
								var url="?option=com_indicadores_impacto&task=indicadores_impacto_update";
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
												var message='El indicador fue insertado con exito'
                        					if($('#taskusuario').val()=='update')
                            					message='El indicador fue actualizado con exito'
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
									Indicadores_impacto.gridDataSource.read();
									$('#indicadores_impacto_form')[0].reset();
									wnd_indicadores_impacto.close();
	            			}
	        			});
					}
					else
					{
						$.smallBox({
							title: 'Error',
							content:'Por favor  llenar los campos',
							color: "#BA0916",
							timeout: 6000
						})
					}
				});
	$('#accionbtn_save_new').click(function()
	{
		if (validator_indicadores_impacto.validate())
		{
			var fd = new FormData(document.querySelector("#indicadores_impacto_form"));


			var url="?option=com_indicadores_impacto&task=indicadores_impacto_add";

			$.ajax({
				type: "POST",
				url:url,
				data:fd,
				cache: false,
				processData: false,
				contentType: false,
				success:function(response){

					if(response.success==true=="")
					{
						$('#text-error').html(response.message);
						$.smallBox({
							title: '',
							content:$('#message-error').html(),
							color: "#BA0916",
							timeout: 6000
						})
					}
					else
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
					$('#id_indicador').val= "";
					showInsert_indicadores_impacto();
				}
			});
		}
		else
		{
			$.smallBox({
				title: 'Error',
				content:'Por favor  llenar los campos',
				color: "#BA0916",
				timeout: 6000
			})
		}

	});
    $('#cancelbtn_indicador').click(function(){
        $('#indicadores_impacto_form')[0].reset();
		Indicadores_impacto.gridDataSource.read();
        wnd_indicadores_impacto.close();
    });

    $('#addbutton_indicadores_impacto').click(function(){
        showInsert_indicadores_impacto();
    });
    $('#deletebutton_indicadores_impacto').click(function(){
        var checkbox_checked=$('#gridselection_indicadores_impacto .check_row:checked');

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
                      var dataItem=Indicadores_impacto.finditem($(this).attr('id'));
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
                        url:"?option=com_indicadores_impacto&task=indicadores_impacto_delete_one",
                        data:{
                            array:JSON.stringify(array)
                        },
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
                            Indicadores_impacto.gridDataSource.read();
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
