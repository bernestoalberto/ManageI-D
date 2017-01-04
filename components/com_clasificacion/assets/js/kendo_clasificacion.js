/** * Created by Ernesto on .
 *Date:12/16/2015  
 *Time:11:35 */
//Creando variables globales
	var validator;
	var Clasificacion={};
	var message=""


	//Creando los windows Dialogs
	wnd_clasificacion = $("#clasificacion_window").kendoWindow({
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
        				if(Clasificacion.oldElement!=null) {
							
				    			$('#nombre_clasificacion').val(Clasificacion.oldElement.nombre_clasificacion);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Clasificacion.oldElement=null;
	Clasificacion.change = function onChange(arg) {
};
	Clasificacion.change = function onDataBinding(arg) {
};
	Clasificacion.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Clasificacion.kgrid=this;
		}
	Clasificacion.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Clasificacion.gridDataSource._data,function(val,index){
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
               dataURI: Clasificacion.gridDataSource,                                                    
               fileName: "clasificacion.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_clasificacion() {
					Clasificacion.oldElement=null;
					validator_clasificacion.hideMessages();
		    		$('#clasificacion_form')[0].reset();
		    		$('#taskclasificacion').val('insert');
                   $('#accionbtn_clasificacionsave_exit').text('Guardar y Salir');         
		    		wnd_clasificacion.title("Insertar Clasificacion");
                   $('#accionbtnclasificacion_save_new').show();
		    		wnd_clasificacion.center().open();
				}

//Mostrar Ventanas
				function showUpdate_clasificacion(e) {
					validator_clasificacion.hideMessages();
				    $('#clasificacion_form')[0].reset();
				    var dataItem=Clasificacion.finditem(e.id);
				    Clasificacion.oldElement= dataItem;
				    $('#taskclasificacion').val('update');
				    wnd_clasificacion.title("Actualizar Clasificación");
                   $('#accionbtn_clasificacionsave_exit').text('Actualizar');                   
                   $('#accionbtn_clasificacionsave_new').hide();                                 
				    wnd_clasificacion.center().open();
				}

//Eliminar elemento
function delete_element_clasificacion(e)
{
    var dataItem=Clasificacion.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Clasificacion?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_clasificacion&task=clasificacion_delete_one",
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
                    Clasificacion.gridDataSource.read();
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
	validator_clasificacion=$("#clasificacion_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Clasificacion.oldElement==null)
                    		{
								if(input.is("[id=nombre_clasificacion]")) {
									value=$('#nombre_clasificacion').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El nombre_clasificacion  ingresado no debe exceder los 25 caracteres";
										return $('#nombre_clasificacion').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.nombre_clasificacion==value)
										{
											found=true;
											message="Ya existe esa clasificacion";
											i=Entidad.gridDataSource._data.length;
											return $('#nombre_clasificacion').val('');
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
	Clasificacion.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_clasificacion&task=clasificacion_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_clasificacion:{type:"number"},
						nombre_clasificacion:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_clasificacion").kendoGrid({
	        dataSource: Clasificacion.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 groupable:true,
	        sortable: true,
	        change: Clasificacion.change,
			resizable: true,
	        dataBound: Clasificacion.dataBound,
	        dataBinding: Clasificacion.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_clasificacion' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_clasificacion",
					template:'<div id="item" data-text="#: id_clasificacion#">#: id_clasificacion#</div>',
	                title: "Id",
	                width: '8%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "nombre_clasificacion",
					template:'<div id="item" data-text="#: nombre_clasificacion#">#: nombre_clasificacion#</div>',
	                title: "Nombre Clasificación",
	                width: '80%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_clasificacion(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_clasificacion(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_clasificacion').click(function () {
        var c = this.checked;
        $('#gridselection_clasificacion :checkbox').prop('checked',c);
    });
    $('#accionbtn_clasificacionsave_exit').click(function()
			    {
					if (validator_clasificacion.validate())
                    {

                      var fd = new FormData(document.querySelector("#clasificacion_form"));                                                                                                                                     
                      var  url="?option=com_clasificacion&task=clasificacion_add"; 
	        			if($('#taskclasificacion').val()=="update")
							{
                       var olditem=JSON.stringify(Clasificacion.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_clasificacion&task=clasificacion_update";
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
	                					Clasificacion.gridDataSource.read();
                                       $('#clasificacion_form')[0].reset();
            	                					wnd_clasificacion.close();
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
    $('#accionbtn_clasificacionsave_new').click(function()
			    {
					if (validator_clasificacion.validate())
                    {

                       var fd = new FormData(document.querySelector("#clasificacion_form")); 
	        			 var url="?option=com_clasificacion&task=clasificacion_add"; 
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
                                       showInsert_clasificacion();           
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

    $('#cancelbtn_clasificacion').click(function(){
        $('#clasificacion_form')[0].reset();
           Clasificacion.gridDataSource.read();                       
        wnd_clasificacion.close();
    });

    $('#addbutton_clasificacion').click(function(){
        showInsert_clasificacion();
    });
    $('#deletebutton_clasificacion').click(function(){
        var checkbox_checked=$('#gridselection_clasificacion .check_row:checked');

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
                      var dataItem=Clasificacion.finditem($(this).attr('id'));
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
                        url:"?option=com_clasificacion&task=clasificacion_delete_one", 
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
                            Clasificacion.gridDataSource.read();
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
