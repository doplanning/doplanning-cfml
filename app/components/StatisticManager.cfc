<!--- Copyright Era7 Information Technologies 2007-2015 --->

<cfcomponent output="false">

	<cfset component = "StatisticManager">


	<!--- ----------------- GET GENERAL STATISTICS --------------------------------------------   --->

	<cffunction name="getGeneralStatistics" output="false" returntype="struct" access="public">
		<cfargument name="from_date" type="string" required="false">
		<cfargument name="end_date" type="string" required="false">

		<cfset var method = "getGeneralStatistics">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="includes/checkAdminAccess.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/StatisticQuery" method="getGeneralStatistics" returnvariable="statisticsQuery">
				<cfif isDefined("arguments.from_date")>
					<cfinvokeargument name="from_date" value="#from_date#"/>
				</cfif>
				<cfif isDefined("arguments.end_date")>
					<cfinvokeargument name="end_date" value="#end_date#"/>
				</cfif>
				<cfinvokeargument name="client_abb" value="#SESSION.client_abb#"/>
				<cfinvokeargument name="client_dsn" value="#client_dsn#"/>
			</cfinvoke>

			<cfset response = {result=true, query=#statisticsQuery#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->


	<!--- ----------------------- GET TOTAL ITEMS BY USERS -------------------------------- --->

	<cffunction name="getTotalItemsByUser" output="false" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="include_subareas" type="boolean" required="false" default="false">
		<cfargument name="area_type" type="string" requierd="true">
		<cfargument name="from_date" type="string" required="false">
		<cfargument name="end_date" type="string" required="false">


		<cfset var method = "getTotalItemsByUser">

		<cfset var response = structNew()>
		<cfset var itemsByType = structNew()>
		<cfset var subAreasIds = "">
		<cfset var areasIds = "">

		<!---
		commented for development
		<cftry>--->

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfif arguments.include_subareas IS true>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getSubAreasIds" returnvariable="subAreasIds">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfset areasIds = ListAppend(subAreasIds, arguments.area_id)>

			</cfif>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="listAllAreaItems" returnvariable="getAreaItemsResult">
				<cfif arguments.include_subareas IS true>
					<cfinvokeargument name="areas_ids" value="#areasIds#">
				<cfelse>
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfif>
				<cfinvokeargument name="area_type" value="#arguments.area_type#">

				<cfinvokeargument name="published" value="false">

				<cfinvokeargument name="withConsultations" value="#APPLICATION.moduleConsultations#">
				<cfinvokeargument name="withPubmedsComments" value="#APPLICATION.modulePubMedComments#">
				<cfinvokeargument name="withLists" value="#APPLICATION.moduleLists#">
				<cfinvokeargument name="withForms" value="#APPLICATION.moduleForms#">
				<cfinvokeargument name="withDPDocuments" value="#APPLICATION.moduleDPDocuments#">
				<cfinvokeargument name="withMailings" value="#APPLICATION.moduleMailing#">

				<cfinvokeargument name="full_content" value="false">
				<cfinvokeargument name="with_position" value="false">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset totalItemsQuery = getAreaItemsResult.query>

			<!--- getAreaItemTypesStruct --->
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemManager" method="getAreaItemTypesStruct" returnvariable="itemTypesStruct">
			</cfinvoke>

			<cfset itemTypesArray = structSort(itemTypesStruct, "numeric", "ASC", "position")>

			<!--- Loop items types --->
			<cfloop array="#itemTypesArray#" index="itemTypeId">

				<cfif listFind("13,16", itemTypeId) IS 0><!---Typologies are not included--->

					<cfset var itemTypeName = itemTypesStruct[itemTypeId].name>
					<cfset var itemTypeGender = itemTypesStruct[itemTypeId].gender>

					<cfquery dbtype="query" name="itemsQuery">
						SELECT user_in_charge AS user_id, user_full_name, count(*) AS total
						FROM totalItemsQuery
						WHERE itemTypeId = <cfqueryparam value="#itemTypeId#" cfsqltype="cf_sql_integer">
						GROUP BY user_in_charge, user_full_name;
					</cfquery>

					<cfset itemsByType[itemTypeId] = itemsQuery>

				</cfif>

			</cfloop>

			<cfset response = {result=true, totalItems=#itemsByType#}>

			<!---
			commented for development
			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>--->

		<cfreturn response>

	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->


</cfcomponent>
