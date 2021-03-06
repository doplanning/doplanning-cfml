<!--- Copyright Era7 Information Technologies 2007-2015 --->

<cfcomponent output="false">

	<cfset component = "TableManager">


	<!--- ------------------------------------- createTableInDatabase -------------------------------------  --->

	<cffunction name="createTableInDatabase" output="false" access="package" returntype="void">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="table_general" type="boolean" required="false" default="false">

		<cfset var method = "createTableInDatabase">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfquery name="createTable" datasource="#client_dsn#">
				CREATE TABLE `#client_abb#_#tableTypeTable#_rows_#arguments.table_id#` (
				  `row_id` int(20) unsigned NOT NULL AUTO_INCREMENT,
				  `insert_user_id` int(11) DEFAULT NULL,
				  `last_update_user_id` int(11) DEFAULT NULL,
				  `creation_date` datetime NOT NULL,
				  `last_update_date` datetime DEFAULT NULL,
				  `position` int(10) unsigned NOT NULL,
					<cfif arguments.table_general IS true AND ( tableTypeId IS 1 OR tableTypeId IS 2 )>
						`area_id` INT(11) NOT NULL,
					</cfif>
				  PRIMARY KEY (`row_id`) USING BTREE,
				  KEY `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_1` (`insert_user_id`),
				  KEY `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_2` (`last_update_user_id`),
				  CONSTRAINT `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_2` FOREIGN KEY (`last_update_user_id`) REFERENCES `#client_abb#_users` (`id`) ON DELETE SET NULL,
				  CONSTRAINT `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_1` FOREIGN KEY (`insert_user_id`) REFERENCES `#client_abb#_users` (`id`) ON DELETE SET NULL
					<cfif arguments.table_general IS true AND ( tableTypeId IS 1 OR tableTypeId IS 2 )>
						, CONSTRAINT `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_3` FOREIGN KEY (`area_id`) REFERENCES `#client_abb#_areas` (`id`) ON DELETE RESTRICT ON UPDATE NO ACTION
					</cfif>

				) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
			</cfquery>

	</cffunction>


	<!--- ------------------------------------- addAreaColumnToTable -------------------------------------  --->

	<cffunction name="addAreaColumnToTable" output="false" access="package" returntype="void">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="default_area_id" type="numeric" required="true">

		<cfset var method = "addAreaColumnToTable">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfquery name="addAreaColumn" datasource="#client_dsn#">
				ALTER TABLE `#client_abb#_#tableTypeTable#_rows_#arguments.table_id#`
					ADD COLUMN `area_id` INT(11) NOT NULL,
					ADD INDEX `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_area_idx` (`area_id` ASC);
			</cfquery>

			<cfquery name="setDefaultArea" datasource="#client_dsn#">
				UPDATE `#client_abb#_#tableTypeTable#_rows_#arguments.table_id#`
				SET area_id = <cfqueryparam value="#arguments.default_area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfquery name="addAreaColumnRestriction" datasource="#client_dsn#">
				ALTER TABLE `#client_abb#_#tableTypeTable#_rows_#arguments.table_id#`
					ADD CONSTRAINT `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_area_idx`
					FOREIGN KEY (`area_id`)
					REFERENCES `#client_abb#_areas` (`id`)
					ON DELETE RESTRICT
					ON UPDATE NO ACTION;
			</cfquery>

	</cffunction>


	<!--- ------------------------------------- deleteAreaColumnInTable -------------------------------------  --->

	<cffunction name="deleteAreaColumnInTable" output="false" access="package" returntype="void">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "deleteAreaColumnInTable">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfquery name="deleteAreaFK" datasource="#client_dsn#">
				ALTER TABLE `#client_abb#_#tableTypeTable#_rows_#arguments.table_id#`
					DROP FOREIGN KEY `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_area_idx`;
			</cfquery>

			<cfquery name="deleteAreaColumn" datasource="#client_dsn#">
				ALTER TABLE `#client_abb#_#tableTypeTable#_rows_#arguments.table_id#`
					DROP COLUMN `area_id`,
					DROP INDEX `FK_#client_abb#_#tableTypeTable#_rows_#arguments.table_id#_area_idx`;
			</cfquery>

	</cffunction>



	<!--- ------------------------------------- getTable -------------------------------------  --->

	<cffunction name="getTable" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="with_categories" type="boolean" required="false" default="false">

		<cfset var method = "getTable">

		<cfset var response = structNew()>

		<cfset var area_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/TableQuery" method="getTable" returnvariable="getTableQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="parse_dates" value="true">
				<cfinvokeargument name="published" value="false">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif getTableQuery.recordCount GT 0>

				<cfset area_id = getTableQuery.area_id>

				<cfif getTableQuery.general IS false><!---No es tabla general--->

					<cfif arguments.tableTypeId IS 3 AND APPLICATION.filesTablesInheritance IS true><!--- Typologies with inheritante --->

						<!--- checkTableWithInheritanceAccess --->
						<cfinvoke component="TableManager" method="checkTableWithInheritanceAccess">
							<cfinvokeargument name="table_id" value="#arguments.table_id#">
							<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">

							<cfinvokeargument name="table_area_id" value="#area_id#">
						</cfinvoke>

					<cfelse>

						<!---checkAreaAccess--->
						<cfinclude template="includes/checkAreaAccess.cfm">

					</cfif>

				</cfif>

				<cfif arguments.with_categories IS true>

					<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getItemCategories" returnvariable="categoriesQuery">
						<cfinvokeargument name="item_id" value="#arguments.table_id#">
						<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

					<cfset response = {result=true, table=#getTableQuery#, categories=#categoriesQuery#}>

				<cfelse>

					<cfset response = {result=true, table=#getTableQuery#}>

				</cfif>


			<cfelse><!---Item does not exist--->

				<cfset error_code = 501>

				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- checkTableWithInheritanceAccess -------------------------------------  --->

	<cffunction name="checkTableWithInheritanceAccess" output="false" access="public" returntype="void">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="table_area_id" type="numeric" required="true">

		<cfset var method = "checkTableAccess">

		<cfset var subAreasIds = "">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!--- Get table sub areas list --->
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getSubAreasIds" returnvariable="subAreasIds">
				<cfinvokeargument name="area_id" value="#arguments.table_area_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset subAreasIds = listAppend(subAreasIds, arguments.table_area_id)>

			<!--- checkAreasAccess --->
			<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreasAccess">
				<cfinvokeargument name="areasList" value="#subAreasIds#">
			</cfinvoke>

	</cffunction>




	<!--- ------------------------------------- getEmptyTable -------------------------------------  --->

	<cffunction name="getEmptyTable" output="false" access="public" returntype="struct">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "getEmptyTable">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfquery name="getTableQuery" datasource="#client_dsn#">
				SELECT *
				FROM #client_abb#_#tableTypeTable#
				WHERE id = -1;
			</cfquery>

			<cfif arguments.tableTypeId IS 1 OR arguments.tableTypeId IS 2>
				<cfset queryAddRow(getTableQuery, 1)>
				<cfset querySetCell(getTableQuery, "publication_date", DateFormat(now(), "DD-MM-YYYY")&" "&TimeFormat(now(), "HH:mm:ss"))>

				<cfset querySetCell(getTableQuery, "publication_validated", true)>
				<cfset querySetCell(getTableQuery, "list_rows_by_default", true)>
			</cfif>

			<cfset response = {result=true, table=#getTableQuery#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ------------------------------------- getAreaTables -------------------------------------  --->

	<cffunction name="getAreaTables" output="false" access="public" returntype="struct">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="area_type" type="string" required="true">
		<cfargument name="user_in_charge" type="numeric" required="false">
		<cfargument name="limit" type="numeric" required="false">
		<cfargument name="structure_available" type="boolean" required="false">
		<cfargument name="with_user" type="boolean" required="false" default="false">

		<cfset var method = "getAreaTables">

		<cfset var response = structNew()>

		<cfset var parentAreasIds = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<!---checkAreaAccess--->
			<cfinclude template="includes/checkAreaAccess.cfm">

			<cfif arguments.tableTypeId IS 3 AND APPLICATION.filesTablesInheritance IS true><!--- Typologies with inheritante --->

				<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getParentAreasIds" returnvariable="parentAreasIds">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="areas_list" value="#arguments.area_id#">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

			</cfif>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getAreaItems" returnvariable="getAreaTablesResult">
				<cfif arguments.tableTypeId IS 3 AND APPLICATION.filesTablesInheritance IS true>
					<cfinvokeargument name="areas_ids" value="#parentAreasIds#">
				<cfelse>
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="area_type" value="#arguments.area_type#">
				</cfif>
				<cfif isDefined("arguments.user_in_charge")>
					<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
				</cfif>
				<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
				<cfinvokeargument name="listFormat" value="true">
				<cfinvokeargument name="format_content" value="default">
				<cfinvokeargument name="with_user" value="#arguments.with_user#">
				<cfinvokeargument name="parse_dates" value="true"/>
				<cfif isDefined("arguments.limit")>
					<cfinvokeargument name="limit" value="#arguments.limit#">
				</cfif>
				<cfif isDefined("arguments.structure_available") AND arguments.structure_available IS true>
					<cfinvokeargument name="structure_available" value="true"/>
				</cfif>
				<cfinvokeargument name="published" value="false">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset areaTablesQuery = getAreaTablesResult.query>

			<cfset response = {result=true, areaTables=#areaTablesQuery#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- getAllAreasTables -------------------------------------  --->

	<cffunction name="getAllAreasTypologies" output="false" access="public" returntype="struct">
		<!---<cfargument name="search_text" type="string" required="no">
		<cfargument name="user_in_charge" type="numeric" required="false">
		<cfargument name="format_content" type="string" required="no" default="default">
		<cfargument name="with_area" type="boolean" required="no" default="false">
		<cfargument name="limit" type="numeric" required="false">
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">

		<cfargument name="structure_available" type="boolean" required="false">--->


		<cfset var method = "getAllAreasTypologies">

		<cfset var response = structNew()>

		<!---<cfset var tableTypeId = 3>--->
		<cfset var user_areas_ids = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="AreaManager" method="getAllUserAreasList" returnvariable="user_areas_ids">
				<cfinvokeargument name="get_user_id" value="#user_id#">
			</cfinvoke>

			<!---
			<cfif APPLICATION.filesTablesInheritance IS true><!--- Typologies with inheritante ---> --->

				<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getAreaFiles" returnvariable="getAreaFilesResult">
					<cfinvokeargument name="areas_ids" value="#user_areas_ids#">
					<cfinvokeargument name="parse_dates" value="false">
					<cfinvokeargument name="with_user" value="false">
					<cfinvokeargument name="with_area" value="false">
					<cfinvokeargument name="with_typology" value="true">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfset filesQuery = getAreaFilesResult.query>

				<cfquery dbtype="query" name="typologiesQuery">
					SELECT DISTINCT typology_id AS id, typology_title AS title
					FROM filesQuery
					ORDER BY title ASC;
				</cfquery>

				<cfset response = {result=true, query=#typologiesQuery#}>

			<!---
			<cfelse>
				<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

				<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getAreaItems" returnvariable="getAreaItemsResult">
					<cfinvokeargument name="areas_ids" value="#user_areas_ids#">
					<!---<cfif isDefined("arguments.search_text")>
						<cfinvokeargument name="search_text" value="#arguments.search_text#">
					</cfif>
					<cfif isDefined("arguments.user_in_charge")>
						<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
					</cfif>--->
					<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
					<cfinvokeargument name="listFormat" value="true">
					<cfinvokeargument name="format_content" value="default">
					<cfinvokeargument name="with_user" value="true">
					<!---<cfinvokeargument name="with_area" value="#arguments.with_area#">--->
					<cfinvokeargument name="parse_dates" value="true"/>
					<!---<cfif isDefined("arguments.limit")>
					<cfinvokeargument name="limit" value="#arguments.limit#">
					</cfif>
					<cfif isDefined("arguments.from_date")>
					<cfinvokeargument name="from_date" value="#arguments.from_date#">
					</cfif>
					<cfif isDefined("arguments.end_date")>
					<cfinvokeargument name="end_date" value="#arguments.end_date#">
					</cfif>--->

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>


				<cfset response = {result=true, query=#getAreaItemsResult.query#}>

			</cfif>--->

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- getAllTypologies -------------------------------------  --->

	<cffunction name="getAllTypologies" output="false" access="public" returntype="struct">
		<cfargument name="tableTypeId" type="string" required="true">
		<cfargument name="with_area" type="boolean" required="false" default="false">
		<cfargument name="parse_dates" type="boolean" required="false" default="true">

		<cfset var method = "getAllTypologies">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/TableQuery" method="getAllTypologies" returnvariable="typologiesQuery">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="with_area" value="#arguments.with_area#">
				<cfinvokeargument name="parse_dates" value="#arguments.parse_dates#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, query=#typologiesQuery#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- -------------------------------- getTablesWithStructureAvailable -------------------------------  --->

	<cffunction name="getTablesWithStructureAvailable" output="false" access="public" returntype="struct">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "getTablesWithStructureAvailable">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/TableQuery" method="getAllTables" returnvariable="getTablesResult">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">

				<cfinvokeargument name="structure_available" value="true"/>

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, tables=#getTablesResult.query#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- getTableFields -------------------------------------  --->

	<cffunction name="getTableFields" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="with_types" type="boolean" required="false" default="false">
		<cfargument name="view_id" type="numeric" required="false">
		<cfargument name="only_view_fields" type="boolean" required="false">
		<cfargument name="file_id" type="numeric" required="false"><!--- Only for Typologies --->
		<cfargument name="with_separators" type="boolean" required="false">
		<cfargument name="include_in_list" type="boolean" required="false">
		<cfargument name="include_in_row_content" type="boolean" required="false">
		<cfargument name="include_in_new_row" type="boolean" required="false">
		<cfargument name="include_in_update_row" type="boolean" required="false">
		<cfargument name="include_in_all_users" type="boolean" required="false">
		<cfargument name="search_id" type="numeric" required="false">

		<cfset var method = "getTableFields">

		<cfset var response = structNew()>

		<cfset var area_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/FieldQuery" method="getTableFields" returnvariable="getTableFieldsQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="with_types" value="#arguments.with_types#">
				<cfinvokeargument name="with_table" value="true">
				<cfinvokeargument name="view_id" value="#arguments.view_id#">
				<cfinvokeargument name="only_view_fields" value="#arguments.only_view_fields#">
				<cfinvokeargument name="with_separators" value="#arguments.with_separators#">
				<cfinvokeargument name="include_in_list" value="#arguments.include_in_list#">
				<cfinvokeargument name="include_in_row_content" value="#arguments.include_in_row_content#">
				<cfinvokeargument name="include_in_new_row" value="#arguments.include_in_new_row#">
				<cfinvokeargument name="include_in_update_row" value="#arguments.include_in_update_row#">
				<cfinvokeargument name="include_in_all_users" value="#arguments.include_in_all_users#">
				<cfinvokeargument name="search_id" value="#arguments.search_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif getTableFieldsQuery.recordCount GT 0>

				<cfset area_id = getTableFieldsQuery.area_id>

				<cfif getTableFieldsQuery.general IS false><!---No es tabla general--->

					<cfif arguments.tableTypeId IS 3 AND isDefined("arguments.file_id")><!---Typology (file)--->

						<!---checkAreaFileAccess--->
						<cfinvoke component="FileManager" method="checkAreaFileAccess" returnvariable="checkAreaFileAccessResponse">
							<cfinvokeargument name="file_id" value="#arguments.file_id#">
						</cfinvoke>

						<cfif checkAreaFileAccessResponse.result IS false>
							<cfset error_code = 104>
							<cfthrow errorcode="#error_code#">
						<cfelse>
							<cfset file = checkAreaFileAccessResponse.file>
							<cfset file_typology_id = file.typology_id>

							<cfif file_typology_id NEQ arguments.table_id>
								<cfset error_code = 104>
								<cfthrow errorcode="#error_code#">
							</cfif>
						</cfif>

					<cfelseif arguments.tableTypeId IS 3 AND APPLICATION.filesTablesInheritance IS true><!--- Typologies with inheritante --->

						<!--- checkTableWithInheritanceAccess --->
						<cfinvoke component="TableManager" method="checkTableWithInheritanceAccess">
							<cfinvokeargument name="table_id" value="#arguments.table_id#">
							<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">

							<cfinvokeargument name="table_area_id" value="#area_id#">
						</cfinvoke>

					<cfelseif getTableFieldsQuery.structure_available IS false><!--- La estructura no está compartida --->

						<!--- checkAreaAccess --->
						<cfinclude template="includes/checkAreaAccess.cfm">

					</cfif>

				</cfif>

			</cfif>

			<cfset response = {result=true, tableFields=getTableFieldsQuery}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- getTableRows -------------------------------------  --->

	<cffunction name="getTableRows" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="fields" type="query" required="false">
		<cfargument name="area_id" type="numeric" required="false">


		<cfset var method = "getTableRows">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="RowManager" method="getTableRows" returnvariable="response">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="fields" value="#arguments.fields#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- getTableRows -------------------------------------  --->

	<cffunction name="getTableRowCount" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="false">


		<cfset var method = "getTableRowCount">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/RowQuery" method="getTableRowCount" returnvariable="rowQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, rowCount=rowQuery.count}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- getTableActions -------------------------------------  --->

	<cffunction name="getTableActions" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "getTableActions">

		<cfset var response = structNew()>

		<cfset var area_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/ActionQuery" method="getTableActions" returnvariable="getTableActionsQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="with_table" value="true">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif getTableActionsQuery.recordCount GT 0>

				<cfset area_id = getTableActionsQuery.area_id>

				<!---checkAreaResponsibleAccess--->
				<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
					<cfinvokeargument name="area_id" value="#area_id#">
				</cfinvoke>

			</cfif>

			<cfset response = {result=true, tableActions=getTableActionsQuery}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- getTableUsers -------------------------------------  --->

	<cffunction name="getTableUsers" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="with_table" type="boolean" required="false" default="false">

		<cfset var method = "getTableUsers">

		<cfset var response = structNew()>

		<cfset var area_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/TableQuery" method="getTable" returnvariable="tableQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="parse_dates" value="false">
				<cfinvokeargument name="published" value="false">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif tableQuery.recordCount IS 0><!---Item does not exist--->

				<cfset error_code = 501>

				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfset area_id = tableQuery.area_id>

			<!---checkAreaResponsibleAccess--->
			<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
				<cfinvokeargument name="area_id" value="#area_id#">
			</cfinvoke>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/TableQuery" method="getTableUsers" returnvariable="getTableUsersQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="with_table" value="#arguments.with_table#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, tableUsers=getTableUsersQuery}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ------------------------------------- getTableViews -------------------------------------  --->

	<cffunction name="getTableViews" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "getTableViews">

		<cfset var response = structNew()>

		<cfset var area_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/ViewQuery" method="getTableViews" returnvariable="getTableViewsQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="with_table" value="true">
				<cfinvokeargument name="parse_dates" value="true">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif getTableViewsQuery.recordCount GT 0>

				<cfset area_id = getTableViewsQuery.area_id>

				<!---
				<cfif arguments.tableTypeId IS NOT 3 OR getTableViewsQuery.general IS false><!---No es tipología general--->

					<cfif arguments.tableTypeId IS 3 AND APPLICATION.filesTablesInheritance IS true><!--- Typologies with inheritante --->

						<!--- checkTableWithInheritanceAccess --->
						<cfinvoke component="TableManager" method="checkTableWithInheritanceAccess">
							<cfinvokeargument name="table_id" value="#arguments.table_id#">
							<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">

							<cfinvokeargument name="table_area_id" value="#area_id#">
						</cfinvoke>

					<cfelseif getTableViewsQuery.structure_available IS false><!--- La estructura no está compartida --->

						<!--- checkAreaAccess --->
						<cfinclude template="includes/checkAreaAccess.cfm">

					</cfif>

				</cfif>
				--->

			</cfif>

			<cfset response = {result=true, tableFields=getTableViewsQuery}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ------------------------------------- getTableSearchs -------------------------------------  --->

	<cffunction name="getTableSearchs" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "getTableSearchs">

		<cfset var response = structNew()>

		<cfset var area_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/TableQuery" method="getTableSearchs" returnvariable="getTableSearchsQuery">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, query=getTableSearchsQuery}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ------------------------------------- setAreaDefaultTable -------------------------------------  --->

	<cffunction name="setAreaDefaultTable" output="false" access="public" returntype="struct">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "setAreaDefaultTable">

		<cfset var response = structNew()>

		<cfset var table = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<!---checkAreaResponsibleAccess--->
			<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfinvoke component="TableManager" method="getTable" returnvariable="getTableResponse">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
			</cfinvoke>

			<cfif getTableResponse.result IS false>
				<cfreturn getTableResponse>
			</cfif>

			<cfset table = getTableResponse.table>

			<cfif arguments.tableTypeId IS 3 AND APPLICATION.filesTablesInheritance IS true><!--- Typologies with inheritante --->

				<!--- Get table sub areas list --->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getSubAreasIds" returnvariable="subAreasIds">
					<cfinvokeargument name="area_id" value="#table.area_id#">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfset subAreasIds = listAppend(subAreasIds, table.area_id)>

				<cfif listFind(subAreasIds, arguments.area_id) IS 0>

					<cfthrow message="Tabla no disponible en esta área">

				</cfif>

			<cfelseif table.area_id NEQ arguments.area_id AND table.general IS false>

				<cfthrow message="Tabla no disponible en esta área">

			</cfif>

			<cfquery datasource="#client_dsn#" name="setAreaDefaultTable">
				UPDATE #client_abb#_areas
				SET default_#tableTypeName#_id = <cfqueryparam value="#arguments.table_id#" cfsqltype="cf_sql_integer">
				WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, area_id=#arguments.area_id#, table_id=#arguments.table_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- removeAreaDefaultTable -------------------------------------  --->

	<cffunction name="removeAreaDefaultTable" output="false" access="public" returntype="struct">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "removeAreaDefaultTable">

		<cfset var response = structNew()>

		<cfset var table = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<!---checkAreaResponsibleAccess--->
			<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfquery datasource="#client_dsn#" name="setAreaDefaultTable">
				UPDATE #client_abb#_areas
				SET default_#tableTypeName#_id = <cfqueryparam null="true" cfsqltype="cf_sql_integer">
				WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, area_id=#arguments.area_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ------------------------------------- getAreaDefaultTable -------------------------------------  --->

	<cffunction name="getAreaDefaultTable" output="false" access="public" returntype="struct">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">

		<cfset var method = "getAreaDefaultTable">

		<cfset var response = structNew()>

		<cfset var default_table_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfquery datasource="#client_dsn#" name="getAreaDefaultTableId">
				SELECT areas.parent_id, areas.default_#tableTypeName#_id AS default_table_id
				FROM #client_abb#_areas AS areas
				WHERE areas.id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif getAreaDefaultTableId.recordCount GT 0>

				<cfif isNumeric(getAreaDefaultTableId.default_table_id) GT 0>

					<cfset default_table_id = getAreaDefaultTableId.default_table_id>

				<cfelseif isNumeric(getAreaDefaultTableId.parent_id)>

					<cfinvoke component="TableManager" method="getAreaDefaultTable" returnvariable="defaultTableResponse">
						<cfinvokeargument name="area_id" value="#getAreaDefaultTableId.parent_id#">
						<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
					</cfinvoke>

					<cfset default_table_id = defaultTableResponse.table_id>

				</cfif>

			<cfelse><!---The area does not exist--->

				<cfset error_code = 401>
				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfset response = {result=true, table_id=#default_table_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!------------------------ IS USER IN TABLE-------------------------------------->
	<cffunction name="isUserInTable" returntype="struct" output="false" access="public">
		<cfargument name="table_id" type="numeric" required="true"/>
		<cfargument name="check_user_id" type="numeric" required="true"/>

		<cfset var method = "isUserInTable">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<!---isUserInTable--->
			<cfquery name="isUserInTable" datasource="#client_dsn#">
				SELECT user_id
				FROM #client_abb#_#tableTypeTable#_users
				WHERE #tableTypeName#_id = <cfqueryparam value="#arguments.table_id#" cfsqltype="cf_sql_integer">
				AND user_id = <cfqueryparam value="#arguments.check_user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif isUserInTable.recordCount GT 0><!--- The user is in the table  --->
				<cfset response = {result=true, isUserInTable=true}>
			<cfelse>
				<cfset response = {result=true, isUserInTable=false}>
			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!------------------------ ADD USER TO TABLE-------------------------------------->
	<cffunction name="addUserToTable" returntype="struct" output="false" access="private">
		<cfargument name="tableQuery" type="query" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="add_user_id" type="numeric" required="true">

		<cfset var method = "addUserToTable">

		<cfset response = structNew()>

		<cfset var client_abb = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfset table_id = tableQuery.table_id>

			<cfinvoke component="UserManager" method="getUser" returnvariable="userQuery">
				<cfinvokeargument name="get_user_id" value="#arguments.add_user_id#">
				<cfinvokeargument name="return_type" value="query"/>
			</cfinvoke>

			<cfinvoke component="TableManager" method="isUserInTable" returnvariable="isUserInTableResponse">
				<cfinvokeargument name="table_id" value="#table_id#">
				<cfinvokeargument name="check_user_id" value="#arguments.add_user_id#">
			</cfinvoke>
			<cfif isUserInTableResponse.result IS false>
				<cfreturn isUserInTableResponse>
			</cfif>

			<cfif isUserInTableResponse.isUserInTable IS true><!--- The user already is in the table  --->
				<cfthrow message="El usuario ya estaba añadido en la #tableTypeNameEs#">
			</cfif>

			<cfquery name="addUserToTable" datasource="#client_dsn#">
				INSERT INTO #client_abb#_#tableTypeTable#_users (#tableTypeName#_id, user_id)
				VALUES (<cfqueryparam value="#table_id#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#arguments.add_user_id#" cfsqltype="cf_sql_integer">);
			</cfquery>

			<cfinvoke component="AlertManager" method="addUserToTable">
				<cfinvokeargument name="tableQuery" value="#arguments.tableQuery#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="userQuery" value="#userQuery#">
			</cfinvoke>

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, table_id=#table_id#, user_id=#arguments.add_user_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!------------------------ ADD USERS TO TABLE-------------------------------------->
	<cffunction name="addUsersToTable" returntype="struct" output="false" access="public">
		<cfargument name="table_id" type="numeric" required="true"/>
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="users_ids" type="array" required="true"/>

		<cfset var method = "addUsersToTable">

		<cfset var response = structNew()>

		<cfset var area_id = "">
		<cfset var table = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="TableManager" method="getTable" returnvariable="getTableResponse">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
			</cfinvoke>

			<cfif getTableResponse.result IS false>
				<cfreturn getTableResponse>
			</cfif>

			<cfset table = getTableResponse.table>

			<cfset area_id = table.area_id>

			<!---checkAreaResponsibleAccess--->
			<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
				<cfinvokeargument name="area_id" value="#area_id#">
			</cfinvoke>

			<cfloop array="#arguments.users_ids#" index="cur_user_id">

				<cfinvoke component="TableManager" method="addUserToTable" returnvariable="responseAddUser">
					<cfinvokeargument name="tableQuery" value="#table#"/>
					<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#"/>
					<cfinvokeargument name="add_user_id" value="#cur_user_id#"/>
				</cfinvoke>

				<cfif responseAddUser.result IS false><!---User assign failed--->

					<cfreturn responseAddUser>

				</cfif>

			</cfloop>

			<cfset response = {result=true, table_id=#arguments.table_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ------------------------------------- removeUserFromTable -------------------------------------  --->

	<cffunction name="removeUserFromTable" output="false" access="public" returntype="struct">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="remove_user_id" type="numeric" required="true">

		<cfset var method = "removeUserFromTable">

		<cfset var response = structNew()>

		<cfset var area_id = "">
		<cfset var table = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfinvoke component="TableManager" method="getTable" returnvariable="getTableResponse">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
			</cfinvoke>

			<cfif getTableResponse.result IS false>
				<cfreturn getTableResponse>
			</cfif>

			<cfset table = getTableResponse.table>

			<cfset area_id = table.area_id>

			<!---checkAreaResponsibleAccess--->
			<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
				<cfinvokeargument name="area_id" value="#area_id#">
			</cfinvoke>

			<cfinvoke component="TableManager" method="isUserInTable" returnvariable="isUserInTableResponse">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="check_user_id" value="#arguments.remove_user_id#">
			</cfinvoke>
			<cfif isUserInTableResponse.result IS false>
				<cfreturn isUserInTableResponse>
			</cfif>

			<cfif isUserInTableResponse.isUserInTable IS false><!--- The user is not in the table  --->
				<cfthrow message="El usuario no estaba añadido en la #tableTypeNameEs#">
			</cfif>

			<cfquery name="removeUserFromTable" datasource="#client_dsn#">
				DELETE FROM #client_abb#_#tableTypeTable#_users
				WHERE #tableTypeName#_id = <cfqueryparam value="#arguments.table_id#" cfsqltype="cf_sql_integer">
				AND user_id = <cfqueryparam value="#arguments.remove_user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, table_id=#arguments.table_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>



	<!------------------------ HAS TABLE ROWS OF OTHER AREAS-------------------------------------->

	<cffunction name="hasTableRowsOfOtherAreas" returntype="struct" output="false" access="public">
		<cfargument name="table_id" type="numeric" required="true"/>
		<cfargument name="tableTypeId" type="numeric" required="true"/>

		<cfset var method = "hasTableRowsOfOtherAreas">

		<cfset var response = structNew()>

		<cfset var rowsOfOtherAreas = false>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<!---Table fields--->
			<cfinvoke component="#APPLICATION.componentsPath#/TableManager" method="getTableFields" returnvariable="fieldsResult">
				<cfinvokeargument name="table_id" value="#table_id#">
				<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
				<cfinvokeargument name="with_types" value="true">
				<cfif isDefined("URL.search_id") AND isNumeric(URL.search_id)>
					<cfinvokeargument name="search_id" value="#URL.search_id#">
				</cfif>
			</cfinvoke>
			<cfset allFields = fieldsResult.tableFields>

			<cfif allFields.general IS true><!--- General table --->

				<cfinvoke component="#APPLICATION.componentsPath#/TableManager" method="getTableRows" returnvariable="tableRowsResult">
					<cfinvokeargument name="table_id" value="#table_id#">
					<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
					<cfinvokeargument name="fields" value="#allFields#">
				</cfinvoke>

				<cfset tableRows = tableRowsResult.rows>

				<cfif tableRows.recordCount GT 0>

					<cfquery dbtype="query" name="rowsOfOtherAreasQuery">
						SELECT *
						FROM tableRows
						WHERE area_id != <cfqueryparam value="#allFields.area_id#" cfsqltype="cf_sql_integer">;
					</cfquery>

					<cfif rowsOfOtherAreasQuery.recordCount GT 0>
						<cfset rowsOfOtherAreas = true>
					</cfif>

				</cfif>

			</cfif>

			<cfset response = {result=true, rowsOfOtherAreas=rowsOfOtherAreas}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>

	<!------------------------ GET TABLE ROWS IN USER AREAS-------------------------------------->

	<cffunction name="getTableRowsInUserAreas" returntype="struct" output="false" access="public">
		<cfargument name="table_id" type="numeric" required="true"/>
		<cfargument name="tableTypeId" type="numeric" required="true"/>
		<cfargument name="get_user_id" type="numeric" required="true"/>

		<cfset var method = "getTableRowsInUserAreas">

		<cfset var response = structNew()>

		<cfset var userAreasIds = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

			<cfinvoke component="AreaManager" method="getAllUserAreasList" returnvariable="userAreasIds">
				<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
			</cfinvoke>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/TableManager" method="getTableRowsInAreas" returnvariable="response">
				<cfinvokeargument name="table_id" value="#arguments.table_id#">
				<cfinvokeargument name="tableTypeId" value="#arguments.tableTypeId#">
				<cfinvokeargument name="areas_ids" value="#userAreasIds#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


</cfcomponent>
