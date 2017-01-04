
	var validator;
	var Persona={};
	var message=""




	//Definir controladora
	Persona.oldElement=null;
	Persona.change = function onChange(arg) {
};
	Persona.change = function onDataBinding(arg) {
};
	Persona.dataBound=function onDataBound(arg) {
		    var dataarray=this._data;
		    var i=0;
		    $('#all_check').prop('checked',false);
		    Persona.kgrid=this;
		}
	Persona.finditem=function(uid){
    var dataItem=null;
    dataItem=$.map(Persona.gridDataSource._data,function(val,index){
        if(val.uid==uid)
        {
            return val;
        }
    });
    return dataItem[0];
}





//On load
$(function() {
	validator_persona=$("#persona_form").kendoValidator({
			rules:{
					unique: function(input) {
                   	var found=false;
                   	var value=input.val();
                   	var i=0;
						if(Persona.oldElement==null)
                    		{
							return !found;
						}
						else
						{
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
	Persona.gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type:'POST',
                url: "?option=com_persona&task=persona_json_list",
                dataType: "json"
            }
        },
		change: function(e){
			console.clear();
		},
       schema:{
			model:{
				fields:{
						id_persona:{type:"number"},
						dni:{type:"number"},
						nombre:{type:"string"},
						apellido:{type:"string"},
						direccion:{type:"string"},
						correo:{type:"string"},
						telefono:{type:"number"},
						movil:{type:"number"},
					password:{type:"string"},
						foto:{type:"string"}
				}
			}
 		},
        pageSize: 12
    });
	 $("#gridselection_persona").kendoGrid({
	        dataSource: Persona.gridDataSource,
	        height: 490,
		columnMenu: true,
		filterable: {
			mode: "row"
		},
	        sortable: true,
	        change: Persona.change,
			resizable: true,
	        dataBound: Persona.dataBound,
	        dataBinding: Persona.dataBinding,
	        pageable: {
	            buttonCount: 5,
	            refresh: true,
	            pageSizes: [2,10,20,30,50,100]
	        },
	        columns: [

	            {
	                field: "id_persona",
					template:'<div id="item" data-text="#: id_persona#">#: id_persona#</div>',
	                title: "Id",
	                width: '5%',
					type:"number",
	            	hidden:false
	            }
				,

	            {
	                field: "dni",
					template:'<div id="item" data-text="#: dni#">#: dni#</div>',
	                title: "Dni",
	                width: '9%',
					type:"string"
	            }
				,

	            {
	                field: "nombre",
					template:'<div id="item" data-text="#: nombre#">#: nombre#</div>',
	                title: "Nombre",
	                width: '9%',
					type:"string"
	            }
				,


	            {
	                field: "direccion",
					template:'<div id="item" data-text="#: direccion#">#: direccion#</div>',
	                title: "Dirección",
	                width: '9%',
					type:"string"
	            }
				,

	            {
	                field: "correo",
					template:'<div id="item" data-text="#: correo#">#: correo#</div>',
	                title: "Correo",
	                width: '9%',
					type:"string"
	            }
				,

	            {
	                field: "telefono",
					template:'<div id="item" data-text="#: telefono#">#: telefono#</div>',
	                title: "Telefono",
	                width: '9%',
					type:"number"
	            }
				,

	            {
	                field: "movil",
					template:'<div id="item" data-text="#: movil#">#: movil#</div>',
	                title: "Móvil",
	                width: '9%',
					type:"number"
	            }
				,
				{
					field: "username",
					template:'<div id="item" data-text="#: username#">#: username#</div>',
					title: "Usuario",
					width: '9%',
					type:"string"
				}
				,
				{
					field: "password",
					template:'<div id="item" data-text="#: password#">#: password#</div>',
					title: "Contraseña",
					width: '9%',
					type:"string",
					hidden:true
				},
				{
					field: "foto",
					template:'<div id="item" data-text="#: foto#"><img class="user-image img-circle" data-image="#: foto#" data-nombre="#: nombre#" width="25px" height="25px" src="../../../images/users/#:foto#"></div>',
					title: "Foto",
					width: '6%',
					type:"string"
				}

		
	        ]
	    });
/*Acciones de los botones*/

    $('#all_check_persona').click(function () {
        var c = this.checked;
        $('#gridselection_persona :checkbox').prop('checked',c);
    });
});