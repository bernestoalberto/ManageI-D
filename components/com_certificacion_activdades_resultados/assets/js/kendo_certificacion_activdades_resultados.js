/** * Created by Ernesto on .
 *Date:1/3/2016  
 *Time:23:17 */
//Creando variables globales
	var validator;
	var Certificacion_activdades_resultados={};
	var message=""


	//Creando los windows Dialogs
	wnd_certificacion_activdades_resultados = $("#certificacion_activdades_resultados_window").kendoWindow({
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
        				if(Certificacion_activdades_resultados.oldElement!=null) {
							
				    			$('#periodo_evaluacion_cert').val(Certificacion_activdades_resultados.oldElement.periodo_evaluacion_cert);
				    			$('#a_r_tres').val(Certificacion_activdades_resultados.oldElement.a_r_tres);
				    			$('#a_r_dos').val(Certificacion_activdades_resultados.oldElement.a_r_dos);
				    			$('#actividades_resultados').val(Certificacion_activdades_resultados.oldElement.actividades_resultados);
				    			$('#cumplimiento_dos').val(Certificacion_activdades_resultados.oldElement.cumplimiento_dos);
				    			$('#cumplimiento_tres').val(Certificacion_activdades_resultados.oldElement.cumplimiento_tres);
				    			$('#cumplimiento').val(Certificacion_activdades_resultados.oldElement.cumplimiento);
				    			$('#gastos_incurridos').val(Certificacion_activdades_resultados.oldElement.gastos_incurridos);
				    			$('#observaciones').val(Certificacion_activdades_resultados.oldElement.observaciones);
				    			$('#nombre_apellidos_presidente').val(Certificacion_activdades_resultados.oldElement.nombre_apellidos_presidente);
				    			$('#fecha_certifica_presidente').val(Certificacion_activdades_resultados.oldElement.fecha_certifica_presidente);
				    			$('#nombre_apellidos_director').val(Certificacion_activdades_resultados.oldElement.nombre_apellidos_director);
				    			$('#fecha_certifica_director').val(Certificacion_activdades_resultados.oldElement.fecha_certifica_director);
				    			if(Certificacion_activdades_resultados.oldElement.id_estado_cumplimiento==-1)
				    			       Certificacion_activdades_resultados.oldElement.id_estado_cumplimiento='';
				    			$('#id_evaluacion').data("kendoDropDownList").value(Certificacion_activdades_resultados.oldElement.id_evaluacion);
				    			$('#id_proyecto_certif').data("kendoDropDownList").value(Certificacion_activdades_resultados.oldElement.id_proyecto_certif);
						}

						else
						{

				    			$('#id_evaluacion').data("kendoDropDownList").value('');
				    			$('#id_programa').data("kendoDropDownList").value('');
				    			$('#id_proyecto_certif').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Certificacion_activdades_resultados.oldElement=null;

$("#gastos_incurridos").kendoNumericTextBox({
	max:5000,
	min:100,
	format: "c",
	decimals: 3,
	step:50



});

		/*Data Source  Estado_cumplimiento*/

		/*Data Source  Evaluacion*/
	var evaluaciondatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_evaluacion&task=evaluacion_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Evaluacion*/
		$("#id_evaluacion").kendoDropDownList({
        dataTextField: "evaluacion",
        dataValueField: "id_evaluacion",
        dataSource: evaluaciondatasource,
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
		$("#id_proyecto_certif").kendoDropDownList({
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
		/*Date Picker  fecha_certifica_presidente*/
		$("#fecha_certifica_presidente").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
	});		
		/*Date Picker  fecha_certifica_director*/
		$("#fecha_certifica_director").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true,
			readonly: true,
			open: function (e) {
			},
			change: function (e) {
			},
			close: function (e) {}
	});		
	Certificacion_activdades_resultados.change = function onChange(arg) {
};
	Certificacion_activdades_resultados.change = function onDataBinding(arg) {
};
	Certificacion_activdades_resultados.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Certificacion_activdades_resultados.kgrid=this;
		}
	Certificacion_activdades_resultados.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Certificacion_activdades_resultados.gridDataSource._data,function(val,index){
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
               dataURI: Certificacion_activdades_resultados.gridDataSource,                                                    
               fileName: "certificacion_activdades_resultados.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_certificacion_activdades_resultados() {
					Certificacion_activdades_resultados.oldElement=null;
					validator_certificacion_activdades_resultados.hideMessages();
		    		$('#certificacion_activdades_resultados_form')[0].reset();
		    		$('#taskcertificacion_activdades_resultados').val('insert');
                   $('#accionbtn_certificacion_activdades_resultadossave_exit').text('Guardar y Salir');         
		    		wnd_certificacion_activdades_resultados.title("Insertar Certificación Activdades Resultados");
                   $('#accionbtncertificacion_activdades_resultados_save_new').show();
					$('#id_proyecto_certif').data('kendoDropDownList').enable();
		    		wnd_certificacion_activdades_resultados.center().open();
				}

//Mostrar Ventanas
				function showUpdate_certificacion_activdades_resultados(e) {
					validator_certificacion_activdades_resultados.hideMessages();
				    $('#certificacion_activdades_resultados_form')[0].reset();
				    var dataItem=Certificacion_activdades_resultados.finditem(e.id);
				    Certificacion_activdades_resultados.oldElement= dataItem;
				    $('#taskcertificacion_activdades_resultados').val('update');
					$('#id_proyecto_certif').data('kendoDropDownList').readonly();
				    wnd_certificacion_activdades_resultados.title("Actualizar Certificación Activdades Resultados");
                   $('#accionbtn_certificacion_activdades_resultadossave_exit').text('Actualizar');                   
                   $('#accionbtn_certificacion_activdades_resultadossave_new').hide();                                 
				    wnd_certificacion_activdades_resultados.center().open();
				}

//Eliminar elemento
function delete_element_certificacion_activdades_resultados(e)
{
    var dataItem=Certificacion_activdades_resultados.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Certificacion_activdades_resultados?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
			$.ajax({
				type: "POST",
				url:"?option=com_certificacion_activdades_resultados&task=certificacion_activdades_resultados_delete_one",
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
					Certificacion_activdades_resultados.gridDataSource.read();
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
	validator_certificacion_activdades_resultados=$("#certificacion_activdades_resultados_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Certificacion_activdades_resultados.oldElement==null)
                    		{
								if(input.is("[id=id_proyecto_certif]")) {
									value = $('#id_proyecto_certif').data('kendoDropDownList').value();
									var anno = $('#annocertif').val();
									var periodo;

									if ($('#etapa11').prop("checked")) {
										periodo = $('#etapa11').val();

									}
									else if ($('#etapa22').prop("checked")) {
										periodo = $('#etapa22').val();

									}
									else if ($('#etapa33').prop("checked") ) {
										periodo = $('#etapa33').val();
									}
									else{
										periodo = $('#etapa44').val();
								}
									while (i < Certificacion_activdades_resultados.gridDataSource._data.length) {
										var elem = Certificacion_activdades_resultados.gridDataSource._data[i];
										if (elem.id_proyecto==value&& elem.periodo_evaluacion_cert== periodo && elem.anno==anno)
										{
											found=true;
											message="Existe una certificación para esta etapa, año y proyecto";
											i=Certificacion_activdades_resultados.gridDataSource._data.length;
											return $('#id_proyecto_certif').data('kendoDropDownList').value('');
										}
										i++;
									}
								}
								if(input.is("[id=actividades_resultados]")) {
									var value = $('#actividades_resultados').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las actividades_resultados ingresadas no debe exceder los 100 caracteres";
										return $('#actividades_resultados').val('');
									}
								}
								if(input.is("[id=a_r_dos]")) {
									var value = $('#a_r_dos').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las a_r_dos ingresadas no debe exceder los 100 caracteres";
										return $('#a_r_dos').val('');
									}
								}
								if(input.is("[id=a_r_tres]")) {
									var value = $('#a_r_tres').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las a_r_tres ingresadas no debe exceder los 100 caracteres";
										return $('#a_r_tres').val('');
									}
								}
								if(input.is("[id=observaciones]")) {
									var value = $('#observaciones').val();
									var size = value.length;
								if(size > 100){
										found=true;
										message="Las observaciones ingresadas no debe exceder los 100 caracteres";
										return $('#observaciones').val('');
									}
								}
								if(input.is("[id=nombre_apellidos_presidente]")) {
									var value = $('#nombre_apellidos_presidente').val();
									var size = value.length;
								if(size > 40){
										found=true;
										message="Los nombre_apellidos_presidente ingresadas no debe exceder los 40 caracteres";
										return $('#nombre_apellidos_presidente').val('');
									}
								}
								if(input.is("[id=nombre_apellidos_director]")) {
									var value = $('#nombre_apellidos_director').val();
									var size = value.length;
								if(size > 40){
										found=true;
										message="Los nombre_apellidos_director ingresadas no debe exceder los 40 caracteres";
										return $('#nombre_apellidos_director').val('');
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
	Certificacion_activdades_resultados.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_certificacion_activdades_resultados&task=certificacion_activdades_resultados_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_certificacion:{type:"number"},
						periodo_evaluacion_cert:{type:"string"},
						actividades_resultados:{type:"string"},
						actividades_r_tres:{type:"string"},
						actividades_r_dos:{type:"string"},
						cumplimiento:{type:"string"},
						cumplimiento_dos:{type:"string"},
						cumplimiento_tres:{type:"string"},
					    cantidad_anticipa:{type:"number"},
						gastos_incurridos:{type:"number"},
						observaciones:{type:"string"},
						nombre_apellidos_presidente:{type:"string"},
						fecha_certifica_presidente:{type:"date"},
						nombre_apellidos_director:{type:"string"},
						fecha_certifica_director:{type:"date"},
						id_programa:{type:"number"},
						programa:{type:"string"},
						id_evaluacion:{type:"number"},
					    evaluacion:{type:"string"},
						id_anticipo:{type:"number"},
						anticipo:{type:"number"},
						id_proyecto_certif:{type:"number"},
						proyecto:{type:"string"}



				}
			}
 		},
        pageSize: 12
    });
      $("#gridselection_certificacion_activdades_resultados").kendoGrid({
	        dataSource: Certificacion_activdades_resultados.gridDataSource,
	        height: 500,
		  columnMenu: true,
		  filterable: {
			  mode: "row"
		  },

		  detailTemplate: kendo.template($("#template_certify").html()),
			 groupable:true,
	        sortable: true,
	        change: Certificacion_activdades_resultados.change,
			resizable: true,
	        dataBound: Certificacion_activdades_resultados.dataBound,
	        dataBinding: Certificacion_activdades_resultados.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_certificacion_activdades_resultados' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_certificacion",
					template:'<div id="item" data-text="#: id_certificacion#">#: id_certificacion#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "periodo_evaluacion_cert",
					template:'<div id="item" data-text="#: periodo_evaluacion_cert#">#: periodo_evaluacion_cert#</div>',
	                title: "Periodo ",
	                width: '7%',
					type:"string"
	            }
				,

	            {
	                field: "actividades_resultados",
					template:'<div id="item" data-text="#: actividades_resultados#">#: actividades_resultados#</div>',
	                title: "Actividades Resultados",
	                width: '15%',
					type:"string"
	            }
				,
				{
					field: "cumplimiento",
					template:'<div id="item" data-text="#: cumplimiento#">#: cumplimiento#</div>',
					title: "Cumplimiento",
					width: '10%',
					type:"string"
				}

				,
				{
	                field: "a_r_dos",
					template:'<div id="item" data-text="#: a_r_dos#">#: a_r_dos#</div>',
	                title: "Actividades_resultados_dos",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,
				{
					field: "cumplimiento_dos",
					template:'<div id="item" data-text="#: cumplimiento_dos#">#: cumplimiento_dos#</div>',
					title: "Cumplimiento",
					width: '10%',
					type:"string",
					hidden:true
				}

				,
				{
	                field: "a_r_tres",
					template:'<div id="item" data-text="#: a_r_tres#">#: a_r_tres#</div>',
	                title: "Actividades_resultados_tres",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "cumplimiento_tres",
					template:'<div id="item" data-text="#: cumplimiento_tres#">#: cumplimiento_tres#</div>',
	                title: "Cumplimiento",
	                width: '10%',
					type:"string",
					hidden:true
	            }

				,
				{
					field: "cantidad_anticipa",
					title: "anticipo",
					template:'<div id="item" data-text="#: cantidad_anticipa#">#: cantidad_anticipa#</div>',
					width: '2%',
					type:"number",
					hidden:true
				},

	            {
	                field: "gastos_incurridos",
					template:'<div id="item" data-text="#: gastos_incurridos#">#: gastos_incurridos#</div>',
	                title: "Gastos",
	                width: '8%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "observaciones",
					template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
	                title: "Observaciones",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "nombre_apellidos_presidente",
					template:'<div id="item" data-text="#: nombre_apellidos_presidente#">#: nombre_apellidos_presidente#</div>',
	                title: "presidente",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_certifica_presidente",
	                title: "Fecha_certifica_presidente",
	                width: '8%',
					type:"date",
					format:"{0:dd-MM-yyyy}",
					hidden:true

				}
				,

	            {
	                field: "nombre_apellidos_director",
					template:'<div id="item" data-text="#: nombre_apellidos_director#">#: nombre_apellidos_director#</div>',
	                title: "Nombre_apellidos_director",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_certifica_director",
	                title: "Fecha_certifica_director",
	                width: '8%',
					type:"date",
					format:"{0:dd-MM-yyyy}",
					hidden:true
				}
				,

	            {
	                field: "id_evaluacion",
	                title: "ID",
					template:'<div id="item" data-text="#: id_evaluacion#">#: id_evaluacion#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,
	            {
	                field: "evaluacion",
	                title: "Evaluación",
					template:'<div id="item" data-text="#: evaluacion#">#: evaluacion#</div>',
	                width: '8%',
					type:"string"
				}
			,

	            {
	                field: "id_anticipo",
	                title: "ID",
					template:'<div id="item" data-text="#: id_anticipo#">#: id_anticipo#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}

			,       {
	                field: "id_programa",
	                title: "ID",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}

			,        {
	                field: "programa",
	                title: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
	                width: '5%',
					type:"string",
					hidden:true
				}

			,       {
	                field: "id_proyecto_certif",
	                title: "ID",
					template:'<div id="item" data-text="#: id_proyecto_certif#">#: id_proyecto_certif#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}

			,      {
	                field: "proyecto",
	                title: "Proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
	                width: '8%',
					type:"string"
				}

			,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_certificacion_activdades_resultados(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_certificacion_activdades_resultados(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });


/*Acciones de los botones*/

    $('#all_check_certificacion_activdades_resultados').click(function () {
        var c = this.checked;
        $('#gridselection_certificacion_activdades_resultados :checkbox').prop('checked',c);
    });
    $('#accionbtn_certificacion_activdades_resultadossave_exit').click(function()
			    {
					if (validator_certificacion_activdades_resultados.validate())
                    {

                      var fd = new FormData(document.querySelector("#certificacion_activdades_resultados_form"));                                                                                                                                     
                      var  url="?option=com_certificacion_activdades_resultados&task=certificacion_activdades_resultados_add"; 
	        			if($('#taskcertificacion_activdades_resultados').val()=="update")
							{
                       var olditem=JSON.stringify(Certificacion_activdades_resultados.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_certificacion_activdades_resultados&task=certificacion_activdades_resultados_update";
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
	                					Certificacion_activdades_resultados.gridDataSource.read();
                                       $('#certificacion_activdades_resultados_form')[0].reset();
            	                					wnd_certificacion_activdades_resultados.close();
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
    $('#accionbtn_certificacion_activdades_resultadossave_new').click(function()
			    {
					if (validator_certificacion_activdades_resultados.validate())
                    {

                       var fd = new FormData(document.querySelector("#certificacion_activdades_resultados_form")); 
	        			 var url="?option=com_certificacion_activdades_resultados&task=certificacion_activdades_resultados_add"; 
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
                                       showInsert_certificacion_activdades_resultados();           
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

    $('#cancelbtn_certificacion_activdades_resultados').click(function(){
        $('#certificacion_activdades_resultados_form')[0].reset();
           Certificacion_activdades_resultados.gridDataSource.read();                       
        wnd_certificacion_activdades_resultados.close();
    });

    $('#addbutton_certificacion_activdades_resultados').click(function(){
        showInsert_certificacion_activdades_resultados();
    });
    $('#deletebutton_certificacion_activdades_resultados').click(function(){
        var checkbox_checked=$('#gridselection_certificacion_activdades_resultados .check_row:checked');

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
                      var dataItem=Certificacion_activdades_resultados.finditem($(this).attr('id'));
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
                        url:"?option=com_certificacion_activdades_resultados&task=certificacion_activdades_resultados_delete_one", 
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
                            Certificacion_activdades_resultados.gridDataSource.read();
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
