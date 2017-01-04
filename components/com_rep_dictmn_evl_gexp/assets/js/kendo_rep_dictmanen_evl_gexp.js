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


$("#export_pdf_rep_grupo_exp").click(function() {

	kendo.drawing.drawDOM($("#pdf_rep_grupo_exp"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte Grupo de Expertos de sobre Informe de Etapa del Proyecto.pdf",
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
			url:"?option=com_rep_dictmn_evl_gexp&task=rep_dictmn_evl_gexp_json_list",
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
				etapa:{type:"string"},
				nombre_proyecto:{type:"string"},
				evaluación_objetivos:{type:"string"},
				evaluación_resultados:{type:"string"},
				evaluación_actividades:{type:"string"},
				observaciones:{type:"string"},
				conclusiones:{type:"string"},
				recomendaciones:{type:"string"},
				nombre_apellidos_miembroGEP:{type:"string"},
				cumplimiento_cronograma_actividades:{type:"string"},
				cumplimiento_resultados_programados:{type:"string"}
			}
		}
	},
	pageSize: 12
});
$("#gridselection_rep_grupo_exp").kendoGrid({
	dataSource: RepAnticipoEjecutora.gridDataSource,
	height: 500,
	sortable: true,
	change: RepAnticipoEjecutora.change,
	groupable:true,
	resizable: true,
	filterable: {
		mode: "row"
	},
	detailTemplate: kendo.template($("#template_rep_grupo_exp").html()),
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
			field: "etapa",
			template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
			title: "Etapa",
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
			field: "evaluación_objetivos",
			template:'<div id="item" data-text="#: evaluación_objetivos#">#: evaluación_objetivos#</div>',
			title: "evaluación_objetivos",
			width: '10%',
			type:"string",
			hidden:true

		}
		,
		{
			field: "evaluación_resultados",
			template:'<div id="item" data-text="#: evaluación_resultados#">#: evaluación_resultados#</div>',
			title: "evaluación_resultados",
			width: '10%',
			type:"string",
				hidden:true
		}
		,
		{
			field: "evaluación_actividades",
			template:'<div id="item" data-text="#: evaluación_actividades#">#: evaluación_actividades#</div>',
			title: "evaluación_actividades",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
          {
			field: "observaciones",
			template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
			title: "observaciones",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "conclusiones",
			template:'<div id="item" data-text="#: conclusiones#">#: conclusiones#</div>',
			title: "conclusiones",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "recomendaciones",
			template:'<div id="item" data-text="#: recomendaciones#">#: recomendaciones#</div>',
			title: "recomendaciones",
			width: '10%',
			type:"string",
			hidden:true
		}
		,	{
			field: "nombre_apellidos_miembroGEP",
			template:'<div id="item" data-text="#: nombre_apellidos_miembroGEP#">#: nombre_apellidos_miembroGEP#</div>',
			title: "Miembro GEP",
			width: '10%',
			type:"string"
		}
		,
		{
			field: "cumplimiento_cronograma_actividades",
			template:'<div id="item" data-text="#: cumplimiento_cronograma_actividades#">#: cumplimiento_cronograma_actividades#</div>',
			title: "cumplimiento_cronograma_actividades",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "cumplimiento_resultados_programados",
			template:'<div id="item" data-text="#: cumplimiento_resultados_programados#">#: cumplimiento_resultados_programados#</div>',
			title: "cumplimiento_resultados_programados",
			width: '10%',
			type:"string",
			hidden:true
		}


	]
});



