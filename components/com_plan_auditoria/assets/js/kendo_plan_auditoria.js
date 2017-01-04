/** * Created by Ernesto on .
 *Date:1/9/2016  
 *Time:0:19 */
//Creando variables globales
	var validator;
	var Plan_auditoria={};
	var message=""


	//Creando los windows Dialogs
	wnd_plan_auditoria = $("#plan_auditoria_window").kendoWindow({
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
        				if(Plan_auditoria.oldElement!=null) {
							
				    			$('#objetivos_alcance').val(Plan_auditoria.oldElement.objetivos_alcance);
				    			$('#fecha_plan').val(Plan_auditoria.oldElement.fecha_plan);
				    			$('#director_entidad').val(Plan_auditoria.oldElement.director_entidad);
				    			$('#equipo_auditor').val(Plan_auditoria.oldElement.equipo_auditor);
				    			$('#fecha_cumplimiento').val(Plan_auditoria.oldElement.fecha_cumplimiento);
				    			$('#id_proyecto').data("kendoDropDownList").value(Plan_auditoria.oldElement.id_proyecto);
						}

						else
						{

				    			$('#id_proyecto').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Plan_auditoria.oldElement=null;


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
		/*Date Picker  fecha_plan*/
		$("#fecha_plan").kendoDatePicker({
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
		/*Date Picker  fecha_cumplimiento*/
		$("#fecha_cumplimiento").kendoDatePicker({
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
	Plan_auditoria.change = function onChange(arg) {
};
	Plan_auditoria.change = function onDataBinding(arg) {
};
	Plan_auditoria.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Plan_auditoria.kgrid=this;
		}
	Plan_auditoria.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Plan_auditoria.gridDataSource._data,function(val,index){
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
               dataURI: Plan_auditoria.gridDataSource,                                                    
               fileName: "plan_auditoria.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_plan_auditoria() {
					Plan_auditoria.oldElement=null;
					validator_plan_auditoria.hideMessages();
		    		$('#plan_auditoria_form')[0].reset();
		    		$('#taskplan_auditoria').val('insert');
					$("#id_proyecto").data('kendoDropDownList').enable();
                   $('#accionbtn_plan_auditoriasave_exit').text('Guardar y Salir');         
		    		wnd_plan_auditoria.title("Insertar Plan_auditoria");
                   $('#accionbtnplan_auditoria_save_new').show();
		    		wnd_plan_auditoria.center().open();
				}

//Mostrar Ventanas
				function showUpdate_plan_auditoria(e) {
					validator_plan_auditoria.hideMessages();
				    $('#plan_auditoria_form')[0].reset();
				    var dataItem=Plan_auditoria.finditem(e.id);
				    Plan_auditoria.oldElement= dataItem;
					$("#id_proyecto").data('kendoDropDownList').readonly();
				    $('#taskplan_auditoria').val('update');
				    wnd_plan_auditoria.title("Actualizar Plan_auditoria");
                   $('#accionbtn_plan_auditoriasave_exit').text('Actualizar');                   
                   $('#accionbtn_plan_auditoriasave_new').hide();                                 
				    wnd_plan_auditoria.center().open();
				}

//Eliminar elemento
function delete_element_plan_auditoria(e)
{
    var dataItem=Plan_auditoria.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Plan_auditoria?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_plan_auditoria&task=plan_auditoria_delete_one",
                data:{
                    array:JSON.stringify(array)
                },
                success:function(response){
if(response.success===true) {                               	var message='El elemento fue eliminado con exito';
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
                    Plan_auditoria.gridDataSource.read();
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
	validator_plan_auditoria=$("#plan_auditoria_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Plan_auditoria.oldElement==null)
                    		{
								if(input.is("[id=fecha_cumplimiento]")) {
									var	inicio = $("#fecha_plan").data('kendoDatePicker').value();
									var	final = $("#fecha_cumplimiento").data('kendoDatePicker').value();
									if(inicio > final){
										message = "La fecha cumplimiento debe ser posterior a la fecha plan";
										return $('#fecha_cumplimiento').data('kendoDatePicker').value('');
									}
								}
								if(input.is("[id=objetivos_alcance]")) {
									var value = $('#objetivos_alcance').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="El objetivos_alcance ingresado no debe exceder los 250 caracteres";
										return $('#objetivos_alcance').val('');
									}
								}
								if(input.is("[id=director_entidad]")) {
									var value = $('#director_entidad').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="El director_entidad ingresado no debe exceder los 250 caracteres";
										return $('#director_entidad').val('');
									}
								}
								if(input.is("[id=equipo_auditor]")) {
									var value = $('#equipo_auditor').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="El equipo_auditor ingresado no debe exceder los 250 caracteres";
										return $('#equipo_auditor').val('');
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
	Plan_auditoria.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_plan_auditoria&task=plan_auditoria_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_plan_auditoria:{type:"number"},
						objetivos_alcance:{type:"string"},
						fecha_plan:{type:"date"},
						director_entidad:{type:"string"},
						equipo_auditor:{type:"string"},
						fecha_cumplimiento:{type:"date"},
						id_programa:{type:"number"},
						programa:{type:"string"},
						id_entidad:{type:"number"},
					     entidad:{type:"string"},
						id_proyecto:{type:"number"},
					     proyecto:{type:"string"},

				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_plan_auditoria").kendoGrid({
	        dataSource: Plan_auditoria.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 groupable:true,
		 detailTemplate: kendo.template($("#template_plan_auditoria").html()),
	        sortable: true,
	        change: Plan_auditoria.change,
			resizable: true,
	        dataBound: Plan_auditoria.dataBound,
	        dataBinding: Plan_auditoria.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_plan_auditoria' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_plan_auditoria",
					template:'<div id="item" data-text="#: id_plan_auditoria#">#: id_plan_auditoria#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,
				{
					field: "id_proyecto",
					title: "id_proyecto",
					template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
					width: '5%',
					type:"number",
					hidden:true
				}
				,
				{
					field: "proyecto",
					title: "Proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
					width: '10%',
					type:"string"
				}
				,       {
					field: "id_programa",
					title: "id_programa",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
					width: '5%',
					type:"number",
					hidden:true
				}
				,
				{
					field: "programa",
					title: "Programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
					width: '10%',
					type:"string",
					hidden:true
				}
				,     {
					field: "id_entidad",
					title: "id_entidad",
					template:'<div id="item" data-text="#: id_entidad#">#: id_entidad#</div>',
					width: '5%',
					type:"number",
					hidden:true
				}
				,
				{
					field: "entidad",
					title: "Entidad",
					template:'<div id="item" data-text="#: entidad#">#: entidad#</div>',
					width: '10%',
					type:"string"
				}
				,

	            {
	                field: "objetivos_alcance",
					template:'<div id="item" data-text="#: objetivos_alcance#">#: objetivos_alcance#</div>',
	                title: "Objetivos Alcance",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_plan",
	                title: "Fecha Plan",
	                width: '15%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	
	            }
				,

	            {
						field: "director_entidad",
					template:'<div id="item" data-text="#: director_entidad#">#: director_entidad#</div>',
	                title: "Director Entidad",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
						field: "equipo_auditor",
					template:'<div id="item" data-text="#: equipo_auditor#">#: equipo_auditor#</div>',
	                title: "Equipo Auditor",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_cumplimiento",
	                title: "Fecha Cumplimiento",
	                width: '15%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	
	            }
				,


				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_plan_auditoria(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_plan_auditoria(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });


/*Acciones de los botones*/

    $('#all_check_plan_auditoria').click(function () {
        var c = this.checked;
        $('#gridselection_plan_auditoria :checkbox').prop('checked',c);
    });
    $('#accionbtn_plan_auditoriasave_exit').click(function()
			    {
					if (validator_plan_auditoria.validate())
                    {

                      var fd = new FormData(document.querySelector("#plan_auditoria_form"));                                                                                                                                     
                      var  url="?option=com_plan_auditoria&task=plan_auditoria_add"; 
	        			if($('#taskplan_auditoria').val()=="update")
							{
                       var olditem=JSON.stringify(Plan_auditoria.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_plan_auditoria&task=plan_auditoria_update";
							}
	        			$.ajax({
	        				type: "POST",
	        				url:url,
	            			data:fd,
                           cache: false,
                           processData: false,
                           contentType: false,
	                           success:function(response){
                    					if(response.success===true)
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
	                					Plan_auditoria.gridDataSource.read();
                                       $('#plan_auditoria_form')[0].reset();
            	                					wnd_plan_auditoria.close();
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
    $('#accionbtn_plan_auditoriasave_new').click(function()
			    {
					if (validator_plan_auditoria.validate())
                    {

                       var fd = new FormData(document.querySelector("#plan_auditoria_form")); 
	        			 var url="?option=com_plan_auditoria&task=plan_auditoria_add"; 
	        			$.ajax({
	        				type: "POST",
	        				url:url,
	            			data:fd,
                           cache: false,
                           processData: false,
                           contentType: false,
	                           success:function(response){
                    					if(response.success===true)
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
                                       showInsert_plan_auditoria();           
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

    $('#cancelbtn_plan_auditoria').click(function(){
        $('#plan_auditoria_form')[0].reset();
           Plan_auditoria.gridDataSource.read();                       
        wnd_plan_auditoria.close();
    });

    $('#addbutton_plan_auditoria').click(function(){
        showInsert_plan_auditoria();
    });
    $('#deletebutton_plan_auditoria').click(function(){
        var checkbox_checked=$('#gridselection_plan_auditoria .check_row:checked');

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
                      var dataItem=Plan_auditoria.finditem($(this).attr('id'));
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
                        url:"?option=com_plan_auditoria&task=plan_auditoria_delete_one", 
                        data:{
                            array:JSON.stringify(array)
                        },
                        success:function(response){
if(response.success===true) {
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
                            Plan_auditoria.gridDataSource.read();
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
