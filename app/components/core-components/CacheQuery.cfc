<!--- Copyright Era7 Information Technologies 2007-2014 --->

<cfcomponent output="false">

	<cfset component = "CacheQuery">

	<!---getCacheTree--->
		
	<cffunction name="getCacheTree" output="false" returntype="query" access="public">
		<cfargument name="user_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="version" type="numeric" required="true">
		<cfargument name="tree_type" type="string" required="true"><!--- default / admin --->
		
		<cfargument name="client_abb" type="string" required="true">
		<cfargument name="client_dsn" type="string" required="true">		
		
		<cfset var method = "getArea">
			
			<cfquery datasource="#client_dsn#" name="getCacheQuery">
				SELECT *
				FROM #client_abb#_areas_tree_cache
				WHERE user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">
				AND area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND version = <cfqueryparam value="#arguments.version#" cfsqltype="cf_sql_integer">
				AND tree_type = <cfqueryparam value="#arguments.tree_type#" cfsqltype="cf_sql_varchar">;
			</cfquery>
		
		<cfreturn getCacheQuery>
		
	</cffunction>


	<!---saveCacheTree--->
		
	<cffunction name="saveCacheTree" output="false" returntype="void" access="public">
		<cfargument name="user_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="version" type="numeric" required="true">
		<cfargument name="tree_type" type="string" required="true"><!--- default / admin --->
		<cfargument name="cache_content" type="string" required="true">
		
		<cfargument name="client_abb" type="string" required="true">
		<cfargument name="client_dsn" type="string" required="true">		
		
		<cfset var method = "saveCacheTree">
			
			<cfquery datasource="#client_dsn#" name="saveCacheTreeQuery">
				INSERT INTO #client_abb#_areas_tree_cache
				SET user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">,
				area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">,
				tree_type = <cfqueryparam value="#arguments.tree_type#" cfsqltype="cf_sql_varchar">,
				version = <cfqueryparam value="#arguments.version#" cfsqltype="cf_sql_integer">,
				cache_content = <cfqueryparam value="#arguments.cache_content#" cfsqltype="cf_sql_longvarchar">
				ON DUPLICATE KEY UPDATE version = <cfqueryparam value="#arguments.version#" cfsqltype="cf_sql_integer">,
				cache_content = <cfqueryparam value="#arguments.cache_content#" cfsqltype="cf_sql_longvarchar">;
			</cfquery>
				
	</cffunction>


	<!---deleteUserCacheTree--->

	<cffunction name="deleteUserCacheTree" output="false" returntype="void" access="public">
		<cfargument name="user_id" type="numeric" required="true">
		<cfargument name="tree_type" type="string" required="true">
		
		<cfargument name="client_abb" type="string" required="true">
		<cfargument name="client_dsn" type="string" required="true">		
		
		<cfset var method = "deleteUserCacheTree">
			
			<cfquery datasource="#client_dsn#" name="deleteUserCacheTreeQuery">
				DELETE
				FROM #client_abb#_areas_tree_cache
				WHERE user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">
				AND tree_type = <cfqueryparam value="#arguments.tree_type#" cfsqltype="cf_sql_varchar">;
			</cfquery>
				
	</cffunction>

</cfcomponent>