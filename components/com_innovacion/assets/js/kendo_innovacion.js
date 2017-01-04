/** * Created by Ernesto on .
 *Date:12/27/2015  
 *Time:0:49 */
//Creando variables globales
	var validator;
	var Innovacion={};
	var message=""


	//Creando los windows Dialogs
	wnd_innovacion = $("#innovacion_window").kendoWindow({
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
        				if(Innovacion.oldElement!=null) {
							
				    			$('#problema_resolver').val(Innovacion.oldElement.problema_resolver);
				    			$('#fundamentacion_tecnologica').val(Innovacion.oldElement.fundamentacion_tecnologica);
				    			$('#fundamentacion_mercado').val(Innovacion.oldElement.fundamentacion_mercado);
				    			$('#aspectos_tecncios').val(Innovacion.oldElement.aspectos_tecncios);
				    			$('#aspectos_eco_mercado').val(Innovacion.oldElement.aspectos_eco_mercado);
				    			$('#capacidad_asimilacion_desarrollo').val(Innovacion.oldElement.capacidad_asimilacion_desarrollo);
				    			$('#energia').val(Innovacion.oldElement.energia);
				    			$('#mat_primas_recursos_naturales').val(Innovacion.oldElement.mat_primas_recursos_naturales);
				    			$('#calidad').val(Innovacion.oldElement.calidad);
				    			$('#medio_ambiente').val(Innovacion.oldElement.medio_ambiente);
				    			$('#propiedad_intelectual').val(Innovacion.oldElement.propiedad_intelectual);
				    			$('#tecnlogias_constructivas').val(Innovacion.oldElement.tecnlogias_constructivas);
				    			$('#analisis_sostenibilidad_innovacion').val(Innovacion.oldElement.analisis_sostenibilidad_innovacion);
				    			$('#otros_anexos').val(Innovacion.oldElement.otros_anexos);
				    			$('#id_proyecto_innovacion').data("kendoDropDownList").value(Innovacion.oldElement.id_proyecto);
						}

						else
						{
				    			$('#id_proyecto_innovacion').data("kendoDropDownList").value('');

						}
			    }}).data("kendoWindow");



	//Definir controladora
	Innovacion.oldElement=null;
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
		$("#id_proyecto_innovacion").kendoDropDownList({
        dataTextField: "nombre_proyecto",
        dataValueField: "id_proyecto",
        dataSource: proyectodatasource,
        filter: "contains",
		 open: function(e) {
           valid = true;
        },
		 change:function(e){

        },
        select: function(e){
        //    valid = true;
        },
        close: function(e){
            // if no valid selection - clear input
           if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });


	Innovacion.change = function onChange(arg) {
};
	Innovacion.change = function onDataBinding(arg) {
};
	Innovacion.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Innovacion.kgrid=this;
		}
	Innovacion.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Innovacion.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}





				function showInsert_innovacion() {
					Innovacion.oldElement=null;
					validator_innovacion.hideMessages();
		    		$('#innovacion_form')[0].reset();
		    		$('#taskinnovacion').val('insert');
                   $('#accionbtn_innovacionsave_exit').text('Guardar y Salir');
					//$('#id_proyecto').data('kendoDropDownList').enable();
		    		wnd_innovacion.title("Insertar Proyecto de Innovación");
                   $('#accionbtninnovacion_save_new').show();
		    		wnd_innovacion.center().open();
				}

//Mostrar Ventanas
				function showUpdate_innovacion(e) {
					validator_innovacion.hideMessages();
				    $('#innovacion_form')[0].reset();
				    var dataItem=Innovacion.finditem(e.id);
				    Innovacion.oldElement= dataItem;
				    $('#taskinnovacion').val('update');
				//	$('#id_proyecto').data('kendoDropDownList').readonly();
				    wnd_innovacion.title("Actualizar Proyecto de Innovación");
                   $('#accionbtn_innovacionsave_exit').text('Actualizar');                   
                   $('#accionbtn_innovacionsave_new').hide();                                 
				    wnd_innovacion.center().open();
				}

