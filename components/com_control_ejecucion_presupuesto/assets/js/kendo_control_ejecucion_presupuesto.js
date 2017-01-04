/** * Created by Ernesto on .
 *Date:1/3/2016  
 *Time:23:9 */
//Creando variables globales
	var validator;
	var Control_ejecucion_presupuesto={};
	var message=""


	//Creando los windows Dialogs
	wnd_control_ejecucion_presupuesto = $("#control_ejecucion_presupuesto_window").kendoWindow({
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
        				if(Control_ejecucion_presupuesto.oldElement!=null) {
							
				    			$('#id_anno').data("kendoDropDownList").value(Control_ejecucion_presupuesto.oldElement.id_anno);
				    			$('#fecha_inicio').val(Control_ejecucion_presupuesto.oldElement.fecha_inicio);
				    			$('#id_anticipo').data("kendoDropDownList").value(Control_ejecucion_presupuesto.oldElement.id_anticipo);
				    			$('#fecha_terminacion').val(Control_ejecucion_presupuesto.oldElement.fecha_terminacion);
				    			$('#id_certificacion').data("kendoDropDownList").value(Control_ejecucion_presupuesto.oldElement.id_certificacion);
				    			$('#gastos_ejecucion').val(Control_ejecucion_presupuesto.oldElement.gastos_ejecucion);
				    			$('#id_notif_ingresos_gastos').data("kendoDropDownList").value(Control_ejecucion_presupuesto.oldElement.id_notif_ingresos_gastos);
				    			$('#id_programa').data("kendoDropDownList").value(Control_ejecucion_presupuesto.oldElement.id_programa);
				    			//$('#id_mes').data("kendoDropDownList").value(Control_ejecucion_presupuesto.oldElement.id_mes);
				    			$('#id_proyecto').data("kendoDropDownList").value(Control_ejecucion_presupuesto.oldElement.id_proyecto);
						}

						else
						{
				    			//$('#id_mes').data("kendoDropDownList").value('');
				    			$('#id_anno').data("kendoDropDownList").value('');
				    			$('#id_anticipo').data("kendoDropDownList").value('');
				    			$('#id_certificacion').data("kendoDropDownList").value('');
				    			$('#id_notif_ingresos_gastos').data("kendoDropDownList").value('');
				    			$('#id_programa').data("kendoDropDownList").value('');
				    			$('#id_proyecto').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Control_ejecucion_presupuesto.oldElement=null;
		/*Data Source  Mes*/




		/*Data Source  Programa*/

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
		$("#id_proyecto_control_ejecucion_presupuesto").kendoDropDownList({
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

			},
			close: function(e){

			},
			suggest: true,
			index: 3
		});
		/*Date Picker  fecha_inicio*/
		$("#fecha_inicio").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
	});		
		/*Date Picker  fecha_terminacion*/
		$("#fecha_terminacion").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
	});		
	Control_ejecucion_presupuesto.change = function onChange(arg) {
};
	Control_ejecucion_presupuesto.change = function onDataBinding(arg) {
};
	Control_ejecucion_presupuesto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Control_ejecucion_presupuesto.kgrid=this;
		}
	Control_ejecucion_presupuesto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Control_ejecucion_presupuesto.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}


                   function showInsert_control_ejecucion_presupuesto() {
					Control_ejecucion_presupuesto.oldElement=null;
					validator_control_ejecucion_presupuesto.hideMessages();
		    		$('#control_ejecucion_presupuesto_form')[0].reset();
		    		$('#taskcontrol_ejecucion_presupuesto').val('insert');
                   $('#accionbtn_control_ejecucion_presupuestosave_exit').text('Guardar y Salir');         
		    		wnd_control_ejecucion_presupuesto.title("Insertar Control y Ejecución del Presupuesto");
                   $('#accionbtncontrol_ejecucion_presupuesto_save_new').show();
		    		wnd_control_ejecucion_presupuesto.center().open();
				}

//Mostrar Ventanas
				function showUpdate_control_ejecucion_presupuesto(e) {
					validator_control_ejecucion_presupuesto.hideMessages();
				    $('#control_ejecucion_presupuesto_form')[0].reset();
				    var dataItem=Control_ejecucion_presupuesto.finditem(e.id);
				    Control_ejecucion_presupuesto.oldElement= dataItem;
				    $('#taskcontrol_ejecucion_presupuesto').val('update');
				    wnd_control_ejecucion_presupuesto.title("Actualizar Control_ejecucion_presupuesto");
                   $('#accionbtn_control_ejecucion_presupuestosave_exit').text('Actualizar');                   
                   $('#accionbtn_control_ejecucion_presupuestosave_new').hide();                                 
				    wnd_control_ejecucion_presupuesto.center().open();
				}

