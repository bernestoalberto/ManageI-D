/** * Created by Ernesto on .
 *Date:1/6/2016  
 *Time:13:21 */
//Creando variables globales
	var validator;
	var Informe_ejecucion_programa={};
	var message=""


	//Creando los windows Dialogs
	wnd_informe_ejecucion_programa = $("#informe_ejecucion_programa_window").kendoWindow({
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
        				if(Informe_ejecucion_programa.oldElement!=null) {
							
				    			$('#nivel_ejecucion_presupuesto').val(Informe_ejecucion_programa.oldElement.nivel_ejecucion_presupuesto);
				    			$('#etapa').val(Informe_ejecucion_programa.oldElement.etapa);
				    			$('#principales_dificultades').val(Informe_ejecucion_programa.oldElement.principales_dificultades);
				    			$('#conclusiones_recomendaciones').val(Informe_ejecucion_programa.oldElement.conclusiones_recomendaciones);
				    			$('#fecha_informe').val(Informe_ejecucion_programa.oldElement.fecha_informe);
				    			$('#cumplimiento_objtvs_propuestos').val(Informe_ejecucion_programa.oldElement.cumplimiento_objtvs_propuestos);
				    			$('#cumplimiento_resultados_programados').val(Informe_ejecucion_programa.oldElement.cumplimiento_resultados_programados);
				    			$('#id_programa_ejecucion').data("kendoDropDownList").value(Informe_ejecucion_programa.oldElement.id_programa_ejecucion);
						}

						else
						{
				    			$('#id_programa_ejecucion').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Informe_ejecucion_programa.oldElement=null;
		/*Data Source  Programa*/
	var programadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_convocatoria&task=programa_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Programa*/
		$("#id_programa_ejecucion").kendoDropDownList({
        dataTextField: "nombre",
        dataValueField: "id_programa",
        dataSource: programadatasource,
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
		/*Date Picker  fecha_informe*/
		$("#fecha_informe").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
	});		
	Informe_ejecucion_programa.change = function onChange(arg) {
};
	Informe_ejecucion_programa.change = function onDataBinding(arg) {
};
	Informe_ejecucion_programa.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Informe_ejecucion_programa.kgrid=this;
		}
	Informe_ejecucion_programa.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Informe_ejecucion_programa.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}




				function showInsert_informe_ejecucion_programa() {
					Informe_ejecucion_programa.oldElement=null;
					validator_informe_ejecucion_programa.hideMessages();
		    		$('#informe_ejecucion_programa_form')[0].reset();
		    		$('#taskinforme_ejecucion_programa').val('insert');
                   $('#accionbtn_informe_ejecucion_programasave_exit').text('Guardar y Salir');
					$('#id_programa_ejecucion').data("kendoDropDownList").enable();
		    		wnd_informe_ejecucion_programa.title("Crear Informe de Ejecución del Programa");
                   $('#accionbtninforme_ejecucion_programa_save_new').show();
		    		wnd_informe_ejecucion_programa.center().open();
				}

//Mostrar Ventanas
				function showUpdate_informe_ejecucion_programa(e) {
					validator_informe_ejecucion_programa.hideMessages();
				    $('#informe_ejecucion_programa_form')[0].reset();
				    var dataItem=Informe_ejecucion_programa.finditem(e.id);
				    Informe_ejecucion_programa.oldElement= dataItem;
				    $('#taskinforme_ejecucion_programa').val('update');
					$('#id_programa_ejecucion').data("kendoDropDownList").readonly();
				    wnd_informe_ejecucion_programa.title("Actualizar Informe de Ejecución del Programa");
                   $('#accionbtn_informe_ejecucion_programasave_exit').text('Actualizar');                   
                   $('#accionbtn_informe_ejecucion_programasave_new').hide();                                 
				    wnd_informe_ejecucion_programa.center().open();
				}

//Eliminar elemento
function delete_element_informe_ejecucion_programa(e)
{
    var dataItem=Informe_ejecucion_programa.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Informe_ejecucion_programa?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_informe_ejecucion_programa&task=informe_ejecucion_programa_delete_one",
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
                    Informe_ejecucion_programa.gridDataSource.read();
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
	validator_informe_ejecucion_programa=$("#informe_ejecucion_programa_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Informe_ejecucion_programa.oldElement==null)
                    		{

								if(input.is("[id=id_programa_ejecucion]")) {
								 	value=$('#id_programa_ejecucion').data('kendoDropDownList').value();
									var etapa ;
									if($('#etapaE1').prop("checked")){
											etapa=$('#etapaE1').val();
								}

									else{
										etapa=$('#etapaE2').val();
									}

								 	while (i < Informe_ejecucion_programa.gridDataSource._data.length) {
                                		var elem=Informe_ejecucion_programa.gridDataSource._data[i];
                                	 if(elem.id_programa==value && elem.etapa==etapa)
                                		{
                                    		found=true;
											message="Existe un informe de ejecucion de programa  para esta etapa ";
                                    		i=Informe_ejecucion_programa.gridDataSource._data.length;
											return $('#id_programa_ejecucion').data('kendoDropDownList').value('');
		                                }
                                		i++;
                            		}
								}
								if(input.is("[id=cumplimiento_objtvs_propuestos]")) {
									var value = $('#cumplimiento_objtvs_propuestos').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El Cumplimiento_Objtvs_Propuestos ingresado no debe exceder los 100 caracteres";
										return $('#cumplimiento_objtvs_propuestos').val('');
									}
								}
								if(input.is("[id=cumplimiento_resultados_programados]")) {
									var value = $('#cumplimiento_resultados_programados').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El Cumplimiento_Resultados_Programados ingresado no debe exceder los 100 caracteres";
										return $('#cumplimiento_resultados_programados').val('');
									}
								}
								if(input.is("[id=nivel_ejecucion_presupuesto]")) {
									var value = $('#nivel_ejecucion_presupuesto').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El Nivel_Ejecución_Presupuesto no debe exceder los 100 caracteres";
										return $('#nivel_ejecucion_presupuesto').val('');
									}
								}
								if(input.is("[id=conclusiones_recomendaciones]")) {
									var value = $('#conclusiones_recomendaciones').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las Conclusiones_Recomendaciones no debe exceder los 100 caracteres";
										return $('#conclusiones_recomendaciones	').val('');
									}
								}
								if(input.is("[id=principales_dificultades]")) {
									var value = $('#principales_dificultades').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las principales_dificultades no debe exceder los 100 caracteres";
										return $('#principales_dificultades	').val('');
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
	Informe_ejecucion_programa.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_informe_ejecucion_programa&task=informe_ejecucion_programa_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_informe_ejecucion_programa:{type:"number"},
						nivel_ejecucion_presupuesto:{type:"string"},
						etapa:{type:"string"},
						principales_dificultades:{type:"string"},
						conclusiones_recomendaciones:{type:"string"},
						nombre_apellidos_secretatio:{type:"string"},
						nombre_apellidos_jefe:{type:"string"},
						fecha_informe:{type:"date"},
						cumplimiento_objtvs_propuestos:{type:"string"},
						cumplimiento_resultados_programados:{type:"string"},
						id_programa:{type:"number"},
						programa:{type:"string"},
						entidad:{type:"string"}

				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_informe_ejecucion_programa").kendoGrid({
	        dataSource: Informe_ejecucion_programa.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 detailTemplate: kendo.template($("#template_ejeucion_programa").html()),
	        sortable: true,
			 groupable:true,
	        change: Informe_ejecucion_programa.change,
			resizable: true,
	        dataBound: Informe_ejecucion_programa.dataBound,
	        dataBinding: Informe_ejecucion_programa.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_informe_ejecucion_programa' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_informe_ejecucion_programa",
					template:'<div id="item" data-text="#: id_informe_ejecucion_programa#">#: id_informe_ejecucion_programa#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,    {
	                field: "id_programa",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
	                title: "id_programa",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,
				{
	                field: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
	                title: "Programa",
	                width: '10%',
					type:"string"
	            }
				,
				{
	                field: "entidad",
					template:'<div id="item" data-text="#: entidad#">#: entidad#</div>',
	                title: "Entidad",
	                width: '10%',
					type:"string"
	            }
				,

	            {
	                field: "nivel_ejecucion_presupuesto",
					template:'<div id="item" data-text="#: nivel_ejecucion_presupuesto#">#: nivel_ejecucion_presupuesto#</div>',
	                title: "Nivel Ejecución Presupuesto",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "etapa",
					template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
	                title: "Etapa",
	                width: '15%',
					type:"string"
	            }
				,

	            {
	                field: "principales_dificultades",
					template:'<div id="item" data-text="#: principales_dificultades#">#: principales_dificultades#</div>',
	                title: "Principales Dificultades",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "conclusiones_recomendaciones",
					template:'<div id="item" data-text="#: conclusiones_recomendaciones#">#: conclusiones_recomendaciones#</div>',
	                title: "Conclusiones_recomendaciones",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "nombre_apellidos_secretatio",
					template:'<div id="item" data-text="#: nombre_apellidos_secretatio#">#: nombre_apellidos_secretatio#</div>',
	                title: "Secretatio",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "nombre_apellidos_jefe",
					template:'<div id="item" data-text="#: nombre_apellidos_jefe#">#: nombre_apellidos_jefe#</div>',
	                title: "Jefe",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_informe",
	                title: "Fecha Informe",
	                width: '8%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	
	            }
				,

	            {
	                field: "cumplimiento_objtvs_propuestos",
					template:'<div id="item" data-text="#: cumplimiento_objtvs_propuestos#">#: cumplimiento_objtvs_propuestos#</div>',
	                title: "Cumplimiento Objtvs Propuestos",
	                width: '5%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "cumplimiento_resultados_programados",
					template:'<div id="item" data-text="#: cumplimiento_resultados_programados#">#: cumplimiento_resultados_programados#</div>',
	                title: "Cumplimiento Resultados Programados",
	                width: '5%',
					type:"string",
					hidden:true
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_informe_ejecucion_programa(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_informe_ejecucion_programa(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_informe_ejecucion_programa').click(function () {
        var c = this.checked;
        $('#gridselection_informe_ejecucion_programa :checkbox').prop('checked',c);
    });
    $('#accionbtn_informe_ejecucion_programasave_exit').click(function()
			    {
					if (validator_informe_ejecucion_programa.validate())
                    {

                      var fd = new FormData(document.querySelector("#informe_ejecucion_programa_form"));                                                                                                                                     
                      var  url="?option=com_informe_ejecucion_programa&task=informe_ejecucion_programa_add"; 
	        			if($('#taskinforme_ejecucion_programa').val()=="update")
							{
                       var olditem=JSON.stringify(Informe_ejecucion_programa.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_informe_ejecucion_programa&task=informe_ejecucion_programa_update";
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
	                					Informe_ejecucion_programa.gridDataSource.read();
                                       $('#informe_ejecucion_programa_form')[0].reset();
            	                					wnd_informe_ejecucion_programa.close();
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
    $('#accionbtn_informe_ejecucion_programasave_new').click(function()
			    {
					if (validator_informe_ejecucion_programa.validate())
                    {

                       var fd = new FormData(document.querySelector("#informe_ejecucion_programa_form")); 
	        			 var url="?option=com_informe_ejecucion_programa&task=informe_ejecucion_programa_add"; 
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
                                       showInsert_informe_ejecucion_programa();           
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

    $('#cancelbtn_informe_ejecucion_programa').click(function(){
        $('#informe_ejecucion_programa_form')[0].reset();
           Informe_ejecucion_programa.gridDataSource.read();                       
        wnd_informe_ejecucion_programa.close();
    });

    $('#addbutton_informe_ejecucion_programa').click(function(){
        showInsert_informe_ejecucion_programa();
    });
    $('#deletebutton_informe_ejecucion_programa').click(function(){
        var checkbox_checked=$('#gridselection_informe_ejecucion_programa .check_row:checked');

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
                      var dataItem=Informe_ejecucion_programa.finditem($(this).attr('id'));
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
                        url:"?option=com_informe_ejecucion_programa&task=informe_ejecucion_programa_delete_one", 
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
                            Informe_ejecucion_programa.gridDataSource.read();
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
