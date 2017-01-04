/** * Created by Ernesto on .
 *Date:1/6/2016  
 *Time:10:15 */
//Creando variables globales
	var validator;
	var Oponencia_informe_etapa={};
	var message=""


	//Creando los windows Dialogs
	wnd_oponencia_informe_etapa = $("#oponencia_informe_etapa_window").kendoWindow({
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
        				if(Oponencia_informe_etapa.oldElement!=null) {
							
				    			$('#id_informe_etapa').data("kendoDropDownList").value(Oponencia_informe_etapa.oldElement.id_informe_etapa);
				    			$('#resultados_programados').val(Oponencia_informe_etapa.oldElement.resultados_programados);
				    			$('#conclusiones').val(Oponencia_informe_etapa.oldElement.conclusiones);
				    			$('#recomendaciones').val(Oponencia_informe_etapa.oldElement.recomendaciones);
				    			$('#fecha').val(Oponencia_informe_etapa.oldElement.fecha);
				    		//	$('#id_proyecto_oponencia').val(Oponencia_informe_etapa.oldElement.id_proyecto);
						}

						else
						{
				    			$('#id_informe_etapa').data("kendoDropDownList").value('');
						}
			    }}).data("kendoWindow");



	//Definir controladora
	Oponencia_informe_etapa.oldElement=null;
		/*Data Source  Informe_etapa*/
	var informe_etapadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_informe_etapa&task=informe_etapa_combo_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Informe_etapa*/
		$("#id_informe_etapa").kendoDropDownList({
        dataTextField: "proyecto",
        dataValueField: "id_informe_etapa",
        dataSource: informe_etapadatasource,
        filter: "contains",
		 open: function(e) {
            valid = true;
        },
		 change:function(e){
			 valid = true;
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
		/*Date Picker  fecha*/
		$("#fecha").kendoDatePicker({
			value: kendo.date.today(),
			parseFormats: ["yyyy/MM/dd"],
			singleDatePicker: true,
			format: 'yyyy/MM/dd',
			showDropdowns: true
	});		
	Oponencia_informe_etapa.change = function onChange(arg) {
};
	Oponencia_informe_etapa.change = function onDataBinding(arg) {
};
	Oponencia_informe_etapa.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Oponencia_informe_etapa.kgrid=this;
		}
	Oponencia_informe_etapa.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Oponencia_informe_etapa.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}

				function showInsert_oponencia_informe_etapa() {
					Oponencia_informe_etapa.oldElement=null;
					validator_oponencia_informe_etapa.hideMessages();
		    		$('#oponencia_informe_etapa_form')[0].reset();
		    		$('#taskoponencia_informe_etapa').val('insert');
					$('#id_informe_etapa').data('kendoDropDownList').enable();
				//	$('#id_proyecto_oponencia').data('kendoDropDownList').enable();
                   $('#accionbtn_oponencia_informe_etapasave_exit').text('Guardar y Salir');
		    		wnd_oponencia_informe_etapa.title("Crear Oponencia de Informe Etapa");
                   $('#accionbtnoponencia_informe_etapa_save_new').show();
		    		wnd_oponencia_informe_etapa.center().open();
				}

//Mostrar Ventanas
				function showUpdate_oponencia_informe_etapa(e) {
					validator_oponencia_informe_etapa.hideMessages();
				    $('#oponencia_informe_etapa_form')[0].reset();
				    var dataItem=Oponencia_informe_etapa.finditem(e.id);
				    Oponencia_informe_etapa.oldElement= dataItem;
				    $('#taskoponencia_informe_etapa').val('update');
					$('#id_informe_etapa').data('kendoDropDownList').readonly();
					//$('#id_proyecto_oponencia').data('kendoDropDownList').readonly();
				    wnd_oponencia_informe_etapa.title("Actualizar Oponencia de Informe Etapa");
                   $('#accionbtn_oponencia_informe_etapasave_exit').text('Actualizar');                   
                   $('#accionbtn_oponencia_informe_etapasave_new').hide();                                 
				    wnd_oponencia_informe_etapa.center().open();
				}

//Eliminar elemento
function delete_element_oponencia_informe_etapa(e)
{
    var dataItem=Oponencia_informe_etapa.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Oponencia_informe_etapa?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_oponencia_informe_etapa&task=oponencia_informe_etapa_delete_one",
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
                    Oponencia_informe_etapa.gridDataSource.read();
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
	validator_oponencia_informe_etapa=$("#oponencia_informe_etapa_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Oponencia_informe_etapa.oldElement==null)
                    		{
/*
								if(input.is("[id=id_proyecto_oponencia]")) {
								 	value=$('#id_informe_etapa').data('kendoDropDownList').value();
                                    var project = $('#id_proyecto_oponencia').data('kendoDropDownList').value();
									var	anno = $("#anno").val();
								 	while (i < Oponencia_informe_etapa.gridDataSource._data.length) {
                                		var elem=Oponencia_informe_etapa.gridDataSource._data[i];
                                	 if(elem.id_informe_etapa==value && project==elem.id_proyecto && elem.anno==anno)
                                		{
                                    		found=true;
											message="Existe una oponencia_informe_etapa para este proyecto";
                                    		 i=Oponencia_informe_etapa.gridDataSource._data.length;
											return $('#id_proyecto_oponencia').data('kendoDropDownList').value('');
		                                }
                                		i++;
                            		}
								}*/


								if(input.is("[id=resultados_programados]")) {
									var value = $('#resultados_programados').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Los resultados_programados ingresado no debe exceder los 100 caracteres";
										return $('#resultados_programados').val('');
									}
								}
								if(input.is("[id=conclusiones]")) {
									var value = $('#conclusiones').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las conclusiones no debe exceder los 100 caracteres";
										return $('#conclusiones').val('');
									}
								}
								if(input.is("[id=recomendaciones]")) {
									var value = $('#recomendaciones').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="Las recomendaciones no debe exceder los 100 caracteres";
										return $('#recomendaciones').val('');
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
	Oponencia_informe_etapa.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_oponencia_informe_etapa&task=oponencia_informe_etapa_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_oponencia:{type:"number"},
						id_informe_etapa:{type:"number"},
						id_proyecto:{type:"number"},
						etapa:{type:"string"},
						resultados_programados:{type:"string"},
						conclusiones:{type:"string"},
						recomendaciones:{type:"string"},
						fecha:{type:"date"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_oponencia_informe_etapa").kendoGrid({
	        dataSource: Oponencia_informe_etapa.gridDataSource,
	        height: 500,
		 columnMenu: true,
		 filterable: {
			 mode: "row"
		 },
		 detailTemplate: kendo.template($("#template_oponencia").html()),
	        sortable: true,
			 groupable:true,
	        change: Oponencia_informe_etapa.change,
			resizable: true,
	        dataBound: Oponencia_informe_etapa.dataBound,
	        dataBinding: Oponencia_informe_etapa.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_oponencia_informe_etapa' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "anno",
					template:'<div id="item" data-text="#: anno#">#: anno#</div>',
	                title: "anno",
	                width: '8%',
					type:"number"
	            }
				,  {
	                field: "id_oponencia",
					template:'<div id="item" data-text="#: id_oponencia#">#: id_oponencia#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:true
	            }
				,
				{
	                field: "id_proyecto",
					template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
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
	                width: '10%',
					type:"string"
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
			,    {
	                field: "etapa",
	                title: "Etapa",
					template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
	                width: '15%',
					type:"string"
				}
			,

	            {
	                field: "resultados_programados",
					template:'<div id="item" data-text="#: resultados_programados#">#: resultados_programados#</div>',
	                title: "Resultados Programados",
	                width: '20%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "conclusiones",
					template:'<div id="item" data-text="#: conclusiones#">#: conclusiones#</div>',
	                title: "Conclusiones",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "recomendaciones",
					template:'<div id="item" data-text="#: recomendaciones#">#: recomendaciones#</div>',
	                title: "Recomendaciones",
	                width: '15%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "fecha",
	                title: "Fecha Oponencia",
	                width: '15%',
					type:"date",
	            	format:"{0:dd-MM-yyyy}"	
	            }
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_oponencia_informe_etapa(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_oponencia_informe_etapa(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });


/*Acciones de los botones*/

    $('#all_check_oponencia_informe_etapa').click(function () {
        var c = this.checked;
        $('#gridselection_oponencia_informe_etapa :checkbox').prop('checked',c);
    });
    $('#accionbtn_oponencia_informe_etapasave_exit').click(function()
			    {
					if (validator_oponencia_informe_etapa.validate())
                    {

                      var fd = new FormData(document.querySelector("#oponencia_informe_etapa_form"));                                                                                                                                     
                      var  url="?option=com_oponencia_informe_etapa&task=oponencia_informe_etapa_add"; 
	        			if($('#taskoponencia_informe_etapa').val()=="update")
							{
                       var olditem=JSON.stringify(Oponencia_informe_etapa.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_oponencia_informe_etapa&task=oponencia_informe_etapa_update";
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
	                					Oponencia_informe_etapa.gridDataSource.read();
                                       $('#oponencia_informe_etapa_form')[0].reset();
            	                					wnd_oponencia_informe_etapa.close();
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
    $('#accionbtn_oponencia_informe_etapasave_new').click(function()
			    {
					if (validator_oponencia_informe_etapa.validate())
                    {

                       var fd = new FormData(document.querySelector("#oponencia_informe_etapa_form")); 
	        			 var url="?option=com_oponencia_informe_etapa&task=oponencia_informe_etapa_add"; 
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
                                       showInsert_oponencia_informe_etapa();           
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

    $('#cancelbtn_oponencia_informe_etapa').click(function(){
        $('#oponencia_informe_etapa_form')[0].reset();
           Oponencia_informe_etapa.gridDataSource.read();                       
        wnd_oponencia_informe_etapa.close();
    });

    $('#addbutton_oponencia_informe_etapa').click(function(){
        showInsert_oponencia_informe_etapa();
    });
    $('#deletebutton_oponencia_informe_etapa').click(function(){
        var checkbox_checked=$('#gridselection_oponencia_informe_etapa .check_row:checked');

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
                      var dataItem=Oponencia_informe_etapa.finditem($(this).attr('id'));
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
                        url:"?option=com_oponencia_informe_etapa&task=oponencia_informe_etapa_delete_one", 
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
                            Oponencia_informe_etapa.gridDataSource.read();
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