//Eliminar elemento
function delete_element_control_ejecucion_presupuesto(e)
{
    var dataItem=Control_ejecucion_presupuesto.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Control_ejecucion_presupuesto?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_control_ejecucion_presupuesto&task=control_ejecucion_presupuesto_delete_one",
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
                    Control_ejecucion_presupuesto.gridDataSource.read();
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
	validator_control_ejecucion_presupuesto=$("#control_ejecucion_presupuesto_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Control_ejecucion_presupuesto.oldElement==null)
                    		{
								if(input.is("[id=id_proyecto_control_ejecucion_presupuesto]")) {
										value = $('#id_proyecto_control_ejecucion_presupuesto').data('kendoDropDownList').value();
										var anno = $('#annocep').val();
										var periodo;

										if ($('#etapa1c').prop("checked")) {
											periodo = $('#etapa1c').val();

										}
										else if ($('#etapa2c').prop("checked")) {
											periodo = $('#etapa2c').val();

										}
										else if ($('#etapa3c').prop("checked") ) {
											periodo = $('#etapa3c').val();
										}
										else{
											periodo = $('#etapa4c').val();
										}
										while (i < Control_ejecucion_presupuesto.gridDataSource._data.length) {
											var elem = Control_ejecucion_presupuesto.gridDataSource._data[i];
											if (elem.id_proyecto==value&& elem.etapa== periodo && elem.anno==anno)
											{
												found=true;
												message="Existe una notificación de ingresos y gastos para esta etapa, año y proyecto";
												i=Control_ejecucion_presupuesto.gridDataSource._data.length;
												return $('#id_proyecto_control_ejecucion_presupuesto').data('kendoDropDownList').value('');
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
	Control_ejecucion_presupuesto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_control_ejecucion_presupuesto&task=control_ejecucion_presupuesto_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
					id_control_ejecucion_presupuesto:{type:"number"},
					id_programa:{type:"number"},
					programa:{type:"string"},
					id_proyecto_control_ejecucion_presupuesto:{type:"number"},
					proyecto:{type:"string"},
					codigo:{type:"number"},
					fecha_inicio:{type:"date"},
					fecha_terminacion:{type:"date"},
					anno:{type:"number"},
					etapa:{type:"string"},
					financiamiento_planificado:{type:"number"},
					id_anticipo:{type:"number"},
					cantidad_anticipa:{type:"number"},
					id_certificacion:{type:"number"},
					calificacion:{type:"string"},
					id_notif_ingresos_gastos:{type:"number"},
					ingreso:{type:"number"},
					gastos:{type:"string"},
					saldo:{type:"number"}
				}
			}
 		},
        pageSize: 12
    });
	  $("#gridselection_control_ejecucion_presupuesto").kendoGrid({
	        dataSource: Control_ejecucion_presupuesto.gridDataSource,
	        height: 500,
		  columnMenu: true,
		  filterable: {
			  mode: "row"
		  },
		  detailTemplate: kendo.template($("#template_presupuesto").html()),
			 groupable:true,
	        sortable: true,
	        change: Control_ejecucion_presupuesto.change,
			resizable: true,
	        dataBound: Control_ejecucion_presupuesto.dataBound,
	        dataBinding: Control_ejecucion_presupuesto.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_control_ejecucion_presupuesto' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_control_ejecucion_presupuesto",
					template:'<div id="item" data-text="#: id_control_ejecucion_presupuesto#">#: id_control_ejecucion_presupuesto#</div>',
	                title: "Id",
	                width: '7%',
					type:"number",
	            	hidden:true
	            }
				,
                {
	                field: "id_programa",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,    {
	                field: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
	                title: "Programa",
	                width: '15%',
					type:"string",
	            	hidden:true
	            }
				,
                {
	                field: "id_proyecto_control_ejecucion_presupuesto",
					template:'<div id="item" data-text="#: id_proyecto_control_ejecucion_presupuesto#">#: id_proyecto_control_ejecucion_presupuesto#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,
                {
                    field: "proyecto",
                    template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
                    title: "Proyecto",
                    width: '15%',
                    type:"string",
                    hidden:false
                }
                ,
                {
                    field: "codigo",
                    template:'<div id="item" data-text="#: codigo#">#: codigo#</div>',
                    title: "Codigo",
                    width: '15%',
                    type:"number",
                    hidden:true
                }
                ,

	            {
	                field: "anno",
	                title: "Año",
					template:'<div id="item" data-text="#: anno#">#: anno#</div>',
	                width: '10%',
					type:"number"
				}
			,
				{
					field: "etapa",
					title: "Etapa",
					template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
					width: '10%',
					type:"string"
				}
				,

				{
	                field: "fecha_inicio",
	                title: "Fecha_inicio",
	                width: '20%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	,
					hidden:true
	            }
				,
                {
                    field: "fecha_terminacion",
                    title: "Fecha_terminacion",
                    width: '20%',
                    type:"date",
                    format:"{0:dd-MM-yyyy}",
					hidden:true
                }
                ,

	            {
	                field: "financiamiento_planificado",
	                title: "Financiamiento",
					template:'<div id="item" data-text="#: financiamiento_planificado#">#: financiamiento_planificado#</div>',
	                width: '15%',
					type:"number"
				}
			,  {
	                field: "id_anticipo",
	                title: "ID",
					template:'<div id="item" data-text="#: id_anticipo#">#: id_anticipo#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,
	            {
	                field: "cantidad_anticipa",
	                title: "Anticipo(CUP)",
					template:'<div id="item" data-text="#: cantidad_anticipa#">#: cantidad_anticipa#</div>',
	                width: '15%',
					type:"number"
				}
			,

	            {
	                field: "id_certificacion",
	                title: "ID",
					template:'<div id="item" data-text="#: id_certificacion#">#: id_certificacion#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,     {
	                field: "calificacion",
	                title: "calificacion",
					template:'<div id="item" data-text="#: calificacion#">#: calificacion#</div>',
	                width: '15%',
					type:"string",
					hidden:true
				}
			,
	             {
	                field: "ingreso",
	                title: "Ingresos(CUP)",
					template:'<div id="item" data-text="#: ingreso#">#: ingreso#</div>',
	                width: '12%',
					type:"number"
				}
			,

	            {
	                field: "gastos",
					template:'<div id="item" data-text="#: gastos#">#: gastos#</div>',
	                title: "Gastos(CUP)",
	                width: '12%',
					type:"number"
	            }
				,

	            {
	                field: "id_notif_ingresos_gastos",
	                title: "ID",
					template:'<div id="item" data-text="#: id_notif_ingresos_gastos#">#: id_notif_ingresos_gastos#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,
        {
	                field: "saldo",
	                title: "Saldo(CUP)",
					template:'<div id="item" data-text="#: saldo#">#: saldo#</div>',
	                width: '12%',
					type:"number"
				}
			,

				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_control_ejecucion_presupuesto(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_control_ejecucion_presupuesto(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_control_ejecucion_presupuesto').click(function () {
        var c = this.checked;
        $('#gridselection_control_ejecucion_presupuesto :checkbox').prop('checked',c);
    });
    $('#accionbtn_control_ejecucion_presupuestosave_exit').click(function()
			    {
					if (validator_control_ejecucion_presupuesto.validate())
                    {

                      var fd = new FormData(document.querySelector("#control_ejecucion_presupuesto_form"));                                                                                                                                     
                      var  url="?option=com_control_ejecucion_presupuesto&task=control_ejecucion_presupuesto_add"; 
	        			if($('#taskcontrol_ejecucion_presupuesto').val()=="update")
							{
                       var olditem=JSON.stringify(Control_ejecucion_presupuesto.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_control_ejecucion_presupuesto&task=control_ejecucion_presupuesto_update";
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
	                					Control_ejecucion_presupuesto.gridDataSource.read();
                                       $('#control_ejecucion_presupuesto_form')[0].reset();
            	                					wnd_control_ejecucion_presupuesto.close();
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
    $('#accionbtn_control_ejecucion_presupuestosave_new').click(function()
			    {
					if (validator_control_ejecucion_presupuesto.validate())
                    {

                       var fd = new FormData(document.querySelector("#control_ejecucion_presupuesto_form")); 
	        			 var url="?option=com_control_ejecucion_presupuesto&task=control_ejecucion_presupuesto_add"; 
	        			$.ajax({
	        				type: "POST",
	        				url:url,
	            			data:fd,
                           cache: false,
                           processData: false,
                           contentType: false,
	                           success:function(response){
                    					if(response.success=true)
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
                                       showInsert_control_ejecucion_presupuesto();           
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

    $('#cancelbtn_control_ejecucion_presupuesto').click(function(){
        $('#control_ejecucion_presupuesto_form')[0].reset();
           Control_ejecucion_presupuesto.gridDataSource.read();                       
        wnd_control_ejecucion_presupuesto.close();
    });

    $('#addbutton_control_ejecucion_presupuesto').click(function(){
        showInsert_control_ejecucion_presupuesto();
    });
    $('#deletebutton_control_ejecucion_presupuesto').click(function(){
        var checkbox_checked=$('#gridselection_control_ejecucion_presupuesto .check_row:checked');

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
                      var dataItem=Control_ejecucion_presupuesto.finditem($(this).attr('id'));
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
                        url:"?option=com_control_ejecucion_presupuesto&task=control_ejecucion_presupuesto_delete_one", 
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
                            Control_ejecucion_presupuesto.gridDataSource.read();
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
