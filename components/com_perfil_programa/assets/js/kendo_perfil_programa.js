
//Creando variables globales
var validator;
var Perfil_programa={};
var message="";

//Creando los windows Dialogs
wnd_Perfil_programa = $("#Perfil_programa_window").kendoWindow({
    modal: true,
    visible: false,
    resizable: true,
    width: '70%',
    heigth:400,
    animation : {
        open: {
            effects: 'expand:vertical'
        },
        close: {
            effects:'expand:vertical',
            reverse: true
        }
    },
    activate:function(e){
        if(Perfil_programa.oldElement!=null) {

            $('#denominacion').val(Perfil_programa.oldElement.denominacion);
            $('#fundamentacion').val(Perfil_programa.oldElement.fundamentacion);
            $('#objetivo_especifico').val(Perfil_programa.oldElement.objetivo_especifico);
            $('#principalesResultados').val(Perfil_programa.oldElement.principalesResultados);
            $('#potencialHumano').val(Perfil_programa.oldElement.potencialHumano);
            $('#presupuesto').val(Perfil_programa.oldElement.presupuesto);
            $('#plazoEjecucion').val(Perfil_programa.oldElement.plazoEjecucion);
            $('#otro').val(Perfil_programa.oldElement.otro);
            $('#numero_proyectos').val(Perfil_programa.oldElement.numero_proyectos);
            $('#id_prioridad').data("kendoDropDownList").value(Perfil_programa.oldElement.id_prioridad);
            $('#id_indicador').data("kendoDropDownList").value(Perfil_programa.oldElement.id_indicador);
            $('#archivo').val(Perfil_programa.oldElement.archivo);

        }
        else
        {
            $('#id_indicador').data("kendoDropDownList").value('');
            $('#id_prioridad').data("kendoDropDownList").value('');
        }

    }}).data("kendoWindow");

$("#numero_proyectos").kendoNumericTextBox({
    decimals: 0,
    format: "# proyecto(s)",
    min:1,
    max:15
});

//Definir controladora
Perfil_programa.oldElement=null;
$("#plazoEjecucion").kendoNumericTextBox({
    decimals: 0,
    format: "# año(s)",
    min:1,
    max:5
});

$("#presupuesto").kendoNumericTextBox({
    format: "#.00 CUP",
    decimals: 3,
    min:1000,
    step:50,
     max:50000000
});


$("#export_pdf_perfil_programa").click(function() {
    $('#addbutton_Perfil_programa').hide();
    $('#deletebutton_Perfil_programa').hide();

    kendo.drawing.drawDOM($("#pdf_perfil_programa"))
        .then(function(group) {
            return kendo.drawing.exportPDF(group, {
                paperSize: "auto",
                margin: { left: "1cm", top: "1cm", right: "1cm", bottom: "1cm" }
            });
        })
        .done(function(data) {
            $('#addbutton_Perfil_programa').show();
            $('#deletebutton_Perfil_programa').show();
            kendo.saveAs({
                dataURI: data,
                fileName: "PerfildeProgama.pdf",
                proxyURL: ""
            });
        });
});
var indicadores_impactodatasource = new kendo.data.DataSource({
    transport: {
        read: {
            type:'POST',
            url: "?option=com_indicadores_impacto&task=indicadores_impacto_json_list",
            dataType: "json"
        }
    }
});
/*ComboBox  Indicadores_impacto*/
$("#id_indicador").kendoDropDownList({
    dataTextField: "indicador",
    dataValueField: "id_indicador",
    dataSource: indicadores_impactodatasource,
    editable:'false',
    filter: "contains",
    open: function(e) {
        valid = false;
    },
    change:function(e){

     //   if (!valid) this.value('');
    },
    select: function(e){
        valid = true;
    },
    close: function(e){
        // if no valid selection - clear input
     //   if (!valid) this.value('');
    },
    suggest: true,
    index: 3
});
/*Data Source  Prioridad*/
var prioridaddatasource = new kendo.data.DataSource({
    transport: {
        read: {
            type:'POST',
            url: "?option=com_prioridad&task=prioridad_json_list",
            dataType: "json"
        }
    }
});
/*ComboBox  Prioridad*/
$("#id_prioridad").kendoDropDownList ({
    dataTextField: "problema",
    dataValueField: "id_prioridad",
    dataSource: prioridaddatasource,
    editable:'false',
    filter: "contains",
    open: function(e) {
        valid = true;
    },
    change:function(e){

      //  if (!valid) this.value('');
    },
    select: function(e){
        valid = true;
    },
    close: function(e){
        // if no valid selection - clear input
    //    if (!valid) this.value('');
    },
    suggest: true,
    index: 3
});

