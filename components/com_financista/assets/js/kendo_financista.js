/** * Created by Ernesto on .
 *Date:1/1/2016  
 *Time:12:23 */
//Creando variables globales
	var validator;
	var Financista={};
	var message=""


	//Creando los windows Dialogs
	wnd_financista = $("#financista_window").kendoWindow({
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
        				if(Financista.oldElement!=null) {
							
				    			$('#id_entidad').data("kendoDropDownList").value(Financista.oldElement.id_entidad);
				    			$('#plan_CIT').val(Financista.oldElement.plan_CIT);
				    			$('#cifra_planificada').val(Financista.oldElement.cifra_planificada);
				    			$('#id_proyecto').data("kendoDropDownList").value(Financista.oldElement.id_proyecto);
				    		//	$('#id_persona').data("kendoDropDownList").value(Financista.oldElement.id_persona);
						}
						else
						{

							$('#id_entidad').data("kendoDropDownList").value('');
							$('#id_proyecto').data("kendoDropDownList").value('');
							//$('#id_persona').data("kendoDropDownList").value('');
						}

			    }}).data("kendoWindow");



	//Definir controladora
	Financista.oldElement=null;
	Financista.change = function onChange(arg) {
};
	Financista.change = function onDataBinding(arg) {
};
	Financista.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Financista.kgrid=this;
		}
	Financista.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Financista.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
};

$("#cifra_planificada").kendoNumericTextBox({
	max:500000,
	min:1000,
	format: "#.00 CUP",
	decimals: 3,
	step:50



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
$("#id_proyecto").kendoDropDownList({
	dataTextField: "nombre_proyecto",
	dataValueField: "id_proyecto",
	dataSource: proyectodatasource,
	filter: "contains",
	open: function(e) {
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
var entidaddatasource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_entidad&task=entidad_json_list",
			dataType: "json"
		}
	}
});
$("#id_entidad").kendoDropDownList({
	dataTextField: "nombre",
	dataValueField: "id_entidad",
	dataSource: entidaddatasource,
	filter: "contains",
	open: function(e) {
		//  valid = false;
	},
	change:function(e){

	},
	select: function(e){
		//  valid = true;
	},
	close: function(e){
		// if no valid selection - clear input
		// if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});
var financista = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_persona&task=persona_json_list",
			dataType: "json"
		}
	}
});
/*ComboBox  Jefeproyecto*/
$("#id_persona").kendoDropDownList({
	dataTextField: "nombre",
	dataValueField: "id_persona",
	dataSource: financista,
	filter: "contains",
	open: function(e) {
		// valid = false;
	},
	change:function(e){

	},
	select: function(e){
		//valid = true;
	},
	close: function(e){
		// if no valid selection - clear input
		//  if (!valid) this.value('');
	},
	suggest: true,
	index: 3
});
/*Data Source  Programa*/




				function showInsert_financista() {
					Financista.oldElement=null;
					validator_financista.hideMessages();
		    		$('#financista_form')[0].reset();
		    		$('#taskfinancista').val('insert');
					$('#id_entidad').data("kendoDropDownList").enable();
                   $('#accionbtn_financistasave_exit').text('Guardar y Salir');         
		    		wnd_financista.title("Crear Entidad Financista");
                   $('#accionbtnfinancista_save_new').show();
		    		wnd_financista.center().open();
				}

//Mostrar Ventanas
				function showUpdate_financista(e) {
					validator_financista.hideMessages();
				    $('#financista_form')[0].reset();
				    var dataItem=Financista.finditem(e.id);
				    Financista.oldElement= dataItem;
					$('#id_entidad').data("kendoDropDownList").readonly();
				    $('#taskfinancista').val('update');
				    wnd_financista.title("Actualizar Financista");
                   $('#accionbtn_financistasave_exit').text('Actualizar');                   
                   $('#accionbtn_financistasave_new').hide();                                 
				    wnd_financista.center().open();
				}

