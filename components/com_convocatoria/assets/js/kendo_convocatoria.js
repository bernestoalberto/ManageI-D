/** * Created by Ernesto on .
 *Date:12/12/2015  
 *Time:6:42 */
//Creando variables globales
	var validator;
	var Convocatoria={};
	var message=""


	//Creando los windows Dialogs
	wnd_convocatoria = $("#convocatoria_window").kendoWindow({
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
        				if(Convocatoria.oldElement!=null) {
							
				    			$('#id_programa_convocatoria').data("kendoDropDownList").value(Convocatoria.oldElement.id_programa_convocatoria);
				    			$('#texto').val(Convocatoria.oldElement.texto);
				    			$('#incio').val(Convocatoria.oldElement.inicio);
				    			$('#cierre').val(Convocatoria.oldElement.cierre);
				    			$('#visibilidad').val(Convocatoria.oldElement.visibilidad);
						}

						else
						{
				    			$('#id_programa_convocatoria').data("kendoDropDownList").value('');

						}
			    }}).data("kendoWindow");



	//Definir controladora
	Convocatoria.oldElement=null;
		/*Data Source  Programa*/
	var programadatasource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_programa&task=programa_filtro_json_list",
                dataType: "json"
            }
        }
    });
		/*ComboBox  Programa*/
		$("#id_programa_convocatoria").kendoDropDownList({
        dataTextField: "nombre",
        dataValueField: "id_programa",
        dataSource: programadatasource,
        filter: "contains",
		 open: function(e) {
        },
		 change:function(e){
		changeValue();

        },
        select: function(e){


        },
        close: function(e){
            // if no valid selection - clear input
        //    if (!valid) this.value('');
        },
        suggest: true,
        index: 3
    });
$("#inicio").kendoDatePicker({
	value: kendo.date.today(),
	parseFormats: ["yyyy/MM/dd"],
	singleDatePicker:true,
	format: 'yyyy/MM/dd',
	showDropdowns:true,
	readonly:true,
	open:function(e){
		this.value =  kendo.date.today();
	},
	change:function(e){
	},
	close:function(e){
	}

});
$("#cierre").kendoDatePicker({
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

$("#export_pdf_convocatoria").click(function() {
	$('#addbutton_convocatoria').hide();
	$('#deletebutton_convocatoria').hide();

	kendo.drawing.drawDOM($("#pdf_convocatoria"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				$('#addbutton_convocatoria').show();
				$('#deletebutton_convocatoria').show();
				kendo.saveAs({
					dataURI: data,
					fileName: "Convocatoria.pdf",
					proxyURL: ""
				});
			});
});



	Convocatoria.change = function onChange(arg) {
};
	Convocatoria.change = function onDataBinding(arg) {
};
	Convocatoria.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Convocatoria.kgrid=this;
		}
	Convocatoria.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Convocatoria.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}

function changeValue (){

	var id = $('#id_programa_convocatoria').data('kendoDropDownList').value();
//	$('#id_persona').data('kendoDropDownList').value(id);

}

				function showInsert_convocatoria() {
					Convocatoria.oldElement=null;
					validator_convocatoria.hideMessages();
		    		$('#convocatoria_form')[0].reset();
		    		$('#taskconvocatoria').val('insert');
		    		wnd_convocatoria.title("Crear Convocatoria");
					$('#accionbtn_convocatoriasave_exit').text('Guardar y Salir');
					$('#id_programa_convocatoria').data('kendoDropDownList').enable();
                   $('#accionbtn_convocatoriasave_new').show();
		    		wnd_convocatoria.center().open();
				}

//Mostrar Ventanas
				function showUpdate_convocatoria(e) {
					validator_convocatoria.hideMessages();
				    $('#convocatoria_form')[0].reset();
				    var dataItem=Convocatoria.finditem(e.id);
				    Convocatoria.oldElement= dataItem;
				    $('#taskconvocatoria').val('update');
					$('#id_programa_convocatoria').data('kendoDropDownList').readonly();
				    wnd_convocatoria.title("Actualizar Convocatoria");
                   $('#accionbtn_convocatoriasave_exit').text('Actualizar');
                   $('#accionbtn_convocatoriasave_new').hide();
				    wnd_convocatoria.center().open();
				}

