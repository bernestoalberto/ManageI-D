/** * Created by Ernesto on .
 *Date:1/9/2016  
 *Time:0:19 */
//Creando variables globales
	var validator;
	var Informe_auditoria={};
	var message=""


	//Creando los windows Dialogs
	wnd_informe_auditoria = $("#informe_auditoria_window").kendoWindow({
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
        				if(Informe_auditoria.oldElement!=null) {
							
				    			$('#fecha_confeccion').val(Informe_auditoria.oldElement.fecha_confeccion);
				    			$('#objetivos').val(Informe_auditoria.oldElement.objetivos);
				    			$('#alcance').val(Informe_auditoria.oldElement.alcance);
				    			$('#auditor_lider').val(Informe_auditoria.oldElement.auditor_lider);
				    			$('#equipo_auditor').val(Informe_auditoria.oldElement.equipo_auditor);
				    			$('#documentacion_revisada').val(Informe_auditoria.oldElement.documentacion_revisada);
				    			$('#personal_entrevistado').val(Informe_auditoria.oldElement.personal_entrevistado);
				    			$('#opinion_equipo_auditor').val(Informe_auditoria.oldElement.opinion_equipo_auditor);
				    			$('#no_conformidades_detectadas').val(Informe_auditoria.oldElement.no_conformidades_detectadas);
				    			$('#observaciones').val(Informe_auditoria.oldElement.observaciones);
				    			$('#elaborado_por').val(Informe_auditoria.oldElement.elaborado_por);
				    			$('#id_proyecto').data("kendoDropDownList").value(Informe_auditoria.oldElement.id_proyecto);
						}

						else
						{

				    			$('#id_proyecto').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Informe_auditoria.oldElement=null;



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
		/*Date Picker  fecha_confeccion*/
		$("#fecha_confeccion").kendoDatePicker({
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
	Informe_auditoria.change = function onChange(arg) {
};
	Informe_auditoria.change = function onDataBinding(arg) {
};
	Informe_auditoria.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Informe_auditoria.kgrid=this;
		}
	Informe_auditoria.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Informe_auditoria.gridDataSource._data,function(val,index){
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
               dataURI: Informe_auditoria.gridDataSource,                                                    
               fileName: "informe_auditoria.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_informe_auditoria() {
					Informe_auditoria.oldElement=null;
					validator_informe_auditoria.hideMessages();
		    		$('#informe_auditoria_form')[0].reset();
		    		$('#taskinforme_auditoria').val('insert');
					$('#id_proyecto').data("kendoDropDownList").enable();
                   $('#accionbtn_informe_auditoriasave_exit').text('Guardar y Salir');         
		    		wnd_informe_auditoria.title("Crear Informe Auditoria");
                   $('#accionbtninforme_auditoria_save_new').show();
		    		wnd_informe_auditoria.center().open();
				}

//Mostrar Ventanas
				function showUpdate_informe_auditoria(e) {
					validator_informe_auditoria.hideMessages();
				    $('#informe_auditoria_form')[0].reset();
				    var dataItem=Informe_auditoria.finditem(e.id);
				    Informe_auditoria.oldElement= dataItem;
				    $('#taskinforme_auditoria').val('update');
					$('#id_proyecto').data("kendoDropDownList").readonly();
				    wnd_informe_auditoria.title("Actualizar Informe Auditoria");
                   $('#accionbtn_informe_auditoriasave_exit').text('Actualizar');                   
                   $('#accionbtn_informe_auditoriasave_new').hide();                                 
				    wnd_informe_auditoria.center().open();
				}

//Eliminar elemento
function delete_element_informe_auditoria(e)
{
    var dataItem=Informe_auditoria.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Informe_auditoria?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_informe_auditoria&task=informe_auditoria_delete_one",
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
                    Informe_auditoria.gridDataSource.read();
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
	validator_informe_auditoria=$("#informe_auditoria_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Informe_auditoria.oldElement==null)
                    		{
								if(input.is("[id=objetivos_alcance]")) {
									var value = $('#objetivos_alcance').val();
									var size = value.length;

									if(size > 250){
										found=true;
										message="El objetivos_alcance ingresado no debe exceder los 250 caracteres";
										return $('#objetivos_alcance').val('');
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
	Informe_auditoria.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_informe_auditoria&task=informe_auditoria_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
					id_nforme_auditoria:{type:"number"},
					fecha_confeccion:{type:"date"},
					id_programa:{type:"number"},
					programa:{type:"string"},
					id_entidad:{type:"number"},
					entidad:{type:"string"},
					id_proyecto:{type:"number"},
					proyecto:{type:"string"},
					objetivos:{type:"string"},
					alcance:{type:"string"},
					auditor_lider:{type:"string"},
					equipo_auditor:{type:"string"},
					documentacion_revisada:{type:"string"},
					personal_entrevistado:{type:"string"},
					opinion_equipo_auditor:{type:"string"},
					id_documentacion_evidencias:{type:"number"},
					no_conformidades_detectadas:{type:"string"},
					observaciones:{type:"string"},
					elaborado_por:{type:"string"}



				}
			}
 		},
        pageSize: 12
    });
 $("#gridselection_informe_auditoria").kendoGrid({
	        dataSource: Informe_auditoria.gridDataSource,
	        height: 500,
	 columnMenu: true,
	 filterable: {
		 mode: "row"
	 },
	 groupable:true,
	 detailTemplate: kendo.template($("#template_informe_auditoria").html()),
	        sortable: true,
	        change: Informe_auditoria.change,
			resizable: true,
	        dataBound: Informe_auditoria.dataBound,
	        dataBinding: Informe_auditoria.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [
	            {	                
					field: "",
	                title: "",
	                width: '4%',
	                headerTemplate: "<input class='' id='all_check_informe_auditoria' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_nforme_auditoria",
					template:'<div id="item" data-text="#: id_nforme_auditoria#">#: id_nforme_auditoria#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "fecha_confeccion",
	                title: "Fecha Confección",
	                width: '20%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	
	            }
				,

				{
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
					width: '20%',
					type:"string"
				}
				,	{
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
					width: '20%',
					type:"string"
				}
				,	{
					field: "id_entidad",
					title: "ID",
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
					width: '20%',
					type:"string"
				}
				,

	            {
	                field: "objetivos",
					template:'<div id="item" data-text="#: objetivos#">#: objetivos#</div>',
	                title: "Objetivos",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "alcance",
					template:'<div id="item" data-text="#: alcance#">#: alcance#</div>',
	                title: "Alcance",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "auditor_lider",
					template:'<div id="item" data-text="#: auditor_lider#">#: auditor_lider#</div>',
	                title: "Auditor Lider",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,
   {
	                field: "equipo_auditor",
					template:'<div id="item" data-text="#: equipo_auditor#">#: equipo_auditor#</div>',
	                title: "Equipo Auditor",
	                width: '20%',
					type:"string",
	                 hidden:true
	            }
				,

	            {
	                field: "documentacion_revisada",
					template:'<div id="item" data-text="#: documentacion_revisada#">#: documentacion_revisada#</div>',
	                title: "Documentación Revisada",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "personal_entrevistado",
					template:'<div id="item" data-text="#: personal_entrevistado#">#: personal_entrevistado#</div>',
	                title: "Personal Entrevistado",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "opinion_equipo_auditor",
					template:'<div id="item" data-text="#: opinion_equipo_auditor#">#: opinion_equipo_auditor#</div>',
	                title: "Opinion Equipo Auditor",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "id_documentacion_evidencias",
					template:'<div id="item" data-text="#: id_documentacion_evidencias#">#: id_documentacion_evidencias#</div>',
	                title: "id_documentacion_evidencias",
	                width: '2%',
					type:"number",
					hidden:true
	            }
				,    {
	                field: "no_conformidades_detectadas",
					template:'<div id="item" data-text="#: no_conformidades_detectadas#">#: no_conformidades_detectadas#</div>',
	                title: "Evidencias",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "observaciones",
					template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
	                title: "Observaciones",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "elaborado_por",
					template:'<div id="item" data-text="#: elaborado_por#">#: elaborado_por#</div>',
	                title: "Elaborado Por",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_informe_auditoria(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_informe_auditoria(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });



/*Acciones de los botones*/

    $('#all_check_informe_auditoria').click(function () {
        var c = this.checked;
        $('#gridselection_informe_auditoria :checkbox').prop('checked',c);
    });
    $('#accionbtn_informe_auditoriasave_exit').click(function()
			    {
					if (validator_informe_auditoria.validate())
                    {

                      var fd = new FormData(document.querySelector("#informe_auditoria_form"));                                                                                                                                     
                      var  url="?option=com_informe_auditoria&task=informe_auditoria_add"; 
	        			if($('#taskinforme_auditoria').val()=="update")
							{
                       var olditem=JSON.stringify(Informe_auditoria.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_informe_auditoria&task=informe_auditoria_update";
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
	                					Informe_auditoria.gridDataSource.read();
                                       $('#informe_auditoria_form')[0].reset();
            	                					wnd_informe_auditoria.close();
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
    $('#accionbtn_informe_auditoriasave_new').click(function()
			    {
					if (validator_informe_auditoria.validate())
                    {

                       var fd = new FormData(document.querySelector("#informe_auditoria_form")); 
	        			 var url="?option=com_informe_auditoria&task=informe_auditoria_add"; 
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
                                       showInsert_informe_auditoria();           
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

    $('#cancelbtn_informe_auditoria').click(function(){
        $('#informe_auditoria_form')[0].reset();
           Informe_auditoria.gridDataSource.read();                       
        wnd_informe_auditoria.close();
    });

    $('#addbutton_informe_auditoria').click(function(){
        showInsert_informe_auditoria();
    });
    $('#deletebutton_informe_auditoria').click(function(){
        var checkbox_checked=$('#gridselection_informe_auditoria .check_row:checked');

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
                      var dataItem=Informe_auditoria.finditem($(this).attr('id'));
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
                        url:"?option=com_informe_auditoria&task=informe_auditoria_delete_one", 
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
                            Informe_auditoria.gridDataSource.read();
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
