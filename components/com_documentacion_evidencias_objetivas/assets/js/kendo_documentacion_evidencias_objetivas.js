/** * Created by Ernesto on .
 *Date:1/9/2016  
 *Time:0:19 */
//Creando variables globales
	var validator;
	var Documentacion_evidencias_objetivas={};
	var message=""


	//Creando los windows Dialogs
	wnd_documentacion_evidencias_objetivas = $("#documentacion_evidencias_objetivas_window").kendoWindow({
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
        				if(Documentacion_evidencias_objetivas.oldElement!=null) {
							
				    			$('#nombre_auditor').val(Documentacion_evidencias_objetivas.oldElement.nombre_auditor);
				    			$('#nombre_auditado').val(Documentacion_evidencias_objetivas.oldElement.nombre_auditado);
				    			$('#deficiencias_evidencias').val(Documentacion_evidencias_objetivas.oldElement.deficiencias_evidencias);
				    			$('#fecha_recogida_info').val(Documentacion_evidencias_objetivas.oldElement.fecha_recogida_info);
				    			$('#documento').val(Documentacion_evidencias_objetivas.oldElement.documento);
				    			$('#id_proyecto').data("kendoDropDownList").value(Documentacion_evidencias_objetivas.oldElement.id_proyecto);
						}

						else
						{

				    			$('#id_proyecto').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Documentacion_evidencias_objetivas.oldElement=null;
		/*Data Source  Programa*/

		/*Data Source  Proyecto*/
	var proyectodatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_proyecto&task=proyecto_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Proyecto*/
		$("#id_proyecto").kendoDropDownList({
        dataTextField: "nombre_proyecto",
        dataValueField: "id_proyecto",
        dataSource: proyectodatasource,
        filter: "contains",
		 open: function(e) {
            valid = false;
        },
		 change:function(e){
        },
        select: function(e){
            valid = true;
        },
        close: function(e){
        },
        suggest: true,
        index: 3
    });
		/*Date Picker  fecha_recogida_info*/
		$("#fecha_recogida_info").kendoDatePicker({
        value: kendo.date.today(),                                      
         parseFormats: ["yyyy/MM/dd"],                     
        singleDatePicker:true,                                        
         format: 'yyyy/MM/dd',                                         
          showDropdowns:true,                                           
           readonly:true,                                                
            open:function(e){                                            
                     },                                                  
          change:function(e){                                            
                         },                                               
        close:function(e){                                                
			}
	});		
	Documentacion_evidencias_objetivas.change = function onChange(arg) {
};
	Documentacion_evidencias_objetivas.change = function onDataBinding(arg) {
};
	Documentacion_evidencias_objetivas.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Documentacion_evidencias_objetivas.kgrid=this;
		}
	Documentacion_evidencias_objetivas.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Documentacion_evidencias_objetivas.gridDataSource._data,function(val,index){
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
               dataURI: Documentacion_evidencias_objetivas.gridDataSource,                                                    
               fileName: "documentacion_evidencias_objetivas.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_documentacion_evidencias_objetivas() {
					Documentacion_evidencias_objetivas.oldElement=null;
					validator_documentacion_evidencias_objetivas.hideMessages();
		    		$('#documentacion_evidencias_objetivas_form')[0].reset();
		    		$('#taskdocumentacion_evidencias_objetivas').val('insert');
					$('#id_proyecto').data("kendoDropDownList").enable();
                   $('#accionbtn_documentacion_evidencias_objetivassave_exit').text('Guardar y Salir');         
		    		wnd_documentacion_evidencias_objetivas.title("Crear Documentación de Evidencias Objetivas");
                   $('#accionbtndocumentacion_evidencias_objetivas_save_new').show();
		    		wnd_documentacion_evidencias_objetivas.center().open();
				}

//Mostrar Ventanas
				function showUpdate_documentacion_evidencias_objetivas(e) {
					validator_documentacion_evidencias_objetivas.hideMessages();
				    $('#documentacion_evidencias_objetivas_form')[0].reset();
				    var dataItem=Documentacion_evidencias_objetivas.finditem(e.id);
				    Documentacion_evidencias_objetivas.oldElement= dataItem;
					$('#id_proyecto').data("kendoDropDownList").readonly();
				    $('#taskdocumentacion_evidencias_objetivas').val('update');
				    wnd_documentacion_evidencias_objetivas.title("Actualizar Documentación de Evidencias Objetivas");
                   $('#accionbtn_documentacion_evidencias_objetivassave_exit').text('Actualizar');                   
                   $('#accionbtn_documentacion_evidencias_objetivassave_new').hide();                                 
				    wnd_documentacion_evidencias_objetivas.center().open();
				}

//Eliminar elemento
function delete_element_documentacion_evidencias_objetivas(e)
{
    var dataItem=Documentacion_evidencias_objetivas.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Documentacion_evidencias_objetivas?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_documentacion_evidencias_objetivas&task=documentacion_evidencias_objetivas_delete_one",
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
                    Documentacion_evidencias_objetivas.gridDataSource.read();
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
	validator_documentacion_evidencias_objetivas=$("#documentacion_evidencias_objetivas_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Documentacion_evidencias_objetivas.oldElement==null)
                    		{
								if(input.is("[id=documento]")) {
									var value = $('#documento').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="El documento ingresado no debe exceder los 250 caracteres";
										return $('#documento').val('');
									}
								}
								if(input.is("[id=deficiencias_evidencias]")) {
									var value = $('#deficiencias_evidencias').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="Las deficiencias_evidencias ingresadas no debe exceder los 250 caracteres";
										return $('#deficiencias_evidencias').val('');
									}
								}
								if(input.is("[id=nombre_auditor]")) {
									var value = $('#nombre_auditor').val();
									var size = value.length;

									if(size > 30){
										found=true;
										message="El nombre_auditor ingresadas no debe exceder los 30 caracteres";
										return $('#nombre_auditor').val('');
									}
								}
								if(input.is("[id=nombre_auditado]")) {
									var value = $('#nombre_auditado').val();
									var size = value.length;

									if(size > 50){
										found=true;
										message="El nombre_auditado ingresadas no debe exceder los 30 caracteres";
										return $('#nombre_auditado').val('');
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
	Documentacion_evidencias_objetivas.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_documentacion_evidencias_objetivas&task=documentacion_evidencias_objetivas_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_documentacion_evidencias:{type:"number"},
						nombre_auditor:{type:"string"},
						nombre_auditado:{type:"string"},
						deficiencias_evidencias:{type:"string"},
						fecha_recogida_info:{type:"date"},
						documento:{type:"string"},
						id_programa:{type:"number"},
						programa:{type:"string"},
						id_proyecto:{type:"number"},
						proyecto:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_documentacion_evidencias_objetivas").kendoGrid({
	        dataSource: Documentacion_evidencias_objetivas.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 groupable:true,
		 detailTemplate: kendo.template($("#template_evidencias_objetivas").html()),
	        sortable: true,
	        change: Documentacion_evidencias_objetivas.change,
			resizable: true,
	        dataBound: Documentacion_evidencias_objetivas.dataBound,
	        dataBinding: Documentacion_evidencias_objetivas.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_documentacion_evidencias_objetivas' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_documentacion_evidencias",
					template:'<div id="item" data-text="#: id_documentacion_evidencias#">#: id_documentacion_evidencias#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "nombre_auditor",
					template:'<div id="item" data-text="#: nombre_auditor#">#: nombre_auditor#</div>',
	                title: "Auditor",
	                width: '9%',
					type:"string"
	            }
				,

	            {
	                field: "nombre_auditado",
					template:'<div id="item" data-text="#: nombre_auditado#">#: nombre_auditado#</div>',
	                title: "Auditado",
	                width: '9%',
					type:"string"
	            }
				,

	            {
	                field: "deficiencias_evidencias",
					template:'<div id="item" data-text="#: deficiencias_evidencias#">#: deficiencias_evidencias#</div>',
	                title: "Deficiencias Evidencias",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_recogida_info",
	                title: "Fecha Recogida Info",
	                width: '9%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	
	            }
				,

	            {
	                field: "documento",
					template:'<div id="item" data-text="#: documento#">#: documento#</div>',
	                title: "Documento",
	                width: '9%',
					type:"string",
					hidden:true
	            }
				,     {
	                field: "id_programa",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
	                title: "id_programa",
	                width: '5%',
					type:"number",
					hidden:true
	            }
				,     {
	                field: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
	                title: "Programa",
	                width: '9%',
					type:"string"
	            }
				,     {
	                field: "id_proyecto",
					template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
	                title: "id_proyecto",
	                width: '5%',
					type:"number",
					hidden:true
	            }
				,     {
	                field: "proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
	                title: "Proyecto",
	                width: '10%',
					type:"string"
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_documentacion_evidencias_objetivas(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_documentacion_evidencias_objetivas(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_documentacion_evidencias_objetivas').click(function () {
        var c = this.checked;
        $('#gridselection_documentacion_evidencias_objetivas :checkbox').prop('checked',c);
    });
    $('#accionbtn_documentacion_evidencias_objetivassave_exit').click(function()
			    {
					if (validator_documentacion_evidencias_objetivas.validate())
                    {

                      var fd = new FormData(document.querySelector("#documentacion_evidencias_objetivas_form"));                                                                                                                                     
                      var  url="?option=com_documentacion_evidencias_objetivas&task=documentacion_evidencias_objetivas_add"; 
	        			if($('#taskdocumentacion_evidencias_objetivas').val()=="update")
							{
                       var olditem=JSON.stringify(Documentacion_evidencias_objetivas.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_documentacion_evidencias_objetivas&task=documentacion_evidencias_objetivas_update";
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
	                					Documentacion_evidencias_objetivas.gridDataSource.read();
                                       $('#documentacion_evidencias_objetivas_form')[0].reset();
            	                					wnd_documentacion_evidencias_objetivas.close();
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
    $('#accionbtn_documentacion_evidencias_objetivassave_new').click(function()
			    {
					if (validator_documentacion_evidencias_objetivas.validate())
                    {

                       var fd = new FormData(document.querySelector("#documentacion_evidencias_objetivas_form")); 
	        			 var url="?option=com_documentacion_evidencias_objetivas&task=documentacion_evidencias_objetivas_add"; 
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
                                       showInsert_documentacion_evidencias_objetivas();           
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

    $('#cancelbtn_documentacion_evidencias_objetivas').click(function(){
        $('#documentacion_evidencias_objetivas_form')[0].reset();
           Documentacion_evidencias_objetivas.gridDataSource.read();                       
        wnd_documentacion_evidencias_objetivas.close();
    });

    $('#addbutton_documentacion_evidencias_objetivas').click(function(){
        showInsert_documentacion_evidencias_objetivas();
    });
    $('#deletebutton_documentacion_evidencias_objetivas').click(function(){
        var checkbox_checked=$('#gridselection_documentacion_evidencias_objetivas .check_row:checked');

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
                      var dataItem=Documentacion_evidencias_objetivas.finditem($(this).attr('id'));
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
                        url:"?option=com_documentacion_evidencias_objetivas&task=documentacion_evidencias_objetivas_delete_one", 
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
                            Documentacion_evidencias_objetivas.gridDataSource.read();
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
