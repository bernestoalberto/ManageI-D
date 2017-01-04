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


$("#export_pdf_rep_financiamiento_programa_proyecto").click(function() {

	kendo.drawing.drawDOM($("#pdf_rep_financiamiento_programa_proyecto"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte sobre financiamiento del Programa y los Proyectos.pdf",
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
			url:"?option=com_financiamiento_programa_proyecto&task=financiamiento_programa_proyecto_json_list",
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
				titulo_proyecto:{type:"string"},
				nombre_programa:{type:"string"},
				numero_proyectos:{type:"numeric"},
				institucion:{type:"string"},
				presupuesto_proyecto:{type:"numeric"},
				presupuesto_programa:{type:"numeric"}

			}
		}
	},
	pageSize: 12
});
$("#gridselection_rep_financiamiento_programa_proyecto").kendoGrid({
	dataSource: RepAnticipoEjecutora.gridDataSource,
	height: 500,
	sortable: true,
	change: RepAnticipoEjecutora.change,
	groupable:true,
	resizable: true,
	filterable: {
		mode: "row"
	},
	detailTemplate: kendo.template($("#template_rep_financiamiento_programa_proyecto").html()),
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
			field: "nombre_programa",
			template:'<div id="item" data-text="#: nombre_programa#">#: nombre_programa#</div>',
			title: "Programa",
			width: '10%',
			type:"string",
			hidden:true

		}
		,	{
			field: "numero",
			template:'<div id="item" data-text="#: numero#">#: numero#</div>',
			title: "numero",
			width: '10%',
			type:"numeric",
			hidden:true

		}
		,
		{
			field: "numero_proyectos",
			template:'<div id="item" data-text="#: numero_proyectos#">#: numero_proyectos#</div>',
			title: "Núumero Proyectos",
			width: '10%',
			type:"numeric",
			hidden:true

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
			field: "presupuesto_proyecto",
			template:'<div id="item" data-text="#: presupuesto_proyecto#">#: presupuesto_proyecto#</div>',
			title: "Presupuesto Proyecto (CUP)",
			width: '10%',
			type:"numeric"
		}
		,
		{
			field: "presupuesto_programa",
			template:'<div id="item" data-text="#: presupuesto_programa#">#: presupuesto_programa#</div>',
			title: "Presupuesto Programa (CUP)",
			width: '10%',
			type:"numeric",
			hidden:true
		}
		,

		{
			field: "titulo_proyecto",
			template:'<div id="item" data-text="#: titulo_proyecto#">#: titulo_proyecto#</div>',
			title: "Proyecto",
			width: '10%',
			type:"string"
		}



	]
});



