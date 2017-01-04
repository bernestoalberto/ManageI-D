/** * Created by Ernesto on .
 *Date:12/28/2015  
 *Time:13:27 */
//Creando variables globales
	var validator;
	var Evaluacion={};
	var message=""


	//Creando los windows Dialogs
	wnd_evaluacion = $("#evaluacion_window").kendoWindow({
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
        				if(Evaluacion.oldElement!=null) {
							
				    			$('#evaluacion').val(Evaluacion.oldElement.evaluacion);
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Evaluacion.oldElement=null;
	Evaluacion.change = function onChange(arg) {
};
	Evaluacion.change = function onDataBinding(arg) {
};
	Evaluacion.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Evaluacion.kgrid=this;
		}
	Evaluacion.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Evaluacion.gridDataSource._data,function(val,index){
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
               dataURI: Evaluacion.gridDataSource,                                                    
               fileName: "evaluacion.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_evaluacion() {
					Evaluacion.oldElement=null;
					validator_evaluacion.hideMessages();
		    		$('#evaluacion_form')[0].reset();
		    		$('#taskevaluacion').val('insert');
                   $('#accionbtn_evaluacionsave_exit').text('Guardar y Salir');         
		    		wnd_evaluacion.title("Insertar Evaluacion");
                   $('#accionbtnevaluacion_save_new').show();
		    		wnd_evaluacion.center().open();
				}

//Mostrar Ventanas
				function showUpdate_evaluacion(e) {
					validator_evaluacion.hideMessages();
				    $('#evaluacion_form')[0].reset();
				    var dataItem=Evaluacion.finditem(e.id);
				    Evaluacion.oldElement= dataItem;
				    $('#taskevaluacion').val('update');
				    wnd_evaluacion.title("Actualizar Evaluacion");
                   $('#accionbtn_evaluacionsave_exit').text('Actualizar');                   
                   $('#accionbtn_evaluacionsave_new').hide();                                 
				    wnd_evaluacion.center().open();
				}

//Eliminar elemento
function delete_element_evaluacion(e)
{
    var dataItem=Evaluacion.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Evaluacion?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_evaluacion&task=evaluacion_delete_one",
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
                    Evaluacion.gridDataSource.read();
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
	validator_evaluacion=$("#evaluacion_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Evaluacion.oldElement==null)
                    		{
								if(input.is("[id=evaluacion]")) {
									value=$('#evaluacion').val();
									var size = value.length;
									if(size > 25){
										found=true;
										message="El evaluacion  ingresado no debe exceder los 25 caracteres";
										return $('#evaluacion').val('');
									}

									while (i < Entidad.gridDataSource._data.length) {
										var elem=Entidad.gridDataSource._data[i];
										if(elem.evaluacion==value)
										{
											found=true;
											message="Ya existe esa evaluacion";
											i=Entidad.gridDataSource._data.length;
											return $('#evaluacion').val('');
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
	Evaluacion.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_evaluacion&task=evaluacion_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_evaluacion:{type:"number"},
						evaluacion:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_evaluacion").kendoGrid({
	        dataSource: Evaluacion.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 groupable:true,
	        sortable: true,
			 groupable:true,
	        change: Evaluacion.change,
			resizable: true,
	        dataBound: Evaluacion.dataBound,
	        dataBinding: Evaluacion.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_evaluacion' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_evaluacion",
					template:'<div id="item" data-text="#: id_evaluacion#">#: id_evaluacion#</div>',
	                title: "Id",
	                width: '10%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "evaluacion",
					template:'<div id="item" data-text="#: evaluacion#">#: evaluacion#</div>',
	                title: "Evaluación",
	                width: '75%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_evaluacion(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_evaluacion(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_evaluacion').click(function () {
        var c = this.checked;
        $('#gridselection_evaluacion :checkbox').prop('checked',c);
    });
    $('#accionbtn_evaluacionsave_exit').click(function()
			    {
					if (validator_evaluacion.validate())
                    {

                      var fd = new FormData(document.querySelector("#evaluacion_form"));                                                                                                                                     
                      var  url="?option=com_evaluacion&task=evaluacion_add"; 
	        			if($('#taskevaluacion').val()=="update")
							{
                       var olditem=JSON.stringify(Evaluacion.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_evaluacion&task=evaluacion_update";
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
	                					Evaluacion.gridDataSource.read();
                                       $('#evaluacion_form')[0].reset();
            	                					wnd_evaluacion.close();
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
    $('#accionbtn_evaluacionsave_new').click(function()
			    {
					if (validator_evaluacion.validate())
                    {

                       var fd = new FormData(document.querySelector("#evaluacion_form")); 
	        			 var url="?option=com_evaluacion&task=evaluacion_add"; 
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
                                       showInsert_evaluacion();           
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

    $('#cancelbtn_evaluacion').click(function(){
        $('#evaluacion_form')[0].reset();
           Evaluacion.gridDataSource.read();                       
        wnd_evaluacion.close();
    });

    $('#addbutton_evaluacion').click(function(){
        showInsert_evaluacion();
    });
    $('#deletebutton_evaluacion').click(function(){
        var checkbox_checked=$('#gridselection_evaluacion .check_row:checked');

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
                      var dataItem=Evaluacion.finditem($(this).attr('id'));
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
                        url:"?option=com_evaluacion&task=evaluacion_delete_one", 
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
                            Evaluacion.gridDataSource.read();
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