//Eliminar elemento
function delete_element_innovacion(e)
{
    var dataItem=Innovacion.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Innovacion?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_innovacion&task=innovacion_delete_one",
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
                    Innovacion.gridDataSource.read();
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
	validator_innovacion=$("#innovacion_form").kendoValidator({
			rules:{
					unique: function(input) {
						var found = false;
						var value = input.val();
						var i = 0;
						if (Innovacion.oldElement == null) {

							if (input.is("[id=id_proyecto_innovacion]")) {
								value = $('#id_proyecto_innovacion').data('kendoDropDownList').value();

								while (i < Innovacion.gridDataSource._data.length) {
									var elem = Innovacion.gridDataSource._data[i];
									if (elem.id_proyecto == value) {
										found = true;
										message = "El  proyecto de innovacion  seleccionado ya existe";
										i = Innovacion.gridDataSource._data.length;
										return $('#id_proyecto_innovacion').data('kendoDropDownList').value('');
									}
									i++;
								}
							}

							if (input.is("[id=otros_anexos]")) {

								value = $('#otros_anexos').val();
								if (value.size > 2273856) {
									found = true;
									message = "El archivo debe ser menor de 2.3 Mb";
									return $('#otros_anexos').val('');

								}
							}
							if (input.is("[id=problema_resolver]")) {
								var value = $('#problema_resolver').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "El problema_resolver ingresada no debe exceder los 100 caracteres";
									return $('#problema_resolver').val('');
								}
							}
							if (input.is("[id=fundamentacion_tecnologica]")) {
								var value = $('#fundamentacion_tecnologica').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La fundamentacion_tecnologica ingresada no debe exceder los 100 caracteres";
									return $('#fundamentacion_tecnologica').val('');
								}
							}
							if (input.is("[id=fundamentacion_mercado]")) {
								var value = $('#fundamentacion_mercado').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La fundamentacion_mercado ingresada no debe exceder los 100 caracteres";
									return $('#fundamentacion_mercado').val('');
								}
							}
							if (input.is("[id=aspectos_tecncios]")) {
								var value = $('#aspectos_tecncios').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La aspectos_tecncios ingresada no debe exceder los 100 caracteres";
									return $('#aspectos_tecncios').val('');
								}
							}
							if (input.is("[id=aspectos_eco_mercado]")) {
								var value = $('#aspectos_eco_mercado').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "Los aspectos_eco_mercado ingresada no debe exceder los 100 caracteres";
									return $('#aspectos_eco_mercado').val('');
								}
							}
							if (input.is("[id=capacidad_asimilacion_desarrollo]")) {
								var value = $('#capacidad_asimilacion_desarrollo').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La capacidad_asimilacion_desarrollo ingresada no debe exceder los 100 caracteres";
									return $('#capacidad_asimilacion_desarrollo').val('');
								}
							}
							if (input.is("[id=energia]")) {
								var value = $('#energia').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La energia ingresada no debe exceder los 100 caracteres";
									return $('#energia').val('');
								}
							}
							if (input.is("[id=mat_primas_recursos_naturales]")) {
								var value = $('#mat_primas_recursos_naturales').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La mat_primas_recursos_naturales ingresada no debe exceder los 100 caracteres";
									return $('#mat_primas_recursos_naturales').val('');
								}
							}
							if (input.is("[id=calidad]")) {
								var value = $('#calidad').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La calidad ingresada no debe exceder los 100 caracteres";
									return $('#calidad').val('');
								}
							}
							if (input.is("[id=medio_ambiente]")) {
								var value = $('#medio_ambiente').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "El medio_ambiente ingresada no debe exceder los 100 caracteres";
									return $('#medio_ambiente').val('');
								}
							}
							if (input.is("[id=propiedad_intelectual]")) {
								var value = $('#propiedad_intelectual').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "La propiedad_intelectual ingresada no debe exceder los 100 caracteres";
									return $('#propiedad_intelectual').val('');
								}
							}
							if (input.is("[id=tecnlogias_constructivas]")) {
								var value = $('#tecnlogias_constructivas').val();
								var size = value.length;

								if (size > 100) {
									found = true;
									message = "Las tecnlogias_constructivas ingresada no debe exceder los 100 caracteres";
									return $('#tecnlogias_constructivas').val('');
								}
							}
							if (input.is("[id=analisis_sostenibilidad_innovacion]")) {
								var value = $('#analisis_sostenibilidad_innovacion').val();
								var size = value.length;

								if (size > 250) {
									found = true;
									message = "El analisis_sostenibilidad_innovacion ingresada no debe exceder los 250 caracteres";
									return $('#analisis_sostenibilidad_innovacion').val('');
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
	Innovacion.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_innovacion&task=innovacion_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },
       schema:{
			model:{
				fields:{
						problema_resolver:{type:"string"},
					fundamentacion_tecnologica:{type:"string"},
						fundamentacion_mercado:{type:"string"},
						aspectos_tecncios:{type:"string"},
						aspectos_eco_mercado:{type:"string"},
						capacidad_asimilacion_desarrollo:{type:"string"},
						energia:{type:"string"},
						mat_primas_recursos_naturales:{type:"string"},
						calidad:{type:"string"},
						medio_ambiente:{type:"string"},
						propiedad_intelectual:{type:"string"},
						tecnlogias_constructivas:{type:"string"},
						analisis_sostenibilidad_innovacion:{type:"string"},
						otros_anexos:{type:"string"},
						id_proyecto:{type:"number"},
						id_persona:{type:"number"}


				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_innovacion").kendoGrid({
	        dataSource: Innovacion.gridDataSource,
	        height: 600,
		    width:'200%',
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 detailTemplate: kendo.template($("#template_innovacion").html()),
			 groupable:true,
	        sortable: true,
	        change: Innovacion.change,
			resizable: true,
	        dataBound: Innovacion.dataBound,
	        dataBinding: Innovacion.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_innovacion' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_proyecto",
					template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
	                title: "id",
	                width: '3%',
					type:"number",
					hidden:true
	            }
				,
				{
	                field: "proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
	                title: "Proyecto",
	                width: '8%',
					type:"string"
	            }
				,
				{
					field: "id_persona",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
					title: "id",
					width: '3%',
					type:"number",
					hidden:true
				}
				,

				{
	                field: "jefeproyecto",
					template:'<div id="item" data-text="#: jefeproyecto#">#: jefeproyecto#</div>',
	                title: "Jefe Proyecto",
	                width: '14%',
					type:"string"
	            }
				,
 {
	                field: "problema_resolver",
					template:'<div id="item" data-text="#: problema_resolver#">#: problema_resolver#</div>',
	                title: "Problema Resolver",
	                width: '15%',
					type:"string",
	                hidden:true
	            }
				,

	            {
	                field: "fundamentacion_tecnologica",
					template:'<div id="item" data-text="#: fundamentacion_tecnologica#">#: fundamentacion_tecnologica#</div>',
	                title: "Fundamentación Tecnológica",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fundamentacion_mercado",
					template:'<div id="item" data-text="#: fundamentacion_mercado#">#: fundamentacion_mercado#</div>',
	                title: "Fundamentación Mercado",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "aspectos_tecncios",
					template:'<div id="item" data-text="#: aspectos_tecncios#">#: aspectos_tecncios#</div>',
	                title: "Aspectos Técnicos",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "aspectos_eco_mercado",
					template:'<div id="item" data-text="#: aspectos_eco_mercado#">#: aspectos_eco_mercado#</div>',
	                title: "Aspectos Eco Mercado",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "capacidad_asimilacion_desarrollo",
					template:'<div id="item" data-text="#: capacidad_asimilacion_desarrollo#">#: capacidad_asimilacion_desarrollo#</div>',
	                title: "Capacidad Asimilación Desarrollo",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "energia",
					template:'<div id="item" data-text="#: energia#">#: energia#</div>',
	                title: "Energia",
	                width: '8%',
					type:"string"
	            }
				,

	            {
	                field: "mat_primas_recursos_naturales",
					template:'<div id="item" data-text="#: mat_primas_recursos_naturales#">#: mat_primas_recursos_naturales#</div>',
	                title: "Mat.Primas",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "calidad",
					template:'<div id="item" data-text="#: calidad#">#: calidad#</div>',
	                title: "Calidad",
	                width: '8%',
					type:"string"
	            }
				,

	            {
	                field: "medio_ambiente",
					template:'<div id="item" data-text="#: medio_ambiente#">#: medio_ambiente#</div>',
	                title: "Medio Ambiente",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "propiedad_intelectual",
					template:'<div id="item" data-text="#: propiedad_intelectual#">#: propiedad_intelectual#</div>',
	                title: "Propiedad Intelectual",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "tecnlogias_constructivas",
					template:'<div id="item" data-text="#: tecnlogias_constructivas#">#: tecnlogias_constructivas#</div>',
	                title: "Tecnlogías Constructivas",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "analisis_sostenibilidad_innovacion",
					template:'<div id="item" data-text="#: analisis_sostenibilidad_innovacion#">#: analisis_sostenibilidad_innovacion#</div>',
	                title: "Analisis Sostenibilidad Innovación",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "otros_anexos",
					template:'<div id="item" data-text="#: otros_anexos#">#: otros_anexos#</div>',
	                title: "Otros Anexos",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_innovacion(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_innovacion(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_innovacion').click(function () {
        var c = this.checked;
        $('#gridselection_innovacion :checkbox').prop('checked',c);
    });
    $('#accionbtn_innovacionsave_exit').click(function()
			    {
					if (validator_innovacion.validate())
                    {

                      var fd = new FormData(document.querySelector("#innovacion_form"));                                                                                                                                     
                      var  url="?option=com_innovacion&task=innovacion_add"; 
	        			if($('#taskinnovacion').val()=="update")
							{
                       var olditem=JSON.stringify(Innovacion.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_innovacion&task=innovacion_update";
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
	                					Innovacion.gridDataSource.read();
                                       $('#innovacion_form')[0].reset();
            	                					wnd_innovacion.close();
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
    $('#accionbtn_innovacionsave_new').click(function()
			    {
					if (validator_innovacion.validate())
                    {

                       var fd = new FormData(document.querySelector("#innovacion_form")); 
	        			 var url="?option=com_innovacion&task=innovacion_add"; 
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
                                       showInsert_innovacion();           
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

    $('#cancelbtn_innovacion').click(function(){
        $('#innovacion_form')[0].reset();
           Innovacion.gridDataSource.read();                       
        wnd_innovacion.close();
    });

    $('#addbutton_innovacion').click(function(){
        showInsert_innovacion();
    });
    $('#deletebutton_innovacion').click(function(){
        var checkbox_checked=$('#gridselection_innovacion .check_row:checked');

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
                      var dataItem=Innovacion.finditem($(this).attr('id'));
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
						url:"?option=com_innovacion&task=innovacion_delete_one",
						data:{
							array:JSON.stringify(array)
						},
						success:function(response){
							if(response.success==true) {
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
							Innovacion.gridDataSource.read();
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
