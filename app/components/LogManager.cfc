<!---Copyright Era7 Information Technologies 2007-2008

	Date of file creation: 12-08-2008
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 08-07-2009
	
--->
<cfcomponent displayname="LogManager" output="false">

	<cfset component = "LogManager">	
	
	<cfset date_format = "%d-%m-%Y"><!---%H:%i:%s---><!---Formato de fecha en la que se debe recibir los parámetros--->
	<cfset datetime_format = "%d-%m-%Y %H:%i:%s">
	
	<!----------------------------------------- saveLog -------------------------------------------------->
	
	<cffunction name="saveLog" access="public" returntype="void">
		<cfargument name="log_component" type="string" required="yes">
		<cfargument name="log_method" type="string" required="yes">
		<cfargument name="log_content" type="string" required="yes">
		<cfargument name="client_abb" type="string" required="no">
		
		<cfset var method = "saveLog">
		
		<cftry>
			
			<cfif NOT isDefined("arguments.client_abb")>
				<cfinclude template="includes/sessionVarsNoAppCheck.cfm">
			<cfelse>
				<cfset client_dsn = APPLICATION.identifier&"_"&arguments.client_abb>
			</cfif>
		
			<cfquery name="recordLog" datasource="#client_dsn#">
				INSERT INTO #client_abb#_logs (user_id, request_content, component, method)
				VALUES 
				(<cfif isDefined("user_id")>
					<cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">
				 <cfelse>
					<cfqueryparam null="yes" cfsqltype="cf_sql_integer">
				 </cfif>, '#log_content#', '#log_component#', '#log_method#')
			</cfquery>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
	</cffunction>
	
	
	<!----------------------------------------- getLogs -------------------------------------------------->
	
	<!---<cffunction name="getLogs" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getLogs">
		
		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">
			
		<cfset var xmlRequest = "">
		<cfset var xmlResult = "">
		<cfset var xmlResponseContent = "">
	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="includes/checkAdminAccess.cfm">
			
			<cfif isDefined("xmlRequest.request.parameters.logs.xmlAttributes.items_page")>
				<cfset logs_per_page = xmlRequest.request.parameters.logs.xmlAttributes.items_page>
			<cfelse>
				<cfset logs_per_page = 20>
			</cfif>
			
			<cfif isDefined("xmlRequest.request.parameters.logs.xmlAttributes.page")>
			
				<cfset current_page = xmlRequest.request.parameters.logs.xmlAttributes.page>
			
			<cfelse>
				<cfset current_page = 1>
			</cfif>
			
			<cfif isDefined("xmlRequest.request.parameters.logs.xmlAttributes.date_from")>
				<cfset date_from = xmlRequest.request.parameters.logs.xmlAttributes.date_from>
			</cfif>
			<cfif isDefined("xmlRequest.request.parameters.logs.xmlAttributes.date_to")>
				<cfset date_to = xmlRequest.request.parameters.logs.xmlAttributes.date_to>
			</cfif>
			
			<cfif isDefined("xmlRequest.request.parameters.logs.xmlAttributes.user_id")>
				<cfset user_log = xmlRequest.request.parameters.logs.xmlAttributes.user_id>
			</cfif>
			
			<cfif isDefined("xmlRequest.request.parameters.logs.xmlAttributes.action_id")>
				<cfset action_id = xmlRequest.request.parameters.logs.xmlAttributes.action_id>
			</cfif>
			
	
			<cfif isDefined("xmlRequest.request.parameters.order")>
		
				<cfset order_by = xmlRequest.request.parameters.order.xmlAttributes.parameter>
				
				<cfif order_by EQ "id">
					<cfset order_by = "log_id">
				</cfif>
				
				<cfset order_type = xmlRequest.request.parameters.order.xmlAttributes.order_type>
			
			<cfelse>
			
				<cfset order_by = "time">
				<cfset order_type = "desc">
			
			</cfif>

			
			<cfset init_log = (current_page-1)*logs_per_page>
			
			<cfquery datasource="#client_dsn#" name="logs">
				SELECT SQL_CALC_FOUND_ROWS *, logs.id AS log_id 
				FROM #client_abb#_logs AS logs 
				LEFT JOIN #client_abb#_users AS users ON logs.user_id = users.id

				WHERE logs.id != 0
				<cfif isDefined("user_log")>
				AND logs.user_id = <cfqueryparam value="#user_log#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif isDefined("date_from")>
				AND logs.time >= STR_TO_DATE(<cfqueryparam value="#date_from#" cfsqltype="cf_sql_varchar">,'#date_format#')
				</cfif>
				<cfif isDefined("date_to")>
				AND logs.time <= STR_TO_DATE(<cfqueryparam value="#date_to# 23:59:59" cfsqltype="cf_sql_varchar">,'#datetime_format#')
				</cfif>
				ORDER BY #order_by# #order_type#
				LIMIT #init_log#, #logs_per_page#;
			</cfquery>			
			
			<cfquery datasource="#client_dsn#" name="getLogCount">
				SELECT FOUND_ROWS() AS num_logs;
			</cfquery>
			
			<cfquery datasource="#APPLICATION.dsn#" name="methods">
				SELECT *
				FROM APP_methods AS methods; 
			</cfquery>
			
			<cfquery datasource="#APPLICATION.dsn#" name="components">
				SELECT *
				FROM APP_components AS components; 
			</cfquery>
			
			<cfquery dbtype="query" name="getLog">
				SELECT *
				FROM logs, methods, components
				WHERE logs.method = methods.name
				AND logs.component = components.name
				<cfif isDefined("action_id")>
				AND methods.id = <cfqueryparam value="#action_id#" cfsqltype="cf_sql_integer">
				</cfif>;
			</cfquery>

			
			<cfset num_logs = getLogCount.num_logs>
			
			<cfset num_pages = ceiling(num_logs/logs_per_page)>
			
			<cfset xmlResult = '<logs total="#num_logs#" pages="#num_pages#" page="#current_page#">'>
			
			<cfif getLog.RecordCount GT 0>
				<cfloop query="getLog">
					
					<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringLogTime">
						<cfinvokeargument name="timestamp_date" value="#getLog.time#">
					</cfinvoke>
					
					<cfset xmlLog = '<log id="#getLog.log_id#" user_id="#getLog.user_id#" time="#stringLogTime#"><user_full_name><![CDATA[#getLog.family_name# #getLog.name#]]></user_full_name><action><![CDATA[#getLog.action_es#]]></action><description><![CDATA[#getLog.description_es#]]></description></log>'>
					<cfset xmlResult = xmlResult&xmlLog>
				</cfloop>
			</cfif>
			
			<cfset xmlResponseContent = xmlResult&"</logs>">
	
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>--->
	
	
<!----------------------------------------- getLogs con paginación -------------------------------------------------->
	
	<!---<cffunction name="getLogs" returntype="struct" access="public">
		<cfargument name="user_log" type="numeric" required="no">
		<cfargument name="date_from" type="string" required="no">
		<cfargument name="date_to" type="string" required="no">
		<cfargument name="action_id" type="string" required="no">
		<cfargument name="logs_per_page" type="numeric" required="no" default="20">
		<cfargument name="current_page" type="numeric" required="no" default="1">
		<cfargument name="order_by" type="string" required="no" default="time">
		<cfargument name="order_type" type="string" required="no" default="desc">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="includes/checkAdminAccess.cfm">
			
			<cfset init_log = (current_page-1)*logs_per_page>
			
			<cfquery datasource="#client_dsn#" name="logs">
				SELECT SQL_CALC_FOUND_ROWS *, logs.id AS log_id 
				FROM #client_abb#_logs AS logs 
				LEFT JOIN #client_abb#_users AS users ON logs.user_id = users.id
				WHERE logs.id != 0
				<cfif isDefined("arguments.user_log")>
				AND logs.user_id = <cfqueryparam value="#arguments.user_log#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif isDefined("arguments.date_from")>
				AND logs.time >= STR_TO_DATE(<cfqueryparam value="#arguments.date_from#" cfsqltype="cf_sql_varchar">,'#date_format#')
				</cfif>
				<cfif isDefined("arguments.date_to")>
				AND logs.time <= STR_TO_DATE(<cfqueryparam value="#arguments.date_to# 23:59:59" cfsqltype="cf_sql_varchar">,'#datetime_format#')
				</cfif>
				<cfif isDefined("arguments.action")>
				AND logs.method = <cfqueryparam value="#arguments.action_id#" cfsqltype="cf_sql_varchar">
				</cfif>				
				ORDER BY #order_by# #order_type#
				LIMIT #init_log#, #logs_per_page#;
			</cfquery>			
			

	
			<cfset response = {result="true", message="", query=#logs#}>			
			
			<cfcatch>
			
				<cfinclude template="includes/errorHandlerStruct.cfm">
				
			</cfcatch>										
			
		</cftry>
		
		<cfreturn #response#>
		
	</cffunction>--->	
	
	
	
	
	
	
<!----------------------------------------- getLogs -------------------------------------------------->
	
	<cffunction name="getLogs" returntype="struct" access="public">
		<cfargument name="user_log" type="numeric" required="no">
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
		<cfargument name="action" type="string" required="no">
		<cfargument name="limit" type="numeric" required="yes" >
		<cfargument name="order_by" type="string" required="no" default="time">
		<cfargument name="order_type" type="string" required="no" default="desc">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="includes/checkAdminAccess.cfm">
			
			<cfquery datasource="#client_dsn#" name="logs">
				SELECT SQL_CALC_FOUND_ROWS logs.*, logs.id AS log_id, CONCAT(users.family_name, ' ', users.name) as name
				FROM #client_abb#_logs AS logs 
				LEFT JOIN #client_abb#_users AS users ON logs.user_id = users.id
				WHERE logs.id != 0
				<cfif isDefined("arguments.user_log")>
				AND logs.user_id = <cfqueryparam value="#arguments.user_log#" cfsqltype="cf_sql_integer">
				</cfif>
				<cfif isDefined("arguments.from_date")>
				AND logs.time >= STR_TO_DATE(<cfqueryparam value="#arguments.from_date#" cfsqltype="cf_sql_varchar">,'#date_format#')
				</cfif>
				<cfif isDefined("arguments.end_date")>
				AND logs.time <= STR_TO_DATE(<cfqueryparam value="#arguments.end_date# 23:59:59" cfsqltype="cf_sql_varchar">,'#datetime_format#')
				</cfif>
				<cfif isDefined("arguments.action")>
				AND logs.method = <cfqueryparam value="#arguments.action#" cfsqltype="cf_sql_varchar">
				</cfif>				
				ORDER BY #order_by# #order_type#
				LIMIT #limit#;
			</cfquery>	
	
			<cfset response = {result="true", message="", query=#logs#}>			
			
			<cfcatch>
			
				<cfinclude template="includes/errorHandlerStruct.cfm">
				
			</cfcatch>										
			
		</cftry>
		
		<cfreturn #response#>
		
	</cffunction>	
	
	
	
	
	
		
	
<!----------------------------------------- getLogItem -------------------------------------------------->
	
	<cffunction name="getLogItem" returntype="struct" access="public">
		<cfargument name="log_id" type="numeric" required="yes">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="includes/checkAdminAccess.cfm">
			
			<cfquery datasource="#client_dsn#" name="logs">
				SELECT logs.*, logs.id AS log_id, CONCAT(users.family_name, ' ', users.name) as name, users.email, users.image_type, users.id as user_id
				FROM #client_abb#_logs AS logs 
				LEFT JOIN #client_abb#_users AS users ON logs.user_id = users.id
				WHERE logs.id = <cfqueryparam value="#arguments.log_id#" cfsqltype="cf_sql_integer">
				;	
			</cfquery>	
	
			<cfset response = {result="true", message="", query=#logs#}>			
			
			<cfcatch>
			
				<cfinclude template="includes/errorHandlerStruct.cfm">
				
			</cfcatch>										
			
		</cftry>
		
		<cfreturn #response#>
		
	</cffunction>	
	
	
	
	
	
	
	
	
	
	
	<!----------------------------------------- getLogActions -------------------------------------------------->
	
	<!---Devuelve una lista de las acciones de log disponibles--->
	
	<!---<cffunction name="getLogActions" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getLogActions">
		
		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">
			
		<cfset var xmlRequest = "">
		<cfset var xmlResult = "">
		<cfset var xmlResponseContent = "">
	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="includes/checkAdminAccess.cfm">
			
			<cfquery datasource="#APPLICATION.dsn#" name="getLogActions">
				SELECT *
				FROM APP_methods AS methods
				WHERE action_es != ''
				ORDER BY action_es ASC;
			</cfquery>
			
			<cfset xmlResult = '<log_actions>'>
			
			<cfif getLogActions.RecordCount GT 0>
				<cfloop query="getLogActions">
					
					<cfset xmlLog = '<log_action id="#getLogActions.id#"><action><![CDATA[#getLogActions.action_es#]]></action><description><![CDATA[#getLogActions.description_es#]]></description></log_action>'>
					<cfset xmlResult = xmlResult&xmlLog>
				</cfloop>
			</cfif>
			
			<cfset xmlResponseContent = xmlResult&"</log_actions>">
	
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
</cfcomponent>--->



	<!---cmartinez--->
	<!----------------------------------------- getLogActions -------------------------------------------------->
	
	<!---Devuelve una lista de las acciones de log disponibles--->
	
	<cffunction name="getLogActions" returntype="struct" access="public">
		
		<cfset var method = "getLogActions">	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="includes/checkAdminAccess.cfm">
			
			<cfquery datasource="#APPLICATION.dsn#" name="getLogActions">
				SELECT *
				FROM APP_methods AS methods
				WHERE action_es != ''
				ORDER BY action_es ASC;
			</cfquery>
			
			<cfset response = {result="true", message="", query=#getLogActions#}>			
			
			<cfcatch>
			
				<cfinclude template="includes/errorHandlerStruct.cfm">
				
			</cfcatch>										
			
		</cftry>
		
		<cfreturn #response#>
		
	</cffunction>
	
</cfcomponent>