Perfil_programa.change = function onChange(arg) {
};
Perfil_programa.change = function onDataBinding(arg) {
};
Perfil_programa.dataBound=function onDataBound(arg) {
    var dataarray=this._data;
    var i=0;
    $('#all_check').prop('checked',false);
    Perfil_programa.kgrid=this;
}
Perfil_programa.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Perfil_programa.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



function showInsert_Perfil_programa() {
    Perfil_programa.oldElement=null;
    validator_Perfil_programa.hideMessages();
    $('#perfil_programa_form')[0].reset();
    $('#taskPerfil_programa').val('insert');
    wnd_Perfil_programa.title("Crear Perfil de Programa");
    $('#accionbtn_save_exit').text("Guardar y Salir");
    $('#accionbtn_save_new').show();
    wnd_Perfil_programa.center().open();
}

//Mostrar Ventanas
function showUpdate_Perfil_programa(e) {
    validator_Perfil_programa.hideMessages();
    $('#perfil_programa_form')[0].reset();
    var dataItem=Perfil_programa.finditem(e.id);
    Perfil_programa.oldElement= dataItem;
    $('#taskPerfil_programa').val('update');
    wnd_Perfil_programa.title("Actualizar Perfil_programa");
    $('#accionbtn_save_new').hide();
    $('#accionbtn_save_exit').text("Actualizar");
    wnd_Perfil_programa.center().open();
}

