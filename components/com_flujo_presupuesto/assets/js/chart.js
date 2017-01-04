
var validator;
var flujo={};
flujo.oldElement=null;
var Gasto;
var Ingreso;
var message="";


validator_flujo_presupuesto=$("#flujo_presupuesto_form").kendoValidator({
        rules:{
            unique: function(input) {
                var found=false;
                var value=input.val();
                var i=0;
                if(flujo.oldElement==null)
                {



                    if(input.is("[id=proyecto]")) {
                        var  valorcombo = $('#proyecto').data('kendoDropDownList').value()

                        if(valorcombo=="")
                        {
                            found=true;
                            message="Debe seleccionar un proyecto para graficar";
                            return $('#proyecto').data('kendoDropDownList').value('');
                        }
                    }

                    return !found;
                }
                return true;
            }
        },
        messages: {
            unique: function(input) {
                return message;
            },
            required:"Este campo necesita un valor"
        }
    }
).data("kendoValidator");


/*var annodatasource = new kendo.data.DataSource({
    transport: {
        read: {
            type:'POST',
            url: "?option=com_proyecto&task=proyecto_json_combo_list",
            dataType: "json"
        }
    }
});*/
var annodatasource = [
    { anno: "2013", id_anno: "1" },
    { anno: "2014", id_anno: "2" },
    { anno: "2015", id_anno: "3" },
    { anno: "2016", id_anno: "4" }
];
//ComboBox  proyecto
$("#anno").kendoDropDownList ({
    dataSource: annodatasource,
    dataTextField: "anno",
    dataValueField: "anno",
    editable:'false',
    filter: "contains",
});//ComboBox  proyecto
var proyectodatasource = new kendo.data.DataSource({
    transport: {
        read: {
            type:'POST',
            url: "?option=com_proyecto&task=proyecto_json_combo_list",
            dataType: "json"
        }
    }
});
$("#proyecto").kendoDropDownList ({
    dataTextField: "nombre_proyecto",
    dataValueField: "id_proyecto",
    dataSource: proyectodatasource,
    editable:'false',
    filter: "contains",
    open: function(e) {
        valid = true;

    },
    change:function(e){
        if (validator_flujo_presupuesto.validate()) {
            var fd = $("#proyecto").data('kendoDropDownList').value();
            var url = "?option=com_flujo_presupuesto&task=chart_json_list";
            var anno = $("#anno").data('kendoDropDownList').value();

            $.ajax({
                type: "GET",
                url: url,
                data: {
                    fd:fd,
                    anno:anno
                },
                success: function (response) {
                    datachart=response;
                    gastos=datachart[0]['gastos'];
                    ingreso=datachart[0]['ingreso'];
                    console.log(datachart[0]['ingreso'])
                    createChart();
                }

            });
        }
    },
    select: function(e){
        valid = true;
    },
    close: function(e){
    },
    suggest: true,
    index: 3
});
/*var annodatasource = new kendo.data.DataSource({
 transport: {
 read: {
 type:'POST',
 url: "?option=com_anno&task=anno_json_list",
 dataType: "json"
 }
 }
 });

 //ComboBox  anno
 $("#anno").kendoDropDownList ({
 dataTextField: "anno",
 dataValueField: "id_anno",
 dataSource: annodatasource,
 editable:'false',
 filter: "contains",
 open: function(e) {
 valid = true;

 },
 change:function(e){
 if (validator_flujo_presupuesto.validate()) {
 //  var fd = $("#proyecto").data('kendoDropDownList').value();
 var fd = new FormData(document.querySelector("#flujo_presupuesto_form"));
 var url = "?option=com_flujo_presupuesto&task=json_list";

 $.ajax({
 type: "POST",
 url: url,
 data: fd,
 cache: false,
 processData: false,
 contentType: false,
 success: function (response) {
 $(document).ready(createChart);
 $(document).bind("kendo:skinChange", createChart);
 }

 });
 }
 },
 select: function(e){
 valid = true;
 },
 close: function(e){
 },
 suggest: true,
 index: 3
 });*/
