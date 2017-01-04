/** * Created by Ernesto on .
 *Date:1/6/2016  
 *Time:10:15 */
//Creando variables globales
	var validator;
	var Dictamen_grupo_expertos_inf_etapa={};
	var message=""


	//Creando los windows Dialogs
	wnd_dictamen_grupo_expertos_inf_etapa = $("#dictamen_grupo_expertos_inf_etapa_window").kendoWindow({
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
        				if(Dictamen_grupo_expertos_inf_etapa.oldElement!=null) {
							
				    			$('#id_informe_etap_gexp').data("kendoDropDownList").value(Dictamen_grupo_expertos_inf_etapa.oldElement.id_informe_etap_gexp);
				    			$('#id_proyecto_gexp').data("kendoDropDownList").value(Dictamen_grupo_expertos_inf_etapa.oldElement.id_proyecto_gexp);
				    			$('#evaluacion_objetivos').data("kendoDropDownList").value(Dictamen_grupo_expertos_inf_etapa.oldElement.evaluacion_objetivos);
				    			$('#evaluacion_resultados').data("kendoDropDownList").value(Dictamen_grupo_expertos_inf_etapa.oldElement.evaluacion_resultados);
				    			$('#evaluacion_actividades').data("kendoDropDownList").value(Dictamen_grupo_expertos_inf_etapa.oldElement.evaluacion_actividades);
				    			$('#observaciones').val(Dictamen_grupo_expertos_inf_etapa.oldElement.observaciones);
				    			$('#conclusiones').val(Dictamen_grupo_expertos_inf_etapa.oldElement.conclusiones);
				    			$('#recomendaciones').val(Dictamen_grupo_expertos_inf_etapa.oldElement.recomendaciones);
				    			$('#nombre_apellidos_miembroGEP').val(Dictamen_grupo_expertos_inf_etapa.oldElement.nombre_apellidos_miembroGEP);
				    			$('#fecha_dictamen').val(Dictamen_grupo_expertos_inf_etapa.oldElement.fecha_dictamen);
						}

						else
						{
							$('#evaluacion_objetivos').data("kendoDropDownList").value('');
							$('#evaluacion_resultados').data("kendoDropDownList").value('');
							$('#evaluacion_actividades').data("kendoDropDownList").value('');
							$('#id_informe_etap_gexp').data("kendoDropDownList").value('');
							$('#id_proyecto_gexp').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Dictamen_grupo_expertos_inf_etapa.oldElement=null;
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
		$("#evaluacion_objetivos").kendoDropDownList({
        dataTextField: "evaluacion",
        dataValueField: "id_evaluacion",
        dataSource: evaluaciondatasource,
        filter: "contains",
		 open: function(e) {
            //valid = false;
        },
		 change:function(e){
        },
        select: function(e){
           // valid = true;
        },
        close: function(e){
            // if no valid selection - clear input
            //if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
$("#evaluacion_resultados").kendoDropDownList({
        dataTextField: "evaluacion",
        dataValueField: "id_evaluacion",
        dataSource: evaluaciondatasource,
        filter: "contains",
		 open: function(e) {
            //valid = false;
        },
		 change:function(e){
        },
        select: function(e){
           // valid = true;
        },
        close: function(e){
            // if no valid selection - clear input
            //if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
$("#evaluacion_actividades").kendoDropDownList({
        dataTextField: "evaluacion",
        dataValueField: "id_evaluacion",
        dataSource: evaluaciondatasource,
        filter: "contains",
		 open: function(e) {
            //valid = false;
        },
		 change:function(e){
        },
        select: function(e){
           // valid = true;
        },
        close: function(e){
            // if no valid selection - clear input
            //if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
		/*Data Source  Informe_etapa*/
	var informe_etapadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_informe_etapa&task=informe_etapa_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Informe_etapa*/
		$("#id_informe_etap_gexp").kendoDropDownList({
        dataTextField: "etapa",
        dataValueField: "id_informe_etapa",
        dataSource: informe_etapadatasource,
        filter: "contains",
		 open: function(e) {
            valid = false;
        },
		 change:function(e){
            	if (!valid) this.value('');
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
$("#id_proyecto_gexp").kendoDropDownList({
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
		/*Date Picker  fecha_dictamen*/
		$("#fecha_dictamen").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
	});		
	Dictamen_grupo_expertos_inf_etapa.change = function onChange(arg) {
};
	Dictamen_grupo_expertos_inf_etapa.change = function onDataBinding(arg) {
};
	Dictamen_grupo_expertos_inf_etapa.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Dictamen_grupo_expertos_inf_etapa.kgrid=this;
		}
	Dictamen_grupo_expertos_inf_etapa.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Dictamen_grupo_expertos_inf_etapa.gridDataSource._data,function(val,index){
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
               dataURI: Dictamen_grupo_expertos_inf_etapa.gridDataSource,                                                    
               fileName: "dictamen_grupo_expertos_inf_etapa.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_dictamen_grupo_expertos_inf_etapa() {
					Dictamen_grupo_expertos_inf_etapa.oldElement=null;
					validator_dictamen_grupo_expertos_inf_etapa.hideMessages();
		    		$('#dictamen_grupo_expertos_inf_etapa_form')[0].reset();
					$('#id_informe_etapa').data("kendoDropDownList").enable();
					$('#id_proyecto_gexp').data("kendoDropDownList").enable();
		    		$('#taskdictamen_grupo_expertos_inf_etapa').val('insert');
                   $('#accionbtn_dictamen_grupo_expertos_inf_etapasave_exit').text('Guardar y Salir');         
		    		wnd_dictamen_grupo_expertos_inf_etapa.title("Crear Dictámen del Grupo de Expertos de Informe de Etapa");
                   $('#accionbtndictamen_grupo_expertos_inf_etapa_save_new').show();
		    		wnd_dictamen_grupo_expertos_inf_etapa.center().open();
				}

//Mostrar Ventanas
				function showUpdate_dictamen_grupo_expertos_inf_etapa(e) {
					validator_dictamen_grupo_expertos_inf_etapa.hideMessages();
				    $('#dictamen_grupo_expertos_inf_etapa_form')[0].reset();
				    var dataItem=Dictamen_grupo_expertos_inf_etapa.finditem(e.id);
					$('#id_informe_etapa').data("kendoDropDownList").readonly();
					$('#id_proyecto_gexp').data("kendoDropDownList").readonly();
				    Dictamen_grupo_expertos_inf_etapa.oldElement= dataItem;
				    $('#taskdictamen_grupo_expertos_inf_etapa').val('update');
				    wnd_dictamen_grupo_expertos_inf_etapa.title("Actualizar Dictámen del Grupo de Expertos de Informe de Etapa");
                   $('#accionbtn_dictamen_grupo_expertos_inf_etapasave_exit').text('Actualizar');                   
                   $('#accionbtn_dictamen_grupo_expertos_inf_etapasave_new').hide();                                 
				    wnd_dictamen_grupo_expertos_inf_etapa.center().open();
				}

//Eliminar elemento
function delete_element_dictamen_grupo_expertos_inf_etapa(e)
{
    var dataItem=Dictamen_grupo_expertos_inf_etapa.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Dictamen_grupo_expertos_inf_etapa?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_dictamen_grupo_expertos_inf_etapa&task=dictamen_grupo_expertos_inf_etapa_delete_one",
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
                    Dictamen_grupo_expertos_inf_etapa.gridDataSource.read();
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
	validator_dictamen_grupo_expertos_inf_etapa=$("#dictamen_grupo_expertos_inf_etapa_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Dictamen_grupo_expertos_inf_etapa.oldElement==null)
                    		{

							/*	if(input.is("[id=id_informe_etapa]")) {
								 	value=$('#id_informe_etapa').data('kendoDropDownList').value();

								 	while (i < Dictamen_grupo_expertos_inf_etapa.gridDataSource._data.length) {
                                		var elem=Dictamen_grupo_expertos_inf_etapa.gridDataSource._data[i];
                                	 if(elem.id_informe_etapa()==value)
                                		{
                                    		found=true;
											message="Existe un dictamen_grupo_expertos_inf_etapa con este id_informe_etapa";
                                    		i=Dictamen_grupo_expertos_inf_etapa.gridDataSource._data.length;
											return $('#id_informe_etapa').data('kendoDropDownList').value('');
		                                }
                                		i++;
                            		}
								}*/
								if(input.is("[id=observaciones]")) {
									var value = $('#observaciones').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las observaciones ingresadas no debe exceder los 100 caracteres";
										return $('#observaciones').val('');
									}
								}	if(input.is("[id=recomendaciones]")) {
									var value = $('#recomendaciones').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las recomendaciones ingresadas no debe exceder los 100 caracteres";
										return $('#recomendaciones').val('');
									}
								}
								if(input.is("[id=nombre_apellidos_miembroGEP]")) {
									var value = $('#nombre_apellidos_miembroGEP').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El nombre_apellidos_miembroGEP ingresadas no debe exceder los 100 caracteres";
										return $('#nombre_apellidos_miembroGEP').val('');
									}
								}
								if(input.is("[id=id_proyecto_gexp]")) {
									value = $('#id_proyecto_gexp').data('kendoDropDownList').text();
									var anno = $('#annodge').val();
									var etapa =  $('#id_informe_etap_gexp').data('kendoDropDownList').value();

									while (i < Dictamen_grupo_expertos_inf_etapa.gridDataSource._data.length) {
										var elem = Dictamen_grupo_expertos_inf_etapa.gridDataSource._data[i];
										if (elem.proyecto==value&& elem.id_informe_etapa== etapa && elem.anno==anno)
										{
											found=true;
											message="Existe un Dictámen del Grupo de Expertos para esta etapa, año y proyecto";
											i=Dictamen_grupo_expertos_inf_etapa.gridDataSource._data.length;
											return $('#id_proyecto_gexp').data('kendoDropDownList').value('');
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
	Dictamen_grupo_expertos_inf_etapa.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_dictamen_grupo_expertos_inf_etapa&task=dictamen_grupo_expertos_inf_etapa_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
					id_dictamen_grup_exp:{type:"number"},
					id_informe_etapa:{type:"number"},
					etapa:{type:"string"},
					anno:{type:"number"},
					programa:{type:"string"},
					proyecto:{type:"string"},
					codigo:{type:"number"},
					entidad:{type:"string"},
					id_evaluacion_objetivos:{type:"number"},
					evaluacion_objetivos:{type:"string"},
					id_evaluacion_resultados:{type:"number"},
					evaluacion_resultados:{type:"string"},
					id_evaluacion_actividades:{type:"number"},
					evaluacion_actividades:{type:"string"},
					observaciones:{type:"string"},
					anticipo:{type:"number"},
					gastos:{type:"number"},
					conclusiones:{type:"string"},
					recomendaciones:{type:"string"},
					nombre_apellidos_miembroGEP:{type:"string"},
					fecha_dictamen:{type:"date"}
				}
			}
 		},
        pageSize: 12
    });
	  $("#gridselection_dictamen_grupo_expertos_inf_etapa").kendoGrid({
	        dataSource: Dictamen_grupo_expertos_inf_etapa.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		  detailTemplate: kendo.template($("#template_gep").html()),
	        sortable: true,
			 groupable:true,
	        change: Dictamen_grupo_expertos_inf_etapa.change,
			resizable: true,
	        dataBound: Dictamen_grupo_expertos_inf_etapa.dataBound,
	        dataBinding: Dictamen_grupo_expertos_inf_etapa.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_dictamen_grupo_expertos_inf_etapa' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_dictamen_grup_exp",
					template:'<div id="item" data-text="#: id_dictamen_grup_exp#">#: id_dictamen_grup_exp#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "id_informe_etapa",
	                title: "ID",
					template:'<div id="item" data-text="#: id_informe_etapa#">#: id_informe_etapa#</div>',
	                width: '5%',
					type:"number",
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
					field: "anno",
					template:'<div id="item" data-text="#: anno#">#: anno#</div>',
					title: "Año",
					width: '10%',
					type:"number"
				}
				,

					{
					field: "programa",
					title: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
					width: '10%',
					type:"string",
						hidden:true
				}
				,

				{
					field: "proyecto",
					title: "Proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
					width: '15%',
					type:"string"
				}
				,
				   {
	                field: "codigo",
	                title: "codigo",
					template:'<div id="item" data-text="#: codigo#">#: codigo#</div>',
	                width: '6%',
					type:"number",
					   hidden:true
				}
			,

				{
	                field: "entidad",
	                title: "Entidad",
					template:'<div id="item" data-text="#: entidad#">#: entidad#</div>',
	                width: '15%',
					type:"string"
				}
			,



	            {
	                field: "id_evaluacion_objetivos",
					template:'<div id="item" data-text="#: id_evaluacion_objetivos#">#: id_evaluacion_objetivos#</div>',
	                title: "id_evaluacion_objetivos",
	                width: '4%',
					type:"number",
					hidden:true
	            }
				,
				{
	                field: "evaluacion_objetivos",
					template:'<div id="item" data-text="#: evaluacion_objetivos#">#: evaluacion_objetivos#</div>',
	                title: "Evaluacion_objetivos",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,
				{
					field: "id_evaluacion_resultados",
					template:'<div id="item" data-text="#: id_evaluacion_resultados#">#: id_evaluacion_resultados#</div>',
					title: "id_evaluacion_resultados",
					width: '4%',
					type:"number",
					hidden:true
				}
				,

	            {
	                field: "evaluacion_resultados",
					template:'<div id="item" data-text="#: evaluacion_resultados#">#: evaluacion_resultados#</div>',
	                title: "Evaluacion_resultados",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,
				{
					field: "id_evaluacion_actividades",
					template:'<div id="item" data-text="#: id_evaluacion_actividades#">#: id_evaluacion_actividades#</div>',
					title: "id_evaluacion_actividades",
					width: '4%',
					type:"number",
					hidden:true
				}
				,

	            {
	                field: "evaluacion_actividades",
					template:'<div id="item" data-text="#: evaluacion_actividades#">#: evaluacion_actividades#</div>',
	                title: "Evaluacion_actividades",
	                width: '15%',
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

				,  {
						field: "anticipo",
						template:'<div id="item" data-text="#: anticipo#">#: anticipo#</div>',
						title: "anticipo",
						width: '10%',
						type:"number",
					hidden:true
					}
					,   {
						field: "gastos",
						template:'<div id="item" data-text="#: gastos#">#: gastos#</div>',
						title: "gastos",
						width: '10%',
						type:"number",
					hidden:true
					}
					,

	            {
	                field: "conclusiones",
					template:'<div id="item" data-text="#: conclusiones#">#: conclusiones#</div>',
	                title: "Conclusiones",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "recomendaciones",
					template:'<div id="item" data-text="#: recomendaciones#">#: recomendaciones#</div>',
	                title: "Recomendaciones",
	                width: '10%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "nombre_apellidos_miembroGEP",
					template:'<div id="item" data-text="#: nombre_apellidos_miembroGEP#">#: nombre_apellidos_miembroGEP#</div>',
	                title: "miembro_GEP",
	                width: '7%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha_dictamen",
	                title: "Fecha Dictámen",
	                width: '15%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	
	            }
				,


				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_dictamen_grupo_expertos_inf_etapa(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_dictamen_grupo_expertos_inf_etapa(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '15%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_dictamen_grupo_expertos_inf_etapa').click(function () {
        var c = this.checked;
        $('#gridselection_dictamen_grupo_expertos_inf_etapa :checkbox').prop('checked',c);
    });
    $('#accionbtn_dictamen_grupo_expertos_inf_etapasave_exit').click(function()
			    {
					if (validator_dictamen_grupo_expertos_inf_etapa.validate())
                    {

                      var fd = new FormData(document.querySelector("#dictamen_grupo_expertos_inf_etapa_form"));                                                                                                                                     
                      var  url="?option=com_dictamen_grupo_expertos_inf_etapa&task=dictamen_grupo_expertos_inf_etapa_add"; 
	        			if($('#taskdictamen_grupo_expertos_inf_etapa').val()=="update")
							{
                       var olditem=JSON.stringify(Dictamen_grupo_expertos_inf_etapa.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_dictamen_grupo_expertos_inf_etapa&task=dictamen_grupo_expertos_inf_etapa_update";
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
	                					Dictamen_grupo_expertos_inf_etapa.gridDataSource.read();
                                       $('#dictamen_grupo_expertos_inf_etapa_form')[0].reset();
            	                					wnd_dictamen_grupo_expertos_inf_etapa.close();
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
    $('#accionbtn_dictamen_grupo_expertos_inf_etapasave_new').click(function()
			    {
					if (validator_dictamen_grupo_expertos_inf_etapa.validate())
                    {

                       var fd = new FormData(document.querySelector("#dictamen_grupo_expertos_inf_etapa_form")); 
	        			 var url="?option=com_dictamen_grupo_expertos_inf_etapa&task=dictamen_grupo_expertos_inf_etapa_add"; 
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
                                       showInsert_dictamen_grupo_expertos_inf_etapa();           
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

    $('#cancelbtn_dictamen_grupo_expertos_inf_etapa').click(function(){
        $('#dictamen_grupo_expertos_inf_etapa_form')[0].reset();
           Dictamen_grupo_expertos_inf_etapa.gridDataSource.read();                       
        wnd_dictamen_grupo_expertos_inf_etapa.close();
    });

    $('#addbutton_dictamen_grupo_expertos_inf_etapa').click(function(){
        showInsert_dictamen_grupo_expertos_inf_etapa();
    });
    $('#deletebutton_dictamen_grupo_expertos_inf_etapa').click(function(){
        var checkbox_checked=$('#gridselection_dictamen_grupo_expertos_inf_etapa .check_row:checked');

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
                      var dataItem=Dictamen_grupo_expertos_inf_etapa.finditem($(this).attr('id'));
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
                        url:"?option=com_dictamen_grupo_expertos_inf_etapa&task=dictamen_grupo_expertos_inf_etapa_delete_one", 
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
                            Dictamen_grupo_expertos_inf_etapa.gridDataSource.read();
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
