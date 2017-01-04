/** * Created by Ernesto on .
 *Date:12/15/2015  
 *Time:14:23 */
//Creando variables globales
	var validator;
	var Grado_cientifico={};
	var message=""


	//Creando los windows Dialogs
	wnd_grado_cientifico = $("#grado_cientifico_window").kendoWindow({
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
        				if(Grado_cientifico.oldElement!=null) {
							
				    			$('#grado').val(Grado_cientifico.oldElement.grado);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Grado_cientifico.oldElement=null;
	Grado_cientifico.change = function onChange(arg) {
};
	Grado_cientifico.change = function onDataBinding(arg) {
};
	Grado_cientifico.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Grado_cientifico.kgrid=this;
		}
	Grado_cientifico.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Grado_cientifico.gridDataSource._data,function(val,index){
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
               fileName: "grado_cientifico.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_grado_cientifico() {
					Grado_cientifico.oldElement=null;
					validator_grado_cientifico.hideMessages();
		    		$('#grado_cientifico_form')[0].reset();
		    		$('#taskgrado_cientifico').val('insert');
                   $('#accionbtn_grado_cientificosave_exit').text('Guardar y Salir');         
		    		wnd_grado_cientifico.title("Insertar Grado_cientifico");
                   $('#accionbtn_grado_cientificosave_new').show();
		    		wnd_grado_cientifico.center().open();
				}

//Mostrar Ventanas
				function showUpdate_grado_cientifico(e) {
					validator_grado_cientifico.hideMessages();
				    $('#grado_cientifico_form')[0].reset();
				    var dataItem=Grado_cientifico.finditem(e.id);
				    Grado_cientifico.oldElement= dataItem;
				    $('#taskgrado_cientifico').val('update');
				    wnd_grado_cientifico.title("Actualizar Grado_cientifico");
                   $('#accionbtn_grado_cientificosave_exit').text('Actualizar');                   
                   $('#accionbtn_grado_cientificosave_new').hide();                                 
				    wnd_grado_cientifico.center().open();
				}

//Eliminar elemento
function delete_element_grado_cientifico(e)
{
    var dataItem=Grado_cientifico.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Grado_cientifico?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_grado_cientifico&task=grado_cientifico_delete_one",
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
                    Grado_cientifico.gridDataSource.read();
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
	validator_grado_cientifico=$("#grado_cientifico_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Grado_cientifico.oldElement==null)
                    		{
								if(input.is("[id=grado]")) {
									value=$('#grado').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El grado  ingresada no debe exceder los 25 caracteres";
										return $('#grado').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.grado==value)
										{
											found=true;
											message="Ya existe una grado";
											i=Entidad.gridDataSource._data.length;
											return $('#grado').val('');
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
	Grado_cientifico.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_grado_cientifico&task=grado_cientifico_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_grado:{type:"number"},
						grado:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_grado_cientifico").kendoGrid({
	        dataSource: Grado_cientifico.gridDataSource,
	        height: 500,
		 columnMenu: true,
			 groupable:true,
		 filterable: {
			 mode: "row"
		 },
	        sortable: true,
	        change: Grado_cientifico.change,
			resizable: true,
	        dataBound: Grado_cientifico.dataBound,
	        dataBinding: Grado_cientifico.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_grado_cientifico' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_grado",
					template:'<div id="item" data-text="#: id_grado#">#: id_grado#</div>',
	                title: "Id",
	                width: '10%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "grado",
					template:'<div id="item" data-text="#: grado#">#: grado#</div>',
	                title: "Grado",
	                width: '80%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_grado_cientifico(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_grado_cientifico(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_grado_cientifico').click(function () {
        var c = this.checked;
        $('#gridselection_grado_cientifico :checkbox').prop('checked',c);
    });
    $('#accionbtn_grado_cientificosave_exit').click(function()
			    {
					if (validator_grado_cientifico.validate())
                    {

                      var fd = new FormData(document.querySelector("#grado_cientifico_form"));                                                                                                                                     
                      var  url="?option=com_grado_cientifico&task=grado_cientifico_add"; 
	        			if($('#taskgrado_cientifico').val()=="update")
							{
                       var olditem=JSON.stringify(Grado_cientifico.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_grado_cientifico&task=grado_cientifico_update";
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
	                					Grado_cientifico.gridDataSource.read();
                                       $('#grado_cientifico_form')[0].reset();
            	                					wnd_grado_cientifico.close();
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
    $('#accionbtn_grado_cientificosave_new').click(function()
			    {
					if (validator_grado_cientifico.validate())
                    {

                       var fd = new FormData(document.querySelector("#grado_cientifico_form")); 
	        			 var url="?option=com_grado_cientifico&task=grado_cientifico_add"; 
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
                                       showInsert_grado_cientifico();           
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

    $('#cancelbtn_grado_cientifico').click(function(){
        $('#grado_cientifico_form')[0].reset();
           Grado_cientifico.gridDataSource.read();                       
        wnd_grado_cientifico.close();
    });

    $('#addbutton_grado_cientifico').click(function(){
        showInsert_grado_cientifico();
    });
    $('#deletebutton_grado_cientifico').click(function(){
        var checkbox_checked=$('#gridselection_grado_cientifico .check_row:checked');

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
                      var dataItem=Grado_cientifico.finditem($(this).attr('id'));
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
                        url:"?option=com_grado_cientifico&task=grado_cientifico_delete_one", 
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
                            Grado_cientifico.gridDataSource.read();
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
