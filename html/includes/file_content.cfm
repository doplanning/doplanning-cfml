<!---Required var: 
	page_type
	return_path (para eliminar o quitar un archivo de un área)
	
	page_types:
		1 Mis documentos
			folder_id required
		2 Archivos de un area
			area_id required
--->

<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFile" returnvariable="objectFile">
	<cfinvokeargument name="file_id" value="#file_id#">
	<cfif isDefined("area_id")>
	<cfinvokeargument name="area_id" value="#area_id#">
	</cfif>
</cfinvoke>

<cfset fileTypeId = objectFile.file_type_id>

<cfoutput>
<script src="#APPLICATION.htmlPath#/language/file_content_en.js" charset="utf-8" type="text/javascript"></script>
</cfoutput>

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<script type="text/javascript">

function confirmDeleteFile() {
	
	var messageDelete = window.lang.convert("Si ELIMINA el archivo, se borrará de TODAS las áreas a las que esté asociado. ¿Seguro que desea borrar el archivo?");
	return confirm(messageDelete);
}

function confirmLockFile(value) {
	
	var messageLock = "";

	if(value)
		messageLock = "¿Seguro que desea bloquear el archivo?. No podrá ser modificado por otros usuarios.";
	else
		messageLock = "¿Seguro que desea desbloquear el archivo?.";
	
	return confirm(messageLock);
}

</script>

<cfoutput>
<div class="div_file_page_name">#objectFile.name#</div>
<div class="div_separator"><!-- --></div>

