/** * Created by Ernesto on .
 *Date:12/20/2015  
 *Time:5:16 */
//Creando variables globales
	var validator;
	var Traza={};
	var message=""




	//Definir controladora
	Traza.oldElement=null;

	Traza.change = function onChange(arg) {
};
	Traza.change = function onDataBinding(arg) {
};
	Traza.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Traza.kgrid=this;
		}
	Traza.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Traza.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}

		$("#export_pdf_traza").click(function() {
    kendo.drawing.drawDOM($("#pdf_traza"))
        .then(function(group) {                                                   
            return kendo.drawing.exportPDF(group, {                                
               paperSize: "auto",                                                    
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }         
           });                                                                                      
       })                                                                                         
       .done(function(data) {
           kendo.saveAs({                                                                             
               dataURI: data,
               fileName: "Traza.pdf",
               proxyURL: ""
           });                                                                                           
       });                                                                                               
});



	Traza.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_traza&task=traza_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						id_traza:{type:"number"},
						usuario:{type:"string"},
						accion:{type:"string"},
					    componente:{type:"string"},
						fecha:{type:"datetime"}
				}
			}
 		},
        pageSize: 12
    });
        $("#gridselection_traza").kendoGrid({
	        dataSource: Traza.gridDataSource,
	        height: 500,
	        columnMenu: true,
				filterable: {
			mode: "row"
		},
	        sortable: true,
			 groupable:true,
	        change: Traza.change,
			resizable: true,
	        dataBound: Traza.dataBound,
	        dataBinding: Traza.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [


	            {
	                field: "id_traza",
					template:'<div id="item" data-text="#: id_traza#">#: id_traza#</div>',
	                title: "Consecutivo",
	                width: '20%',
					type:"number",
	            	hidden:true
	            }
				,

	            {
	                field: "usuario",
					template:'<div id="item" data-text="#: usuario#">#: usuario#</div>',
	                title: "Usuario",
	                width: '28%',
					type:"string"
	            }
				,
				{
	                field: "componente",
					template:'<div id="item" data-text="#: componente#">#: componente#</div>',
	                title: "Componente",
	                width: '28%',
					type:"string"
	            }
				,

	            {
	                field: "accion",
					template:'<div id="item" data-text="#: accion#">#: accion#</div>',
	                title: "Acci&oacuten",
	                width: '28%',
					type:"string"
	            }
				,

	            {
	                field: "fecha",
	                title: "Fecha",
	                width: '28%',
					type:"datetime",
	            	format:"{0:dd-MM-yyyy}"	
	            }

	        ]
	    });

