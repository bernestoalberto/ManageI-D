
//Creando variables globales
var validator;
var Prioridad={};
var message=""

//Creando los windows Dialogs
wnd_prioridad = $("#prioridad_window").kendoWindow({
    modal: true,
    visible: false,
    resizable: false,
    width: 600,
    heigth:400,
    activate:function(e){
        if(Prioridad.oldElement!=null) {
            $('#id_prioridad').val(Prioridad.oldElement.id_prioridad);
            $('#problema').val(Prioridad.oldElement.problema);
        }
    }}).data("kendoWindow");



//Definir controladora
Prioridad.oldElement=null;
// Import DejaVu Sans font for embedding

Prioridad.change = function onChange(arg) {
};
Prioridad.change = function onDataBinding(arg) {
};
Prioridad.dataBound=function onDataBound(arg) {
    var dataarray=this._data;
    var i=0;
    $('#all_check').prop('checked',false);
    Prioridad.kgrid=this;
}
Prioridad.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Prioridad.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}



function showInsert_prioridad() {
    Prioridad.oldElement=null;
    validator_prioridad.hideMessages();
    $('#prioridad_form')[0].reset();
    $('#taskprioridad').val('insert');
    wnd_prioridad.title("Definir Prioridad");
    $('#prioridad_save_exit').text("Guardar y Salir");
    $('#prioridad_save_new').show();
    wnd_prioridad.center().open();
}

//Mostrar Ventanas
function showUpdate_prioridad(e) {
    validator_prioridad.hideMessages();
    $('#prioridad_form')[0].reset();
    var dataItem=Prioridad.finditem(e.id);
    Prioridad.oldElement= dataItem;
    $('#taskprioridad').val('update');
    wnd_prioridad.title("Actualizar Prioridad");
    $('#prioridad_save_new').hide();
    $('#prioridad_save_exit').text("Actualizar");
    wnd_prioridad.center().open();
}