<div class="div_elements_menu"><!---div_elements_menu--->

	<cfif APPLICATION.identifier NEQ "vpnet"><!---DP--->
	
		<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#objectFile.id#" onclick="return downloadFileLinked(this,event)" class="btn btn-small btn-info"><i class="icon-download-alt"></i> <span lang="es">Descargar</span></a>
		
		<cfif listFind(".gif,.jpg,.png",objectFile.file_type) GT 0>
			<cfif page_type IS 1>
			
				<a href="my_files_file_view.cfm?file=#objectFile.id#&folder=#folder_id#" class="btn btn-small"><i class="icon-eye-open"></i> <span lang="es">Visualizar</span></a>
			
			<cfelse>
			
				<a href="area_file_view.cfm?file=#objectFile.id#&area=#area_id#" class="btn btn-small"><i class="icon-eye-open"></i> <span lang="es">Visualizar</span></a>
			
			</cfif>
		</cfif>
	
		
		<cfif page_type IS 1> 

			<a href="my_files_file_replace.cfm?file=#objectFile.id#&folder=#folder_id#" class="btn btn-small"><i class="icon-repeat"></i> <span lang="es">Reemplazar</span></a>
			
			<cfif app_version NEQ "mobile">
			<a href="#APPLICATION.htmlPath#/file.cfm?file=#objectFile.id#&area=#area_id#" title="Abrir en nueva ventana" target="_blank" class="btn btn-small" lang="es"><i class="icon-external-link"></i> <span lang="es">Ampliar</span></a>
			</cfif>
			
			<a href="file_associate_areas.cfm?file=#objectFile.id#&folder=#folder_id#" class="btn btn-small"><i class="icon-plus-sign"></i> <span lang="es">Asociar a áreas</span></a>
			
			<a href="#APPLICATION.htmlComponentsPath#/File.cfc?method=deleteFile&file_id=#objectFile.id#&folder_id=#folder_id#" onclick="return confirmDeleteFile();" class="btn btn-danger btn-small"><i class="icon-remove"></i> <span lang="es">Eliminar</span></a>
			<a href="my_files_file_modify.cfm?file=#objectFile.id#&folder=#folder_id#" class="btn btn-small btn-info"><i class="icon-edit"></i> <span lang="es">Modificar datos</span></a>


		<cfelseif page_type IS 2>

			<cfif fileTypeId IS 2><!---Area file--->
				
				<!---area_allowed--->
				<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="canUserAccessToArea" returnvariable="file_area_allowed">
					<cfinvokeargument name="area_id" value="#objectFile.area_id#">
				</cfinvoke>

			</cfif>
			
			<cfif (fileTypeId IS 1 AND objectFile.user_in_charge EQ SESSION.user_id) OR (fileTypeId IS 2 AND file_area_allowed IS true)>

				<cfif fileTypeId IS 1 || (fileTypeId IS 2 AND objectFile.locked IS true AND objectFile.lock_user_id IS SESSION.user_id)>
					<a href="area_file_replace.cfm?file=#objectFile.id#&area=#area_id#" class="btn btn-small"><i class="icon-repeat"></i> <span lang="es">Reemplazar</span></a>
					<a href="area_file_modify.cfm?file=#objectFile.id#&area=#area_id#&fileTypeId=#fileTypeId#" class="btn btn-small"><i class="icon-edit"></i> <span lang="es">Modificar datos</span></a>
				</cfif>
				
				<cfif app_version NEQ "mobile">
					<a href="#APPLICATION.htmlPath#/file.cfm?file=#objectFile.id#&area=#area_id#" title="Abrir en nueva ventana" target="_blank" class="btn btn-small" lang="es"><i class="icon-external-link"></i> <span lang="es">Ampliar</span></a>
				</cfif>
				
				<a href="area_file_associate_areas.cfm?file=#objectFile.id#&area=#area_id#" class="btn btn-small"><i class="icon-plus-sign"></i> <span lang="es">Asociar a áreas</span></a>
				
				<cfif fileTypeId IS NOT 2 OR area_id NEQ objectFile.area_id>
					<a href="#APPLICATION.htmlComponentsPath#/File.cfc?method=dissociateFile&file_id=#objectFile.id#&area_id=#area_id#&return_path=#return_path#" class="btn btn-warning btn-small"><i class="icon-minus-sign"></i> <span lang="es">Quitar del área</span></a>
				</cfif>

				<cfif fileTypeId IS 2><!--- Area file --->
					
					<cfif objectFile.locked IS true>
						<cfif objectFile.lock_user_id IS SESSION.user_id OR is_user_area_responsible>
							<a href="#APPLICATION.htmlComponentsPath#/File.cfc?method=lockFile&file_id=#objectFile.id#&area_id=#area_id#&lock=false&return_path=#return_path#" class="btn btn-warning btn-small" onclick="return confirmLockFile(false);"><i class="icon-unlock"></i> <span lang="es">Desbloquear</span></a>
						</cfif>
					<cfelse>
						<a href="#APPLICATION.htmlComponentsPath#/File.cfc?method=lockFile&file_id=#objectFile.id#&area_id=#area_id#&lock=true&return_path=#return_path#" class="btn btn-warning btn-small" onclick="return confirmLockFile(true);"><i class="icon-lock"></i> <span lang="es">Bloquear</span></a>
					</cfif>

				</cfif>
				
				<cfif fileTypeId IS 1 || (fileTypeId IS 2 AND objectFile.locked IS false)>
					<a href="#APPLICATION.htmlComponentsPath#/File.cfc?method=deleteFileRemote&file_id=#objectFile.id#&area_id=#area_id#&return_path=#return_path#" onclick="return confirmDeleteFile();" class="btn btn-danger btn-small"><i class="icon-remove"></i> <span lang="es">Eliminar</span></a>
				</cfif>

			</cfif>

			<cfif ( fileTypeId IS 1 || (fileTypeId IS 2 AND objectFile.locked IS false) ) AND ( objectFile.user_in_charge EQ SESSION.user_id OR is_user_area_responsible )>
			
				<a href="file_change_user.cfm?file=#objectFile.id#&area=#area_id#" class="btn btn-warning btn-small"><i class="icon-user"></i> <span lang="es">Cambiar propietario</span></a>

				<cfif fileTypeId IS 2>
					<a href="file_change_area.cfm?file=#objectFile.id#&area=#area_id#" class="btn btn-warning btn-small"><i class="icon-cut"></i> <span lang="es">Cambiar área</span></a>	
				</cfif>

			</cfif>

		</cfif>

		
		
		<cfif APPLICATION.moduleConvertFiles EQ true>
			<cfif objectFile.file_types_conversion.recordCount GT 0>
				<div class="div_element_menu" style="width:130px;">
					<cfif page_type IS 1>
						<cfset form_action = "my_files_file_convert.cfm">
					<cfelse>
						<cfset form_action = "area_file_convert.cfm">
					</cfif>
					<form name="convert_file" id="convert_file" method="get" action="#form_action#" onsubmit="showHideDiv('convert_file_loading');">
						<input type="hidden" name="file" value="#objectFile.id#" />
						<cfif page_type IS 1>
						<input type="hidden" name="folder" value="#folder_id#" />
						<cfelse>
						<input type="hidden" name="area" value="#area_id#" />
						</cfif>
						<div class="div_icon_menus"><input type="image" src="assets/icons/view_file.gif" title="Visualizar el archivo"/></div>
						<div class="div_text_menus"><a href="##" onclick="showHideDiv('convert_file_loading');submitForm('convert_file');" class="text_menus"><span lang="es">Visualizar en</span> </a>
						<select name="file_type" style="width:90px;" onchange="showHideDiv('convert_file_loading');submitForm('convert_file');">
							<cfloop query="objectFile.file_types_conversion">
								<option value="#objectFile.file_types_conversion.file_type#">#objectFile.file_types_conversion.name_es#</option>
							</cfloop>
						</select>
						</div>
					</form>
				</div>
			</cfif> 
		</cfif>
		
	<cfelse>
		
		<cfinclude template="#APPLICATION.htmlPath#/includes/file_content_menu_vpnet.cfm">
	
	</cfif>
