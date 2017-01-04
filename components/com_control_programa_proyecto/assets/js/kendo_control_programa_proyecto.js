/** * Created by Ernesto on .
 *Date:1/6/2016  
 *Time:13:21 */
//Creando variables globales
	var validator;
	var Control_programa_proyecto={};
	var message=""


	//Creando los windows Dialogs
	wnd_control_programa_proyecto = $("#control_programa_proyecto_window").kendoWindow({
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
        				if(Control_programa_proyecto.oldElement!=null) {
							
				    			$('#entidad_finacista').val(Control_programa_proyecto.oldElement.entidad_finacista);
				    			$('#otros_aspectos').val(Control_programa_proyecto.oldElement.otros_aspectos);
				    			$('#acuerdos_adoptados').val(Control_programa_proyecto.oldElement.acuerdos_adoptados);
				    			$('#nombre_apellidos_evaluador').val(Control_programa_proyecto.oldElement.nombre_apellidos_evaluador);
				    			$('#nombre_apellidos_evaluado').val(Control_programa_proyecto.oldElement.nombre_apellidos_evaluado);
				    			$('#participante').val(Control_programa_proyecto.oldElement.participante);
				    			$('#responsabilidad').val(Control_programa_proyecto.oldElement.responsabilidad);
				    			$('#fecha_control').val(Control_programa_proyecto.oldElement.fecha_control);
				    			$('#fecha_firma_evaluador').val(Control_programa_proyecto.oldElement.fecha_firma_evaluador);
				    			$('#fecha_firma_evaluado').val(Control_programa_proyecto.oldElement.fecha_firma_evaluado);
				    			$('#id_estado_ejecucion_proyecto').data("kendoDropDownList").value(Control_programa_proyecto.oldElement.id_estado_ejecucion_proyecto);
				    			$('#id_problema_detectado').data("kendoDropDownList").value(Control_programa_proyecto.oldElement.id_problema_detectado);
				    			$('#participante').data("kendoDropDownList").value(Control_programa_proyecto.oldElement.participante);
				    			$('#id_proyecto').data("kendoDropDownList").value(Control_programa_proyecto.oldElement.id_proyecto);
						}

						else
						{
				    			$('#participante').data("kendoDropDownList").value('');
				    			$('#id_estado_ejecucion_proyecto').data("kendoDropDownList").value('');
				    			$('#id_problema_detectado').data("kendoDropDownList").value('');
				    			$('#id_proyecto').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Control_programa_proyecto.oldElement=null;
		/*Data Source  Ejecutora*/
	var ejecutoradatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_entidad&task=entidad_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  participante*/
		$("#participante").kendoDropDownList({
        dataTextField: "nombre",
        dataValueField: "id_entidad",
        dataSource: ejecutoradatasource,
        filter: "contains",
		 open: function(e) {

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


		/*Data Source  Estado_ejecucion_proyecto*/
	var estado_ejecucion_proyectodatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_estado_ejecucion_proyecto&task=estado_ejecucion_proyecto_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Estado_ejecucion_proyecto*/
		$("#id_estado_ejecucion_proyecto").kendoDropDownList({
        dataTextField: "nombre_estado_ejecucion_proyecto",
        dataValueField: "id_estado_ejecucion_proyecto",
        dataSource: estado_ejecucion_proyectodatasource,
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
		/*Data Source  Problemas_detectados*/
	var problemas_detectadosdatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_problemas_detectados&task=problemas_detectados_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Problemas_detectados*/
		$("#id_problema_detectado").kendoDropDownList({
        dataTextField: "problema",
        dataValueField: "id_problema_detectado",
        dataSource: problemas_detectadosdatasource,
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
            // if no valid selection - clear input
            if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
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
            // if no valid selection - clear input
            if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
		/*Date Picker  fecha_control*/
		$("#fecha_control").kendoDatePicker({
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
	});			$("#fecha_firma_evaluador").kendoDatePicker({
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
	});			$("#fecha_firma_evaluado").kendoDatePicker({
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
	Control_programa_proyecto.change = function onChange(arg) {
};
	Control_programa_proyecto.change = function onDataBinding(arg) {
};
	Control_programa_proyecto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Control_programa_proyecto.kgrid=this;
		}
	Control_programa_proyecto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Control_programa_proyecto.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}





				function showInsert_control_programa_proyecto() {
					Control_programa_proyecto.oldElement=null;
					validator_control_programa_proyecto.hideMessages();
		    		$('#control_programa_proyecto_form')[0].reset();
		    		$('#taskcontrol_programa_proyecto').val('insert');
                   $('#accionbtn_control_programa_proyectosave_exit').text('Guardar y Salir');         
		    		wnd_control_programa_proyecto.title("Crear Control a Programa o Proyecto");
                   $('#accionbtncontrol_programa_proyecto_save_new').show();
		    		wnd_control_programa_proyecto.center().open();
				}

//Mostrar Ventanas
				function showUpdate_control_programa_proyecto(e) {
					validator_control_programa_proyecto.hideMessages();
				    $('#control_programa_proyecto_form')[0].reset();
				    var dataItem=Control_programa_proyecto.finditem(e.id);
				    Control_programa_proyecto.oldElement= dataItem;
				    $('#taskcontrol_programa_proyecto').val('update');
				    wnd_control_programa_proyecto.title("Actualizar Control_programa_proyecto");
                   $('#accionbtn_control_programa_proyectosave_exit').text('Actualizar');                   
                   $('#accionbtn_control_programa_proyectosave_new').hide();                                 
				    wnd_control_programa_proyecto.center().open();
				}

//Eliminar elemento
function delete_element_control_programa_proyecto(e)
{
    var dataItem=Control_programa_proyecto.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Control_programa_proyecto?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_control_programa_proyecto&task=control_programa_proyecto_delete_one",
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
                    Control_programa_proyecto.gridDataSource.read();
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
	validator_control_programa_proyecto=$("#control_programa_proyecto_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Control_programa_proyecto.oldElement==null)
                    		{

								if(input.is("[id=fecha_firma_evaluador]")) {
									var	inicio = $("#fecha_control").data('kendoDatePicker').value();
									var	final = $("#fecha_firma_evaluador").data('kendoDatePicker').value();
									if(inicio > final){
										message = "La fecha_firma_evaluador debe ser posterior a la fecha inicial";
										return $('#fecha_firma_evaluador').data('kendoDatePicker').value('');
									}

								}
								if(input.is("[id=fecha_firma_evaluado]")) {
									var inicio = $("#fecha_control").data('kendoDatePicker').value();
									var final = $("#fecha_firma_evaluado").data('kendoDatePicker').value();
									if (inicio > final) {
										message = "La fecha_firma_evaluado a la fecha inicial";
										return $('#fecha_firma_evaluado').data('kendoDatePicker').value('');
									}
								}
								if(input.is("[id=otros_aspectos]")) {
									 value = $('#otros_aspectos').val();
									var size = value.length;
									if(size > 100){
										found=true;
										message="Los otros_aspectos ingresadas no debe exceder los 100 caracteres";
										return $('#otros_aspectos').val('');
									}
								}
								if(input.is("[id=acuerdos_adoptados]")) {
									 value = $('#acuerdos_adoptados').val();
									var size = value.length;
									if(size > 100){
										found=true;
										message="Los acuerdos_adoptados ingresadas no debe exceder los 100 caracteres";
										return $('#acuerdos_adoptados').val('');
									}
								}
								if(input.is("[id=evaluador]")) {
									 value = $('#evaluador').val();
									var size = value.length;
									if(size > 30){
										found=true;
										message="El evaluador ingresadas no debe exceder los 30 caracteres";
										return $('#evaluador').val('');
									}
								}
								if(input.is("[id=evaluado]")) {
									 value = $('#evaluado').val();
									var size = value.length;
									if(size > 30){
										found=true;
										message="El Evaluado ingresadas no debe exceder los 30 caracteres";
										return $('#evaluado').val('');
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
	Control_programa_proyecto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_control_programa_proyecto&task=control_programa_proyecto_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_control:{type:"number"},
						id_proyecto:{type:"number"},
					    proyecto:{type:"string"},
						id_programa:{type:"number"},
						programa:{type:"string"},
					    codigo:{type:"number"},
					   participante:{type:"number"},
					    entidad:{type:"string"},
					    id_provincia:{type:"number"},
					    provincia:{type:"string"},
					    entidad_finacista:{type:"number"},
					    finacista:{type:"string"},
					   fecha_control:{type:"date"},
						participante:{type:"number"},
						invitado:{type:"string"},
						id_estado_ejecucion_proyecto:{type:"number"},
					   nombre_estado_ejecucion_proyecto:{type:"string"},
						id_problema_detectado:{type:"number"},
						problema:{type:"string"},
					   otros_aspectos:{type:"string"},
					  acuerdos_adoptados:{type:"string"},
					   nombre_apellidos_evaluador:{type:"string"},
				    	fecha_firma_evaluador:{type:"date"},
					   nombre_apellidos_evaluado:{type:"string"},
					   fecha_firma_evaluado:{type:"date"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_control_programa_proyecto").kendoGrid({
	        dataSource: Control_programa_proyecto.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},

		detailTemplate: kendo.template($("#template_control").html()),
	        sortable: true,
			 groupable:true,
	        change: Control_programa_proyecto.change,
			resizable: true,
	        dataBound: Control_programa_proyecto.dataBound,
	        dataBinding: Control_programa_proyecto.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [
	            {	                
					field: "",
	                title: "",
	                width: '5%',
	                headerTemplate: "<input class='' id='all_check_control_programa_proyecto' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_control",
					template:'<div id="item" data-text="#: id_control#">#: id_control#</div>',
	                title: "Id_control",
	                width: '5%',
					type:"number",
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
	                width: '15%',
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
	                width: '15%',
					type:"string"
	            }
				,     {
	                field: "codigo",
					template:'<div id="item" data-text="#: codigo#">#: codigo#</div>',
	                title: "Código",
	                width: '10%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "participante",
					template:'<div id="item" data-text="#: participante#">#: participante#</div>',
	                title: "participante",
	                width: '5%',
					type:"number",
					hidden:true
	            }
				,
				{
	                field: "entidad",
					template:'<div id="item" data-text="#: entidad#">#: entidad#</div>',
	                title: "Ejecutora",
	                width: '15%',
					type:"string"
	            }
				,
				{
	                field: "id_provincia",
					template:'<div id="item" data-text="#: id_provincia#">#: id_provincia#</div>',
	                title: "id_provincia",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,{
	                field: "provincia",
					template:'<div id="item" data-text="#: provincia#">#: provincia#</div>',
	                title: "Provincia",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,
				{
	                field: "entidad_finacista",
					template:'<div id="item" data-text="#: entidad_finacista#">#: entidad_finacista#</div>',
	                title: "Entidad Finacista",
	                width: '5%',
					type:"number",
					hidden:true
	            }
				, {
	                field: "finacista",
					template:'<div id="item" data-text="#: finacista#">#: finacista#</div>',
	                title: "Finacista",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,
				{
					field: "id_estado_ejecucion_proyecto",
					title: "ID",
					template:'<div id="item" data-text="#: id_estado_ejecucion_proyecto#">#: id_estado_ejecucion_proyecto#</div>',
					width: '5%',
					type:"number",
					hidden:true
				}
				,
				{
					field: "nombre_estado_ejecucion_proyecto",
					title: "Estado Ejecución",
					template:'<div id="item" data-text="#: nombre_estado_ejecucion_proyecto#">#: nombre_estado_ejecucion_proyecto#</div>',
					width: '15%',
					type:"string"
				}
				,
				{
					field: "fecha_control",
					title: "Fecha Control",
					width: '15%',
					type:"date",
					format:"{0:dd-MM-yyyy}"
				}
				,


				{
					field: "participante",
					template:'<div id="item" data-text="#: participante#">#: participante#</div>',
					title: "Participante",
					width: '15%',
					type:"number",
					hidden:true
				}
				,
				{
					field: "invitado",
					template:'<div id="item" data-text="#: invitado#">#: invitado#</div>',
					title: "Invitado",
					width: '10%',
					type:"string",
					hidden:true
				}
				,



				{
					field: "id_problema_detectado",
					title: "ID",
					template:'<div id="item" data-text="#: id_problema_detectado#">#: id_problema_detectado#</div>',
					width: '5%',
					type:"number",
					hidden:true
				}
				,
				{
					field: "problema",
					title: "Problema",
					template:'<div id="item" data-text="#: problema#">#: problema#</div>',
					width: '15%',
					type:"string",
					hidden:true
				}
				,

	            {
	                field: "otros_aspectos",
					template:'<div id="item" data-text="#: otros_aspectos#">#: otros_aspectos#</div>',
	                title: "Otros Aspectos",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "acuerdos_adoptados",
					template:'<div id="item" data-text="#: acuerdos_adoptados#">#: acuerdos_adoptados#</div>',
	                title: "Acuerdos Adoptados",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,


				{
					field: "nombre_apellidos_evaluador",
					template:'<div id="item" data-text="#: nombre_apellidos_evaluador#">#: nombre_apellidos_evaluador#</div>',
					title: "Evaluador",
					width: '10%',
					type:"string",
					hidden:true
				}
				,	{
					field: "fecha_firma_evaluador",
					title: "Firma Evaluador",
					width: '20%',
					type:"date",
					format:"{0:dd-MM-yyyy}",
					hidden:true
				}
				,

				{
					field: "nombre_apellidos_evaluado",
					template:'<div id="item" data-text="#: nombre_apellidos_evaluado#">#: nombre_apellidos_evaluado#</div>',
					title: "Evaluado",
					width: '10%',
					type:"string",
					hidden:true
				}
				,	{
					field: "fecha_firma_evaluado",
					title: "Firma Evaluado",
					width: '20%',
					type:"date",
					format:"{0:dd-MM-yyyy}",
					hidden:true
				}
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_control_programa_proyecto(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_control_programa_proyecto(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_control_programa_proyecto').click(function () {
        var c = this.checked;
        $('#gridselection_control_programa_proyecto :checkbox').prop('checked',c);
    });
    $('#accionbtn_control_programa_proyectosave_exit').click(function()
			    {
					if (validator_control_programa_proyecto.validate())
                    {

                      var fd = new FormData(document.querySelector("#control_programa_proyecto_form"));                                                                                                                                     
                      var  url="?option=com_control_programa_proyecto&task=control_programa_proyecto_add";
	        			if($('#taskcontrol_programa_proyecto').val()=="update")
							{
                       var olditem=JSON.stringify(Control_programa_proyecto.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_control_programa_proyecto&task=control_programa_proyecto_update";
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
	                					Control_programa_proyecto.gridDataSource.read();
                                       $('#control_programa_proyecto_form')[0].reset();
            	                					wnd_control_programa_proyecto.close();
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
    $('#accionbtn_control_programa_proyectosave_new').click(function()
			    {
					if (validator_control_programa_proyecto.validate())
                    {

                       var fd = new FormData(document.querySelector("#control_programa_proyecto_form")); 
	        			 var url="?option=com_control_programa_proyecto&task=control_programa_proyecto_add"; 
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
                                       showInsert_control_programa_proyecto();           
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

    $('#cancelbtn_control_programa_proyecto').click(function(){
        $('#control_programa_proyecto_form')[0].reset();
           Control_programa_proyecto.gridDataSource.read();                       
        wnd_control_programa_proyecto.close();
    });

    $('#addbutton_control_programa_proyecto').click(function(){
        showInsert_control_programa_proyecto();
    });
    $('#deletebutton_control_programa_proyecto').click(function(){
        var checkbox_checked=$('#gridselection_control_programa_proyecto .check_row:checked');

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
                      var dataItem=Control_programa_proyecto.finditem($(this).attr('id'));
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
                        url:"?option=com_control_programa_proyecto&task=control_programa_proyecto_delete_one", 
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
                            Control_programa_proyecto.gridDataSource.read();
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
