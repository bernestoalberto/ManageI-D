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


$("#export_pdf_rep_estado_ejecucion_programa_proyecto").click(function() {

	kendo.drawing.drawDOM($("#pdf_rep_estado_ejecucion_programa_proyecto"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte sobre control realizados a los Proyectos.pdf",
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
			url:"?option=com_estado_ejecucion_programa_proyecto&task=estado_ejecucion_proyecto_json_list",
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
				estado_ejecucion:{type:"string"},
				programa:{type:"string"}

			}
		}
	},
	pageSize: 12
});
$("#gridselection_rep_estado_ejecucion_programa_proyecto").kendoGrid({
	dataSource: RepAnticipoEjecutora.gridDataSource,
	height: 500,
	sortable: true,
	change: RepAnticipoEjecutora.change,
	groupable:true,
	resizable: true,
	filterable: {
		mode: "row"
	},
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
			type:"numeric"

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
			field: "estado_ejecucion",
			template:'<div id="item" data-text="#: estado_ejecucion#">#: estado_ejecucion#</div>',
			title: "Estado Ejecución",
			width: '10%',
			type:"string"

		}
		,
		{
			field: "programa",
			template:'<div id="item" data-text="#: programa#">#: programa#</div>',
			title: "Programa",
			width: '10%',
			type:"string"
		}


	]
});



