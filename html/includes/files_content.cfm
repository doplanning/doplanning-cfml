<cfoutput>
<script src="#APPLICATION.htmlPath#/language/area_items_content_en.js" charset="utf-8" type="text/javascript"></script>

<cfinclude template="#APPLICATION.htmlPath#/includes/tablesorter_scripts.cfm">
</cfoutput>

<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">

<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="getAreaFiles" returnvariable="xmlResponse">
	<cfinvokeargument name="area_id" value="#area_id#">
</cfinvoke>

<cfxml variable="xmlFiles">
	<cfoutput>
	#xmlResponse.response.result.files#
	</cfoutput>
</cfxml>

<cfoutput>
<div class="div_head_subtitle_area">
	
	<cfif APPLICATION.identifier NEQ "vpnet"><!---DP--->
		
		<!---Botón antiguo<a href="area_file_new.cfm?area=#area_id#" onclick="openUrl('area_file_new.cfm?area=#area_id#', 'itemIframe', event)" class="btn btn-small btn-info" title="Subir nuevo archivo" lang="es"><i class="icon-plus icon-white"></i> <span lang="es">Nuevo Archivo</span></a> --->

		<a href="area_file_new.cfm?area=#area_id#" onclick="openUrl('area_file_new.cfm?area=#area_id#', 'itemIframe', event)" class="btn btn-small" title="Nuevo Archivo" lang="es"><i class="icon-plus icon-white" style="color:##5BB75B;font-size:15px;line-height:20px;"></i> <img src="#APPLICATION.htmlPath#/assets/icons/file.png" style="height:22px;"/></a>
		
		<!---Opción deshabilitada definitivamente<a href="file_associate.cfm?area=#area_id#" onclick="openUrl('file_associate.cfm?area=#area_id#', 'itemIframe', event)" class="btn btn-small" title="Asociar archivo existente" lang="es"><i class="icon-plus-sign"></i> <span lang="es">Asociar Archivo</span></a>--->
		
		<cfif APPLICATION.modulefilesWithTables>
			<a href="typologies.cfm?area=#area_id#" class="btn btn-small" title="Tipologías de documentos" lang="es"><i class="icon-file-text" ></i> <span>Tipologías de documentos</span></a>
		</cfif>

		<span class="divider">&nbsp;</span>

		<cfif app_version NEQ "mobile">
		<a href="#APPLICATION.htmlPath#/files.cfm?area=#area_id#" class="btn btn-small" title="Abrir en nueva ventana" target="_blank" lang="es"><i class="icon-external-link" style="font-size:14px; line-height:23px;"></i></a>
		</cfif>

		<a href="files.cfm?area=#area_id#" class="btn btn-small" title="Actualizar" lang="es"><i class="icon-refresh" style="font-size:14px; line-height:23px;"></i></a>
	
	<cfelse>
	
		<cfinclude template="#APPLICATION.htmlPath#/includes/area_files_menu_vpnet.cfm">
	
	</cfif>
	
</div>
</cfoutput>

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<cfset full_content = false>
<cfinclude template="#APPLICATION.htmlPath#/includes/file_list_content.cfm">