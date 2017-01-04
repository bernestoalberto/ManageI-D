/** * Created by Ernesto on .
 *Date:12/27/2015  
 *Time:0:49 */
//Creando variables globales
	var validator;
	var Forma_entrega={};
	var message=""


	//Creando los windows Dialogs
	wnd_forma_entrega = $("#forma_entrega_window").kendoWindow({
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
        				if(Forma_entrega.oldElement!=null) {
							
				    			$('#informe').val(Forma_entrega.oldElement.informe);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Forma_entrega.oldElement=null;
	Forma_entrega.change = function onChange(arg) {
};
	Forma_entrega.change = function onDataBinding(arg) {
};
	Forma_entrega.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Forma_entrega.kgrid=this;
		}
	Forma_entrega.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Forma_entrega.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}





				function showInsert_forma_entrega() {
					Forma_entrega.oldElement=null;
					validator_forma_entrega.hideMessages();
		    		$('#forma_entrega_form')[0].reset();
		    		$('#taskforma_entrega').val('insert');
                   $('#accionbtn_forma_entregasave_exit').text('Guardar y Salir');         
		    		wnd_forma_entrega.title("Insertar Forma_entrega");
                   $('#accionbtnforma_entrega_save_new').show();
		    		wnd_forma_entrega.center().open();
				}

//Mostrar Ventanas
				function showUpdate_forma_entrega(e) {
					validator_forma_entrega.hideMessages();
				    $('#forma_entrega_form')[0].reset();
				    var dataItem=Forma_entrega.finditem(e.id);
				    Forma_entrega.oldElement= dataItem;
				    $('#taskforma_entrega').val('update');
				    wnd_forma_entrega.title("Actualizar Forma_entrega");
                   $('#accionbtn_forma_entregasave_exit').text('Actualizar');                   
                   $('#accionbtn_forma_entregasave_new').hide();                                 
				    wnd_forma_entrega.center().open();
				}

//Eliminar elemento
function delete_element_forma_entrega(e)
{
    var dataItem=Forma_entrega.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Forma_entrega?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_forma_entrega&task=forma_entrega_delete_one",
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
                    Forma_entrega.gridDataSource.read();
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
	validator_forma_entrega=$("#forma_entrega_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Forma_entrega.oldElement==null)
                    		{
								if(input.is("[id=informe]")) {
									value=$('#informe').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El informe  ingresado no debe exceder los 25 caracteres";
										return $('#informe').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.informe==value)
										{
											found=true;
											message="Ya existe ese informe";
											i=Entidad.gridDataSource._data.length;
											return $('#informe').val('');
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
	Forma_entrega.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_forma_entrega&task=forma_entrega_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_forma_entrega:{type:"number"},
						informe:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_forma_entrega").kendoGrid({
	        dataSource: Forma_entrega.gridDataSource,
	        height: 500,
		 filterable: {
			 mode: "row"
		 },
		 groupable:true,
	        sortable: true,
	        change: Forma_entrega.change,
			resizable: true,
	        dataBound: Forma_entrega.dataBound,
	        dataBinding: Forma_entrega.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_forma_entrega' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_forma_entrega",
					template:'<div id="item" data-text="#: id_forma_entrega#">#: id_forma_entrega#</div>',
	                title: "ID",
	                width: '8%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "informe",
					template:'<div id="item" data-text="#: informe#">#: informe#</div>',
	                title: "Forma Entrega",
	                width: '75%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_forma_entrega(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_forma_entrega(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_forma_entrega').click(function () {
        var c = this.checked;
        $('#gridselection_forma_entrega :checkbox').prop('checked',c);
    });
    $('#accionbtn_forma_entregasave_exit').click(function()
			    {
					if (validator_forma_entrega.validate())
                    {

                      var fd = new FormData(document.querySelector("#forma_entrega_form"));                                                                                                                                     
                      var  url="?option=com_forma_entrega&task=forma_entrega_add"; 
	        			if($('#taskforma_entrega').val()=="update")
							{
                       var olditem=JSON.stringify(Forma_entrega.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_forma_entrega&task=forma_entrega_update";
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
	                					Forma_entrega.gridDataSource.read();
                                       $('#forma_entrega_form')[0].reset();
            	                					wnd_forma_entrega.close();
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
    $('#accionbtn_forma_entregasave_new').click(function()
			    {
					if (validator_forma_entrega.validate())
                    {

                       var fd = new FormData(document.querySelector("#forma_entrega_form")); 
	        			 var url="?option=com_forma_entrega&task=forma_entrega_add"; 
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
                                       showInsert_forma_entrega();           
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

    $('#cancelbtn_forma_entrega').click(function(){
        $('#forma_entrega_form')[0].reset();
           Forma_entrega.gridDataSource.read();                       
        wnd_forma_entrega.close();
    });

    $('#addbutton_forma_entrega').click(function(){
        showInsert_forma_entrega();
    });
    $('#deletebutton_forma_entrega').click(function(){
        var checkbox_checked=$('#gridselection_forma_entrega .check_row:checked');

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
                      var dataItem=Forma_entrega.finditem($(this).attr('id'));
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
                        url:"?option=com_forma_entrega&task=forma_entrega_delete_one", 
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
                            Forma_entrega.gridDataSource.read();
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