/*$('#graficar').click(function()
 {
 if (validator_flujo_presupuesto.validate()) {
 //  var fd = $("#proyecto").data('kendoDropDownList').value();
 var fd = new FormData(document.querySelector("#flujo_presupuesto_form"));
 var url = "?option=com_flujo_presupuesto&task=flujo_presupuesto_json_list";

 $.ajax({
 type: "POST",
 url: url,
 data: fd,
 cache: false,
 processData: false,
 contentType: false,
 success: function (response) {
 $(document).ready(createChart);
 $(document).bind("kendo:skinChange", createChart);
 }

 });
 }
 });*/

var drawing = kendo.drawing;
var geometry = kendo.geometry;
function createChart() {

    $("#chart").kendoChart({
        dataSource: flujo.gridDataSource,
        title: {
            text: "Flujo del Presupuesto del proyecto"
        },
        legend: {
            position: "bottom",
            item: {
                visual: createLegendItem
            }
        },
        seriesDefaults: {
            type: "column",
            stack: true,
            highlight: {
                toggle: function (e) {
                    // Don't create a highlight overlay,
                    // we'll modify the existing visual instead
                    e.preventDefault();

                    var visual = e.visual;
                    var opacity = e.show ? 0.8 : 1;

                    visual.opacity(opacity);
                }
            },
            visual: function (e) {
                return createColumn(e.rect, e.options.color);
            }
        },
        series: [{
            name: "Gastos",
//                    data: [56000, 63000, 74000, 91000, 117000, 138000, 128000, 115000, 102000, 98000, 123000, 113000]
            data: gastos
        }, {
            name: "Ingresos",
//                    data: [52000, 34000, 23000, 48000, 67000, 830000, 40000, 50000, 64000, 72000, 75000, 81000],
            data: ingreso
        }],
        panes: [{
            clip: false
        }],
        valueAxis: {
            line: {
                visible: false
            }
        },
        categoryAxis: {
            categories: ["Enero-Marzo","Abril-Junio","Julio-Septiembre","Octubre-Diciembre"],
            majorGridLines: {
                visible: false
            },
            line: {
                visible: false
            }
        },
        tooltip: {
            visible: true
        }
    });
}

function createColumn(rect, color) {
    var origin = rect.origin;
    var center = rect.center();
    var bottomRight = rect.bottomRight();
    var radiusX = rect.width() / 2;
    var radiusY = radiusX / 3;
    var gradient = new drawing.LinearGradient({
        stops: [{
            offset: 0,
            color: color
        }, {
            offset: 0.5,
            color: color,
            opacity: 0.9
        }, {
            offset: 0.5,
            color: color,
            opacity: 0.9
        }, {
            offset: 1,
            color: color
        }]
    });

    var path = new drawing.Path({
        fill: gradient,
        stroke: {
            color: "none"
        }
    }).moveTo(origin.x, origin.y)
        .lineTo(origin.x, bottomRight.y)
        .arc(180, 0, radiusX, radiusY, true)
        .lineTo(bottomRight.x, origin.y)
        .arc(0, 180, radiusX, radiusY);

    var topArcGeometry = new geometry.Arc([center.x, origin.y], {
        startAngle: 0,
        endAngle: 360,
        radiusX: radiusX,
        radiusY: radiusY
    });

    var topArc = new drawing.Arc(topArcGeometry, {
        fill: {
            color: color
        },
        stroke: {
            color: "#ebebeb"
        }
    });
    var group = new drawing.Group();
    group.append(path, topArc);
    return group;
}

function createLegendItem(e) {
    var color = e.options.markers.background;
    var labelColor = e.options.labels.color;
    var rect = new geometry.Rect([0, 0], [120, 50]);
    var layout = new drawing.Layout(rect, {
        spacing: 5,
        alignItems: "center"
    });

    var overlay = drawing.Path.fromRect(rect, {
        fill: {
            color: "#fff",
            opacity: 0
        },
        stroke: {
            color: "none"
        },
        cursor: "pointer"
    });

    var column = createColumn(new geometry.Rect([0, 0], [15, 10]), color);
    var label = new drawing.Text(e.series.name, [0, 0], {
        fill: {
            color: labelColor
        }
    })

    layout.append(column, label);
    layout.reflow();

    var group = new drawing.Group().append(layout, overlay);

    return group;
}

