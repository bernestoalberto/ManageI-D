
var validator;
var Log={};
var message=""


//Definir controladora
Log.oldElement=null;
Log.change = function onChange(arg) {
};
Log.change = function onDataBinding(arg) {
};
Log.dataBound=function onDataBound(arg) {
	var dataarray=this._data;
	var i=0;
	$('#all_check').prop('checked',false);
	Log.kgrid=this;
}
Log.finditem=function(uid){
	var dataItem=null;
	dataItem=$.map(Log.gridDataSource._data,function(val,index){
		if(val.uid==uid)
		{
			return val;
		}
	});
	return dataItem[0];
}

	Log.gridDataSource = new kendo.data.DataSource({
		transport: {
			read: {
				type:'POST',
				url: "?option=com_logs&task=logs_json_list",
				dataType: "json"
			}
		},
		change: function(e){
			console.clear();
		},
		schema:{
			model:{
				fields:{
					datetime:{type:"string"},
					priority:{type:"string"},
					category:{type:"string"},
					message:{type:"string"}
				}
			}
		},
		pageSize: 12
	});
	$("#gridselection_logs").kendoGrid({
		dataSource: Log.gridDataSource,
		height: 490,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
		sortable: true,
		change: Log.change,
		resizable: true,
		dataBound: Log.dataBound,
		dataBinding: Log.dataBinding,
		pageable: {
			buttonCount: 5,
			refresh: true,
			pageSizes: [2,10,20,30,50,100]
		},
		columns: [

			{
				field: "datetime",
				title: "Fecha",
				width: '10%',
				type:"string",
				template:'<div id="item" data-text="#: datetime#">#: datetime#</div>'
			}
			,
			{
				field: "priority",
				title: "Prioridad-IPCliente",
				template:'<div id="item" data-text="#: priority#">#: priority#</div>',
				width: '20%',
				type:"string"
			}
			,

			{
				field: "category",
				template:'<div id="item" data-text="#: category#">#: category#</div>',
				title: "Categoria",
				width: '20%',
				type:"string"
			}
			,

			{
				field: "message",
				template:'<div id="item" data-text="#: message#">#: message#</div>',
				title: "Mensaje",
				width: '15%',
				type:"string"
			}

		]
	});




