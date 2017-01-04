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


$("#export_pdf_rep_control_presupuestal").click(function() {

	kendo.drawing.drawDOM($("#pdf_rep_control_presupuestal"))
			.then(function(group) {
				return kendo.drawing.exportPDF(group, {
					paperSize: "auto",
					margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
				});
			})
			.done(function(data) {
				kendo.saveAs({
					dataURI: data,
					fileName: "Reporte sobre el Control Presupuestal de los proyectos.pdf",
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
			url:"?option=com_control_presupuestal&task=control_presupuestal_json_list",
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
				anno:{type:"numeric"},
				etapa:{type:"string"},
				cantidad_anticipa:{type:"numeric"},
				autorizo_registrar_ingreso:{type:"numeric"},
				autorizo_registrar_gasto:{type:"numeric"},
				gastos_incurridos:{type:"numeric"},
				fecha_inicio:{type:"string"},
				fecha_terminacion:{type:"string"}

			}
		}
	},
	pageSize: 12
});
$("#gridselection_rep_control_presupuestal").kendoGrid({
	dataSource: RepAnticipoEjecutora.gridDataSource,
	height: 500,
	sortable: true,
	change: RepAnticipoEjecutora.change,
	groupable:true,
	resizable: true,
	filterable: {
		mode: "row"
	},
	detailTemplate: kendo.template($("#template_rep_control_presupuestal").html()),
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
		},
		{
			field: "anno",
			template:'<div id="item" data-text="#: anno#">#: anno#</div>',
			title: "Año",
			width: '5%',
			type:"numeric"

		}
		,
		{
			field: "etapa",
			template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
			title: "Etapa",
			width: '8%',
			type:"string"

		}
		,
		{
			field: "cantidad_anticipa",
			template:'<div id="item" data-text="#: cantidad_anticipa#">#: cantidad_anticipa#</div>',
			title: "Anticipo(CUP)",
			width: '8%',
			type:"numeric"
		}
		,
		{
			field: "autorizo_registrar_ingreso",
			template:'<div id="item" data-text="#: autorizo_registrar_ingreso#">#: autorizo_registrar_ingreso#</div>',
			title: "Ingreso (CUP)",
			width: '8%',
			type:"numeric"
		}
,
		{
			field: "autorizo_registrar_gasto",
			template:'<div id="item" data-text="#: autorizo_registrar_gasto#">#: autorizo_registrar_gasto#</div>',
			title: "Gasto (CUP)",
			width: '8%',
			type:"numeric"
		},
		{
			field: "gastos_incurridos",
			template:'<div id="item" data-text="#: gastos_incurridos#">#: gastos_incurridos#</div>',
			title: "Gastos Incurridos (CUP)",
			width: '8%',
			type:"numeric",
			hidden:true
		},
		{
			field: "fecha_inicio",
			format:"{0:dd-MM-yyyy}",
			title: "Fecha Inicio",
			width: '10%',
			type:"string",
			hidden:true
		},
		{
			field: "fecha_terminacion",
			format:"{0:dd-MM-yyyy}",
			title: "Fecha Terminación",
			width: '10%',
			type:"string",
			hidden:true
		}




	]
});



