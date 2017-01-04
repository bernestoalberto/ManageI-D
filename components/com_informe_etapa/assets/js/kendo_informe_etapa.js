/** * Created by Ernesto on .
 *Date:1/3/2016  
 *Time:23:17 */
//Creando variables globales
	var validator;
	var Informe_etapa={};
	var message=""


	//Creando los windows Dialogs
	wnd_informe_etapa = $("#informe_etapa_window").kendoWindow({
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
        				if(Informe_etapa.oldElement!=null) {
							
				    			$('#cumplimiento_cronograma_actividades').val(Informe_etapa.oldElement.cumplimiento_cronograma_actividades);
				    			$('#cumplimiento_resultados_programados').val(Informe_etapa.oldElement.cumplimiento_resultados_programados);
				    			$('#id_proyecto_informe_etapa').data("kendoDropDownList").value(Informe_etapa.oldElement.id_proyecto_informe_etapa);

						}

						else
						{
				    			$('#id_proyecto_informe_etapa').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Informe_etapa.oldElement=null;

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
		$("#id_proyecto_informe_etapa").kendoDropDownList({
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
	Informe_etapa.change = function onChange(arg) {
};
	Informe_etapa.change = function onDataBinding(arg) {
};
	Informe_etapa.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Informe_etapa.kgrid=this;
		}
	Informe_etapa.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Informe_etapa.gridDataSource._data,function(val,index){
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
               dataURI: Informe_etapa.gridDataSource,                                                    
               fileName: "informe_etapa.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});                                                                                                        


				function showInsert_informe_etapa() {
					Informe_etapa.oldElement=null;
					validator_informe_etapa.hideMessages();
		    		$('#informe_etapa_form')[0].reset();
		    		$('#taskinforme_etapa').val('insert');
					$("#id_proyecto_informe_etapa").data('kendoDropDownList').enable();
                   $('#accionbtn_informe_etapasave_exit').text('Guardar y Salir');         
		    		wnd_informe_etapa.title("Crear Informe de Etapa");
                   $('#accionbtninforme_etapa_save_new').show();
		    		wnd_informe_etapa.center().open();
				}

//Mostrar Ventanas
				function showUpdate_informe_etapa(e) {
					validator_informe_etapa.hideMessages();
				    $('#informe_etapa_form')[0].reset();
				    var dataItem=Informe_etapa.finditem(e.id);
				    Informe_etapa.oldElement= dataItem;
				    $('#taskinforme_etapa').val('update');
					$("#id_proyecto_informe_etapa").data('kendoDropDownList').readonly();
				    wnd_informe_etapa.title("Actualizar Informe de Etapa");
                   $('#accionbtn_informe_etapasave_exit').text('Actualizar');                   
                   $('#accionbtn_informe_etapasave_new').hide();                                 
				    wnd_informe_etapa.center().open();
				}

//Eliminar elemento
function delete_element_informe_etapa(e)
{
    var dataItem=Informe_etapa.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Informe_etapa?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_informe_etapa&task=informe_etapa_delete_one",
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
                    Informe_etapa.gridDataSource.read();
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
	validator_informe_etapa=$("#informe_etapa_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Informe_etapa.oldElement==null)
                    		{

								if(input.is("[id=cumplimiento_cronograma_actividades]")) {
									var value = $('#cumplimiento_cronograma_actividades').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El cumplimiento_cronograma_actividades ingresado no debe exceder los 100 caracteres";
										return $('#cumplimiento_cronograma_actividades').val('');
									}
								}
								if(input.is("[id=cumplimiento_resultados_programados]")) {
									var value = $('#cumplimiento_resultados_programados').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El cumplimiento_resultados_programados  ingresado no debe exceder los 100 caracteres";
										return $('#cumplimiento_resultados_programados').val('');
									}
								}
								if(input.is("[id=id_proyecto_informe_etapa]")) {
									value = $('#id_proyecto_informe_etapa').data('kendoDropDownList').value();
									var anno = $('#annoie').val();
									var periodo;

									if ($('#etapar1').prop("checked")) {
										periodo = $('#etapar1').val();

									}

									else{
										periodo = $('#etapar2').val();
									}
									while (i < Informe_etapa.gridDataSource._data.length) {
										var elem = Informe_etapa.gridDataSource._data[i];
										if (elem.id_proyecto==value&& elem.etapa== periodo && elem.anno==anno)
										{
											found=true;
											message="Existe un informe de etapa  para esta etapa, año y proyecto";
											i=Informe_etapa.gridDataSource._data.length;
											return $('#id_proyecto_informe_etapa').data('kendoDropDownList').value('');
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
	Informe_etapa.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_informe_etapa&task=informe_etapa_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
					id_informe_etapa:{type:"number"},
					anno:{type:"number"},
					etapa:{type:"string"},
					cumplimiento_cronograma_actividades:{type:"string"},
					cumplimiento_resultados_programados:{type:"string"},
					id_programa:{type:"number"},
					programa:{type:"string"},
					id_entidad:{type:"number"},
					entidad:{type:"string"},
					id_persona:{type:"number"},
					jefe_proyecto:{type:"string"},
					id_proyecto_informe_etapa:{type:"number"},
					proyecto:{type:"string"},
					numero:{type:"number"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_informe_etapa").kendoGrid({
	        dataSource: Informe_etapa.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 detailTemplate: kendo.template($("#template_etapa").html()),
	        sortable: true,
			 groupable:true,
	        change: Informe_etapa.change,
			resizable: true,
	        dataBound: Informe_etapa.dataBound,
	        dataBinding: Informe_etapa.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_informe_etapa' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_informe_etapa",
					template:'<div id="item" data-text="#: id_informe_etapa#">#: id_informe_etapa#</div>',
	                title: "Id",
	                width: '3%',
					type:"number",
	            	hidden:true
	            }
				,  {
	                field: "etapa",
					template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
	                title: "Etapa",
	                width: '10%',
					type:"string"
	            }
				,  {
	                field: "anno",
					template:'<div id="item" data-text="#: anno#">#: anno#</div>',
	                title: "Año",
	                width: '7%',
					type:"number"
	            }
				,
				{
	                field: "id_programa",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
	                title: "id_programa",
	                width: '3%',
					type:"number",
	            	hidden:true
	            }
				,  {
	                field: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
	                title: "Programa",
	                width: '7%',
					type:"string",
					hidden:true
	            }
				,
				{
	                field: "id_proyecto_informe_etapa",
					template:'<div id="item" data-text="#: id_proyecto_informe_etapa#">#: id_proyecto_informe_etapa#</div>',
	                title: "id_proyecto_informe_etapa",
	                width: '3%',
					type:"number",
	            	hidden:true
	            }
				,
				{
	                field: "proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
	                title: "Proyecto",
	                width: '15%',
					type:"string"
	            }
				,
				{
	                field: "numero",
					template:'<div id="item" data-text="#: numero#">#: numero#</div>',
	                title: "Código",
	                width: '7%',
					type:"number",
					hidden:true
	            }
				,
				{
					field: "id_entidad",
					title: "ID",
					template:'<div id="item" data-text="#: id_entidad#">#: id_entidad#</div>',
					width: '5%',
					type:"number",
					hidden:true
				}
				,     {
					field: "entidad",
					title: "Entidad",
					template:'<div id="item" data-text="#: entidad#">#: entidad#</div>',
					width: '15e%',
					type:"string"
				}
				,


	            {
	                field: "cumplimiento_cronograma_actividades",
					template:'<div id="item" data-text="#: cumplimiento_cronograma_actividades#">#: cumplimiento_cronograma_actividades#</div>',
	                title: "Cumplimiento Cronograma Actividades",
	                width: '11%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "cumplimiento_resultados_programados",
					template:'<div id="item" data-text="#: cumplimiento_resultados_programados#">#: cumplimiento_resultados_programados#</div>',
	                title: "Cumplimiento Resultados Programados",
	                width: '11%',
					type:"string",
					hidden:true
	            }
				,


	            {
	                field: "jefe_proyecto",
	                title: "Jefe Proyecto",
					template:'<div id="item" data-text="#: jefe_proyecto#">#: jefe_proyecto#</div>',
	                width: '11%',
					type:"string",
					hidden:true
				}
			,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_informe_etapa(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_informe_etapa(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_informe_etapa').click(function () {
        var c = this.checked;
        $('#gridselection_informe_etapa :checkbox').prop('checked',c);
    });
    $('#accionbtn_informe_etapasave_exit').click(function()
			    {
					if (validator_informe_etapa.validate())
                    {

                      var fd = new FormData(document.querySelector("#informe_etapa_form"));                                                                                                                                     
                      var  url="?option=com_informe_etapa&task=informe_etapa_add"; 
	        			if($('#taskinforme_etapa').val()=="update")
							{
                       var olditem=JSON.stringify(Informe_etapa.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_informe_etapa&task=informe_etapa_update";
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
	                					Informe_etapa.gridDataSource.read();
                                       $('#informe_etapa_form')[0].reset();
            	                					wnd_informe_etapa.close();
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
    $('#accionbtn_informe_etapasave_new').click(function()
			    {
					if (validator_informe_etapa.validate())
                    {

                       var fd = new FormData(document.querySelector("#informe_etapa_form")); 
	        			 var url="?option=com_informe_etapa&task=informe_etapa_add"; 
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
                                       showInsert_informe_etapa();           
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

    $('#cancelbtn_informe_etapa').click(function(){
        $('#informe_etapa_form')[0].reset();
           Informe_etapa.gridDataSource.read();                       
        wnd_informe_etapa.close();
    });

    $('#addbutton_informe_etapa').click(function(){
        showInsert_informe_etapa();
    });
    $('#deletebutton_informe_etapa').click(function(){
        var checkbox_checked=$('#gridselection_informe_etapa .check_row:checked');

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
                      var dataItem=Informe_etapa.finditem($(this).attr('id'));
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
						url:"?option=com_informe_etapa&task=informe_etapa_delete_one",
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
							Informe_etapa.gridDataSource.read();
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
