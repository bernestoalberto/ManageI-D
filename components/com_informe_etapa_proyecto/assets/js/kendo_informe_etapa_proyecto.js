/** * Created by Ernesto on .
 *Date:12/12/2015  
 *Time:6:42 */
//Creando variables globales
	var validator;
	var InformeEtapaProyecto={};
	var message=""





	//Definir controladora
	InformeEtapaProyecto.oldElement=null;
		/*Data Source  Programa*/


$("#export_pdf_inf_report_proyecto").click(function() {

	kendo.drawing.drawDOM($("#pdf_inf_report_proyecto"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Informe Etapa Proyecto.pdf",
					proxyURL: ""
				});
			});
});



	InformeEtapaProyecto.change = function onChange(arg) {
};
	InformeEtapaProyecto.change = function onDataBinding(arg) {
};
	InformeEtapaProyecto.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    InformeEtapaProyecto.kgrid=this;
		}
	InformeEtapaProyecto.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(InformeEtapaProyecto.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}


	InformeEtapaProyecto.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_informe_etapa_proyecto&task=informe_etapa_proyecto_json_list",
                dataType: "json"
            }
        },
      change: function(e){
	console.clear();        
                      },   
       schema:{
			model:{
				fields:{
						nombre_proyecto:{type:"string"},
						institucion:{type:"string"},
						programa:{type:"string"},
						numero:{type:"number"},
						anno:{type:"number"},
						periodo_evaluacion_cert:{type:"string"},
						actividades_resultados:{type:"string"},
						cumplimiento:{type:"string"},
					    jefeprograma:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	$("#gridselection_informe_etapa_proyecto").kendoGrid({
	        dataSource: InformeEtapaProyecto.gridDataSource,
	        height: 500,
	        sortable: true,
	        change: InformeEtapaProyecto.change,
			 groupable:true,
			resizable: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_informe_etapa_proyecto").html()),
		columnMenu: true,
	        dataBound: InformeEtapaProyecto.dataBound,
	        dataBinding: InformeEtapaProyecto.dataBinding,
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
					field: "institucion",
					template:'<div id="item" data-text="#: institucion#">#: institucion#</div>',
					title: "Entidad",
					width: '10%',
					type:"string"

				}
				,
				{
					field: "jefeprograma",
					template:'<div id="item" data-text="#: jefeprograma#">#: jefeprograma#</div>',
					title: "Jefe Programa",
					width: '10%',
					type:"string"

				}
				,
				{
					field: "nombre_proyecto",
					template:'<div id="item" data-text="#: nombre_proyecto#">#: nombre_proyecto#</div>',
					title: "Proyecto",
					width: '10%',
					type:"string"
				}
					,
				{
					field: "numero",
					template:'<div id="item" data-text="#: numero#">#: numero#</div>',
					title: "Número",
					width: '10%',
					type:"number"
				}
					,



	            {
	                field: "anno",
					template:'<div id="item" data-text="#: anno#">#: anno#</div>',
	                title: "Año",
	                width: '10%',
					type:"number"

	            },
				{
					field: "periodo_evaluacion_cert",
					template:'<div id="item" data-text="#: periodo_evaluacion_cert#">#: periodo_evaluacion_cert#</div>',
					title: "Periodo_Evaluación",
					width: '10%',
					type:"string",
					hidden:true
				}
				,	{
					field: "actividades_resultados",
					template:'<div id="item" data-text="#: actividades_resultados#">#: actividades_resultados#</div>',
					title: "Actividades Resultados",
					width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "cumplimiento",
					template:'<div id="item" data-text="#: cumplimiento#">#: cumplimiento#</div>',
					title: "Cumplimiento",
					width: '10%',
					type:"string",
					hidden:true
				}



	        ]
	    });