//Elimina0r elemento
function delete_element_Perfil_programa(e)
{
    var dataItem=Perfil_programa.finditem(e.id);
    var array=[];

    array.push(dataItem);

    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Perfil_programa?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                url:"?option=com_perfil_programa&task=perfil_programa_delete_one",
                data:{
                    array:JSON.stringify(array)
                },
                success:function(response){
                    if(response.success==true)
                    {
                        $.smallBox({
                            title: "<span class='fa fa-trash-o'></span>Eliminar Perfil Programa",
                            content:"<p class='fg-white'>Perfil Programa eliminado correctamente</p>" ,
                            color: "#00a65a",
                            timeout: 4000
                        })
                    }
                    else{
                        $('#text-error').html(response.message);
                        $.smallBox({
                            title: "<span class='fa fa-trash-o'></span>Eliminar Perfil_programa",
                            content:"<p class='fg-white'>Error al eliminar Perfil_programa</p>" ,
                            color: "#9E162E",
                            timeout: 4000
                        })

                    }
                    Perfil_programa.gridDataSource.read();
                }
                //error:problemas
            });
        }
        else
            close();
    })
}
//On load
$(function() {

    validator_Perfil_programa=$("#perfil_programa_form").kendoValidator({
            rules:{
                unique: function(input) {
                    var found=false;
                    var value=input.val();
                    var i=0;
                    if(Perfil_programa.oldElement==null)
                    {



                        if(input.is("[id=denominacion]")) {
                            var value = $('#denominacion').val();
                            var size = value.length;
                            while (i < Perfil_programa.gridDataSource._view.length) {
                                var elem=Perfil_programa.gridDataSource._view[i];
                                if(elem.denominacion==value)
                                {
                                    found=true;
                                    message="Ya este denominación esta definida";
                                    i=Perfil_programa.gridDataSource._view.length;
                                    return $('#denominacion'). val('');
                                }
                                i++;
                            }
                            if(size > 250){
                                found=true;
                                message="La denominacion ingresada no debe exceder los 250 caracteres";
                                return $('#denominacion').val('');
                            }
                        }
                        if(input.is("[id=fundamentacion]")) {
                                var value = $('#fundamentacion').val();
                                 var size = value.length;

                        if(size > 7000){
                            found=true;
                            message="La fundamentación ingresado no debe exceder los 7000 caracteres";
                            return $('#fundamentacion').val('');
                        }
                        }
                        if(input.is("[id=objetivo_especifico]")) {
                                var value = $('#objetivo_especifico').val();
                                 var size = value.length;

                        if(size > 1000){
                            found=true;
                            message="El objetivo_especifico ingresado no debe exceder los 1000 caracteres";
                            return $('#objetivo_especifico').val('');
                        }
                        }

                        return !found;
                    }
                    if(input.is("[id=principalesResultados]")) {
                                var value = $('#principalesResultados').val();
                                 var size = value.length;
                        if(size > 800){
                            found=true;
                            message="Los principalesResultados ingresados no debe exceder los 800 caracteres";
                            return $('#principalesResultados').val('');
                        }
                        if(input.is("[id=potencialHumano]")) {
                            var value = $('#potencialHumano').val();
                            var size = value.length;
                            if (size > 250) {
                                found = true;
                                message = "El potencialHumano ingresados no debe exceder los 250 caracteres";
                                return $('#potencialHumano').val('');
                            }

                        }
                        if(input.is("[id=otro]")) {
                            var value = $('#otro').val();
                            var size = value.length;
                            if (size > 250) {
                                found = true;
                                message = "El textoingresado no debe exceder los 250 caracteres";
                                return $('#otro').val('');
                            }

                        }
                        if (input.is("[id=archivo]")) {

                            value = $('#archivo').val();
                            if (value.size > 2273856) {
                                found = true;
                                message = "El archivo debe ser menor de 2.3 Mb";
                                return $('#archivo').val('');

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
    Perfil_programa.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url: "?option=com_perfil_programa&task=perfil_programa_json_list",
                dataType: "json"
            }
        },
        change: function(e){
        console.clear();
        },

        schema:{
            model:{
                fields:{
                    id_programa:{type:"number"},
                    denominacion:{type:"string"},
                    fundamentacion:{type:"string"},
                    objetivo_especifico:{type:"string"},
                    principalesResultados:{type:"string"},
                    potencialHumano:{type:"string"},
                    presupuesto:{type:"number"},
                    plazoEjecucion:{type:"number"},
                    otro:{type:"string"},
                    numero_proyectos:{type:"number"},
                    id_prioridad:{type:"string"},
                    id_indicador:{type:"string"}

                }
            }
        },

        pageSize: 12
    });



       $("#gridselection_Perfil_programa").kendoGrid({
           dataSource: Perfil_programa.gridDataSource,
           height: 500,
           filterable: {
               mode: "row"
           },
           sortable: true,
           columnMenu: true,
           groupable:true,
           change: Perfil_programa.change,
           resizable: true,
           detailTemplate: kendo.template($("#template_perfil_programa").html()),
           scrollable: true,
           navigatable: true,
           dataBound: Perfil_programa.dataBound,
           dataBinding: Perfil_programa.dataBinding,
           pageable: {
               buttonCount: 5,
               refresh: true,
               pageSizes: [2,10,20,30,50,100]
           },
           columns: [
            {
                field: "",
                title: "",
                width: '4%',
                headerTemplate: "<input class='' id='all_check_Perfil_programa' type='checkbox'/>",
                template: "<input class='check_row' id='#: uid#' type='checkbox' />",
                hidden:false


            }
            ,

            {
                field: "id_programa",
                template:'<div id="item" data-text="#: id_programa#">#: id_programa#</div>',
                title: "Consecutivo",
                width: '5%',
                type:"number",
                hidden:true
            }
            ,


            {
                field: "denominacion",
                template:'<div id="item" data-text="#: denominacion#">#: denominacion#</div>',
                title: "Denominación",
                width: '10%',
                type:"string"
            }
            ,
            {
                field: "fundamentacion",
                template:'<div id="item" data-text="#: fundamentacion#">#: fundamentacion#</div>',
                title: "Fundamentación",
                width: '10%',
                type:"string",
                hidden:true
            }
,
            {
                field: "objetivo_especifico",
                template:'<div id="item" data-text="#: objetivo_especifico#">#: objetivo_especifico#</div>',
                title: "Objetivos Especificos",
                width: '10%',
                type:"string",
                hidden:true
            },
            {
                field: "principalesResultados",
                template:'<div id="item" data-text="#: principalesResultados#">#: principalesResultados#</div>',
                title: "Principales Resultados",
                width: '10%',
                type:"string",
                hidden:true
            },

            {
                field: "potencialHumano",
                template:'<div id="item" data-text="#: potencialHumano#">#: potencialHumano#</div>',
                title: "Potencial Humano",
                width: '10%',
                type:"string",
                hidden:true
            },
            {
                field: "presupuesto",
                template:'<div id="item" data-text="#: presupuesto#">#: presupuesto#</div>',
                title: "Presupuesto",
                width: '10%',
                type:"number"
            },
            {
                field: "plazoEjecucion",
                title: "Plazo Ejecución",
                template:'<div id="item" data-text="#: plazoEjecucion#">#: plazoEjecucion#</div>',
                width: '10%',
                type:"number",

            },
            {
                field: "otro",
                template:'<div id="item" data-text="#: otro#">#: otro#</div>',
                title: "Otro",
                width: '10%',
                type:"string",
                hidden:true
            },
            {
                field: "numero_proyectos",
                template:'<div id="item" data-text="#: numero_proyectos#">#: numero_proyectos#</div>',
                title: "Proyectos",
                width: '10%',
                type:"number"
            },
            {
                field: "id_prioridad",
                template:'<div id="item" data-text="#: id_prioridad#">#: id_prioridad#</div>',
                title: "prioridad",
                width: '10%',
                type:"string",
                hidden:true
            },
            {
                field: "problema",
                template:'<div id="item" data-text="#: problema#">#: problema#</div>',
                title: "Problema",
                width: '15%',
                type:"string",
                hidden:true
            },
            {
                field: "id_indicador",
                template:'<div id="item" data-text="#: id_indicador#">#: id_indicador#</div>',
                title: "indicador",
                width: '10%',
                type:"string",
                hidden:true
            },
            {
                field: "indicador",
                template:'<div id="item" data-text="#: indicador#">#: indicador#</div>',
                title: "Indicador",
                width: '10%',
                type:"string",
                hidden:false
            }


            ,   
			{
                field: "archivo",
                template:'<div id="item" data-text="#: archivo#"><a class="list bg-encabezado fg-white" href="#:archivo#"></a></div>',
                title: "Adjunto",
                width: '10%',
                type:"file"
            }


            ,
            {
                template:"<div class='btn btn-circle btn-icon-circle btn-default' name='btnmodificar' id='#: uid#' onclick='showUpdate_Perfil_programa(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='ion-edit'></i></div>" +
                "<div class='btn btn-circle btn-icon-circle btn-default' name='btneliminar' id='#: uid#' onclick='delete_element_Perfil_programa(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
                name:'edit',
                headerTemplate: "<p>Acciones</p>",
                 width: '10%'
            }
        ]
    });


    /*Acciones de los botones*/

    $('#all_check_Perfil_programa').click(function () {
        var c = this.checked;
        $('#gridselection_Perfil_programa :checkbox').prop('checked',c);
    });
    $('#accionbtn_save_exit').click(function()
    {
        if (validator_Perfil_programa.validate())
        {

            var fd = new FormData(document.querySelector("#perfil_programa_form"));

            var url="?option=com_perfil_programa&task=perfil_programa_add";
            if($('#taskPerfil_programa').val()=="update")
            {

             var olditem=JSON.stringify(Perfil_programa.oldElement);
                fd.append('olditem',olditem);

                var url="?option=com_perfil_programa&task=perfil_programa_update";

            }
            $.ajax({
                type: "POST",
                url:url,
                data: fd,
                cache: false,
                processData: false,
                contentType: false,
                success:function(response){
                    if(response.success==true){
                        var icono = "<span class='ion-android-add-circle'></span>";
                      var accion = "Insertar";
                        var gerundio= "insertada"
                        if($('#taskPerfil_programa').val()=="update"){
                            icono = "<span class='ion-edit'></span>";
                            accion = "Actualizar";
                            gerundio= "actualizada";
                        }
                        $.smallBox({
                            title: icono+accion+" Perfil_programa",
                            content:"<p class='fg-white'>Perfil_programa "+gerundio+" correctamente</p>" ,
                            color: "#00a65a",
                            timeout: 4000
                        })
                    }
                    else {
                        $('#text-error').html(response.message);
                        $.smallBox({
                            title: icono+accion+" Perfil_programa",
                            content:"<p class='fg-white'>Error al "+accion+" la Perfil_programa</p>" ,
                            color: "#9E162E",
                            timeout: 4000
                        })
                    }

                    Perfil_programa.gridDataSource.read();
                    $('#perfil_programa_form')[0].reset();
                    wnd_Perfil_programa.close();
                }

            });


        }
        else {
        $.smallBox({
            title: "Error",
            content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
            color: "#9E162E",
            timeout: 4000
        })
        }
    });
    $('#accionbtn_save_new').click(function()
    {
        if (validator_Perfil_programa.validate())
        {

            var fd = new FormData(document.querySelector("#perfil_programa_form"));

            var url="?option=com_perfil_programa&task=perfil_programa_add";

            $.ajax({
                type: "POST",
                url:url,
                data: fd,
                cache: false,
                processData: false,
                contentType: false,
                success:function(response){
                    if(response.success==true){
                        var icono = "<span class='ion-android-add-circle'></span>";
                        var accion = "Insertar";
                        var gerundio= "insertada"
                        if($('#taskPerfil_programa').val()=="update"){
                            icono = "<span class='ion-edit'></span>";
                            accion = "Actualizar";
                            gerundio= "actualizada";
                        }
                        $.smallBox({
                            title: icono+accion+" Perfil_programa",
                            content:"<p class='fg-white'>Perfil_programa "+gerundio+" correctamente</p>" ,
                            color: "#00a65a",
                            timeout: 4000
                        })
                    }
                    else {
                        $('#text-error').html(response.message);
                        $.smallBox({
                            title: icono+accion+" Perfil_programa",
                            content:"<p class='fg-white'>Error al "+accion+" la Perfil_programa</p>" ,
                            color: "#9E162E",
                            timeout: 4000
                        })
                    }
                    $('#id_prioridad').val= "";
                    showInsert_Perfil_programa();
                    //Perfil_programa.gridDataSource.read();

                }

            });

        }
        else {
                $.smallBox({
                title: "Error",
                content:"<p class='fg-white'>Por favor llene todos los campos</p>" ,
                color: "#9E162E",
                timeout: 4000
                           })
              }
    });
    $('#cancelbtn_perfil_programa').click(function(){
        $('#perfil_programa_form')[0].reset();
        wnd_Perfil_programa.close();
        Perfil_programa.gridDataSource.read();
    });

    $('#addbutton_Perfil_programa').click(function(){
        showInsert_Perfil_programa();
    });
    $('#deletebutton_Perfil_programa').click(function(){
        var checkbox_checked=$('#gridselection_Perfil_programa .check_row:checked');

        if(checkbox_checked.length==0)
        {

            $.smallBox({
                title: "<span class='fa fa-trash-o'></span>     Eliminar Elemento ",
                content: "<p>Debe seleccionar al menos un elemento a eliminar</p>",
                color: "#F2092A",
                timeout: 1000,
                top:10
            })
        }
        else {
            var array=[];
            checkbox_checked.each(function(){
                var dataItem=Perfil_programa.finditem($(this).attr('id'));
                array.push(dataItem);
                }
            );
            $.MetroMessageBox({
                title: "<span class='fa fa-trash-o'></span> Eliminar ",
                content: "<p class='fg-white'>Desea eliminar los elementos seleccionados?</p> ",
                NormalButton: "#232323",
                ActiveButton: "#008a00 ",
                buttons: " [Cancelar][Aceptar]"
            }, function (a) {
                if(a=="Aceptar")
                {
                    $.ajax({
                        type: "POST",
                        url:"?option=com_perfil_programa&task=perfil_programa_delete_one",
                        data:{
                            array:JSON.stringify(array)
                        },
                        success:function(response){
                            if(response.success==true)
                            {
                                var message='El elemento fue eliminado con exito';
                                $.smallBox({
                                    title: '',
                                    content: $('#message-ok').html(),
                                    color: "#00A65A",
                                    timeout: 6000
                                });
                            }
                            else
                            {
                                $('#text-error').html(response.message);
                                $.smallBox({
                                    title: '',
                                    content:$('#message-error').html(),
                                    color: "#BA0916",
                                    timeout: 6000
                                });
                            }
                            Perfil_programa.gridDataSource.read();
                        }

                    });
                }
                else
                    close();
            })
        }
    });
});