//Elimina0r elemento
function delete_element_prioridad(e)
{
    var dataItem=Prioridad.finditem(e.id);
    var array=[];

    array.push(dataItem);

    $.MetroMessageBox({
        title: "<span class='fa fa-trash-o'></span> Eliminar ",
        content: "<p class='fg-white'>Desea eliminar este Prioridad?</p> ",
        NormalButton: "#232323",
        ActiveButton: "#008a00 ",
        buttons: " [Cancelar][Aceptar]"
    }, function (a) {
        if(a=="Aceptar")
        {
            $.ajax({
                type: "POST",
                url:"?option=com_prioridad&task=prioridad_delete_one",
                data:{
                    array:JSON.stringify(array)
                },
                success:function(response){
                    if(response.success==true)
                    {
                        $.smallBox({
                            title: "<span class='fa fa-trash-o'></span>Eliminar Prioridad",
                            content:"<p class='fg-white'>Prioridad eliminada correctamente</p>" ,
                            color: "#00a65a",
                            timeout: 4000
                        })
                    }
                    else{
                        $('#text-error').html(response.message);
                        $.smallBox({
                            title: "<span class='fa fa-trash-o'></span>Eliminar Prioridad",
                            content:"<p class='fg-white'>Error al eliminar prioridad</p>" ,
                            color: "#9E162E",
                            timeout: 4000
                        })

                    }
                    Prioridad.gridDataSource.read();
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

    validator_prioridad=$("#prioridad_form").kendoValidator({
            rules:{
                unique: function(input) {
                    var found=false;
                    var value=input.val();
                    var i=0;
                    if(Prioridad.oldElement==null)
                    {



                        if(input.is("[id=problema]")) {
                                var value = $('#problema').val();
                            var size = value.length;
                            while (i < Prioridad.gridDataSource._view.length) {
                                var elem=Prioridad.gridDataSource._view[i];
                                if(elem.problema==value)
                                {
                                    found=true;
                                    message="Ya este problema esta definido";
                                    i=Prioridad.gridDataSource._view.length;
                                    return $('#problema').val('');
                                }
                                i++;
                            }
                            if(size > 850){
                                found=true;
                                message="El problema ingresado no debe exceder los 250 caracteres";
                                return $('#problema').val('');
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
    Prioridad.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url: "?option=com_prioridad&task=prioridad_json_list",
                dataType: "json"
            }
        },
    /*   change: function(e){
            console.clear();
        },*/
        schema:{
            model:{
                fields:{
                    id_prioridad:{type:"number"},
                    problema:{type:"string"}
                }
            }
        },
        pageSize:20
    });
 $("#gridselection_prioridad").kendoGrid({
        dataSource: Prioridad.gridDataSource,
        height: 500,
        filterable: true,
        sortable: true,
        groupable:true,
       filterable: {
           mode: "row"
       },
      columnMenu: true,
        change: Prioridad.change,
        resizable: true,
        dataBound: Prioridad.dataBound,
        dataBinding: Prioridad.dataBinding,
        pageable: {
            buttonCount: 5,
            refresh: true,
            pageSizes: [2,10,20,30,50,100]
        },
        columns: [
            {
                field: "",
                title: "",
                width: '1%',
                headerTemplate: "<input class='' id='all_check_prioridad' type='checkbox'/>",
                template: "<input class='check_row' id='#: uid#' type='checkbox' />",
                hidden:false


            }
            ,

            {
                field: "id_prioridad",
                template:'<div id="item" data-text="#: id_prioridad#">#: id_prioridad#</div>',
                title: "Id",
                width: '5%',
                type:"number",
                hidden:true
            }
            ,

            {
                field: "problema",
                template:'<div id="item" data-text="#: problema#">#: problema#</div>',
                title: "Problema",
                width: '15%',
                type:"string"
            }
            ,
            {
                template:"<div class='btn btn-circle btn-icon-circle btn-default' name='btnmodificar' id='#: uid#' onclick='showUpdate_prioridad(this)' data-toggle='tooltip' data-original-title='Modificar|Modificar elemento'><i class='ion-edit'></i></div>" +
                "<div class='btn btn-circle btn-icon-circle btn-default' name='btneliminar' id='#: uid#' onclick='delete_element_prioridad(this)' data-toggle='tooltip' data-original-title='Eliminar|Eliminar elemento'><i class='fa fa-trash-o'></i></div>",
                name:'edit',
                headerTemplate: "<p>Acciones</p>",
                 width: '10%'
            }
        ]
    });
    /*Acciones de los botones*/

    $('#all_check_prioridad').click(function () {
        var c = this.checked;
        $('#gridselection_prioridad :checkbox').prop('checked',c);
    });
    $('#prioridad_save_exit').click(function()
    {
        if (validator_prioridad.validate())
        {

            var fd = new FormData(document.querySelector("#prioridad_form"));

            var url="?option=com_prioridad&task=prioridad_add";
            if($('#taskprioridad').val()=="update")
            {

                var olditem=JSON.stringify(Prioridad.oldElement);
                fd.append('olditem',olditem);

                var url="?option=com_prioridad&task=prioridad_update";

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
                        if($('#taskprioridad').val()=="update"){
                            icono = "<span class='ion-edit'></span>";
                            accion = "Actualizar";
                            gerundio= "actualizada";
                        }
                        $.smallBox({
                            title: icono+accion+" Prioridad",
                            content:"<p class='fg-white'>Prioridad "+gerundio+" correctamente</p>" ,
                            color: "#00a65a",
                            timeout: 4000
                        })
                    }
                    else {
                        $('#text-error').html(response.message);
                        $.smallBox({
                            title: icono+accion+" Prioridad",
                            content:"<p class='fg-white'>Error al "+accion+" la Prioridad</p>" ,
                            color: "#9E162E",
                            timeout: 4000
                        })
                    }

                    Prioridad.gridDataSource.read();
                    $('#prioridad_form')[0].reset();
                    wnd_prioridad.close();
                }

            });
        }

    else {
            $.smallBox({
                title: " Error",
                content:"<p class='fg-white'>Llene los campos obligatorios del formulario</p>" ,
                color: "#9E162E",
                timeout: 4000
            })

        }
    }
    );
    $('#prioridad_save_new').click(function()
    {
        if (validator_prioridad.validate())
        {

            var fd = new FormData(document.querySelector("#prioridad_form"));

            var url="?option=com_prioridad&task=prioridad_add";
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
                        if($('#taskprioridad').val()=="update"){
                            icono = "<span class='ion-edit'></span>";
                            accion = "Actualizar";
                            gerundio= "actualizada";
                        }

                        $.smallBox({
                            title: icono+accion+" Prioridad",
                            content:"<p class='fg-white'>Prioridad "+gerundio+" correctamente</p>" ,
                            color: "#00a65a",
                            timeout: 4000
                        });
                    }
                    else {
                        $('#text-error').html(response.message);
                        $.smallBox({
                            title: icono+accion+" Prioridad",
                            content:"<p class='fg-white'>Error al "+accion+" la Prioridad</p>" ,
                            color: "#9E162E",
                            timeout: 4000
                        });
                    }
                    $('#id_prioridad').val= "";
                    showInsert_prioridad();
                    //Prioridad.gridDataSource.read();

                }

            });

        }
        else {
            $.smallBox({
                title: " Error",
                content:"<p class='fg-white'>Llene los campos obligatorios del formulario</p>" ,
                color: "#9E162E",
                timeout: 4000
            })

        }



    }

    );
    $('#cancelbtn_prioridad').click(function(){
        $('#prioridad_form')[0].reset();
        wnd_prioridad.close();
        Prioridad.gridDataSource.read();
    });

    $('#addbutton_prioridad').click(function(){
        showInsert_prioridad();
    });
    $('#deletebutton_prioridad').click(function(){
        var checkbox_checked=$('#gridselection_prioridad .check_row:checked');

        if(checkbox_checked.length==0)
        {

            $.smallBox({
                title: "<span class='fa fa-trash-o'></span>     Eliminar Elemento ",
                content: "<p>Debe seleccionar al menos un elemento a eliminar</p>",
                color: "#F2092A",
                timeout: 1000,
                top:10
            });
        }
        else {
            var array=[];
            checkbox_checked.each(function(){
                var dataItem=Prioridad.finditem($(this).attr('id'));
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
                        url:"?option=com_prioridad&task=prioridad_delete_one",
                        data:{
                            array:JSON.stringify(array)
                        },
                        success:function(response){
                            if(response.success==true)
                            {
                                var message='El elemento fue eliminado con exito'

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
                            Prioridad.gridDataSource.read();
                        }
                     
                    });
                }
                else
                    close();
            })
        }
    });
});
