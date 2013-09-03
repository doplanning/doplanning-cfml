<cfoutput>
<script src="#APPLICATION.htmlPath#/admin/language/log_item_content_en.js" charset="utf-8" type="text/javascript"></script>
</cfoutput>


<cfif isDefined("URL.log") AND isNumeric(URL.log)>
	<cfset log_id = URL.log>
	<cfinvoke component="#APPLICATION.componentsPath#/LogManager" method="getLogItem" returnvariable="getLogResponse">
		<cfinvokeargument name="log_id" value="#log_id#">
	</cfinvoke>
		
	<cfif getLogResponse.result IS true>
		
		<cfset logResponse = getLogResponse.query>		
		<cfset numItems = logResponse.RecordCount>

		<cfif numItems IS 1>

			<div class="div_items">
			
				<cfinvoke component="#APPLICATION.htmlComponentsPath#/Log" method="outputLogItem">
					<cfinvokeargument name="log" value="#logResponse#">
					<cfinvokeargument name="full_content" value="true">
					<cfinvokeargument name="app_version" value="html2">
				</cfinvoke>
			
			</div>
		<cfelse>
					
			<div class="div_items">
			<cfoutput>
			<div class="div_text_result"><span lang="es">No se ha seleccionado ningún log</span></div>
			</cfoutput>
			</div>
		</cfif>
		
	<cfelse>
		<cfset message = getLogResponse.message>
			<cfoutput>
			<div class="alert alert-error" style="margin:10px;">&nbsp;<span lang="es">#message#</span></div>
			</cfoutput>
	
	</cfif>

<cfelse>

	<script type="text/javascript">
		openUrlHtml2('empty.cfm','itemIframe');
	</script>


</cfif>
