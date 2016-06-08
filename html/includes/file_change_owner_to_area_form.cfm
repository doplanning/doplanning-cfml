<cfinclude template="#APPLICATION.htmlPath#/includes/file_change_owner_to_area_query.cfm">

<!--- 
<cfoutput>
<script src="#APPLICATION.htmlPath#/language/area_item_en.js" charset="utf-8" type="text/javascript"></script>
</cfoutput> --->


<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">

<div class="div_head_subtitle"><span lang="es">Convertir en archivo de área</span></div>

<cfoutput>

<script>

	function onSubmitForm() {

		if(check_custom_form())	{
			document.getElementById("submitDiv").innerHTML = window.lang.translate("Enviando...");

			return true;
		}
		else
			return false;
	}

	function openAreaSelector(){

		<cfif isNumeric(file.publication_scope_id)>
			return openPopUp('#APPLICATION.mainUrl##APPLICATION.htmlPath#/iframes/area_select.cfm?web_enabled=0&no_web_enabled=1&scope=#file.publication_scope_id#');
		<cfelse>
			return openPopUp('#APPLICATION.mainUrl##APPLICATION.htmlPath#/iframes/area_select.cfm?web_enabled=0&no_web_enabled=1');
		</cfif>

	}

	function setSelectedArea(areaId, areaName) {

		$("##new_area_id").val(areaId);
		$("##new_area_name").val(areaName);

	}

</script>

<script type="text/javascript" src="#APPLICATION.htmlPath#/scripts/checkRailoForm.js"></script>

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<div class="contenedor_fondo_blanco">

<cfform action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" method="post" enctype="multipart/form-data" name="file_form" class="form-horizontal" onsubmit="return onSubmitForm();">
	
	<script>
		var railo_custom_form;

		if( typeof LuceeForms !== 'undefined' && $.isFunction(LuceeForms) ) 
			railo_custom_form = new LuceeForms('file_form');
		else
			railo_custom_form = new RailoForms('file_form');
	</script>
	
	<input type="hidden" name="page" value="#CGI.SCRIPT_NAME#" />
	<input type="hidden" name="file_id" value="#file_id#"/>
	<input type="hidden" name="area_id" value="#area_id#"/>

	<div class="row">
		<div class="col-sm-12">
			<span lang="es">Nombre del archivo:</span>
			<strong>#file.name#</strong>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-12">
			<span lang="es">Propietario actual:</span>
			<strong>#file.user_full_name#</strong>
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-12 col-sm-8">
			<label class="control-label" for="new_area_name" lang="es">Área propietaria del archivo</label>
			<input type="hidden" name="new_area_id" id="new_area_id" value="#ownerArea.new_area_id#" validate="integer" required="true"/>
			<cfinput type="text" name="new_area_name" id="new_area_name" value="#ownerArea.new_area_name#" readonly="true" required="true" message="Debe seleccionar una nueva área" onclick="openAreaSelector()" class="form-control" /> <button onclick="return openAreaSelector()" class="btn btn-default" lang="es">Seleccionar área</button>
		</div>
	</div>

	<p class="help-block" style="font-size:12px;">
		<span lang="es">El archivo pasará a ser propiedad del área seleccionada y podrá ser modificado por cualquier usuario de la misma.</span><br>
		<span lang="es">El archivo seguirá estando accesible desde el área actual.</span><br>
		<span lang="es">Se enviará notificación por email del cambio a los usuarios del área propietaria.</span>
	</p>
	
	<div style="height:10px;"><!--- ---></div>

	<div id="submitDiv">
		<input type="submit" class="btn btn-primary" name="modify" value="Convertir en archivo de área" lang="es"/>

		<a href="file.cfm?file=#file_id#&area=#area#" class="btn btn-default" style="float:right" lang="es">Cancelar</a>
	</div>
</cfform>

</div>

</cfoutput>