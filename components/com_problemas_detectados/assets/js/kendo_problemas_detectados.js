/** * Created by Ernesto on .
 *Date:1/6/2016  
 *Time:13:21 */
//Creando variables globales
	var validator;
	var Problemas_detectados={};
	var message=""


	//Creando los windows Dialogs
	wnd_problemas_detectados = $("#problemas_detectados_window").kendoWindow({
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
        				if(Problemas_detectados.oldElement!=null) {
							
				    			$('#problema').val(Problemas_detectados.oldElement.problema);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Problemas_detectados.oldElement=null;
	Problemas_detectados.change = function onChange(arg) {
};
	Problemas_detectados.change = function onDataBinding(arg) {
};
	Problemas_detectados.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Problemas_detectados.kgrid=this;
		}
	Problemas_detectados.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Problemas_detectados.gridDataSource._data,function(val,index){
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
               dataURI: Problemas_detectados.gridDataSource,                                                    
               fileName: "problemas_detectados.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_problemas_detectados() {
					Problemas_detectados.oldElement=null;
					validator_problemas_detectados.hideMessages();
		    		$('#problemas_detectados_form')[0].reset();
		    		$('#taskproblemas_detectados').val('insert');
                   $('#accionbtn_problemas_detectadossave_exit').text('Guardar y Salir');         
		    		wnd_problemas_detectados.title("Insertar Problemas Detectados");
                   $('#accionbtnproblemas_detectados_save_new').show();
		    		wnd_problemas_detectados.center().open();
				}

//Mostrar Ventanas
				function showUpdate_problemas_detectados(e) {
					validator_problemas_detectados.hideMessages();
				    $('#problemas_detectados_form')[0].reset();
				    var dataItem=Problemas_detectados.finditem(e.id);
				    Problemas_detectados.oldElement= dataItem;
				    $('#taskproblemas_detectados').val('update');
				    wnd_problemas_detectados.title("Actualizar Problemas Detectados");
                   $('#accionbtn_problemas_detectadossave_exit').text('Actualizar');                   
                   $('#accionbtn_problemas_detectadossave_new').hide();                                 
				    wnd_problemas_detectados.center().open();
				}

//Eliminar elemento
function delete_element_problemas_detectados(e)
{
    var dataItem=Problemas_detectados.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Problemas_detectados?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_problemas_detectados&task=problemas_detectados_delete_one",
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
                    Problemas_detectados.gridDataSource.read();
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
	validator_problemas_detectados=$("#problemas_detectados_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Problemas_detectados.oldElement==null)
                    		{
								if(input.is("[id=problema]")) {
									value=$('#problema').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El problema  ingresado no debe exceder los 25 caracteres";
										return $('#problema').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.problema==value)
										{
											found=true;
											message="Ya existe esa problema";
											i=Entidad.gridDataSource._data.length;
											return $('#problema').val('');
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
	Problemas_detectados.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_problemas_detectados&task=problemas_detectados_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_problema_detectado:{type:"number"},
						problema:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_problemas_detectados").kendoGrid({
	        dataSource: Problemas_detectados.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
			 groupable:true,
	        sortable: true,
	        change: Problemas_detectados.change,
			resizable: true,
	        dataBound: Problemas_detectados.dataBound,
	        dataBinding: Problemas_detectados.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_problemas_detectados' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_problema_detectado",
					template:'<div id="item" data-text="#: id_problema_detectado#">#: id_problema_detectado#</div>',
	                title: "Id",
	                width: '10%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "problema",
					template:'<div id="item" data-text="#: problema#">#: problema#</div>',
	                title: "Problema",
	                width: '75%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_problemas_detectados(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_problemas_detectados(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_problemas_detectados').click(function () {
        var c = this.checked;
        $('#gridselection_problemas_detectados :checkbox').prop('checked',c);
    });
    $('#accionbtn_problemas_detectadossave_exit').click(function()
			    {
					if (validator_problemas_detectados.validate())
                    {

                      var fd = new FormData(document.querySelector("#problemas_detectados_form"));                                                                                                                                     
                      var  url="?option=com_problemas_detectados&task=problemas_detectados_add"; 
	        			if($('#taskproblemas_detectados').val()=="update")
							{
                       var olditem=JSON.stringify(Problemas_detectados.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_problemas_detectados&task=problemas_detectados_update";
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
	                					Problemas_detectados.gridDataSource.read();
                                       $('#problemas_detectados_form')[0].reset();
            	                					wnd_problemas_detectados.close();
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
    $('#accionbtn_problemas_detectadossave_new').click(function()
			    {
					if (validator_problemas_detectados.validate())
                    {

                       var fd = new FormData(document.querySelector("#problemas_detectados_form")); 
	        			 var url="?option=com_problemas_detectados&task=problemas_detectados_add"; 
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
                                       showInsert_problemas_detectados();           
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

    $('#cancelbtn_problemas_detectados').click(function(){
        $('#problemas_detectados_form')[0].reset();
           Problemas_detectados.gridDataSource.read();                       
        wnd_problemas_detectados.close();
    });

    $('#addbutton_problemas_detectados').click(function(){
        showInsert_problemas_detectados();
    });
    $('#deletebutton_problemas_detectados').click(function(){
        var checkbox_checked=$('#gridselection_problemas_detectados .check_row:checked');

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
                      var dataItem=Problemas_detectados.finditem($(this).attr('id'));
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
                        url:"?option=com_problemas_detectados&task=problemas_detectados_delete_one", 
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
                            Problemas_detectados.gridDataSource.read();
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
