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


$("#export_pdf_ejecucion_programa").click(function() {

	kendo.drawing.drawDOM($("#pdf_ejecucion_programa"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte Informe de Ejecución del Programa.pdf",
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
			url:"?option=com_rep_informe_ejecucion_programa&task=rep_informe_ejecucion_programa_ejecutora_json_list",
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
				objetivoGeneral:{type:"string"},
				nivel_ejecucion_presupuesto:{type:"string"},
				etapa:{type:"string"},
				principales_dificultades:{type:"string"},
				conclusiones_recomendaciones:{type:"numeric"},
				fecha_informe:{type:"date"},
				cumplimiento_objtvs_propuestos:{type:"string"},
				cumplimiento_resiltados_programados:{type:"string"},
				conclusiones_grupo_exp:{type:"string"},
				evaluacion_objetivos:{type:"string"},
				evaluacion_resultados:{type:"string"},
				evaluacion_actividades:{type:"string"},
				observaciones:{type:"string"},
				fecha_dictamen:{type:"date"},
				institucion:{type:"strimg"},
				jefe_programa:{type:"string"},
				recomendaciones:{type:"string"},
				fecha_certifica_presidente:{type:"date"},
				secretario_programa:{type:"string"}
			}
		}
	},
	pageSize: 12
});
$("#gridselection_informe_ejecucion_programa").kendoGrid({
	dataSource: RepAnticipoEjecutora.gridDataSource,
	height: 500,
	sortable: true,
	change: RepAnticipoEjecutora.change,
	groupable:true,
	resizable: true,
	filterable: {
		mode: "row"
	},
	detailTemplate: kendo.template($("#template_rep_informe_ejecucion_programa").html()),
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
			field: "programa",
			template:'<div id="item" data-text="#: programa#">#: programa#</div>',
			title: "Programa",
			width: '10%',
			type:"string"

		}
		,
		{
			field: "objetivoGeneral",
			template:'<div id="item" data-text="#: objetivoGeneral#">#: objetivoGeneral#</div>',
			title: "Objetivo General",
			width: '10%',
			type:"string",
			hidden:true

		}
		,
		{
			field: "nivel_ejecucion_presupuesto",
			template:'<div id="item" data-text="#: nivel_ejecucion_presupuesto#">#: nivel_ejecucion_presupuesto#</div>',
			title: "Nivel Ejecución Presupuesto",
			width: '10%',
			type:"string",
			hidden:true

		}
		,
		{
			field: "etapa",
			template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
			title: "Etapa",
			width: '10%',
			type:"string"
		}
		,
		{
			field: "principales_dificultades",
			template:'<div id="item" data-text="#: principales_dificultades#">#: principales_dificultades#</div>',
			title: "Principales Dificultades",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "conclusiones_recomendaciones",
			template:'<div id="item" data-text="#: conclusiones_recomendaciones#">#: conclusiones_recomendaciones#</div>',
			title: "Conclusiones Recomendaciones",
			width: '10%',
			type:"string",
			hidden:true
		}
		,

		{
			field: "fecha_informe",
			format:"{0:dd-MM-yyyy}",
			title: "Fecha Informe",
			width: '10%',
			type:"date"
		},
		{
			field: "cumplimiento_objtvs_propuestos",
			template:'<div id="item" data-text="#: cumplimiento_objtvs_propuestos#">#: cumplimiento_objtvs_propuestos#</div>',
			title: "Cumplimiento Objtvs_propuestos",
			width: '10%',
			type:"string",
			hidden:true
		}
		,	{
			field: "cumplimiento_resultados_programados",
			template:'<div id="item" data-text="#: cumplimiento_resultados_programados#">#: cumplimiento_resultados_programados#</div>',
			title: "Cumplimiento Resultados Programados",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "conclusiones_grupo_exp",
			template:'<div id="item" data-text="#: conclusiones_grupo_exp#">#: conclusiones_grupo_exp#</div>',
			title: "Conclusiones Grupo Exp",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "evaluacion_objetivos",
			template:'<div id="item" data-text="#: evaluacion_objetivos#">#: evaluacion_objetivos#</div>',
			title: "Evaluación Objetivos ",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "evaluacion_resultados",
			template:'<div id="item" data-text="#: evaluacion_resultados#">#: evaluacion_resultados#</div>',
			title: "Evaluación Resultados",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "evaluacion_actividades",
			template:'<div id="item" data-text="#: evaluacion_actividades#">#: evaluacion_actividades#</div>',
			title: "Evaluación Actividades",
			width: '10%',
			type:"string",
			hidden:true
		}  ,
		{
			field: "observaciones",
			template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
			title: "Observaciones",
			width: '10%',
			type:"string",
			hidden:true
		}
		,
		{
			field: "fecha_dictamen",
			format:"{0:dd-MM-yyyy}",
			title: "Fecha Dictámen",
			width: '10%',
			type:"date",
			hidden:true
		},   {
			field: "institucion",
			template:'<div id="item" data-text="#: institucion#">#: institucion#</div>',
			title: "Entidad Gestionadora",
			width: '10%',
			type:"string"
		},
		{
			field: "jefe_programa",
			template:'<div id="item" data-text="#: jefe_programa#">#: jefe_programa#</div>',
			title: "Jefe Programa",
			width: '10%',
			type:"string"
		},   {
			field: "recomendaciones",
			template:'<div id="item" data-text="#: recomendaciones#">#: recomendaciones#</div>',
			title: "Recomendaciones",
			width: '10%',
			type:"string",
			hidden:true
		},
		{
			field: "fecha_certifica_presidente",
			format:"{0:dd-MM-yyyy}",
			title: "fecha_certifica_presidente",
			width: '10%',
			type:"date",
			hidden:true
		},   {
			field: "secretario_programa",
			template:'<div id="item" data-text="#: secretario_programa#">#: secretario_programa#</div>',
			title: "secretario_programa",
			width: '10%',
			type:"string",
			hidden:true
		}

	]
});