//Eliminar elemento
function delete_element_financista(e)
{
    var dataItem=Financista.finditem(e.id);
    var array=[];
    array.push(dataItem);
    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Financista?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                        url:"?option=com_financista&task=financista_delete_one",
                data:{
                    array:JSON.stringify(array)
                },
                success:function(response){
if(response.sucess==true) {
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
                    Financista.gridDataSource.read();
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
	validator_financista=$("#financista_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Financista.oldElement==null)
                    		{




								if(input.is("[id=id_proyecto]")) {
									value = $('#id_proyecto').data('kendoDropDownList').value();

								 	while (i < Financista.gridDataSource._data.length) {
                                		var elem=Financista.gridDataSource._data[i];
                                	 if(elem.id_proyecto==value)
                                		{
                                    		found=true;
											message="Existe un financista con este proyecto";
                                    		i=Financista.gridDataSource._data.length;
		                                }
                                		i++;
                            		}
								}
/*
								if(input.is("[id=id_persona]")) {
									value = $('#id_persona').data('kendoDropDownList').value();

								 	while (i < Financista.gridDataSource._data.length) {
                                		var elem=Financista.gridDataSource._data[i];
                                	 if(elem.id_persona==value)
                                		{
                                    		found=true;
											message="Existe un financista con este persona";
                                    		i=Financista.gridDataSource._data.length;
		                                }
                                		i++;
                            		}
								}*/
								if(input.is("[id=plan_CIT]")) {
									 value = $('#plan_CIT').val();
									var size = value.length;

									if(size > 100){
										found=true;
										message="El plan_CIT ingresado no debe exceder los 100 caracteres";
										return $('#plan_CIT').val('');
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
	Financista.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_financista&task=financista_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_entidad:{type:"number"},
						plan_cit:{type:"string"},
						cifra_planificada:{type:"string"},
						id_programa:{type:"number"},
						id_proyecto:{type:"number"},
						proyecto:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	$("#gridselection_financista").kendoGrid({
	        dataSource: Financista.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_financista").html()),
	        sortable: true,
	        change: Financista.change,
			resizable: true,
			 groupable:true,
	        dataBound: Financista.dataBound,
	        dataBinding: Financista.dataBinding,
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
	                headerTemplate: "<input class='' id='all_check_financista' type='checkbox'/>",
	                template: "<input class='check_row' id='#: uid#' type='checkbox'/>",
					hidden:false
	            }
				,

	            {
	                field: "id_entidad",
					template:'<div id="item" data-text="#: id_entidad#">#: id_entidad#</div>',
	                title: "Id_entidad",
	                width: '3%',
					type:"number",
					hidden:true
	            }
				,   {
	                field: "entidad",
					template:'<div id="item" data-text="#: entidad#">#: entidad#</div>',
	                title: "Entidad",
	                width: '11%',
					type:"string"
	            }
				,

	            {
	                field: "plan_CIT",
					template:'<div id="item" data-text="#: plan_CIT#">#: plan_CIT#</div>',
	                title: "plan_CIT",
	                width: '11%',
					type:"string",
					hidden:true
	            }
				,

	            {
	                field: "cifra_planificada",
					template:'<div id="item" data-text="#: cifra_planificada#">#: cifra_planificada#</div>',
	                title: "Cifra Planificada(CUP)",
	                width: '11%',
					type:"number"
	            }
				,

	            {
	                field: "id_programa",
					template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
	                title: "Id_programa",
	                width: '3%',
					type:"number",
					hidden:true


	            }
				,     {
	                field: "programa",
					template:'<div id="item" data-text="#: programa#">#: programa#</div>',
	                title: "Programa",
	                width: '11%',
					type:"string"



	            }
				,

	            {
	                field: "id_proyecto",
					template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
	                title: "Id_proyecto",
	                width: '3%',
					type:"number",
					hidden:true

	            }
				,    {
					field: "proyecto",
					template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
					title: "Proyecto",
					width: '11%',
					type:"string"

	            }
				,

	          /*  {
	                field: "id_persona",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
	                title: "Id_persona",
	                width: '3%',
					type:"number",
					hidden:true
	            }
				,*/
				{
	                template: "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='showUpdate_financista(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='fa fa-edit'></i></div>" +
                          	  "<div class='btn btn-circle btn-icon-circle btn-default' id='#: uid#' onclick='delete_element_financista(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
	                name:'edit',
	                headerTemplate: "<p>Acciones</p>",
	                width: '10%'
	            }
	        ]
	    });

/*Acciones de los botones*/

    $('#all_check_financista').click(function () {
        var c = this.checked;
        $('#gridselection_financista :checkbox').prop('checked',c);
    });
    $('#accionbtn_financistasave_exit').click(function()
			    {
					if (validator_financista.validate())
                    {

                      var fd = new FormData(document.querySelector("#financista_form"));                                                                                                                                     
                      var  url="?option=com_financista&task=financista_add"; 
	        			if($('#taskfinancista').val()=="update")
							{
                       var olditem=JSON.stringify(Financista.oldElement);                       
                       fd.append('olditem',olditem);                                                                               
				var  url="?option=com_financista&task=financista_update";
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
	                					Financista.gridDataSource.read();
                                       $('#financista_form')[0].reset();
            	                					wnd_financista.close();
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
    $('#accionbtn_financistasave_new').click(function()
			    {
					if (validator_financista.validate())
                    {

                       var fd = new FormData(document.querySelector("#financista_form")); 
	        			 var url="?option=com_financista&task=financista_add"; 
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
                                       showInsert_financista();           
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

    $('#cancelbtn_financista').click(function(){
        $('#financista_form')[0].reset();
           Financista.gridDataSource.read();                       
        wnd_financista.close();
    });

    $('#addbutton_financista').click(function(){
        showInsert_financista();
    });
    $('#deletebutton_financista').click(function(){
        var checkbox_checked=$('#gridselection_financista .check_row:checked');

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
                      var dataItem=Financista.finditem($(this).attr('id'));
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
                        url:"?option=com_financista&task=financista_delete_one", 
                        data:{
                            array:JSON.stringify(array)
                        },
                        success:function(response){
if(response.sucess==true) {                               	var message='El elemento fue eliminado con exito';
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
                            Financista.gridDataSource.read();
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
