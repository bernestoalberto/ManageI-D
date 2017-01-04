/** * Created by Ernesto on .
 *Date:12/27/2015  
 *Time:0:49 */
//Creando variables globales
	var validator;
	var Proyecto={};
	var message=""


	//Definir controladora
	Proyecto.oldElement=null;

	Proyecto.change = function onChange(arg) {
};
	Proyecto.change = function onDataBinding(arg) {
};
	Proyecto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Proyecto.kgrid=this;
		}
	Proyecto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Proyecto.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



		$("#export_pdf_proyecto").click(function() {
    kendo.drawing.drawDOM($("#pdf_proyecto"))
        .then(function(group) {                                                   
            return kendo.drawing.exportPDF(group, {                                
               paperSize: "auto",                                                    
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }         
           });                                                                                      
       })                                                                                         
       .done(function(data) {
           kendo.saveAs({                                                                             
               dataURI: data,
               fileName: "proyecto.pdf",                                                               
               proxyURL: "+"                                                                             
           });                                                                                           
       });                                                                                               
});



//On load
$(function() {
	validator_proyecto=$("#proyecto_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Proyecto.oldElement==null)
                    		{

								if(input.is("[id=id_proyecto]")) {
								 	value=$('#id_proyecto').data('kendoComboBox').text();

								 	while (i < Proyecto.gridDataSource._data.length) {
                                		var elem=Proyecto.gridDataSource._data[i];
                                	 if(elem.titulo_proyecto==value)
                                		{
                                    		found=true;
											message="Existe un proyecto con este id_proyecto";
                                    		i=Proyecto.gridDataSource._data.length;
											return $('#id_proyecto').data('kendoComboBox').value('');
		                                }
                                		i++;
                            		}
								}

								if(input.is("[id=id_persona]")) {
								 	value=$('#id_persona').data('kendoComboBox').text();

								 	while (i < Proyecto.gridDataSource._data.length) {
                                		var elem=Proyecto.gridDataSource._data[i];
                                	 if(elem.titulo_proyecto==value)
                                		{
                                    		found=true;
											message="Existe un proyecto con este id_persona";
                                    		i=Proyecto.gridDataSource._data.length;
											return $('#id_persona').data('kendoComboBox').value('');
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
	Proyecto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_proyecto&task=proyecto_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_proyecto:{type:"number"},
						numero:{type:"number"},
						nombre_proyecto:{type:"string"},
						id_persona:{type:"number"}
				}
			}
 		},
        pageSize: 12
    });
  $("#gridselection_proyecto").kendoGrid({
	        dataSource: Proyecto.gridDataSource,
	        height: 500,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
	        sortable: true,
			 groupable:true,
	        change: Proyecto.change,
			resizable: true,
	        dataBound: Proyecto.dataBound,
	        dataBinding: Proyecto.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [


	            {
	                field: "id_proyecto",
	                title: "ID",
					template:'<div id="item" data-text="#: id_proyecto#">#: id_proyecto#</div>',
	                width: '5%',
					type:"number",
					hidden:true
				}
			,
	            {
	                field: "nombre_proyecto",
	                title: "Proyecto",
					template:'<div id="item" data-text="#: nombre_proyecto#">#: nombre_proyecto#</div>',
	                width: '20%',
					type:"string"
				}
			,

	            {
	                field: "numero",
					template:'<div id="item" data-text="#: numero#">#: numero#</div>',
	                title: "Código",
	                width: '10%',
					type:"number"
	            }
				,

	            {
	                field: "id_persona",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
	                title: "id_persona",
	                width: '5%',
					type:"number",
					hidden:true
	            }
				,    {
	                field: "jefeproyecto",
					template:'<div id="item" data-text="#: jefeproyecto#">#: jefeproyecto#</div>',
	                title: "Jefe Proyecto",
	                width: '10%',
					type:"string"
	            }

	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_proyecto').click(function () {
        var c = this.checked;
        $('#gridselection_proyecto :checkbox').prop('checked',c);
    });



  });
