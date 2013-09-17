<!---Variables requeridas:
itemTypeId
return_path: define la ruta donde se encuentra esta página, para que al enviar el mensaje se vuelva a ella--->
<cfoutput>
<script src="#APPLICATION.htmlPath#/language/area_item_content_en.js" charset="utf-8" type="text/javascript"></script>

<script src="#APPLICATION.htmlPath#/ckeditor/ckeditor.js" type="text/javascript"></script>
</cfoutput>

<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="getUser" returnvariable="objectUser">
	<cfinvokeargument name="user_id" value="#SESSION.user_id#">
	<cfinvokeargument name="format_content" value="all">
</cfinvoke>

<cfif isDefined("URL.area") AND isValid("integer",URL.area)>
	<cfset parent_id = URL.area>
	<cfset parent_kind = "area">
	
	<cfset area_id = parent_id>
	
	<cfset title_default = "">
	
	<cfset return_page = "#itemTypeNameP#.cfm?area=#parent_id#">
	
<cfelseif isDefined("URL.#itemTypeName#")>
	<cfset parent_id = URL[#itemTypeName#]>
	<cfset parent_kind = "#itemTypeName#">
	
	<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="getItem" returnvariable="getItemObject">
		<cfinvokeargument name="item_id" value="#parent_id#">
		<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
	</cfinvoke>
	
	<!---<cfxml variable="xmlItem">
		<cfoutput>
		#xmlResponse.response.result.xmlChildren[1]#
		</cfoutput>
	</cfxml>--->
	
	<cfset area_id = getItemObject.area_id>
	
	<cfset title_default = "Re: "&getItemObject.title>
	
	<cfset return_page = "#itemTypeName#.cfm?#itemTypeName#=#parent_id#">
	
<cfelse>
	<cflocation url="index.cfm" addtoken="no">
</cfif>

<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">
<div class="div_head_subtitle">
<cfoutput>
<cfif itemTypeId IS NOT 7 OR parent_kind EQ "area">
	<span lang="es"><cfif itemTypeGender EQ "male">Nuevo<cfelse>Nueva</cfif> #itemTypeNameEs#</span>
<cfelse>
	<span lang="es">Respuesta a #itemTypeNameEs#</span>
</cfif>
</cfoutput>
</div>

<cfset page_type = 1>
<cfinclude template="#APPLICATION.htmlPath#/includes/area_item_form.cfm">