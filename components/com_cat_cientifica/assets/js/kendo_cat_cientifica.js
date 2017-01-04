/** * Created by Ernesto on .
 *Date:12/15/2015  
 *Time:14:23 */
//Creando variables globales
	var validator;
	var Cat_cientifica={};
	var message=""


	//Creando los windows Dialogs
	wnd_cat_cientifica = $("#cat_cientifica_window").kendoWindow({
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
        				if(Cat_cientifica.oldElement!=null) {
							
				    			$('#categoria').val(Cat_cientifica.oldElement.categoria);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Cat_cientifica.oldElement=null;
	Cat_cientifica.change = function onChange(arg) {
};
	Cat_cientifica.change = function onDataBinding(arg) {
};
	Cat_cientifica.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Cat_cientifica.kgrid=this;
		}
	Cat_cientifica.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Cat_cientifica.gridDataSource._data,function(val,index){
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
               dataURI:   Prioridad.gridDataSource,                                                    
               fileName: "cat_cientifica.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_cat_cientifica() {
					Cat_cientifica.oldElement=null;
					validator_cat_cientifica.hideMessages();
		    		$('#cat_cientifica_form')[0].reset();
		    		$('#taskcat_cientifica').val('insert');
                   $('#accionbtn_cat_cientificasave_exit').text('Guardar y Salir');         
		    		wnd_cat_cientifica.title("Insertar Categoria Científica");
                   $('#accionbtncat_cientifica_save_new').show();
		    		wnd_cat_cientifica.center().open();
				}

//Mostrar Ventanas
				function showUpdate_cat_cientifica(e) {
					validator_cat_cientifica.hideMessages();
				    $('#cat_cientifica_form')[0].reset();
				    var dataItem=Cat_cientifica.finditem(e.id);
				    Cat_cientifica.oldElement= dataItem;
				    $('#taskcat_cientifica').val('update');
				    wnd_cat_cientifica.title("Actualizar Cat_cientifica");
                   $('#accionbtn_cat_cientificasave_exit').text('Actualizar');                   
                   $('#accionbtn_cat_cientificasave_new').hide();                                 
				    wnd_cat_cientifica.center().open();
				}

//Eliminar elemento
function delete_element_cat_cientifica(e)
{
    var dataItem=Cat_cientifica.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Cat_cientifica?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_cat_cientifica&task=cat_cientifica_delete_one",
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
                    Cat_cientifica.gridDataSource.read();
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
	validator_cat_cientifica=$("#cat_cientifica_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Cat_cientifica.oldElement==null)
                    		{
								if(input.is("[id=categoria]")) {
									value=$('#categoria').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El categoria  ingresada no debe exceder los 25 caracteres";
										return $('#grado').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.categoria==value)
										{
											found=true;
											message="Ya existe esa categoria";
											i=Entidad.gridDataSource._data.length;
											return $('#categoria').val('');
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
	Cat_cientifica.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_cat_cientifica&task=cat_cientifica_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_categoria:{type:"number"},
						categoria:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_cat_cientifica").kendoGrid({
	        dataSource: Cat_cientifica.gridDataSource,
	        height: 500,
		 groupable:true,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
	        sortable: true,
	        change: Cat_cientifica.change,
			resizable: true,
	        dataBound: Cat_cientifica.dataBound,
	        dataBinding: Cat_cientifica.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_cat_cientifica' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_categoria",
					template:'<div id="item" data-text="#: id_categoria#">#: id_categoria#</div>',
	                title: "Id",
	                width: '8%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "categoria",
					template:'<div id="item" data-text="#: categoria#">#: categoria#</div>',
	                title: "Categoría",
	                width: '80%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_cat_cientifica(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_cat_cientifica(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_cat_cientifica').click(function () {
        var c = this.checked;
        $('#gridselection_cat_cientifica :checkbox').prop('checked',c);
    });
    $('#accionbtn_cat_cientificasave_exit').click(function()
			    {
					if (validator_cat_cientifica.validate())
                    {

                      var fd = new FormData(document.querySelector("#cat_cientifica_form"));                                                                                                                                     
                      var  url="?option=com_cat_cientifica&task=cat_cientifica_add"; 
	        			if($('#taskcat_cientifica').val()=="update")
							{
                       var olditem=JSON.stringify(Cat_cientifica.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_cat_cientifica&task=cat_cientifica_update";
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
	                					Cat_cientifica.gridDataSource.read();
                                       $('#cat_cientifica_form')[0].reset();
            	                					wnd_cat_cientifica.close();
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
    $('#accionbtn_cat_cientificasave_new').click(function()
			    {
					if (validator_cat_cientifica.validate())
                    {

                       var fd = new FormData(document.querySelector("#cat_cientifica_form")); 
	        			 var url="?option=com_cat_cientifica&task=cat_cientifica_add"; 
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
                                       showInsert_cat_cientifica();           
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

    $('#cancelbtn_cat_cientifica').click(function(){
        $('#cat_cientifica_form')[0].reset();
           Cat_cientifica.gridDataSource.read();                       
        wnd_cat_cientifica.close();
    });

    $('#addbutton_cat_cientifica').click(function(){
        showInsert_cat_cientifica();
    });
    $('#deletebutton_cat_cientifica').click(function(){
        var checkbox_checked=$('#gridselection_cat_cientifica .check_row:checked');

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
                      var dataItem=Cat_cientifica.finditem($(this).attr('id'));
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
                        url:"?option=com_cat_cientifica&task=cat_cientifica_delete_one", 
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
                            Cat_cientifica.gridDataSource.read();
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
