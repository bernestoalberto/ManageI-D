/** * Created by Ernesto on .
 *Date:1/4/2016  
 *Time:0:3 */
//Creando variables globales
	var validator;
	var Estado_ejecucion_proyecto={};
	var message=""


	//Creando los windows Dialogs
	wnd_estado_ejecucion_proyecto = $("#estado_ejecucion_proyecto_window").kendoWindow({
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
        				if(Estado_ejecucion_proyecto.oldElement!=null) {
							
				    			$('#nombre_estado_ejecucion_proyecto').val(Estado_ejecucion_proyecto.oldElement.nombre_estado_ejecucion_proyecto);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Estado_ejecucion_proyecto.oldElement=null;
	Estado_ejecucion_proyecto.change = function onChange(arg) {
};
	Estado_ejecucion_proyecto.change = function onDataBinding(arg) {
};
	Estado_ejecucion_proyecto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Estado_ejecucion_proyecto.kgrid=this;
		}
	Estado_ejecucion_proyecto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Estado_ejecucion_proyecto.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



		$("#export_pdf").click(function() {              
    kendo.drawing.drawDOM($("#wrapperc"))                            
        .then(function(group) {                                                   
            return kendo.drawing.exportPDF(group, {                                
               paperSize: "auto",                                                    
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }         
           });                                                                                      
       })                                                                                         
       .done(function() {                                                                            
           kendo.saveAs({                                                                             
               dataURI: Estado_ejecucion_proyecto.gridDataSource,                                                    
               fileName: "estado_ejecucion_proyecto.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_estado_ejecucion_proyecto() {
					Estado_ejecucion_proyecto.oldElement=null;
					validator_estado_ejecucion_proyecto.hideMessages();
		    		$('#estado_ejecucion_proyecto_form')[0].reset();
		    		$('#taskestado_ejecucion_proyecto').val('insert');
                   $('#accionbtn_estado_ejecucion_proyectosave_exit').text('Guardar y Salir');         
		    		wnd_estado_ejecucion_proyecto.title("Insertar Estado Ejecución Proyecto");
                   $('#accionbtnestado_ejecucion_proyecto_save_new').show();
		    		wnd_estado_ejecucion_proyecto.center().open();
				}

//Mostrar Ventanas
				function showUpdate_estado_ejecucion_proyecto(e) {
					validator_estado_ejecucion_proyecto.hideMessages();
				    $('#estado_ejecucion_proyecto_form')[0].reset();
				    var dataItem=Estado_ejecucion_proyecto.finditem(e.id);
				    Estado_ejecucion_proyecto.oldElement= dataItem;
				    $('#taskestado_ejecucion_proyecto').val('update');
				    wnd_estado_ejecucion_proyecto.title("Actualizar Estado Ejecución Proyecto");
                   $('#accionbtn_estado_ejecucion_proyectosave_exit').text('Actualizar');                   
                   $('#accionbtn_estado_ejecucion_proyectosave_new').hide();                                 
				    wnd_estado_ejecucion_proyecto.center().open();
				}

//Eliminar elemento
function delete_element_estado_ejecucion_proyecto(e)
{
    var dataItem=Estado_ejecucion_proyecto.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Estado_ejecucion_proyecto?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_estado_ejecucion_proyecto&task=estado_ejecucion_proyecto_delete_one",
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
                    Estado_ejecucion_proyecto.gridDataSource.read();
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
	validator_estado_ejecucion_proyecto=$("#estado_ejecucion_proyecto_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Estado_ejecucion_proyecto.oldElement==null)
                    		{
								if(input.is("[id=nombre_estado_ejecucion_proyecto]")) {
									value=$('#nombre_estado_ejecucion_proyecto').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El nombre_estado_ejecucion_proyecto  ingresado no debe exceder los 25 caracteres";
										return $('#nombre_estado_ejecucion_proyecto').val('');
									}

									while (i < Estado_ejecucion_proyecto.gridDataSource._data.length) {
										var elem=Estado_ejecucion_proyecto.gridDataSource._data[i];
										if(elem.nombre_estado_ejecucion_proyecto==value)
										{
											found=true;
											message="El año ingresado ya existe";
											i=Estado_ejecucion_proyecto.gridDataSource._data.length;
											return $('#nombre_estado_ejecucion_proyecto').val('');
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
	Estado_ejecucion_proyecto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_estado_ejecucion_proyecto&task=estado_ejecucion_proyecto_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_estado_ejecucion_proyecto:{type:"number"},
						nombre_estado_ejecucion_proyecto:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	$("#gridselection_estado_ejecucion_proyecto").kendoGrid({
	        dataSource: Estado_ejecucion_proyecto.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
			 groupable:true,
	        sortable: true,
	        change: Estado_ejecucion_proyecto.change,
			resizable: true,
	        dataBound: Estado_ejecucion_proyecto.dataBound,
	        dataBinding: Estado_ejecucion_proyecto.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_estado_ejecucion_proyecto' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_estado_ejecucion_proyecto",
					template:'<div id="item" data-text="#: id_estado_ejecucion_proyecto#">#: id_estado_ejecucion_proyecto#</div>',
	                title: "Id",
	                width: '10%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "nombre_estado_ejecucion_proyecto",
					template:'<div id="item" data-text="#: nombre_estado_ejecucion_proyecto#">#: nombre_estado_ejecucion_proyecto#</div>',
	                title: "Estado Ejecución",
	                width: '80%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_estado_ejecucion_proyecto(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_estado_ejecucion_proyecto(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_estado_ejecucion_proyecto').click(function () {
        var c = this.checked;
        $('#gridselection_estado_ejecucion_proyecto :checkbox').prop('checked',c);
    });
    $('#accionbtn_estado_ejecucion_proyectosave_exit').click(function()
			    {
					if (validator_estado_ejecucion_proyecto.validate())
                    {

                      var fd = new FormData(document.querySelector("#estado_ejecucion_proyecto_form"));                                                                                                                                     
                      var  url="?option=com_estado_ejecucion_proyecto&task=estado_ejecucion_proyecto_add"; 
	        			if($('#taskestado_ejecucion_proyecto').val()=="update")
							{
                       var olditem=JSON.stringify(Estado_ejecucion_proyecto.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				       var  url="?option=com_estado_ejecucion_proyecto&task=estado_ejecucion_proyecto_update";
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
	                					Estado_ejecucion_proyecto.gridDataSource.read();
                                       $('#estado_ejecucion_proyecto_form')[0].reset();
            	                					wnd_estado_ejecucion_proyecto.close();
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
    $('#accionbtn_estado_ejecucion_proyectosave_new').click(function()
			    {
					if (validator_estado_ejecucion_proyecto.validate())
                    {

                       var fd = new FormData(document.querySelector("#estado_ejecucion_proyecto_form")); 
	        			 var url="?option=com_estado_ejecucion_proyecto&task=estado_ejecucion_proyecto_add"; 
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
                                       showInsert_estado_ejecucion_proyecto();           
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

    $('#cancelbtn_estado_ejecucion_proyecto').click(function(){
        $('#estado_ejecucion_proyecto_form')[0].reset();
           Estado_ejecucion_proyecto.gridDataSource.read();                       
        wnd_estado_ejecucion_proyecto.close();
    });

    $('#addbutton_estado_ejecucion_proyecto').click(function(){
        showInsert_estado_ejecucion_proyecto();
    });
    $('#deletebutton_estado_ejecucion_proyecto').click(function(){
        var checkbox_checked=$('#gridselection_estado_ejecucion_proyecto .check_row:checked');

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
                      var dataItem=Estado_ejecucion_proyecto.finditem($(this).attr('id'));
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
                        url:"?option=com_estado_ejecucion_proyecto&task=estado_ejecucion_proyecto_delete_one", 
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
                            Estado_ejecucion_proyecto.gridDataSource.read();
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