//Eliminar elemento
function delete_element_convocatoria(e)
{
    var dataItem=Convocatoria.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Convocatoria?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_convocatoria&task=convocatoria_delete_one",
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
                    Convocatoria.gridDataSource.read();
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
	validator_convocatoria=$("#convocatoria_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
					//	var actual =  kendo.date.today();
                   	var value=input.val();
                   	var i=0;
						if(Convocatoria.oldElement==null)
                    		{
								if(input.is("[id=id_programa_convocatoria]")) {

									value=$('#id_programa_convocatoria').data('kendoDropDownList').value();

									while (i < Convocatoria.gridDataSource._data.length) {
										var elem = Convocatoria.gridDataSource._data[i];
										if (elem.id_programa_convocatoria == value) {
											found = true;
											message = 'El programa escogido para crear la convocatoria  ya existe';
											i = Convocatoria.gridDataSource._data.length;
											return $('#id_programa_convocatoria').data('kendoDropDownList').value('');
										}
										i++;
									}
								}
								if(input.is("[id=texto]")) {
									var value = $('#texto').val();
									var size = value.length;

									if(size > 800){
										found=true;
										message="El texto ingresado no debe exceder los 800 caracteres";
										return $('#texto').val('');
									}
								}
								if(input.is("[id=inicio]")) {
									var	final = $("#cierre").val;
								//	var	final = $("#cierre").data("kendoDatePicker").value();
									var	inicio = $("#inicio").val;
									//var	inicio = $("#inicio").data('kendoDatePicker').value();
									if(final != null && inicio > final){
										message = "La fecha inicial debe ser menor a la fecha de cierre";
										return $('#inicio').data('kendoDatePicker').value('');
									}
								/*	if(actual > inicio){
										message = "La fecha inicial debe ser posterior a la fecha de actual";
										return $('#inicio').data('kendoDatePicker').value('');
									}*/
								}
								if(input.is("[id=cierre]")) {
									var	inicio = $("#inicio").val();
									//var	inicio = $("#inicio").data('kendoDatePicker').value();
									var	final = $("#cierre").val();
									//var	final = $("#cierre").data('kendoDatePicker').value();
									if(inicio != null && inicio > final){
										message = "La fecha de  cierre debe ser posterior a la fecha inicial";
										return $('#cierre').data('kendoDatePicker').value('');
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
	Convocatoria.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_convocatoria&task=convocatoria_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_convocatoria:{type:"number"},
						id_programa_convocatoria:{type:"number"},
						texto:{type:"string"},
						inicio:{type:"date"},
						cierre:{type:"date"},
						visibilidad:{type:"string"},
						id_persona:{type:"number"}
				}
			}
 		},
        pageSize: 12
    });
	$("#gridselection_convocatoria").kendoGrid({
	        dataSource: Convocatoria.gridDataSource,
	        height: 500,
	        sortable: true,
	        change: Convocatoria.change,
			 groupable:true,
			resizable: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_convocatoria").html()),
		columnMenu: true,
	        dataBound: Convocatoria.dataBound,
	        dataBinding: Convocatoria.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_convocatoria' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,
				{
					field: "id_convocatoria",
					template:'<div id="item" data-text="#: id_convocatoria#">#: id_convocatoria#</div>',
					title: "Id",
					width: '5%',
					type:"number",
					hidden:true


				}
				,

	            {
	                field: "id_programa_convocatoria",
					template:'<div id="item" data-text="#: id_programa_convocatoria#">#: id_programa_convocatoria#</div>',
	                title: "Programa",
	                width: '10%',
					type:"number",
					hidden:true

	            },
				{
					field: "nombre",
					template:'<div id="item" data-text="#: nombre#">#: nombre#</div>',
					title: "Nombre",
					width: '10%',
					type:"string"

				}
				,
				{
					field: "texto",
					template:'<div id="item" data-text="#: texto#">#: texto#</div>',
					title: "Texto",
					width: '10%',
					type:"string",
					hidden:true
				}
					,
				{
					field: "inicio",
					title: "Inicio",
					width: '10%',
					type:"date",
					format:"{0:dd-MM-yyyy}"
				}
					,



	            {
	                field: "cierre",
	                title: "Cierre",
	                width: '10%',
					type:"date",
					format:"{0:dd-MM-yyyy}"
	            }
				,
				{
					field: "id_persona",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
					title: "jefe_Programa",
					width: '10%',
					type:"number",
					hidden:true
				},
				{
					field: "nombre_jefe",
					template:'<div id="item" data-text="#: nombre_jefe#">#: nombre_jefe#</div>',
					title: "Jefe Programa",
					width: '10%',
					type:"string"

				}
				,	{
					field: "visibilidad",
					template:'<div id="item" data-text="#: visibilidad#">#: visibilidad#</div>',
					title: "Visibilidad",
					width: '10%',
					type:"string"

				}
				,
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_convocatoria(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_convocatoria(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_convocatoria').click(function () {
        var c = this.checked;
        $('#gridselection_convocatoria :checkbox').prop('checked',c);
    });
    $('#accionbtn_convocatoriasave_exit').click(function()
			    {
					if (validator_convocatoria.validate())
                    {

						var fd = new FormData(document.querySelector("#convocatoria_form"));
						var  url="?option=com_convocatoria&task=convocatoria_add";
						if($('#taskconvocatoria').val()=="update")
						{
							var olditem=JSON.stringify(Convocatoria.oldElement);
							fd.append('olditem',olditem);
							var  url="?option=com_convocatoria&task=convocatoria_update";
						}
	        			$.ajax({
	        				type: "POST",
	        				url:url,
	            			data:fd,
                           cache: false,
                           processData: false,
                           contentType: false,
	                           success:function(response){
                    					if(response.sucess==true)
                    					{
                                           var message='El elemento fue insertado con exito'
                        					if($('#taskusuario').val()=='update')
                            					message='El elemento fue actualizado con exito'
                        					$.smallBox({
                            					title: '',
                            					content: $('#message-ok').html(),
                            					color: "#00A65A",
                            					timeout: 6000
                        					});
                    					}
                    						else
                    					{
                                               $('#text-error').html(response.message);
                        						$.smallBox({
                            						title: '',
                            						content:$('#message-error').html(),
                            						color: "#BA0916",
                            						timeout: 6000
                        						});
                    					}
	                					Convocatoria.gridDataSource.read();
                                       $('#convocatoria_form')[0].reset();
            	                					wnd_convocatoria.close();
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
    $('#accionbtn_convocatoriasave_new').click(function()
			    {
					if (validator_convocatoria.validate())
                    {

                       var fd = new FormData(document.querySelector("#convocatoria_form")); 
	        			 var url="?option=com_convocatoria&task=convocatoria_add"; 
	        			$.ajax({
	        				type: "POST",
	        				url:url,
	            			data:fd,
                           cache: false,
                           processData: false,
                           contentType: false,
	                           success:function(response){
                    					if(response.sucess==true)
                    					{
                                           var message='El elemento fue insertado con exito'
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
                                       showInsert_convocatoria();           
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

    $('#cancelbtn_convocatoria').click(function(){
        $('#convocatoria_form')[0].reset();
           Convocatoria.gridDataSource.read();                       
        wnd_convocatoria.close();
    });

    $('#addbutton_convocatoria').click(function(){
        showInsert_convocatoria();
    });
    $('#deletebutton_convocatoria').click(function(){
        var checkbox_checked=$('#gridselection_convocatoria .check_row:checked');

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
                      var dataItem=Convocatoria.finditem($(this).attr('id'));
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
                        url:"?option=com_convocatoria&task=convocatoria_delete_one", 
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
							Convocatoria.gridDataSource.read();
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
