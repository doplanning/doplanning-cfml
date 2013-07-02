<!---
AQUÍ OBTIENE SI SE ESTÁ EN LA VERSIÓN standard o móvil
app_version almacena si es la versión móvil o la estandar--->
<cfif find("iframes2",CGI.SCRIPT_NAME) GT 0>
	<cfset app_version = "html2">
<cfelseif find("iframes",CGI.SCRIPT_NAME) GT 0>
	<cfset app_version = "standard">
<cfelse>
	<cfset app_version = "mobile">
</cfif>


<cfset curPage = getFileFromPath(CGI.SCRIPT_NAME)>
<cfset curElement = "">

<cfif isDefined("itemTypeId")>

	<cfswitch expression="#itemTypeId#">
		<cfcase value="1">
			<cfset curElement = "messages">
		</cfcase>
		
		<cfcase value="2">
			<cfset curElement = "entries">
		</cfcase>
		
		<cfcase value="3">
			<cfset curElement = "links">
		</cfcase>
		
		<cfcase value="4">
			<cfset curElement = "news">
		</cfcase>
		
		<cfcase value="5">
			<cfset curElement = "events">
		</cfcase>
		
		<cfcase value="5">
			<cfset curElement = "events">
		</cfcase>
		
		<cfcase value="6">
			<cfset curElement = "tasks">
		</cfcase>
		
		<cfcase value="7">
			<cfset curElement = "consultations">
		</cfcase>
		
	</cfswitch>
	
<cfelse>
	
	<cfif find("items",curPage) GT 0>
		<cfset curElement = "items">
	<cfelseif find("file",curPage) GT 0>
		<cfset curElement = "files">
	<cfelseif find("user",curPage) GT 0>
		<cfset curElement = "users">
	</cfif>
	
</cfif>


<cfif isDefined("area_id")>
		
	<cfif NOT isDefined("area_allowed")>
		<!---area_allowed--->
		<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="canUserAccessToArea" returnvariable="area_allowed">
			<cfinvokeargument name="area_id" value="#area_id#">
		</cfinvoke>
	</cfif>
	
	<cfif NOT isDefined("area_name")>
		<!---Esto es para las páginas de mensajes, archivos, usuarios (la mayoría de las páginas excepto la de navegación del arbol area.cfm) que no reciben estos valores--->
		
		<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="getArea" returnvariable="objectArea">
			<cfinvokeargument name="area_id" value="#area_id#">
		</cfinvoke>
		
		<cfset area_name = objectArea.name>
		
	</cfif>
	
	<!---area_type--->
	<cfif NOT isDefined("area_type")>
		<!---Esto es para las páginas de mensajes, archivos, usuarios (la mayoría de las páginas excepto la de navegación del arbol area.cfm) que no reciben este valor--->
		<!---El tipo de un área depende del tipo de las áreas superiores que tenga.--->
		<!---area_type puede ser web, intranet o NULL--->
		<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="getAreaType" returnvariable="area_type">
			<cfinvokeargument name="area_id" value="#area_id#">
		</cfinvoke>
	</cfif>

	
</cfif>