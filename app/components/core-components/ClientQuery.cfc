<!---Copyright Era7 Information Technologies 2007-2014--->

<cfcomponent output="false">

	<cfset component = "ClientQuery">


	<!---getClient--->

	<cffunction name="getClient" output="false" returntype="query" access="public">
		<cfargument name="client_abb" type="string" required="true">

		<cfset var method = "getClient">

		<cfset var client_dsn = "#APPLICATION.identifier#_#arguments.client_abb#">

			<!---<cfquery name="selectClientQuery" datasource="#APPLICATION.dsn#">--->
			<cfquery name="selectClientQuery" datasource="#client_dsn#">
				SELECT *
				FROM `doplanning_app`.`app_clients`
				<!---WHERE abbreviation = <cfqueryparam value="#arguments.client_abb#" cfsqltype="cf_sql_varchar">--->
				WHERE abbreviation LIKE <cfqueryparam value="#client_abb#" cfsqltype="cf_sql_varchar"> COLLATE utf8_bin;
			</cfquery>

		<cfreturn selectClientQuery>

	</cffunction>


	<!---getClients--->

	<cffunction name="getClients" output="false" returntype="query" access="public">
		<cfargument name="excludeClients" type="string" required="false">
		<cfargument name="client_abb" type="string" required="false">

		<cfset var method = "getClients">

			<cfquery name="selectClientsQuery" datasource="#APPLICATION.dsn#">
				SELECT *
				FROM `doplanning_app`.`app_clients`
				<cfif isDefined("arguments.excludeClients")>
					<cfif listLen(arguments.excludeClients) GT 1>
						WHERE abbreviation NOT IN (<cfqueryparam value="#arguments.excludeClients#" cfsqltype="cf_sql_varchar" list="true">)
					<cfelse>
						WHERE abbreviation NOT LIKE <cfqueryparam value="#arguments.excludeClients#" cfsqltype="cf_sql_varchar">
					</cfif>
				</cfif>
				<cfif isDefined("arguments.client_abb")>
					WHERE abbreviation LIKE <cfqueryparam value="#arguments.client_abb#" cfsqltype="cf_sql_varchar"> COLLATE utf8_bin
				</cfif>
				;
			</cfquery>

		<cfreturn selectClientsQuery>

	</cffunction>

</cfcomponent>
