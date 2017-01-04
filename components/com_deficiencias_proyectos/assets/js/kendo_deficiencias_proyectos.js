/**
 * Created by EGI on 18/02/2016.
 */
/** * Created by Ernesto on .
 *Date:12/12/2015
 *Time:6:42 */
//Creando variables globales
var validator;
var RepAnticipoEjecutora={};
var message=""





//Definir controladora
RepAnticipoEjecutora.oldElement=null;
/*Data Source  Programa*/


$("#export_pdf_rep_deficiencias_proyectos").click(function() {

	kendo.drawing.drawDOM($("#pdf_rep_deficiencias_proyectos"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte sobre las Auditorias realizados a los Proyectos.pdf",
					proxyURL: "",
					imageBrowser:"c://"
				});
			});
});



RepAnticipoEjecutora.change = function onChange(arg) {
};
RepAnticipoEjecutora.change = function onDataBinding(arg) {
};
RepAnticipoEjecutora.dataBound=function onDataBound(arg) {
	var dataarray=this._data;
	var i=0;
	$('#all_check').prop('checked',false);
	RepAnticipoEjecutora.kgrid=this;
}
RepAnticipoEjecutora.finditem=function(uid){
	var dataItem=null;
	dataItem=$.map(RepAnticipoEjecutora.gridDataSource._data,function(val,index){
		if(val.uid==uid)
		{
			return val;
		}
	});
	return dataItem[0];
}


RepAnticipoEjecutora.gridDataSource = new kendo.data.DataSource({
	transport: {
		read: {
			type:'POST',
			url:"?option=com_deficiencias_proyectos&task=deficiencias_proyectos_json_list",
			dataType: "json"
		}
	},
	change: function(e){
		console.clear();
	},
	schema:{
		model:{
			fields:{
				numero:{type:"numeric"},
				nombre_proyecto:{type:"string"},
				nombre_auditor:{type:"string"},
				nombre_auditado:{type:"string"},
				deficiencias_evidencias:{type:"string"},
				fecha_recogida_info:{type:"date"},
				documento:{type:"string"}

			}
		}
	},
	pageSize: 12
});
$("#gridselection_rep_deficiencias_proyectos").kendoGrid({
	dataSource: RepAnticipoEjecutora.gridDataSource,
	height: 500,
	sortable: true,
	change: RepAnticipoEjecutora.change,
	groupable:true,
	resizable: true,
	filterable: {
		mode: "row"
	},
	detailTemplate: kendo.template($("#template_rep_deficiencias_proyectos").html()),
	columnMenu: true,
	dataBound: RepAnticipoEjecutora.dataBound,
	dataBinding: RepAnticipoEjecutora.dataBinding,
	pageable: {
		buttonCount: 5,
		refresh: true,
		pageSizes: [2,10,20,30,50,100]
	},
	columns: [


		{
			field: "numero",
			template:'<div id="item" data-text="#: numero#">#: numero#</div>',
			title: "Código",
			width: '10%',
			type:"numeric",
			hidden:true

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
			field: "nombre_auditor",
			template:'<div id="item" data-text="#: nombre_auditor#">#: nombre_auditor#</div>',
			title: "Nombre Auditor",
			width: '10%',
			type:"string"

		}
		,	{
			field: "nombre_auditado",
			template:'<div id="item" data-text="#: nombre_auditado#">#: nombre_auditado#</div>',
			title: "Nombre Auditado",
			width: '10%',
			type:"string"

		}
		,
		{
			field: "deficiencias_evidencias",
			template:'<div id="item" data-text="#: deficiencias_evidencias#">#: deficiencias_evidencias#</div>',
			title: "deficiencias_evidencias",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "documento",
			template:'<div id="item" data-text="#: documento#">#: documento#</div>',
			title: "documento",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "fecha_recogida_info",
			format:"{0:dd-MM-yyyy}",
			title: "Fecha Recogida",
			width: '10%',
			type:"date"
		}


	]
});



