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


$("#export_pdf_rep_programa_auditoria").click(function() {

	kendo.drawing.drawDOM($("#pdf_rep_programa_auditoria"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte sobre Programas de Auditorias.pdf",
					proxyURL: ""
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
			url:"?option=com_programa_auditoria&task=rep_programa_auditoria_json_list",
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
				nombre:{type:"string"},
				nombre_proyecto:{type:"string"},
				programa:{type:"string"},
				fecha_auditoria:{type:"date"},
				aspectos_evaluar:{type:"string"}

			}
		}
	},
	pageSize: 12
});
$("#gridselection_rep_programa_auditoria").kendoGrid({
	dataSource: RepAnticipoEjecutora.gridDataSource,
	height: 500,
	sortable: true,
	change: RepAnticipoEjecutora.change,
	groupable:true,
	resizable: true,
	filterable: {
		mode: "row"
	},
	detailTemplate: kendo.template($("#template_rep_programa_auditoria").html()),
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
			title: "numero",
			width: '10%',
			type:"string",
			hidden:true

		}
		,	{
			field: "nombre",
			template:'<div id="item" data-text="#: nombre#">#: nombre#</div>',
			title: "Entidad Ejecutora",
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
			field: "programa",
			template:'<div id="item" data-text="#: programa#">#: programa#</div>',
			title: "programa",
			width: '10%',
			type:"string",
			hidden:true

		}
		,
		{
			field: "fecha_auditoria",
			format:"{0:dd-MM-yyyy}",
			title: "Fecha Auditoria",
			width: '10%',
			type:"date"
		}
		,
		{
			field: "aspectos_evaluar",
			template:'<div id="item" data-text="#: aspectos_evaluar#">#: aspectos_evaluar#</div>',
			title: "aspectos_evaluar",
			width: '10%',
			type:"string",
			hidden:true
		}



	]
});



