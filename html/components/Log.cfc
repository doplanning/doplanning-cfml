<!---Copyright Era7 Information Technologies 2007-2008

	Date of file creation: 08-07-2009
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 08-07-2009
	
--->
<cfcomponent output="true">

	<cfset component = "Log">
	<cfset request_component = "LogManager">
	
	
	<cffunction name="getLogs" returntype="xml" access="public" output="true">
		<cfargument name="date_from" type="string" required="true">
		<cfargument name="date_to" type="string" required="true">
		<cfargument name="action_id" type="string" required="true">
		<cfargument name="page" type="numeric" required="no" default="1">
		<cfargument name="items_page" type="numeric" required="no" default="1000000">
		
		<cfset var method = "getLogs">
		
		<cfset var request_parameters = "">
		
		<cftry>		
			
			<cfset request_parameters = '<logs page="#arguments.page#" items_page="#arguments.items_page#"'>
			<cfif len(arguments.date_from) GT 0>
				<cfset request_parameters = request_parameters&' date_from="#arguments.date_from#"'>
			</cfif>
			<cfif len(arguments.date_to) GT 0>
				<cfset request_parameters = request_parameters&' date_to="#arguments.date_to#"'>
			</cfif>
			<cfif len(arguments.action_id) GT 0>
				<cfset request_parameters = request_parameters&' action_id="#arguments.action_id#"'>
			</cfif>
			<cfset request_parameters = request_parameters&'>'>
			<cfset request_parameters = request_parameters&'</logs>'>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>

			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	
	
	<cffunction name="outputLogsList" returntype="void" output="true" access="public">
		<cfargument name="logs" type="query" required="true">
		<cfargument name="full_content" type="boolean" required="no" default="false">
		<cfargument name="return_page" type="string" required="no">
		<cfargument name="app_version" type="string" required="true">
		
		<cfset var method = "outputItemsList">

		<cftry>
			
			<cfset logs = arguments.logs>
			
			<cfset numLogs = logs.RecordCount>
			
			
			
			<cfif numLogs GT 0>
			
				<script type="text/javascript">
					$(document).ready(function() { 
						
						$.tablesorter.addParser({
							id: "datetime",
							is: function(s) {
								return false; 
							},
							format: function(s,table) {
								s = s.replace(/\-/g,"/");
								s = s.replace(/(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})/, "$3/$2/$1");
								return $.tablesorter.formatFloat(new Date(s).getTime());
							},
							type: "numeric"
						});
						
						$("##listTable").tablesorter({ 
							<cfif arguments.full_content IS false>
							widgets: ['zebra','filter','select'],
							<cfelse>
							widgets: ['zebra','select'],
							</cfif>
		

							sortList: [[2,1]] ,

							headers: { 

								0: { 
									sorter: false 
								},
								2: { 
									sorter: "datetime" 
								}
		
							},
							<cfif arguments.full_content IS false>
							widgetOptions : {
								filter_childRows : false,
								filter_columnFilters : true,
								filter_cssFilter : 'tablesorter-filter',
								filter_filteredRow   : 'filtered',
								filter_formatter : null,
								filter_functions : null,
								filter_hideFilters : false,
								filter_ignoreCase : true,
								filter_liveSearch : true,
								//filter_reset : 'button.reset',
								filter_searchDelay : 300,
								filter_serversideFiltering: false,
								filter_startsWith : false,
								filter_useParsedData : false,
						    }, 
						   </cfif>
						});
						
						//  Adds "over" class to rows on mouseover
						$("##listTable tr").mouseover(function(){
						  $(this).addClass("over");
						});
					
						//  Removes "over" class from rows on mouseout
						$("##listTable tr").mouseout(function(){
						  $(this).removeClass("over");
						});
						
					}); 
				</script>
				
				<cfset alreadySelected = false>
				
		
				<cfif isDefined("arguments.return_page")>
					<cfset rpage = arguments.return_page>
				<cfelse>
					<cfset rpage = "">
				</cfif>	
				
				
				<cfoutput>
				
				<table id="listTable" class="tablesorter">
					<thead>
						<tr>
							<th style="width:35px" class="filter-false"></th>
							<th lang="es">De</th>
							<th style="width:150px;" lang="es">Fecha</th>	
							<th style="width:39%" lang="es">Acción</th>		
							
							
						</tr>
					</thead>
					
					<tbody>
					
					<cfloop query="arguments.logs">
					
					<!---<cfset item_page_url = "log.cfm?log=#logs.id#&return_page=#URLEncodedFormat(rpage)#">--->
						<cfset item_page_url = "log_item.cfm?log=#logs.id#">

						<!---Item selection--->
						<cfset itemSelected = false>
						
						<cfif alreadySelected IS false>
						
							<!---Esta acción solo se completa si está en la versión HTML2--->
							<script type="text/javascript">
								openUrlHtml2('#item_page_url#','logItemIframe');
							</script>
							<cfset itemSelected = true>
								
							
							<cfif itemSelected IS true>
								<cfset alreadySelected = true>
							</cfif>
							
						</cfif>


						
						<tr <cfif itemSelected IS true>class="selected"</cfif> onclick="openUrl('#item_page_url#','logItemIframe',event)">

							<td style="text-align:center">								
								<cfif APPLICATION.identifier NEQ "vpnet"><!---Message AND DP--->									
								
