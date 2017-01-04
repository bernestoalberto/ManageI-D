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


$("#export_pdf_certificación").click(function() {

    kendo.drawing.drawDOM($("#pdf_certificación"))
        .then(function(group) {
            return kendo.drawing.exportPDF(group, {
                paperSize: "auto",
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
            });
        })
        .done(function(data) {
            kendo.saveAs({
                dataURI: data,
                fileName: "Reporte Certificación de Actividades y Resultados.pdf",
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
            url:"?option=com_certificn_actvs_resultds&task=certificacion_json_list",
            dataType: "json"
        }
    },
    change: function(e){
        console.clear();
    },
    schema:{
        model:{
            fields:{
                nombre_proyecto:{type:"string"},
                numero:{type:"numeric"},
                programa:{type:"string"},
                anno:{type:"numeric"},
                periodo_evaluacion_cert:{type:"string"},
                actividades_resultados:{type:"string"},
                cumplimiento:{type:"string"},
                jefe_proyecto:{type:"string"},
                institucion:{type:"string"},
                a_r_dos:{type:"string"},
                cumplimiento_dos:{type:"string"},
                a_r_tres:{type:"string"},
                cumplimiento_tres:{type:"string"},
                gastos_incurridos:{type:"numeric"},
                observaciones:{type:"string"},
                presidente:{type:"string"},
                fecha_certifica_presidente:{type:"date"},
                director:{type:"string"},
                fecha_certifica_director:{type:"date"},
                anticipo:{type:"numeric"},
                evaluacion:{type:"string"}
            }
        }
    },
    pageSize: 12
});
$("#gridselection_certificación").kendoGrid({
    dataSource: RepAnticipoEjecutora.gridDataSource,
    height: 500,
    sortable: true,
    change: RepAnticipoEjecutora.change,
    groupable:true,
    resizable: true,
    filterable: {
        mode: "row"
    },
    detailTemplate: kendo.template($("#template_certificn_actvs_resultds").html()),
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
            field: "nombre_proyecto",
            template:'<div id="item" data-text="#: nombre_proyecto#">#: nombre_proyecto#</div>',
            title: "Proyecto",
            width: '10%',
            type:"string"

        }
        ,
        {
            field: "numero",
            template:'<div id="item" data-text="#: numero#">#: numero#</div>',
            title: "Número",
            width: '10%',
            type:"numeric",
            hidden:true

        }
        ,
        {
            field: "programa",
            template:'<div id="item" data-text="#: programa#">#: programa#</div>',
            title: "Programa",
            width: '10%',
            type:"string",
            hidden:true

        }
        ,
        {
            field: "anno",
            template:'<div id="item" data-text="#: anno#">#: anno#</div>',
            title: "Año",
            width: '10%',
            type:"numeric"
        }
        ,
        {
            field: "periodo_evaluacion_cert",
            template:'<div id="item" data-text="#: periodo_evaluacion_cert#">#: periodo_evaluacion_cert#</div>',
            title: "Período Evaluación Certificado",
            width: '10%',
            type:"string"
        }
        ,
  {
            field: "actividades_resultados",
            title: "Actividades Resultados",
            width: '10%',
            type:"string"
        }
        ,

        {
            field: "cumplimiento",
            title: "Cumplimiento",
            width: '10%',
            type:"string"
        },
        {
            field: "jefe_proyecto",
            template:'<div id="item" data-text="#: jefe_proyecto#">#: jefe_proyecto#</div>',
            title: "Jefe Proyecto",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,	{
            field: "institucion",
            template:'<div id="item" data-text="#: institucion#">#: institucion#</div>',
            title: "Entidad Ejecutora",
            width: '10%',
            type:"string"
        }
        ,
        {
            field: "a_r_dos",
            template:'<div id="item" data-text="#: a_r_dos#">#: a_r_dos#</div>',
            title: "Actividades Resultados",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
        {
            field: "cumplimiento_dos",
            template:'<div id="item" data-text="#: cumplimiento_dos#">#: cumplimiento_dos#</div>',
            title: "Cumplimiento ",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
        {
            field: "a_r_tres",
            template:'<div id="item" data-text="#: a_r_tres#">#: a_r_tres#</div>',
            title: "Actividades Resultados",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
        {
            field: "cumplimiento_tres",
            template:'<div id="item" data-text="#: cumplimiento_tres#">#: cumplimiento_tres#</div>',
            title: "Cumplimiento",
            width: '10%',
            type:"number",
            hidden:true
        }  ,
        {
            field: "gastos_incurridos",
            template:'<div id="item" data-text="#: gastos_incurridos#">#: gastos_incurridos#</div>',
            title: "Gastos Incurridos",
            width: '10%',
            type:"numeric",
            hidden:true
        }
        ,
        {
            field: "observaciones",
            template:'<div id="item" data-text="#: observaciones#">#: observaciones#</div>',
            title: "Observaciones",
            width: '10%',
            type:"string",
            hidden:true
        },   {
            field: "presidente",
            template:'<div id="item" data-text="#: presidente#">#: presidente#</div>',
            title: "presidente",
            width: '10%',
            type:"string",
            hidden:true
        },   {
            field: "fecha_certifica_presidente",
            title: "Fecha Certifica Presidente",
            width: '10%',
            type:"string",
            format:"{0:dd-MM-yyyy}",
            hidden:true
        },   {
            field: "director",
            template:'<div id="item" data-text="#: director#">#: director#</div>',
            title: "Director",
            width: '10%',
            type:"string",
            hidden:true
        },
        {
            field: "fecha_certifica_director",
            title: "Fecha Certifica Director",
            width: '10%',
            type:"string",
            format:"{0:dd-MM-yyyy}",
            hidden:true
        },   {
            field: "anticipo",
            template:'<div id="item" data-text="#: anticipo#">#: anticipo#</div>',
            title: "Anticipo",
            width: '10%',
            type:"string",
            hidden:true
        },   {
            field: "evaluacion",
            template:'<div id="item" data-text="#: evaluacion#">#: evaluacion#</div>',
            title: "Evaluacion",
            width: '10%',
            type:"string",
            hidden:true
        }


    ]
});



