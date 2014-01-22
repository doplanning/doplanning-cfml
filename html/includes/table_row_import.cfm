<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

<cfif isDefined("URL.#tableTypeName#") AND isNumeric(URL[tableTypeName])>
	<cfset table_id = URL[tableTypeName]>
<cfelse>
	<cflocation url="empty.cfm" addtoken="no">
</cfif>

<cfif isDefined("FORM.file")>
							
	<cfinvoke component="#APPLICATION.htmlComponentsPath#/Row" method="importRows" returnvariable="actionResponse" argumentcollection="#FORM#">
	</cfinvoke>		
	
	<cfif actionResponse.result IS true><!---The import is success--->

		<cflocation url="#tableTypeName#_rows.cfm?#tableTypeName#=#table_id#&res=1&msg=#actionResponse.message#" addtoken="false">
		
	<cfelse><!---There is an error in the import--->
		
		<cfset URL.res = 0>
		<cfset URL.msg = actionResponse.message>

		<cfset fileArray = actionResponse.fileArray>

	</cfif>

<cfelse>

	<script type="text/javascript">
		openUrlHtml2('empty.cfm','itemIframe');
	</script>		

</cfif>

<!--- Table --->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="getTable" returnvariable="table">
	<cfinvokeargument name="table_id" value="#table_id#">
	<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
</cfinvoke>

<cfset area_id = table.area_id>

<!---Table fields--->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="getTableFields" returnvariable="fieldsResult">
	<cfinvokeargument name="table_id" value="#table_id#">
	<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
	<cfinvokeargument name="with_types" value="true"/>
</cfinvoke>
<cfset fields = fieldsResult.tableFields>

<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">

<cfoutput>
<div class="div_message_page_title">#table.title#</div>
<div class="div_separator"><!-- --></div>
</cfoutput>

<div class="div_head_subtitle">
	<span lang="es">Importar registros</span>
</div>

<div class="div_separator"><!-- --></div>

<div class="contenedor_fondo_blanco">

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<cfoutput>

<cfif isDefined("fileArray") AND arrayLen(fileArray) GT 0>

	<h5>Valores cargados del archivo:</h5>
	<table class="table-bordered" style="font-size:10px; margin-bottom:20px;">
		<tbody>

			<tr>
				<td></td>
				<cfloop from="1" to="#ArrayLen(fileArray[1])#" step="1" index="curColumn">
					<td style="color:##CCCCCC">#curColumn#</td>
				</cfloop>
			</tr>
		<cfloop from="1" to="#ArrayLen(fileArray)#" step="1" index="curRow">

			<tr>
				<td style="color:##CCCCCC">#curRow#</td>
			<cfloop from="1" to="#ArrayLen(fileArray[1])#" step="1" index="curColumn">

				<cfset fieldValue = fileArray[curRow][curColumn]>
				<td>#fieldValue#</td>

			</cfloop>
			</tr>

		</cfloop>
		</tbody>
	</table>

