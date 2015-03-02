<!---page_types
1 Create new field
2 Modify field
--->

<cfinclude template="#APPLICATION.htmlPath#/includes/table_field_form_query.cfm">

<cfset return_page = "#tableTypeName#_fields.cfm?#tableTypeName#=#table_id#">

<cfset url_return_path = "&return_path="&URLEncodedFormat(return_path&return_page)>

<cfoutput>
<link href="#APPLICATION.bootstrapDatepickerCSSPath#" rel="stylesheet" />
<script src="#APPLICATION.bootstrapDatepickerJSPath#"></script>
<script src="#APPLICATION.htmlPath#/bootstrap/bootstrap-datepicker/js/locales/bootstrap-datepicker.es.js" charset="UTF-8"></script>

<script src="#APPLICATION.htmlPath#/bootstrap/bootstrap-select/bootstrap-select.min.js"></script>
<link rel="stylesheet" href="#APPLICATION.htmlPath#/bootstrap/bootstrap-select/bootstrap-select.min.css">

<script src="#APPLICATION.htmlPath#/scripts/tablesFunctions.js"></script>

<script>

	function confirmDeleteField() {
	
		var message_delete = "Si ELIMINA el campo, se borrarán definitivamente todos los contenidos que almacena. ¿Seguro que desea eliminar el campo?";
		return confirm(message_delete);
	}

	function onSubmitForm(){

		var typeId = $('##field_type_id').val();

		if(typeId == 9 || typeId == 10){

			var selectedAreaid = $('##list_area_id').val();
			if(!$.isNumeric(selectedAreaid)){
				alert("Debe seleccionar un área para generar la lista");
				return false;
			}

		}

		document.getElementById("submitDiv1").innerHTML = 'Enviando...';
		document.getElementById("submitDiv2").innerHTML = 'Enviando...';

		return true;
	}

	function openAreaSelector(){
		
		return openPopUp('#APPLICATION.htmlPath#/iframes/area_select.cfm');
		
	}

	function setSelectedArea(areaId, areaName) {
		
		$("##list_area_id").val(areaId);
		$("##list_area_name").val(areaName);

		loadAreaList(areaId, 1)
			
	}

	function openUserSelectorWithField(fieldName){

		return openPopUp('#APPLICATION.htmlPath#/iframes/users_select.cfm?field='+fieldName);

	}

	function setSelectedUser(userId, userName, fieldName) {
			
		document.getElementById(fieldName).value = userId;
		document.getElementById(fieldName+"_full_name").value = userName;
	}

	function clearFieldSelectedUser(fieldName) {

		document.getElementById(fieldName).value = "";
		document.getElementById(fieldName+"_full_name").value = "";
	}

	function openItemSelectorWithField(itemTypeId,fieldName){

		return openPopUp('#APPLICATION.htmlPath#/iframes/all_items_select.cfm?itemTypeId='+itemTypeId+'&field='+fieldName);

	}

	function loadAreaList(areaId, selectedValue) {

		if(!isNaN(areaId)){

			showLoadingPage(true);

			var areaListPage = "#APPLICATION.htmlPath#/html_content/area_list_input_options.cfm?area="+areaId;

			if(!isNaN(selectedValue)){
				areaListPage = areaListPage+"&selected="+selectedValue;
			}

			$("##default_value_list").load(areaListPage, function() {

				showLoadingPage(false);

				//$('.selectpicker').selectpicker('refresh');
			});

		} else {

			$("##default_value_list").empty();
		}
	}


	function fieldTypeChange(typeId){

		$("##textDefaultValue").hide();
		$("##dateDefaultValue").hide();
		$("##booleanDefaultValue").hide();
		$("##listDefaultValue").hide();
		$("##userDefaultValue").hide();
		$("##itemDefaultValue").hide();

		$("##listAreaSelector").hide();
		$("##fieldInputTypeList").hide();
		$("##fieldInputTypeListMultiple").hide();
		$("##fieldInputItemType").hide();
		$("##fieldInputMaskType").hide();
		$("##listTextValues").hide();

		$("##default_value_text").prop('disabled', true);
		$("##default_value_date").prop('disabled', true);
		$("##default_value_boolean").prop('disabled', true);
		$("##default_value_list").prop('disabled', true);
		$("##default_value_user").prop('disabled', true);
		$("##default_value_item").prop('disabled', true);

		$("##list_area_id").prop('disabled', true);
		$("##field_input_type_list").prop('disabled', true);
		$("##field_input_type_list_multiple").prop('disabled', true);
		$("##item_type_id").prop('disabled', true);
		$("##mask_type_id").prop('disabled', true);

		$("##list_values").prop('disabled', true);


		if(typeId == 6){ //Date

			$("##dateDefaultValue").show();

			$("##default_value_date").prop('disabled', false);
			

		}else if(typeId == 7){ //Boolean

			$("##booleanDefaultValue").show();
			$("##fieldInputTypeList").show();

			$("##default_value_boolean").prop('disabled', false);
			$("##field_input_type_list").prop('disabled', false);

		}else if(typeId == 9 || typeId == 10 || typeId == 15 || typeId == 16){ //List

			if( typeId == 9 || typeId == 10 ) { //Areas list

				$("##listDefaultValue").show();
				$("##listAreaSelector").show();

				$("##default_value_list").prop('disabled', false);
				$("##list_area_id").prop('disabled', false);

			} else { // List of text values

				$("##textDefaultValue").show();
				$("##listTextValues").show();

				$("##default_value_text").prop('disabled', false);
				$("##list_values").prop('disabled', false);

			}

			
			if(typeId == 9 || typeId == 15){
				$("##fieldInputTypeList").show();
				$("##field_input_type_list").prop('disabled', false);

				$("##fieldInputTypeListMultiple").hide();
				$("##field_input_type_list_multiple").prop('disabled', true);
			} else {
				$("##fieldInputTypeList").hide();
				$("##field_input_type_list").prop('disabled', true);

				$("##fieldInputTypeListMultiple").show();
				$("##field_input_type_list_multiple").prop('disabled', false);
			}

		}else if(typeId == 12){ //User

			$("##userDefaultValue").show();

			$("##default_value_user").prop('disabled', false);

		}else if(typeId == 13){ //Item

			$("##fieldInputItemType").show();
			$("##itemDefaultValue").show();

			<cfif page_type IS 1>
				$("##item_type_id").prop('disabled', false);
			</cfif>
			$("##default_value_item").prop('disabled', false);

		}else {

			$("##textDefaultValue").show();
			
			$("##default_value_text").prop('disabled', false);

			if(typeId == 2 || typeId == 3){

				$("##default_value_text").attr("rows", '4');

			}else{

				$("##default_value_text").attr("rows", '1');
			}

			if(typeId == 5) { //Decimal

				$("##fieldInputMaskType").show();

				$("##mask_type_id").prop('disabled', false);
				
			}


		}

	}

	function fieldItemTypeChange(itemTypeId){

		clearFieldSelectedItem('default_value_item');

	}

	$(document).ready(function() { 

		fieldTypeChange(#field.field_type_id#);

		enableDatePicker('##default_value_date');

		<cfif isDefined("field.list_area_id") AND isNumeric(field.list_area_id)>
			loadAreaList(#field.list_area_id#, '#field.default_value#');
		</cfif>

		//$('.selectpicker').selectpicker();
	});
</script>
</cfoutput>

<cfset client_dsn = APPLICATION.identifier&"_"&SESSION.client_abb>

<!---Table fields types--->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Field" method="getFieldTypes" returnvariable="typesResult">
	<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
</cfinvoke>
<cfset fieldTypes = typesResult.fieldTypes>

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<div class="contenedor_fondo_blanco">
<cfoutput>
<cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" class="form-horizontal" onsubmit="return onSubmitForm();">

	<div id="submitDiv1" style="margin-bottom:10px;">
		<input type="submit" value="Guardar" class="btn btn-primary"/>

		<cfif page_type IS 2>
			<span class="divider">&nbsp;&nbsp;</span>

			<a href="#APPLICATION.htmlComponentsPath#/Field.cfc?method=deleteFieldRemote&field_id=#field_id#&tableTypeId=#tableTypeId##url_return_path#" onclick="return confirmDeleteField();" title="Eliminar campo" class="btn btn-danger btn-sm"><i class="icon-remove"></i> <span lang="es">Eliminar</span></a>
		</cfif>
	</div>
	<input type="hidden" name="page" value="#CGI.SCRIPT_NAME#"/>
	<input type="hidden" name="table_id" value="#table_id#"/>
	<input type="hidden" name="tableTypeId" value="#tableTypeId#"/>
	<!---<input type="hidden" name="return_path" value="#return_path#"/>--->

	<cfif page_type IS 2>
		<input type="hidden" name="field_id" value="#field.field_id#"/>
	</cfif>

	<div class="row">
		<div class="col-md-12">
			<label for="label" class="control-label">Nombre *</label>
			<cfif tableTypeId IS 2>
				<cfset labelMaxLength = "500">
			<cfelse>
				<cfset labelMaxLength = "100">
			</cfif>
			<cfinput type="text" name="label" id="label" value="#field.label#" maxlength="#labelMaxLength#" required="true" message="Nombre requerido" class="form-control"/>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<cfif page_type IS 2>
				<input name="field_type_id" type="hidden" value="#field.field_type_id#"/>
			</cfif>
			<label for="field_type_id" class="control-label">Tipo *</label>
			<select name="field_type_id" id="field_type_id" class="form-control" onchange="fieldTypeChange($('##field_type_id').val());" <cfif page_type IS 2>disabled=</cfif>>
				<cfloop query="fieldTypes">

					<cfif ( tableTypeId EQ 2 AND (fieldTypes.field_type_group EQ "user" OR fieldTypes.field_type_group EQ "doplanning_item") ) OR ( tableTypeId NEQ 3 AND fieldTypes.field_type_id EQ 14 )><!---Los campos "user" y "doplanning_item" no están disponibles en los formularios. El campo "Request URL" sólo está disponible en archivos--->
						<cfcontinue>
					<cfelse>
						<option value="#fieldTypes.field_type_id#" <cfif field.field_type_id IS fieldTypes.field_type_id>selected="selected"</cfif>>#fieldTypes.name#</option>						
					</cfif>
					
				</cfloop>
			</select>
			<small class="help-block">No se puede modificar el tipo una vez creado el campo.</small>
		</div>
	</div>
		
	<div class="row" id="fieldInputItemType">	
		<div class="col-md-10">
			<cfif page_type IS 2 AND isNumeric(field.item_type_id)>
				<input name="item_type_id" type="hidden" value="#field.item_type_id#"/>
			</cfif>			

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemManager" method="getAreaItemTypesStruct" returnvariable="itemTypesStruct">
				<!---<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">--->
			</cfinvoke>

			<cfset itemTypesArray = structSort(itemTypesStruct, "numeric", "ASC", "position")>

			<label class="control-label" for="item_type_id" id="subTypeLabel"><span lang="es">Tipo de elemento de DoPlanning</span> *</label>
			<select name="item_type_id" id="item_type_id" class="form-control" onchange="fieldItemTypeChange($('##item_type_id').val());" <cfif page_type IS 2>disabled</cfif>>
				<cfloop array="#itemTypesArray#" index="itemTypeId">
					<cfif itemTypesStruct[itemTypeId].showInSelect IS true>
						<option value="#itemTypeId#" lang="es" <cfif field.item_type_id IS itemTypeId>selected="selected"</cfif>>#itemTypesStruct[itemTypeId].label#</option>
					</cfif>
				</cfloop>
			</select>
			<small class="help-block">No se puede modificar el tipo de elemento DoPlanning una vez creado el campo.</small>

		</div>
	</div>

	<div class="row" id="fieldInputMaskType">
		<div class="col-md-12">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FieldManager" method="getFieldMaskTypesStruct" returnvariable="maskTypesStruct">
				<cfinvokeargument name="tableTypeId" value="#tableTypeid#">
				<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
			</cfinvoke>

			<cfset maskTypesArray = structSort(maskTypesStruct, "numeric", "ASC", "position")>

			<label for="mask_type_id" class="control-label">Máscara</label>
			<select name="mask_type_id" id="mask_type_id" class="form-control"><!---onchange="fieldItemTypeChange($('##item_type_id').val());"--->
				<option value="">Sin máscara</option>
				<cfloop array="#maskTypesArray#" index="maskTypeId">
					<option value="#maskTypeId#" lang="es" <cfif field.mask_type_id IS maskTypeId>selected="selected"</cfif>>#maskTypesStruct[maskTypeId].label# (#maskTypesStruct[maskTypeId].description#)</option>
				</cfloop>
			</select>
			<small class="help-block">Permite definir como se mostrará el valor numérico introducido.</small>
		</div>
	</div>

	<div class="row" id="fieldInputTypeList">
		<div class="col-md-12">
			<label for="field_input_type_list" class="control-label">Mostrar opciones en</label>
			<select name="field_input_type" id="field_input_type_list" class="form-control">
				<option value="select" <cfif field.field_input_type EQ "select">selected="selected"</cfif>>Lista desplegable</option>
				<option value="radio" <cfif field.field_input_type EQ "radio">selected="selected"</cfif>>Radio (se muestran visibles todas las opciones)</option>
			</select>
		</div>
	</div>

	<div class="row" id="fieldInputTypeListMultiple">
		<div class="col-md-12">
			<label for="field_input_type_list_multiple" class="control-label">Mostrar opciones en</label>
			<select name="field_input_type" id="field_input_type_list_multiple" class="form-control">
				<option value="select" <cfif field.field_input_type EQ "select">selected="selected"</cfif>>Lista</option>
				<option value="checkbox" <cfif field.field_input_type EQ "checkbox">selected="selected"</cfif>>Checkbox (se muestran visibles todas las opciones)</option>
			</select>
		</div>
	</div>

	<div class="row" id="listAreaSelector">
		<div class="col-md-12">
			<cfif isDefined("field.list_area_id") AND isNumeric(field.list_area_id)>
				<!--- getArea --->
				<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="getArea" returnvariable="listArea">
					<cfinvokeargument name="area_id" value="#field.list_area_id#">
				</cfinvoke>
				<cfset list_area_name = listArea.name>
			<cfelse>
				<cfset list_area_name = "">
			</cfif>
			<label for="default_value_text" class="control-label">Área a para generar la lista</label>
			<div class="controls">
				<input type="hidden" name="list_area_id" id="list_area_id" value="#field.list_area_id#" />
				<cfinput type="text" name="list_area_name" id="list_area_name" value="#list_area_name#" readonly="true" onclick="openAreaSelector()" /> <button onclick="return openAreaSelector()" type="button" class="btn btn-default" lang="es">Seleccionar área</button>
			</div>
		</div>
	</div>

	<div class="row" id="listTextValues">
		<div class="col-md-12">
			<label for="list_values">Valores de la lista</label>
			<textarea name="list_values" id="list_values" class="form-control" maxlength="5000" rows="5" <cfif field.field_type_id NEQ 15>disabled="disabled"</cfif>>#field.list_values#<!--- <cfif isDefined("field.list_values")> ESTE IF SE QUITA CUANDO SE AÑADA ESTA FUNCIONALIDAD PARA TODOS LOS DP----></textarea>
			<small class="help-block">Introduce cada valor de la lista en una línea distinta<!---<br/>Ejemplo: Azul<br/>Verde<br/>Amarillo---></small>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="checkbox">
				<label for="required">
					<input type="checkbox" name="required" id="required" value="true" <cfif isDefined("field.required") AND field.required IS true>checked="checked"</cfif> /> Obligatorio<br/>
				</label>
				<small class="help-block">Indica si el campo deber rellenarse de forma obligatoria</small>
			</div>
		</div>
	</div>

	<cfif tableTypeId IS NOT 3>
		
	<div class="row">
		<div class="col-md-12">
			<label for="sort_by_this" class="control-label">Ordenar por defecto por este campo</label>
			<select name="sort_by_this" id="sort_by_this" class="form-control">
				<option value="" <cfif field.sort_by_this IS "">selected="selected"</cfif>>No</option>
				<option value="asc" <cfif field.sort_by_this IS "asc">selected="selected"</cfif>>Orden ascendente</option>
				<option value="desc" <cfif field.sort_by_this IS "desc">selected="selected"</cfif>>Orden descendente</option>
			</select>
			<small class="help-block">Se mostrarán ordenados los registros en el orden especificado por el primer campo que tenga seleccionada esta opción</small>
			<!---<div class="checkbox">
				<label for="sort_by_this">
					<input type="checkbox" name="sort_by_this" id="sort_by_this" value="true" <cfif isDefined("field.sort_by_this") AND field.sort_by_this IS true>checked="checked"</cfif> /> Ordenar por defecto por este campo<br/>
				</label>
				<small class="help-block">Se mostrarán ordenados los registros por el primer campo que tenga seleccionada esta opción</small>
			</div>--->
		</div>
	</div>

	<cfelse><!--- Typologies --->
		<input name="sort_by_this" type="hidden" value="" />
	</cfif>

	<div class="row">
		<div class="col-md-12">
			<label for="description" class="control-label">Descripción</label>
			<textarea name="description" id="description" class="form-control" maxlength="1000">#field.description#</textarea>
		</div>
	</div>

	<div class="row" id="textDefaultValue">
		<div class="col-md-12">
			<label for="default_value_text">Valor por defecto</label>
			<textarea name="default_value" id="default_value_text" class="form-control" maxlength="1000" rows="4" <cfif field.field_type_id IS 6 OR field.field_type_id IS 7>disabled="disabled"</cfif>>#field.default_value#</textarea>
		</div>
	</div>
	<div class="row" id="dateDefaultValue">
		<div class="col-md-12">
			<label for="default_value_date" class="control-label">Valor por defecto</label>
			<input type="text" name="default_value" id="default_value_date" value="#field.default_value#" maxlength="10" class="input_datepicker" <cfif field.field_type_id NEQ 6>disabled="disabled"</cfif>/> <span class="help-inline">Fecha formato DD-MM-AAAA</span>
		</div>
	</div>
	<div class="row" id="booleanDefaultValue">
		<div class="col-md-12">
			<label for="default_value_boolean" class="control-label">Valor por defecto</label>
			<select name="default_value" id="default_value_boolean" class="input-sm" <cfif field.field_type_id NEQ 7>disabled="disabled"</cfif>>
				<option value=""></option>
				<option value="0" <cfif field.default_value IS false>selected="selected"</cfif>>No</option>
				<option value="1" <cfif field.default_value IS true>selected="selected"</cfif>>Sí</option>
			</select>
		</div>
	</div>

	<div class="row" id="listDefaultValue">
		<div class="col-md-12">
			<label for="default_value_boolean" class="control-label">Valor por defecto</label>
			<select name="default_value" id="default_value_list" class="selectpicker span5" <cfif field.field_type_id NEQ 9 OR field.field_type_id NEQ 10>disabled="disabled"</cfif>><!---multiple---></select>
		</div>
	</div>
	
	<div class="row" id="userDefaultValue">
		<div class="col-md-12">

			<cfset field_default_value = field.default_value>

			<cfif field.field_type_id IS 12 AND isNumeric(field_default_value)>
				<cfinvoke component="#APPLICATION.coreComponentsPath#/UserQuery" method="getUser" returnvariable="userQuery">
					<cfinvokeargument name="user_id" value="#field_default_value#">

					<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif userQuery.recordCount GT 0>
					<cfif len(userQuery.user_full_name) GT 0 AND userQuery.user_full_name NEQ " ">
						<cfset field_value_user = userQuery.user_full_name>
					<cfelse>
						<cfset field_value_user = "USUARIO SELECCIONADO SIN NOMBRE">
					</cfif>
				<cfelse>
					<cfset field_value_user = "USUARIO NO DISPONIBLE">
					<cfset field_default_value = "">
				</cfif>
			<cfelse>
				<cfset field_value_user = "">
			</cfif>

			<div class="row">
				<div class="col-md-12">
					<label for="default_value_user" class="control-label">Valor por defecto</label>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-11 col-sm-6">
					<input type="hidden" name="default_value" id="default_value_user" value="#field_default_value#" />
					<input type="text" name="default_value_user_full_name" id="default_value_user_full_name" value="#field_value_user#" class="form-control" readonly onclick="openUserSelectorWithField('default_value_user')" />
				</div>
				<div class="col-xs-1 col-sm-6">
					<button onclick="clearFieldSelectedUser('default_value_user')" type="button" class="btn btn-default" lang="es" title="Quitar usuario seleccionado"><i class="icon-remove"></i></button> 
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-6">
					<button onclick="openUserSelectorWithField('default_value_user')" type="button" class="btn btn-default" lang="es">Seleccionar usuario</button>
				</div>
			</div>

		</div>
	</div>


	<div class="row" id="itemDefaultValue">
		<div class="col-md-12">

			<cfset field_default_value = field.default_value>

			<cfif field.field_type_id IS 13 AND isNumeric(field_default_value)>

				<cfif field.item_type_id IS 10><!--- FILE --->

					<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="fileQuery">
						<cfinvokeargument name="file_id" value="#field_default_value#">
						<cfinvokeargument name="parse_dates" value="false"/>
						<cfinvokeargument name="published" value="false"/>

						<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

					<cfif fileQuery.recordCount GT 0>
						<cfif len(fileQuery.name) GT 0>
							<cfset field_value_title = fileQuery.name>
						<cfelse>
							<cfset field_value_title = "ARCHIVO SELECCIONADO SIN TÍTULO">
						</cfif>
					<cfelse>
						<cfset field_value_title = "ARCHIVO NO DISPONIBLE">
						<cfset field_default_value = "">
					</cfif>
					
				<cfelse><!--- ITEM --->

					<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getItem" returnvariable="itemQuery">
						<cfinvokeargument name="item_id" value="#field_default_value#">
						<cfinvokeargument name="itemTypeId" value="#field.item_type_id#">
						<cfinvokeargument name="parse_dates" value="false"/>
						<cfinvokeargument name="published" value="false"/>

						<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

					<cfif itemQuery.recordCount GT 0>
						<cfif len(itemQuery.title) GT 0>
							<cfset field_value_title = itemQuery.title>
						<cfelse>
							<cfset field_value_title = "ELEMENTO SELECCIONADO SIN TÍTULO">
						</cfif>
					<cfelse>
						<cfset field_value_title = "ELEMENTO NO DISPONIBLE">
						<cfset field_default_value = "">
					</cfif>

				</cfif>
				
			<cfelse>
				<cfset field_value_title = "">
			</cfif>

			<div class="row">
				<div class="col-md-12">
					<label for="default_value_item" class="control-label">Valor por defecto</label>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-11 col-sm-6">
					<input type="hidden" name="default_value" id="default_value_item" value="#field_default_value#" />
					<textarea name="default_value_title" id="default_value_item_title" class="form-control" readonly onclick="openItemSelectorWithField($('##item_type_id').val(),'default_value_item')">#field_value_title#</textarea>
				</div>
				<div class="col-xs-1 col-sm-6">
					<button onclick="clearFieldSelectedItem('default_value_item')" type="button" class="btn btn-default" lang="es" title="Quitar elemento seleccionado"><i class="icon-remove"></i></button> 
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-6">
					<button onclick="openItemSelectorWithField($('##item_type_id').val(),'default_value_item')" type="button" class="btn btn-default" lang="es">Seleccionar elemento</button>
				</div>
			</div>


		</div>
	</div>


	<!---<label for="position">Posición</label>
	<cfinput type="text" name="position" id="position" value="#field.position#" required="true" validate="integer" message="Posición debe ser un número entero" style="width:50px;">--->

	<div id="submitDiv2" style="margin-top:20px;">
		<input type="submit" value="Guardar" class="btn btn-primary"/>
		<!---<a href="area_items.cfm?area=#area_id#" class="btn btn-default">Cancelar</a>--->
	</div>
	
</cfform>
</cfoutput>
</div>