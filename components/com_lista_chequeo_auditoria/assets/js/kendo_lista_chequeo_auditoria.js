/** * Created by Ernesto on .
 *Date:1/9/2016  
 *Time:0:19 */
//Creando variables globales
	var validator;
	var Lista_chequeo_auditoria={};
	var message=""


	//Creando los windows Dialogs
	wnd_lista_chequeo_auditoria = $("#lista_chequeo_auditoria_window").kendoWindow({
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
        				if(Lista_chequeo_auditoria.oldElement!=null) {
							
				    			$('#actividad_proceso_evaluar').val(Lista_chequeo_auditoria.oldElement.actividad_proceso_evaluar);
				    			$('#nombre_auditor').val(Lista_chequeo_auditoria.oldElement.nombre_auditor);
				    			$('#requisitos_evaluar').val(Lista_chequeo_auditoria.oldElement.requisitos_evaluar);
				    			$('#evidencia').val(Lista_chequeo_auditoria.oldElement.evidencia);
				    			$('#observaciones').val(Lista_chequeo_auditoria.oldElement.observaciones);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Lista_chequeo_auditoria.oldElement=null;
	Lista_chequeo_auditoria.change = function onChange(arg) {
};
	Lista_chequeo_auditoria.change = function onDataBinding(arg) {
};
	Lista_chequeo_auditoria.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Lista_chequeo_auditoria.kgrid=this;
		}
	Lista_chequeo_auditoria.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Lista_chequeo_auditoria.gridDataSource._data,function(val,index){
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
               dataURI: Lista_chequeo_auditoria.gridDataSource,                                                    
               fileName: "lista_chequeo_auditoria.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_lista_chequeo_auditoria() {
					Lista_chequeo_auditoria.oldElement=null;
					validator_lista_chequeo_auditoria.hideMessages();
		    		$('#lista_chequeo_auditoria_form')[0].reset();
		    		$('#tasklista_chequeo_auditoria').val('insert');
                   $('#accionbtn_lista_chequeo_auditoriasave_exit').text('Guardar y Salir');         
		    		wnd_lista_chequeo_auditoria.title("Insertar Lista_chequeo_auditoria");
                   $('#accionbtnlista_chequeo_auditoria_save_new').show();
		    		wnd_lista_chequeo_auditoria.center().open();
				}

//Mostrar Ventanas
				function showUpdate_lista_chequeo_auditoria(e) {
					validator_lista_chequeo_auditoria.hideMessages();
				    $('#lista_chequeo_auditoria_form')[0].reset();
				    var dataItem=Lista_chequeo_auditoria.finditem(e.id);
				    Lista_chequeo_auditoria.oldElement= dataItem;
				    $('#tasklista_chequeo_auditoria').val('update');
				    wnd_lista_chequeo_auditoria.title("Actualizar Lista_chequeo_auditoria");
                   $('#accionbtn_lista_chequeo_auditoriasave_exit').text('Actualizar');                   
                   $('#accionbtn_lista_chequeo_auditoriasave_new').hide();                                 
				    wnd_lista_chequeo_auditoria.center().open();
				}

//Eliminar elemento
function delete_element_lista_chequeo_auditoria(e)
{
    var dataItem=Lista_chequeo_auditoria.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Lista_chequeo_auditoria?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_lista_chequeo_auditoria&task=lista_chequeo_auditoria_delete_one",
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
                    Lista_chequeo_auditoria.gridDataSource.read();
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
	validator_lista_chequeo_auditoria=$("#lista_chequeo_auditoria_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Lista_chequeo_auditoria.oldElement==null)
                    		{
								if(input.is("[id=actividad_proceso_evaluar]")) {
									var value = $('#actividad_proceso_evaluar').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="La actividad_proceso_evaluar ingresado no debe exceder los 250 caracteres";
										return $('#actividad_proceso_evaluar').val('');
									}
								}
								if(input.is("[id=nombre_auditor]")) {
									var value = $('#nombre_auditor').val();
									var size = value.length;

									if(size > 35){
										found=true;
										message="EL nombre_auditor ingresado no debe exceder los 35 caracteres";
										return $('#nombre_auditor').val('');
									}
								}
								if(input.is("[id=requisitos_evaluar]")) {
									var value = $('#requisitos_evaluar').val();
									var size = value.length;

									if(size > 35){
										found=true;
										message="Los requisitos_evaluar ingresado no debe exceder los 35 caracteres";
										return $('#requisitos_evaluar').val('');
									}
								}
								if(input.is("[id=observaciones]")) {
									var value = $('#observaciones').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="Las observaciones ingresadas no debe exceder los 250 caracteres";
										return $('#observaciones').val('');
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
	Lista_chequeo_auditoria.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_lista_chequeo_auditoria&task=lista_chequeo_auditoria_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_lista_chequeo:{type:"number"},
						actividad_proceso_evaluar:{type:"string"},
						nombre_auditor:{type:"string"},
						requisitos_evaluar:{type:"string"},
						observaciones:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
        $("#gridselection_lista_chequeo_auditoria").kendoGrid({
	        dataSource: Lista_chequeo_auditoria.gridDataSource,
	        height: 500,
			columnMenu: true,
			filterable: {
				mode: "row"
			},
			 groupable:true,
	        sortable: true,
	        change: Lista_chequeo_auditoria.change,
			resizable: true,
	        dataBound: Lista_chequeo_auditoria.dataBound,
	        dataBinding: Lista_chequeo_auditoria.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_lista_chequeo_auditoria' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_lista_chequeo",
					template:'<div id="item" data-text="#: id_lista_chequeo#">#: id_lista_chequeo#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "actividad_proceso_evaluar",
					template:'<div id="item" data-text="#: actividad_proceso_evaluar#">#: actividad_proceso_evaluar#</div>',
	                title: "Actividad Proceso Evaluar",
	                width: '15%',
					type:"string"
	            }
				,

	            {
	                field: "nombre_auditor",
					template:'<div id="item" data-text="#: nombre_auditor#">#: nombre_auditor#</div>',
	                title: "Nombre Auditor",
	                width: '15%',
					type:"string"
	            }
				,

	            {
	                field: "requisitos_evaluar",
					template:'<div id="item" data-text="#: requisitos_evaluar#">#: requisitos_evaluar#</div>',
	                title: "Requisitos Evaluar",
	                width: '15%',
					type:"string"
	            }
				,


	            {
	                field: "observaciones",
					template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
	                title: "Observaciones",
	                width: '15%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_lista_chequeo_auditoria(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_lista_chequeo_auditoria(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_lista_chequeo_auditoria').click(function () {
        var c = this.checked;
        $('#gridselection_lista_chequeo_auditoria :checkbox').prop('checked',c);
    });
    $('#accionbtn_lista_chequeo_auditoriasave_exit').click(function()
			    {
					if (validator_lista_chequeo_auditoria.validate())
                    {

                      var fd = new FormData(document.querySelector("#lista_chequeo_auditoria_form"));                                                                                                                                     
                      var  url="?option=com_lista_chequeo_auditoria&task=lista_chequeo_auditoria_add"; 
	        			if($('#tasklista_chequeo_auditoria').val()=="update")
							{
                       var olditem=JSON.stringify(Lista_chequeo_auditoria.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_lista_chequeo_auditoria&task=lista_chequeo_auditoria_update";
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
	                					Lista_chequeo_auditoria.gridDataSource.read();
                                       $('#lista_chequeo_auditoria_form')[0].reset();
            	                					wnd_lista_chequeo_auditoria.close();
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
    $('#accionbtn_lista_chequeo_auditoriasave_new').click(function()
			    {
					if (validator_lista_chequeo_auditoria.validate())
                    {

                       var fd = new FormData(document.querySelector("#lista_chequeo_auditoria_form")); 
	        			 var url="?option=com_lista_chequeo_auditoria&task=lista_chequeo_auditoria_add"; 
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
                                       showInsert_lista_chequeo_auditoria();           
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

    $('#cancelbtn_lista_chequeo_auditoria').click(function(){
        $('#lista_chequeo_auditoria_form')[0].reset();
           Lista_chequeo_auditoria.gridDataSource.read();                       
        wnd_lista_chequeo_auditoria.close();
    });

    $('#addbutton_lista_chequeo_auditoria').click(function(){
        showInsert_lista_chequeo_auditoria();
    });
    $('#deletebutton_lista_chequeo_auditoria').click(function(){
        var checkbox_checked=$('#gridselection_lista_chequeo_auditoria .check_row:checked');

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
                      var dataItem=Lista_chequeo_auditoria.finditem($(this).attr('id'));
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
                        url:"?option=com_lista_chequeo_auditoria&task=lista_chequeo_auditoria_delete_one", 
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
                            Lista_chequeo_auditoria.gridDataSource.read();
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