</cfif>

	<cfset booleanFields = false>
	<cfset dateFields = true>
	<cfset listFields = true>

	<p class="help-block" style="font-size:12px;">
		El archivo utilizado para realizar esta importación deberá tener las siguientes características:<br/>
	
			-Tipo de archivo: <strong>.csv o .txt</strong> delimitado por ; o por tabulaciones.<br/>
			-Codificación: <strong>iso-8859-1</strong> (codificación por defecto en Windows).<br />
			-Número de columnas: <strong>#fields.recordCount#</strong>.<br />
			-<strong>Orden de las columnas</strong>:<br />
			<em>
				<cfloop query="fields">
					#fields.label#
					<cfif fields.currentRow NEQ fields.recordCount>
						,
					</cfif>
					<cfif fields.field_type_id IS 7><!--- BOOLEAN --->
						<cfset booleanFields = true>
					<cfelseif fields.field_type_id EQ 9 OR fields.field_type_id EQ 10><!--- LISTS --->
						<cfset listFields = true>
					<cfelseif fields.input_type IS "date"><!--- DATE --->
						<cfset dateFields = true>
					</cfif>
				</cfloop>
			</em><br/>
			-Si el orden de las columnas no corresponde con el anterior la importación no se realizará correctamente.<br/>
			<!---<cfif listFields IS true>--->
			-<strong>Campos listas</strong>: para que la importación de los campos de listas se realice correctamente, el valor importado de estos campos deberá coincidir exactamente con uno de los valores existentes en la lista.<br/>
			<!---</cfif>
			<cfif booleanFields IS true>--->
			-<strong>Campos Sí/No</strong>: los valores válidos para estos campos son <i>Sí/No, Yes/No, true/false, 0/1</i>.<br/>
			<!---</cfif>
			<cfif dateFields IS true>--->
			-<strong>Campos fecha</strong>: formatos válidos las fechas: <i>DD-MM-AAAA, DD/MM/AAAA</i>.<br/>
			<!---</cfif>--->

			<!----En el archivo no debe aparecer ninguna fila con los títulos de las columnas.<br/>--->
			<!----La primera fila del archivo corresponderá a los títulos de las columnas. Los títulos de las columnas pueden ser diferentes a los indicados, pero <strong>no pueden contener espacios, tildes o caracteres especiales</strong>.<br/>--->
			-Si no se cumplen las características anteriores, la importación no se podrá realizar correctamente.
			<br/>
			<!--- -<a href="usuarios_ejemplo.csv">Aquí</a> puede descargar un archivo de ejemplo.<br/>--->
		<br/>
		No se enviará notificación de los nuevos registros a los usuarios.<br/>
		Una vez pulsado el botón "Importar registros" debe esperar hasta que se complete la operación.
	</p>

	<script type="text/javascript">

		function onSubmitForm(){

			document.getElementById("submitDiv1").innerHTML = window.lang.convert('Enviando...');

		}

	</script>

	<cfform name="import_data" method="post" action="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#" enctype="multipart/form-data" onsubmit="onSubmitForm();" class="form-horizontal">

		<input type="hidden" name="table_id" value="#table_id#" />
		<input type="hidden" name="tableTypeId" value="#tableTypeId#" />

		<div class="row">
			<div class="col-sm-6">
				<label class="control-label" for="file">Archivo CSV con los registros a importar</label>
				<cfinput name="file" id="file" type="file" required="yes" accept=".csv,.tsv,text/plain" message="Archivo de datos requerido para la importación" class="form-control">
			</div>
		</div>

		<div class="row">
			<label for="delimiter" class="col-xs-6 col-sm-3 col-md-2 control-label" style="text-align:left">Delimitador de campos</label>
			<div class="col-xs-5 col-sm-3 col-md-3">
				<select name="delimiter" id="delimiter" class="form-control">
					<option value=";" <cfif isDefined("FORM.delimiter") AND FORM.delimiter EQ ";">selected="selected"</cfif>>Punto y coma ;</option>
					<option value="tab" <cfif isDefined("FORM.delimiter") AND FORM.delimiter EQ "tab">selected="selected"</cfif>>Tabulación</option>
				</select>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="delete_rows" value="true" <cfif isDefined("FORM.delete_rows")>checked</cfif>> Borrar registros existentes en <cfif tableTypeGender EQ "male">el<cfelse>la</cfif> #tableTypeNameEs#
		        </label>
		      </div>
		    </div>
		</div>

		<div class="row">
			<div class="col-sm-12">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="cancel_on_error" value="false" <cfif isDefined("FORM.cancel_on_error")>checked</cfif>> No cancelar si hay errores en importación de registros 
		        </label>
		      </div>
		    </div>
		</div>

		<div class="row">
			<div class="col-sm-12">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox" name="start_row" value="1"<cfif isDefined("FORM.start_row")>checked</cfif>> Importar primera fila del archivo
		        </label>
		        <small class="help-block">Por defecto no se importa la primera fila del archivo (fila para los títulos de las columnas)</small>
		      </div>
		    </div>
		</div>

		<div class="row" style="margin-top:20px">
			<div class="col-sm-12" id="submitDiv1">
				<input type="submit" value="Importar registros" class="btn btn-primary" />

				<a href="#tableTypeName#_rows.cfm?#tableTypeName#=#table_id#&area=#area_id#" class="btn btn-default" style="float:right" lang="es">Cancelar</a>
			</div>
		</div>
				
	</cfform>



</cfoutput>
	
</div><!--- END contenedor_fondo_blanco --->