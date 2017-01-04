/** * Created by Ernesto on .
 *Date:12/12/2015  
 *Time:6:42 */
//Creando variables globales
	var validator;
	var RepInformeAuditoria={};
	var message=""





	//Definir controladora
	RepInformeAuditoria.oldElement=null;
		/*Data Source  Programa*/


$("#export_pdf_rep_informe_auditoria").click(function() {

	kendo.drawing.drawDOM($("#pdf_rep_informe_auditoria"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte Informe de Auditoria.pdf",
					proxyURL: ""
				});
			});
});



	RepInformeAuditoria.change = function onChange(arg) {
};
	RepInformeAuditoria.change = function onDataBinding(arg) {
};
	RepInformeAuditoria.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    RepInformeAuditoria.kgrid=this;
		}
	RepInformeAuditoria.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(RepInformeAuditoria.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}


	RepInformeAuditoria.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url:"?option=com_rep_informe_auditoria&task=rep_informe_auditoria_json_list",
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
					institucion:{type:"string"},
					personal_entrevistado:{type:"string"},
					opinion_equipo_auditor:{type:"string"},
					elaborado_por:{type:"string"},
					objetivos:{type:"string"},
					alcance:{type:"string"},
					fecha_confeccion:{type:"date"},
					auditor_lider:{type:"string"},
					observaciones:{type:"string"},
					no_conformidades_detectadas:{type:"string"},
					nombre_proyecto:{type:"string"}

				}
			}
 		},
        pageSize: 12
    });
	$("#gridselection_rep_informe_auditoria").kendoGrid({
	        dataSource: RepInformeAuditoria.gridDataSource,
	        height: 500,
	        sortable: true,
	        change: RepInformeAuditoria.change,
			 groupable:true,
			resizable: true,
		filterable: {
			mode: "row"
		},
		detailTemplate: kendo.template($("#template_rep_informe_auditoria").html()),
		columnMenu: true,
	        dataBound: RepInformeAuditoria.dataBound,
	        dataBinding: RepInformeAuditoria.dataBinding,
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
				,	{
					field: "nombre_proyecto",
					template:'<div id="item" data-text="#: nombre_proyecto#">#: nombre_proyecto#</div>',
					title: "Proyecto",
					width: '10%',
					type:"string"

				}
				,
				{
					field: "institucion",
					template:'<div id="item" data-text="#: institucion#">#: institucion#</div>',
					title: "Entidad Ejecutora",
					width: '10%',
					type:"string"

				}
				,
				{
					field: "personal_entrevistado",
					template:'<div id="item" data-text="#: personal_entrevistado#">#: personal_entrevistado#</div>',
					title: "personal_entrevistado",
					width: '10%',
					type:"string",
					hidden:true

				}
				,
				{
					field: "opinion_equipo_auditor",
					template:'<div id="item" data-text="#: opinion_equipo_auditor#">#: opinion_equipo_auditor#</div>',
					title: "opinion_equipo_auditor",
					width: '10%',
					type:"string",
					hidden:true
				}
					,
				{
					field: "elaborado_por",
					template:'<div id="item" data-text="#: elaborado_por#">#: elaborado_por#</div>',
					title: "elaborado_por",
					width: '10%',
					type:"string",
					hidden:true
				}
					,



	            {
	                field: "objetivos",
					template:'<div id="item" data-text="#: objetivos#">#: objetivos#</div>',
	                title: "objetivos",
	                width: '10%',
					type:"string",
					hidden:true
	            },
				{
					field: "alcance",
					template:'<div id="item" data-text="#: alcance#">#: alcance#</div>',
					title: "alcance",
					width: '10%',
					type:"string",
					hidden:true
				}
				,	{
					field: "fecha_confeccion",
					title: "Fecha Confección",
					format:"{0:dd-MM-yyyy}",
					width: '10%',
					type:"date"
				}
				,
				{
					field: "auditor_lider",
					template:'<div id="item" data-text="#: auditor_lider#">#: auditor_lider#</div>',
					title: "auditor_lider",
					width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "observaciones",
					template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
					title: "observaciones ",
					width: '10%',
					type:"string",
					hidden:true
				}
				,
				{
					field: "no_conformidades_detectadas",
					template:'<div id="item" data-text="#: no_conformidades_detectadas#">#: no_conformidades_detectadas#</div>',
					title: "no_conformidades_detectadas",
					width: '10%',
					type:"string",
					hidden:true
				}


	        ]
	    });



