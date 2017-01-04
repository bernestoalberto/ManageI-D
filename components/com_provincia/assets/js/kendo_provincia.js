/** * Created by Ernesto on .
 *Date:12/11/2015  
 *Time:3:9 */
//Creando variables globales
	var validator;
	var Provincia={};
	var message=""


	//Creando los windows Dialogs
	wnd_provincia = $("#provincia_window").kendoWindow({
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
        				if(Provincia.oldElement!=null) {
							
				    			$('#nombre_provincia').val(Provincia.oldElement.nombre_provincia);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Provincia.oldElement=null;
	Provincia.change = function onChange(arg) {
};
	Provincia.change = function onDataBinding(arg) {
};
	Provincia.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Provincia.kgrid=this;
		}
	Provincia.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Provincia.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



				function showInsert_provincia() {
					Provincia.oldElement=null;
					validator_provincia.hideMessages();
		    		$('#provincia_form')[0].reset();
		    		$('#taskprovincia').val('insert');
		    		wnd_provincia.title("Insertar Provincia");
					$('#accionbtn_provinciasave_exit').text('Guardar y Salir');
					$('#accionbtn_provinciasave_new').show();
		    		wnd_provincia.center().open();
				}

//Mostrar Ventanas
				function showUpdate_provincia(e) {
					validator_provincia.hideMessages();
				    $('#provincia_form')[0].reset();
				    var dataItem=Provincia.finditem(e.id);
				    Provincia.oldElement= dataItem;
				    $('#taskprovincia').val('update');
				    wnd_provincia.title("Actualizar Provincia");
                   $('#accionbtn_provinciasave_exit').text('Actualizar');                                 
                   $('#accionbtn_provinciasave_new').hide();
				    wnd_provincia.center().open();
				}

//Eliminar elemento
function delete_element_provincia(e)
{
    var dataItem=Provincia.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Provincia?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_provincia&task=provincia_delete_one",
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
                    Provincia.gridDataSource.read();
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
	validator_provincia=$("#provincia_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Provincia.oldElement==null)
                    		{

								if(input.is("[id=nombre_provincia]")) {
									value=$('#nombre_provincia').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="La provincia  ingresada no debe exceder los 25 caracteres";
										return $('#nombre_provincia').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.nombre_provincia==value)
										{
											found=true;
											message="Ya existe una provincia";
											i=Entidad.gridDataSource._data.length;
											return $('#nombre_provincia').val('');
										}
										i++;
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
	Provincia.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_provincia&task=provincia_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_provincia:{type:"number"},
						nombre_provincia:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_provincia").kendoGrid({
	        dataSource: Provincia.gridDataSource,
	        height: 490,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
	        sortable: true,
	        change: Provincia.change,
			resizable: true,
			 groupable:true,
	        dataBound: Provincia.dataBound,
	        dataBinding: Provincia.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_provincia' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_provincia",
					template:'<div id="item" data-text="#: id_provincia#">#: id_provincia#</div>',
	                title: "Id",
	                width: '10%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "nombre_provincia",
					template:'<div id="item" data-text="#: nombre_provincia#">#: nombre_provincia#</div>',
	                title: "Nombre Provincia",
	                width: '75%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_provincia(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_provincia(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '20%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_provincia').click(function () {
        var c = this.checked;
        $('#gridselection_provincia :checkbox').prop('checked',c);
    });
    $('#accionbtn_provinciasave_exit').click(function()
			    {
					if (validator_provincia.validate())
                    {
                     var fd = new FormData(document.querySelector("#provincia_form"));
                      var  url ="?option=com_provincia&task=provincia_add";
	        			if($('#taskprovincia').val()=="update")
							{
                       var olditem=JSON.stringify(Provincia.oldElement);
                       fd.append('olditem',olditem);
				var  url="?option=com_provincia&task=provincia_update";
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
	                					Provincia.gridDataSource.read();
                                       $('#provincia_form')[0].reset();
            	                					wnd_provincia.close();
	            			}
	        			});
					}
					else {
	$.smallBox({         
		title: "Error",
		content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
		color:" #9162E",
		timeout: 4000
	});
}                                                                              
	    });
    $('#accionbtn_provinciasave_new').click(function()
			    {
					if (validator_provincia.validate())
                    {
						var fd = new FormData(document.querySelector("#provincia_form"));

	        			 var url="?option=com_provincia&task=provincia_add" 
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
                                       showInsert_provincia();           
	            			}
	        			});
					}   else {              
	$.smallBox({         
		title: Error,   
		content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
		color:" #9162E",
		timeout: 4000                                                          
	})                                                                          
}                                                                              
	    });

    $('#cancelbtn_provincia').click(function(){
        $('#provincia_form')[0].reset();
		Provincia.gridDataSource.read();
        wnd_provincia.close();
    });

    $('#addbutton_provincia').click(function(){
        showInsert_provincia();
    });
    $('#deletebutton_provincia').click(function(){
        var checkbox_checked=$('#gridselection_provincia .check_row:checked');

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
                      var dataItem=Provincia.finditem($(this).attr('id'));
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
                        url:"?option=com_provincia&task=provincia_delete_one",
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
                            Provincia.gridDataSource.read();
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