</div>
<!---<cfdump var="#objectFile.file_types_conversion#">--->
</cfoutput>

<cfoutput>
	<!---<div class="div_file_page_name">#objectFile.name#</div>
	<div class="div_separator"><!-- --></div>--->
	<div class="div_file_page_file">
		<cfif page_type NEQ 1>

			<cfif objectFile.locked IS true>
				<div class="alert">
					<span>Archivo bloqueado por el usuario <a href="area_user.cfm?area=#objectFile.area_id#&user=#objectFile.lock_user_id#">#objectFile.lock_user_full_name#</a>.</span>
				</div>
			<cfelseif objectFile.file_type_id IS 2>
				<div class="alert alert-info">
					<span>Debe bloquear el archivo para poder modificarlo o reemplazarlo.</span>
				</div>
			</cfif>

			<cfif objectFile.file_type_id IS NOT 1>
				<cfif objectFile.locked IS true>
				<div class="div_file_page_label">
					<span>Fecha de bloqueo:</span> <span class="text_file_page">#objectFile.lock_date#</span>
				</div>
				</cfif>
				<div class="div_file_page_label">
					<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="getArea" returnvariable="fileArea">
						<cfinvokeargument name="area_id" value="#objectFile.area_id#">
					</cfinvoke>

					<span><b>Propiedad del área: </b></span>
					
					<a onclick="openUrl('area_items.cfm?area=#objectFile.area_id#&file=#objectFile.id#','areaIframe',event)" style="cursor:pointer">#fileArea.name#</a>
				</div>
			</cfif>
			<div class="div_file_page_label">
				<cfif objectFile.file_type_id IS 1><!--- User file --->
					<a href="area_user.cfm?area=#area_id#&user=#objectFile.user_in_charge#">
					<cfif len(objectFile.user_image_type) GT 0>
						<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#objectFile.user_in_charge#&type=#objectFile.user_image_type#&small=" alt="#objectFile.user_full_name#" class="item_img" style="margin-right:2px;"/>									
					<cfelse>						
						<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#objectFile.user_full_name#" class="item_img_default" style="margin-right:2px;"/>
					</cfif></a>
				<cfelse><!--- Area file --->	
					<span>Creado por: </span>
				</cfif>				
				<a href="area_user.cfm?area=#area_id#&user=#objectFile.user_in_charge#">#objectFile.user_full_name#</a>
			</div>
			<!---<div class="div_file_page_user">#objectFile.user_full_name#</div>--->
		</cfif>
		<div class="div_file_page_label"><span lang="es">Nombre de archivo:</span></div>
		<div class="div_file_page_user">#objectFile.file_name#</div>
		
		<div class="div_file_page_label"><span lang="es">Fecha de subida:</span> <span class="text_file_page">#objectFile.uploading_date#</span></div>	
		<div class="div_file_page_label"><span lang="es">Fecha de reemplazo:</span> <span class="text_file_page"><cfif len(objectFile.replacement_date) GT 0>#objectFile.replacement_date#<cfelse>-</cfif></span></div> 
		
		<div class="div_file_page_label"><span lang="es">Tipo de archivo:</span> <span class="text_file_page">#objectFile.file_type#</span></div>
		

		<cfif isNumeric(objectFile.file_size)>
			<!---fileUrl--->
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileManager" method="trasnformFileSize" returnvariable="file_size">
				<cfinvokeargument name="file_size_full" value="#objectFile.file_size#">
			</cfinvoke>
		<cfelse>
			<cfset file_size = objectFile.file_size>
		</cfif>

		<div class="div_file_page_size"><div class="div_file_page_label"><span lang="es">Tamaño:</span> <span class="text_file_page">#file_size#</span></div></div>
		
		<div class="div_file_page_label"><span lang="es">Descripción:</span></div>
		<div class="div_file_page_description">#objectFile.description#</div>

		<!---fileUrl--->
		<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getAreaFileUrl" returnvariable="areaFileUrl">
			<cfinvokeargument name="file_id" value="#objectFile.id#">
			<cfinvokeargument name="area_id" value="#area_id#">
		</cfinvoke>

		<div class="div_message_page_label"><span lang="es">URL en DoPlanning:</span></div>
		<input type="text" value="#areaFileUrl#" onClick="this.select();" class="input-block-level" readonly="readonly" style="cursor:text"/>

		<!---Typology--->
		<cfif APPLICATION.modulefilesWithTables IS true>
			
			<!---Typology fields--->
			<cfset table_id = objectFile.typology_id>
			<cfset tableTypeId = 3>
			<cfset row_id = objectFile.typology_row_id>

			<cfif isNumeric(table_id) AND isNumeric(row_id)>

				<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="getTable" returnvariable="table">
					<cfinvokeargument name="table_id" value="#table_id#">
					<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
				</cfinvoke>
				
				<cfinvoke component="#APPLICATION.htmlComponentsPath#/Row" method="getRow" returnvariable="getRowResponse">
					<cfinvokeargument name="table_id" value="#table_id#"/>
					<cfinvokeargument name="tableTypeId" value="#tableTypeId#"/>
					<cfinvokeargument name="row_id" value="#row_id#"/>
				</cfinvoke>

				<cfset row = getRowResponse.row>

				<div class="div_message_page_label">Tipología: <span class="text_message_page"><strong>#table.title#</strong></span></div>

				<cfinclude template="#APPLICATION.htmlPath#/includes/table_row_content_fields.cfm">
				
			</cfif>

			

		</cfif>

	</div>
</cfoutput>

<div id="convert_file_loading" style="position:absolute; width:100%; height:94%; top:0px; background-color:#EEEEEE; text-align:center; padding-top:90px; display:none;">
<cfoutput>
<div class="alert"><span lang="es">Generando archivo...</span></div>
<div style="margin:auto; text-align:center; padding-top:30px;">
<img src="#APPLICATION.path#/html/assets/icons/loading.gif" alt="Cargando" />
</div>
</cfoutput>
</div>
