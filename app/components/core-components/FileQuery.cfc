<!---Copyright Era7 Information Technologies 2007-2012

	Date of file creation: 16-05-2012
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 14-01-2013
	
--->
<cfcomponent output="false">

	<cfset component = "FileQuery">	
	
	<cfset date_format = "%d-%m-%Y"><!---%H:%i:%s---><!---Formato de fecha en la que se debe recibir los parámetros--->
	<cfset datetime_format = "%d-%m-%Y %H:%i:%s">
	
	
	<!---getFile--->
	
	<cffunction name="getFile" output="false" returntype="query" access="public">
		<cfargument name="file_id" type="numeric" required="yes">
		<cfargument name="area_id" type="numeric" required="no">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "getFile">
					
		
		<cfquery name="selectFileQuery" datasource="#client_dsn#">		
			SELECT physical_name, user_in_charge, file_size, file_type, files.name, file_name, uploading_date, replacement_date, files.description, files.status, users.family_name, files.id AS file_id, users.name AS user_name, users.image_type AS user_image_type
			<cfif isDefined("arguments.area_id")>
			, areas_files.association_date
			</cfif>
			FROM #client_abb#_files AS files
			INNER JOIN #client_abb#_users AS users 
			ON files.id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer"> AND files.user_in_charge = users.id
			<cfif isDefined("arguments.area_id")>
			INNER JOIN #client_abb#_areas_files AS areas_files 
			ON areas_files.area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer"> AND files.id = areas_files.file_id
			</cfif>
			AND status = 'ok';
		</cfquery>	
			
		
		<cfreturn selectFileQuery>
		
	</cffunction>
	
	
	
	<!---getAreaFiles--->
	
	<cffunction name="getAreaFiles" output="false" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="no">
		<cfargument name="areas_ids" type="string" required="no">
		<cfargument name="search_text" type="string" required="no">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="limit" type="numeric" required="no">
		<cfargument name="with_area" type="boolean" required="no" default="false">
		
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "getAreaFiles">
		<cfset var count = 0>
		
		<cfset var search_text_re = "">
		
		<cfif isDefined("arguments.search_text") AND len(arguments.search_text) GT 0>
			
			<cfinvoke component="#APPLICATION.componentsPath#/SearchManager" method="generateSearchText" returnvariable="search_text_re">
				<cfinvokeargument name="text" value="#arguments.search_text#">
			</cfinvoke>
			
		</cfif>
		
		<cfquery name="areaFilesQuery" datasource="#client_dsn#">
			SELECT <cfif isDefined("arguments.limit")>SQL_CALC_FOUND_ROWS</cfif>
			files.id, files.physical_name, files.user_in_charge, files.file_size, files.file_type, a.association_date, files.replacement_date, files.name, files.file_name, files.description, users.family_name, a.area_id, users.name AS user_name, IF(replacement_date IS NULL,association_date,replacement_date) AS last_version_date
			<cfif arguments.with_area IS true>
			, areas.name AS area_name
			</cfif>
			FROM #client_abb#_areas_files AS a
			INNER JOIN #client_abb#_files AS files ON a.file_id = files.id
			INNER JOIN #client_abb#_users AS users ON files.user_in_charge = users.id
			<cfif arguments.with_area IS true>
			INNER JOIN #client_abb#_areas AS areas ON a.area_id = areas.id
			</cfif>
			WHERE 
			<cfif isDefined("arguments.areas_ids")>
			a.area_id IN (<cfqueryparam value="#arguments.areas_ids#" cfsqltype="cf_sql_varchar" list="yes">)
			<cfelse>
			a.area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif isDefined("arguments.user_in_charge")>
			AND files.user_in_charge = <cfqueryparam value="#arguments.user_in_charge#" cfsqltype="cf_sql_integer">
			</cfif>
			<cfif len(search_text_re) GT 0><!---Search--->
			AND (files.name REGEXP <cfqueryparam value="#search_text_re#" cfsqltype="cf_sql_varchar">
			OR files.physical_name REGEXP <cfqueryparam value="#search_text_re#" cfsqltype="cf_sql_varchar">
			OR files.description REGEXP <cfqueryparam value="#search_text_re#" cfsqltype="cf_sql_varchar">
			)
			</cfif>
			AND files.status = 'ok'
			
			<cfif isDefined("arguments.from_date")>
			AND files.uploading_date >= STR_TO_DATE(<cfqueryparam value="#arguments.from_date#" cfsqltype="cf_sql_varchar">,'#date_format#')
			</cfif>
			<cfif isDefined("arguments.end_date")>
			AND files.uploading_date <= STR_TO_DATE(<cfqueryparam value="#arguments.end_date# 23:59:59" cfsqltype="cf_sql_varchar">,'#datetime_format#')
			</cfif>			
			
			ORDER BY last_version_date DESC
			<cfif isDefined("arguments.limit")>
			LIMIT #arguments.limit#
			</cfif>;
		</cfquery>
		
		<cfif isDefined("arguments.limit")>
			<cfquery datasource="#client_dsn#" name="getCount">
				SELECT FOUND_ROWS() AS count;
			</cfquery>
			<cfset count = getCount.count>
		</cfif>
		
		
		<!---<cfreturn areaFilesQuery>--->
		
		<cfreturn {query=areaFilesQuery, count=count}>
		
	</cffunction>
	
	
	
	<!---getImage--->
	
	<cffunction name="getImage" output="false" returntype="query" access="public">
		<cfargument name="image_id" type="numeric" required="yes">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "getImage">
					
		<cfquery name="selectImageQuery" datasource="#client_dsn#">		
			SELECT images.*, file_size AS file_size_full
			FROM #client_abb#_areas_images AS images
			WHERE images.id = <cfqueryparam value="#arguments.image_id#" cfsqltype="cf_sql_integer">
			AND status = 'ok';
		</cfquery>	
			
		<cfreturn selectImageQuery>
		
	</cffunction>
  
</cfcomponent>