<!---									<cfif len(logs.user_image_type) GT 0>
										<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#objectItem.user_in_charge#&type=#logs.user_image_type#&small=" alt="#objectItem.user_full_name#" class="item_img"/>									
									<cfelse>							
										<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#logs.user_full_name#" class="item_img_default" />
									</cfif>--->
								
								<cfelse>
									<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#.png" class="item_img" alt="#itemTypeNameEs#"/>									
								</cfif>
	
							</td>		
							<td><span class="text_message_data">#logs.name#</span></td>
							<td><span class="text_message_data">#DateFormat(logs.time, APPLICATION.dateFormat)# #TimeFormat(logs.time, "HH:mm:ss")#</span></td>					
							<td><span class="text_message_data">#logs.method#</span></td>
							
							
							
						</tr>
					
					</cfloop>
					
					</tbody>
					</table>
				</cfoutput>
			</cfif>
								
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	
	<cffunction name="outputLogItem" returntype="void" output="true" access="public">
		<cfargument name="log" type="query" required="true">
		<!---<cfargument name="contact_format" type="boolean" required="false" default="false">--->
		
		<cfset var method = "outputLogItem">
		
		<cfset var user_page = "">
		
		<cftry>
			
			<cfoutput>
			<div class="div_log_page_title">			
			<span lang="es">Detalles del log</span>
			</div>
			<div class="div_separator"><!-- --></div>
			
		
				<div class="div_user_page_title">
				<cfif len(log.image_type) GT 0>
					<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#log.user_id#&type=#log.image_type#&medium=" alt="#log.name#" class="item_img" style="margin-right:2px;"/>									
				<cfelse>							
					<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#log.name#" class="item_img_default" style="margin-right:2px;"/>
				</cfif><br/>
				<span lang="es" class="div_log_page_label">Usuario</span>
				</div>
				
				<div class="div_separator"><!-- --></div>
				<div class="div_user_page_user">
					<div class="div_log_page_label"><span lang="es" style="font-weight:bold">Nombre:</span> #log.name#</div>
					<div class="div_log_page_label"><span lang="es" style="font-weight:bold">Email:</span> <a href="mailto:#log.email#" class="div_user_page_text">#log.email#</a></div>	
					<div class="div_log_page_label"><span lang="es" style="font-weight:bold">&nbsp;</span></div>				
				</div>			
		
			
			
			<div class="div_log_page_log">
				<div class="div_log_page_label"><span lang="es" style="font-weight:bold">Id:</span> #log.log_id#</div>
				<div class="div_log_page_label"><span lang="es" style="font-weight:bold">Acción:</span> #log.method#</div>
				<div class="div_log_page_label"><span lang="es" style="font-weight:bold">Componente:</span> #log.component#</div>
				<div class="div_log_page_label"><span lang="es" style="font-weight:bold">Fecha:</span> #DateFormat(log.time, APPLICATION.dateFormat)# #TimeFormat(log.time, "HH:mm:ss")#</div>
				<div class="div_log_page_label">
				<span lang="es" style="font-weight:bold">Petición:</span> 
				<cfif IsXML(log.request_content)>
					<cfdump var="#xmlParse(log.request_content)#">
				<cfelse>
					#log.request_content#
				</cfif>
				

	
				</div>
			</div>
			
			
			</cfoutput>								
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
</cfcomponent>