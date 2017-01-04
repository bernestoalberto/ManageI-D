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


$("#export_pdf_anticipo_ejecutora").click(function() {

    kendo.drawing.drawDOM($("#pdf_anticipo_ejecutora"))
        .then(function(group) {
            return kendo.drawing.exportPDF(group, {
                paperSize: "auto",
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
            });
        })
        .done(function(data) {
            kendo.saveAs({
                dataURI: data,
                fileName: "Reporte anticipo_ejecutora.pdf",
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
            url:"?option=com_anticipo_ejecutora&task=anticipo_ejecutora_json_list",
            dataType: "json"
        }
    },
    change: function(e){
        console.clear();
    },
    schema:{
        model:{
            fields:{
                etapa:{type:"string"},
                anno:{type:"number"},
                anticipo:{type:"number"},
                institucion:{type:"string"},
                consecutivo:{type:"numeric"},
                programa:{type:"string"},
                fecha_firma:{type:"date"},
                numero_cuenta_bancaria:{type:"numeric"},
                sucursal_creditos:{type:"numeric"},
                persona:{type:"string"},
                apellido:{type:"string"},
                proyecto:{type:"number"},
                fecha_recibe:{type:"date"},
                nombre_recibe:{type:"string"},
                cargo_recibe:{type:"string"}
            }
        }
    },
    pageSize: 12
});
$("#gridselection_rep_anticipo_ejecutora").kendoGrid({
    dataSource: RepAnticipoEjecutora.gridDataSource,
    height: 500,
    sortable: true,
    change: RepAnticipoEjecutora.change,
    groupable:true,
    resizable: true,
    filterable: {
        mode: "row"
    },
    detailTemplate: kendo.template($("#template_rep_anticipo_ejecutora").html()),
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
            field: "etapa",
            template:'<div id="item" data-text="#: etapa#">#: etapa#</div>',
            title: "Etapa",
            width: '10%',
            type:"string"

        }
        ,
        {
            field: "anno",
            template:'<div id="item" data-text="#: anno#">#: anno#</div>',
            title: "Año",
            width: '10%',
            type:"number"

        }
        ,
        {
            field: "anticipo",
            template:'<div id="item" data-text="#: anticipo#">#: anticipo#</div>',
            title: "Anticipo",
            width: '10%',
            type:"number"

        }
        ,
        {
            field: "institución",
            template:'<div id="item" data-text="#: institución#">#: institución#</div>',
            title: "Entidad Ejecutora",
            width: '10%',
            type:"string"
        }
        ,
        {
            field: "programa",
            title: "Programa",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
  {
            field: "consecutivo",
            title: "Consecutivo",
            width: '10%',
            type:"numeric",
             hidden:true
        }
        ,

        {
            field: "fecha_firma",
            title: "Fecha Firma",
            width: '10%',
            type:"date",
            format:"{0:dd-MM-yyyy}"
        },
        {
            field: "numero_cuenta_bancaria",
            template:'<div id="item" data-text="#: numero_cuenta_bancaria#">#: numero_cuenta_bancaria#</div>',
            title: "Número Cuenta Bancaria",
            width: '10%',
            type:"numeric",
            hidden:true
        }
        ,	{
            field: "sucursal_creditos",
            template:'<div id="item" data-text="#: sucursal_creditos#">#: sucursal_creditos#</div>',
            title: "Sucursal Créditos",
            width: '10%',
            type:"numeric",
            hidden:true
        }
        ,
        {
            field: "persona",
            template:'<div id="item" data-text="#: persona#">#: persona#</div>',
            title: "Persona",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
        {
            field: "apellido",
            template:'<div id="item" data-text="#: apellido#">#: apellido#</div>',
            title: "Apellido ",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
        {
            field: "proyecto",
            template:'<div id="item" data-text="#: proyecto#">#: proyecto#</div>',
            title: "Proyecto",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
        {
            field: "fecha_recibe",
            template:'<div id="item" data-text="#: fecha_recibe#">#: fecha_recibe#</div>',
            title: "Fecha Recibe",
            width: '10%',
            type:"number",
            hidden:true
        }  ,
        {
            field: "nombre_recibe",
            template:'<div id="item" data-text="#: nombre_recibe#">#: nombre_recibe#</div>',
            title: "Nombre Recibe",
            width: '10%',
            type:"string",
            hidden:true
        }
        ,
        {
            field: "cargo_recibe",
            template:'<div id="item" data-text="#: cargo_recibe#">#: cargo_recibe#</div>',
            title: "Cargo Recibe",
            width: '10%',
            type:"string",
            hidden:true
        }


    ]
});



