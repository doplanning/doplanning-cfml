<cfoutput>
<script src="#APPLICATION.htmlPath#/language/area_items_content_en.js" charset="utf-8" type="text/javascript"></script>

<cfinclude template="#APPLICATION.htmlPath#/includes/tablesorter_scripts.cfm">

<script type="text/javascript" src="#APPLICATION.path#/jquery/jquery.highlight.js"></script>
</cfoutput>


<cfinclude template="#APPLICATION.htmlPath#/includes/search_2_bar.cfm">


<cfif isDefined("URL.search")>

	<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getAllAreasFiles" returnvariable="xmlResponseContent">
		<cfif len(search_text) GT 0>
		<cfinvokeargument name="search_text" value="#search_text#">	
		</cfif>
		<cfif isNumeric(user_in_charge)>
		<cfinvokeargument name="user_in_charge" value="#user_in_charge#">
		</cfif>
		<cfif isNumeric(limit_to)>
		<cfinvokeargument name="limit" value="#limit_to#">
		</cfif>
		
		<cfif len(from_date) GT 0>
			<cfinvokeargument name="from_date" value="#from_date#">
		</cfif>		
		
		<cfif len(end_date) GT 0>
			<cfinvokeargument name="end_date" value="#end_date#">
		</cfif>			
		
		
	</cfinvoke>
		
	<cfxml variable="xmlFiles">
	<cfoutput>
	#xmlResponseContent#
	</cfoutput>
	</cfxml>
	
	<cfset full_content = true>
	<cfinclude template="#APPLICATION.htmlPath#/includes/file_list_content.cfm">
	
<cfelse>

	<script type="text/javascript">
		openUrlHtml2('empty.cfm','itemIframe');
	</script>

	<div class="alert alert-info" style="margin:10px;"><i class="icon-info-sign"></i>&nbsp;<span lang="es">Introduzca unos parámetros de búsqueda y haga click en "Buscar".</span></div>

</cfif>

<!---<cfset return_page = "index.cfm">
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Interfaz" method="returnElement">
	<cfinvokeargument name="return_page" value="#return_page#">
</cfinvoke>--->