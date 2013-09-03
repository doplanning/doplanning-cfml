<div class="div_message_page_title">Logs</div>

<!---<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">--->

<cfoutput>
<script src="#APPLICATION.htmlPath#/admin/language/logs_content_en.js" charset="utf-8" type="text/javascript"></script>
</cfoutput>


<cfoutput>
<script src="#APPLICATION.htmlPath#/language/area_items_content_en.js" charset="utf-8" type="text/javascript"></script>

<cfinclude template="#APPLICATION.htmlPath#/includes/tablesorter_scripts.cfm">

<script type="text/javascript" src="#APPLICATION.path#/jquery/jquery.highlight.js"></script>
</cfoutput>



<cfinclude template="#APPLICATION.htmlPath#/admin/includes/search_log_bar.cfm">




<cfif isDefined("URL.search")>

	<cfinvoke component="#APPLICATION.componentsPath#/LogManager" method="getLogs" returnvariable="getLogsResponse">

		<cfif isNumeric(user_log)>
			<cfinvokeargument name="user_log" value="#user_log#">
		</cfif>
		
		<cfif len(action) GT 0>
			<cfinvokeargument name="action" value="#action#">
		</cfif>
		
		<cfif len(from_date) GT 0>
			<cfinvokeargument name="from_date" value="#from_date#">
		</cfif>		
		
		<cfif len(end_date) GT 0>
			<cfinvokeargument name="end_date" value="#end_date#">
		</cfif>				
		
		<cfif isNumeric(limit_to)>
			<cfinvokeargument name="limit" value="#limit_to#">
		</cfif>
	</cfinvoke>
		
		
	<cfif getLogsResponse.result IS true>
		
		<cfset logsResponse = getLogsResponse.query>		
		<cfset numItems = logsResponse.RecordCount>
		

		<cfif numItems GT 0>
			<cfoutput>
			<div class="div_search_results_text" style="margin-bottom:5px; margin-top:5px;"><span lang="es">Resultado:</span> #numItems# logs</span></div>
			</cfoutput>
			<div class="div_items">
			
				<cfinvoke component="#APPLICATION.htmlComponentsPath#/Log" method="outputLogsList">
					<cfinvokeargument name="logs" value="#logsResponse#">
					<cfinvokeargument name="full_content" value="true">
					<cfinvokeargument name="app_version" value="html2">
				</cfinvoke>
			
			</div>
		<cfelse>
			
			<script type="text/javascript">
				openUrlHtml2('empty.cfm','logItemIframe');
			</script>			
		
			<div class="div_items">
			<cfoutput>
			<div class="div_text_result"><span lang="es">No hay logs.</span></div>
			</cfoutput>
			</div>
		</cfif>
		
	<cfelse>
		<cfset message = getLogsResponse.message>
			<cfoutput>
			<div class="alert alert-error" style="margin:10px;">&nbsp;<span lang="es">#message#</span></div>
			</cfoutput>
	
	</cfif>

<cfelse>

	<script type="text/javascript">
		openUrlHtml2('empty.cfm','itemIframe');
	</script>
	
	<div class="alert alert-info" style="margin:10px;"><i class="icon-info-sign"></i>&nbsp;<span lang="es">Introduzca los parámetros que desee y haga click en "Filtrar".</span></div>

</cfif>

