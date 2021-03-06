<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

<cfif isDefined("URL.#tableTypeName#") AND isNumeric(URL[tableTypeName])>
	<cfset table_id = URL[tableTypeName]>
<cfelse>
	<cflocation url="empty.cfm" addtoken="no">
</cfif>

<!--- Table --->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="getTable" returnvariable="table">
	<cfinvokeargument name="table_id" value="#table_id#">
	<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
</cfinvoke>

<cfif isDefined("URL.area") AND isNumeric(URL.area)>
	<cfset area_id = URL.area>
<cfelse>
	<cfset area_id = table.area_id>
</cfif>

<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">

<cfif app_version NEQ "mobile">
	<cfoutput>
	<div class="div_message_page_title">#table.title#</div>
	<div class="div_separator"><!-- --></div>
	</cfoutput>
</cfif>

<div class="div_head_subtitle">
	<span lang="es">Exportar registros</span>
</div>

<div class="div_separator"><!-- --></div>

<div class="contenedor_fondo_blanco">

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<cfoutput>

	<cfif table.general IS true>
		<div class="alert alert-info" role="alert"><span lang="es">Se incluirán en la exportación los registros de esta área y las inferiores.</span></div>
	</cfif>

	<p class="help-block" style="font-size:12px;">
		<span lang="es">Se generará un archivo con codificación iso-8859-1 con el contenido de los registros.</span>
	</p>

	<script type="text/javascript">

		function onSubmitForm(){

			document.getElementById("submitDiv1").innerHTML = window.lang.translate('Exportación solicitada...');

			showLoading = false;
		}

	</script>

	<cfform name="export_data" method="post" action="table_row_export_download.cfm?#CGI.QUERY_STRING#" onsubmit="onSubmitForm();" class="form-horizontal">

		<input type="hidden" name="table_id" value="#table_id#" />
		<input type="hidden" name="tableTypeId" value="#tableTypeId#" />
		<input type="hidden" name="area_id" value="#area_id#" />

		<div class="row">
			<label for="delimiter" class="col-xs-6 col-sm-3 col-md-2 control-label" style="text-align:left" lang="es">Delimitador de campos</label>
			<div class="col-xs-5 col-sm-3 col-md-3">
				<select name="delimiter" id="delimiter" class="form-control">
					<option value=";" <cfif isDefined("FORM.delimiter") AND FORM.delimiter EQ ";">selected="selected"</cfif> lang="es">Punto y coma ;</option>
					<option value="tab" <cfif isDefined("FORM.delimiter") AND FORM.delimiter EQ "tab">selected="selected"</cfif> lang="es">Tabulación</option>
				</select>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12">
		      <b lang="es">Incluir las siguientes columnas:</b>
		    </div>
		</div>

		<div class="row">
			<div class="col-xs-offset-1 col-xs-11">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="include_creation_date" value="true"><span lang="es">Fecha de creación</span>
		      	</label>
		      </div>
		    </div>
		</div>

		<div class="row">
			<div class="col-xs-offset-1 col-xs-11">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="include_last_update_date" value="true"><span lang="es">Fecha de última modificación</span>
		      	</label>
		      </div>
		    </div>
		</div>

		<div class="row">
			<div class="col-xs-offset-1 col-xs-11">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="include_insert_user" value="true"><span lang="es">Usuario creación</span>
		      	</label>
		      </div>
		    </div>
		</div>

		<div class="row">
			<div class="col-xs-offset-1 col-xs-11">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="include_update_user" value="true"><span lang="es">Usuario última modificación</span>
		      </label>
		      </div>
		    </div>
		</div>

		<div class="row">
			<div class="col-sm-12">
				&nbsp;
		    </div>
		</div>

		<div class="row">
			<div class="col-sm-12">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="decimals_with_mask" value="true"><span lang="es">Aplicar máscaras a los valores decimales exportados.</span>
		       <br/><span lang="es">Use esta opción para poder exportar los valores decimales delimitados por coma en lugar de punto para que sean interpretados correctamente en Excel</span></label>
		      </div>
		    </div>
		</div>

		<div class="row">
			<div class="col-sm-12">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="ms_excel_compatibility" value="true"><span lang="es">Habilitar compatibilidad de apertura con las nuevas versiones de Microsoft Office Excel (versiones a partir de 2010)</span>
		      	</label>
		      </div>
		    </div>
		</div>



		<div class="row" style="margin-top:20px">
			<div class="col-sm-12" id="submitDiv1">
				<input type="submit" value="Exportar registros" class="btn btn-primary" lang="es" />
				<a href="#tableTypeName#_rows.cfm?#tableTypeName#=#table_id#&area=#area_id#" class="btn btn-default" style="float:right" lang="es">Cancelar</a>
			</div>
		</div>

	</cfform>



</cfoutput>

</div><!--- END contenedor_fondo_blanco --->
