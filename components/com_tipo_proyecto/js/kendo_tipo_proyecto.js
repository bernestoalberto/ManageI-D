/** * Created by Ernesto on .
 *Date:12/16/2015  
 *Time:11:35 */
//Creando variables globales
	var validator;
	var Tipo_proyecto={};
	var message=""


	//Creando los windows Dialogs
	wnd_tipo_proyecto = $("#tipo_proyecto_window").kendoWindow({
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
        				if(Tipo_proyecto.oldElement!=null) {
							
				    			$('#tipo').val(Tipo_proyecto.oldElement.tipo);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Tipo_proyecto.oldElement=null;
	Tipo_proyecto.change = function onChange(arg) {
};
	Tipo_proyecto.change = function onDataBinding(arg) {
};
	Tipo_proyecto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Tipo_proyecto.kgrid=this;
		}
	Tipo_proyecto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Tipo_proyecto.gridDataSource._data,function(val,index){
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
               dataURI: Tipo_proyecto.gridDataSource,                                                    
               fileName: "tipo_proyecto.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_tipo_proyecto() {
					Tipo_proyecto.oldElement=null;
					validator_tipo_proyecto.hideMessages();
		    		$('#tipo_proyecto_form')[0].reset();
		    		$('#tasktipo_proyecto').val('insert');
                   $('#accionbtn_tipo_proyectosave_exit').text('Guardar y Salir');         
		    		wnd_tipo_proyecto.title("Insertar Tipo_proyecto");
                   $('#accionbtntipo_proyecto_save_new').show();
		    		wnd_tipo_proyecto.center().open();
				}

//Mostrar Ventanas
				function showUpdate_tipo_proyecto(e) {
					validator_tipo_proyecto.hideMessages();
				    $('#tipo_proyecto_form')[0].reset();
				    var dataItem=Tipo_proyecto.finditem(e.id);
				    Tipo_proyecto.oldElement= dataItem;
				    $('#tasktipo_proyecto').val('update');
				    wnd_tipo_proyecto.title("Actualizar Tipo_proyecto");
                   $('#accionbtn_tipo_proyectosave_exit').text('Actualizar');                   
                   $('#accionbtn_tipo_proyectosave_new').hide();                                 
				    wnd_tipo_proyecto.center().open();
				}

//Eliminar elemento
function delete_element_tipo_proyecto(e)
{
    var dataItem=Tipo_proyecto.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Tipo_proyecto?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_tipo_proyecto&task=tipo_proyecto_delete_one",
                data:{
                    array:JSON.stringify(array)
                },
                success:function(response){
if(response) {                               	var message='El elemento fue eliminado con exito';
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
                    Tipo_proyecto.gridDataSource.read();
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
	validator_tipo_proyecto=$("#tipo_proyecto_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Tipo_proyecto.oldElement==null)
                    		{
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
	Tipo_proyecto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_tipo_proyecto&task=tipo_proyecto_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_tipo_proyecto:{type:"number"},
						tipo:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	var $kgridtipo_proyecto =  $("#gridselection_tipo_proyecto").kendoGrid({
	        dataSource: Tipo_proyecto.gridDataSource,
	        height: 500,
	        filterable: true,
	        sortable: true,
	        change: Tipo_proyecto.change,
			resizable: true,
	        dataBound: Tipo_proyecto.dataBound,
	        dataBinding: Tipo_proyecto.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_tipo_proyecto' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_tipo_proyecto",
					template:'<div id="item" data-text="#: id_tipo_proyecto#">#: id_tipo_proyecto#</div>',
	                title: "Numero",
	                width: '5%',
					type:"number",
	            	hidden:false
	            }
				,

	            {
	                field: "tipo",
					template:'<div id="item" data-text="#: tipo#">#: tipo#</div>',
	                title: "Tipo",
	                width: '95%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_tipo_proyecto(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_tipo_proyecto(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_tipo_proyecto').click(function () {
        var c = this.checked;
        $('#gridselection_tipo_proyecto :checkbox').prop('checked',c);
    });
    $('#accionbtn_tipo_proyectosave_exit').click(function()
			    {
					if (validator_tipo_proyecto.validate())
                    {

                      var fd = new FormData(document.querySelector("#tipo_proyecto_form"));                                                                                                                                     
                      var  url="?option=com_tipo_proyecto&task=tipo_proyecto_add"; 
	        			if($('#tasktipo_proyecto').val()=="update")
							{
                       var olditem=JSON.stringify(Tipo_proyecto.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_tipo_proyecto&task=tipo_proyecto_update";
							}
	        			$.ajax({
	        				type: "POST",
	        				url:url,
	            			data:fd,
                           cache: false,
                           processData: false,
                           contentType: false,
	                           success:function(response){
                    					if(response)
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
                                               $('#text-error').html(result.message);
                        						$.smallBox({
                            						title: '',
                            						content:$('#message-error').html(),
                            						color: "#BA0916",
                            						timeout: 6000
                        						})
                    					}
	                					Tipo_proyecto.gridDataSource.read();
                                       $('#tipo_proyecto_form')[0].reset();
            	                					wnd_tipo_proyecto.close();
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
    $('#accionbtn_tipo_proyectosave_new').click(function()
			    {
					if (validator_tipo_proyecto.validate())
                    {

                       var fd = new FormData(document.querySelector("#tipo_proyecto_form")); 
	        			 var url="?option=com_tipo_proyecto&task=tipo_proyecto_add"; 
	        			$.ajax({
	        				type: "POST",
	        				url:url,
	            			data:fd,
                           cache: false,
                           processData: false,
                           contentType: false,
	                           success:function(response){
                    					if(response)
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
                                               $('#text-error').html(result.message);
                        						$.smallBox({
                            						title: '',
                            						content:$('#message-error').html(),
                            						color: "#BA0916",
                            						timeout: 6000
                        						})
                    					}
                                       showInsert_tipo_proyecto();           
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

    $('#cancelbtn_tipo_proyecto').click(function(){
        $('#tipo_proyecto_form')[0].reset();
           Tipo_proyecto.gridDataSource.read();                       
        wnd_tipo_proyecto.close();
    });

    $('#addbutton_tipo_proyecto').click(function(){
        showInsert_tipo_proyecto();
    });
    $('#deletebutton_tipo_proyecto').click(function(){
        var checkbox_checked=$('#gridselection_tipo_proyecto .check_row:checked');

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
                      var dataItem=Tipo_proyecto.finditem($(this).attr('id'));
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
                        url:"?option=com_tipo_proyecto&task=tipo_proyecto_delete_one", 
                        data:{
                            array:JSON.stringify(array)
                        },
                        success:function(response){
if(response) {                               	var message='El elemento fue eliminado con exito';
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
                            Tipo_proyecto.gridDataSource.read();
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
