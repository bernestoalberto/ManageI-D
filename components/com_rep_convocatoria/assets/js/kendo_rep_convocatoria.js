/** * Created by Ernesto on .
 *Date:12/12/2015  
 *Time:6:42 */
//Creando variables globales
	var validator;
	var RepConvocatoria={};
	var message=""





	//Definir controladora
	RepConvocatoria.oldElement=null;
		/*Data Source  Programa*/


$("#export_pdf_convocatoria").click(function() {

	kendo.drawing.drawDOM($("#pdf_convocatoria"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte Convocatoria.pdf",
					proxyURL: ""
				});
			});
});



	RepConvocatoria.change = function onChange(arg) {
};
	RepConvocatoria.change = function onDataBinding(arg) {
};
	RepConvocatoria.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    RepConvocatoria.kgrid=this;
		}
	RepConvocatoria.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(RepConvocatoria.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}


	RepConvocatoria.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_rep_convocatoria&task=convocatoria_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						programa:{type:"string"},
						entidad:{type:"string"},
						texto:{type:"string"},
						inicio:{type:"date"},
						cierre:{type:"date"},
						denominacion:{type:"string"},
						objetivo_especifico:{type:"string"},
						indicador:{type:"string"},
					    secrenombre:{type:"string"},
						problema:{type:"string"},
						presupuesto:{type:"number"}
				}
			}
 		},
        pageSize: 12
    });
	$("#gridselection_rep_convocatoria").kendoGrid({
	        dataSource: RepConvocatoria.gridDataSource,
	        height: 500,
	        sortable: true,
	        change: RepConvocatoria.change,
			 groupable:true,
			resizable: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_rep_convocatoria").html()),
		columnMenu: true,
	        dataBound: RepConvocatoria.dataBound,
	        dataBinding: RepConvocatoria.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [


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
					field: "nombre",
					template:'<div id="item" data-text="#: nombre#">#: nombre#</div>',
					title: "Jefe Programa",
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
	            },
				{
					field: "denominacion",
					template:'<div id="item" data-text="#: denominacion#">#: denominacion#</div>',
					title: "Denominación",
					width: '10%',
					type:"string",
					hidden:true
				}
				,	{
					field: "objetivo_especifico",
					template:'<div id="item" data-text="#: objetivo_especifico#">#: objetivo_especifico#</div>',
					title: "Objetivo Específico",
					width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "indicador",
					template:'<div id="item" data-text="#: indicador#">#: indicador#</div>',
					title: "Indicador",
					width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "secrenombre",
					template:'<div id="item" data-text="#: secrenombre#">#: secrenombre#</div>',
					title: "Secretario Programa ",
					width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "problema",
					template:'<div id="item" data-text="#: problema#">#: problema#</div>',
					title: "Problema",
					width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "presupuesto",
					template:'<div id="item" data-text="#: presupuesto#">#: presupuesto#</div>',
					title: "Presupuesto",
					width: '10%',
					type:"number",
					hidden:true
				}


	        ]
	    });



