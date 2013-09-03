<!---Copyright Era7 Information Technologies 2007-2012

	Date of file creation: 25-04-2012
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 26-12-2012
	
	27-09-2012 alucena: añadidos campos de iframe para entradas, noticias y eventos
	02-10-2012 alucena: los enlaces y documentos solo se listan en vpnet
	26-11-2012 alucena: añadido position a noticias
	09-04-2013 alucena: getItem devuelve valores de iframes_display_types
	21-06-2013 alucena: areaItemTypeSwitch.cfm cambiado de directorio
	
--->
<cfcomponent output="false">

	<cfset component = "AreaItemQuery">	
	
	
	<cfset date_format = "%d-%m-%Y"><!---%H:%i:%s---><!---Formato de fecha en la que se debe recibir los parámetros--->
	<cfset datetime_format = "%d-%m-%Y %H:%i:%s">
	
	<!---getItem--->
	
	<cffunction name="getItem" output="false" returntype="query" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "getItem">
					
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfquery name="selectItemQuery" datasource="#client_dsn#">
				SELECT items.parent_id, items.parent_kind, items.user_in_charge, items.creation_date, items.title, items.description, items.attached_file_id, items.attached_file_name, files.file_type, items.area_id, items.id AS item_id, items.link,
				users.name AS user_name, users.family_name, users.image_type AS user_image_type
				
				<cfif arguments.itemTypeId IS NOT 1>
					, items.last_update_date, items.attached_image_id, items.attached_image_name
				</cfif>
				<cfif itemTypeId IS 5 OR itemTypeId IS 6><!---Events, Tasks--->
				, items.start_date, items.end_date
					<cfif itemTypeId IS 5><!---Events--->
					, items.start_time, items.end_time
					, items.place
					<cfelse><!---Tasks--->
					, items.recipient_user, items.done, items.estimated_value, items.real_value
					</cfif>
				</cfif>
				<cfif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News--->
					, items.position
					<cfif itemTypeId IS 2><!---Entries--->
					, items.display_type_id
					</cfif>
				</cfif> 
				<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 4 OR arguments.itemTypeId IS 5><!---Entries, News, Events--->	
					, items.iframe_url, items.iframe_display_type_id, iframes_display_types.width AS iframe_width, iframes_display_types.width_unit AS iframe_width_unit, iframes_display_types.height AS iframe_height, iframes_display_types.height_unit AS iframe_height_unit
				</cfif>	 
				<cfif arguments.itemTypeId IS 7><!---Consultation--->
					, items.state, items.identifier, items.read_date
				</cfif>
				FROM #client_abb#_#itemTypeTable# AS items
				INNER JOIN #client_abb#_users AS users ON items.user_in_charge = users.id
				LEFT JOIN #client_abb#_files AS files ON files.id = items.attached_file_id
				<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 4 OR arguments.itemTypeId IS 5>
				INNER JOIN #client_abb#_iframes_display_types AS iframes_display_types ON items.iframe_display_type_id = iframes_display_types.iframe_display_type_id
				</cfif>
				WHERE items.id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">; 
			</cfquery>
			<!---AND status='ok'???? Esto no se pone por si se necesitan obtener mensajes desde la aplicación con el status pending--->
		
		<cfreturn selectItemQuery>
		
	</cffunction>
	
	
	<!---getAreaItems--->
	
	<cffunction name="getAreaItems" output="false" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="format_content" type="string" required="yes">
		<cfargument name="listFormat" type="string" required="yes">
		<cfargument name="area_id" type="string" required="no">
		<cfargument name="areas_ids" type="string" required="no">
		<cfargument name="search_text" type="string" required="no">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="recipient_user" type="numeric" required="no">
		<cfargument name="with_user" type="boolean" required="no" default="false">
		<cfargument name="with_area" type="boolean" required="no" default="false">
		<cfargument name="limit" type="numeric" required="no"><!---Limita el número de elementos a mostrar. Solo debe usarse si listFormat es false--->
		<cfargument name="done" type="boolean" required="no">
		<cfargument name="state" type="string" required="no">
		<cfargument name="offset" type="numeric" required="no">
		<!---<cfargument name="init_item" type="string" required="no">
		<cfargument name="items_page" type="string" required="no">--->		
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">	
		
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">	
		
		<cfset var method = "getAreaItems">
		<cfset var count = 0>
		
		<cfset var search_text_re = "">
					
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfif isDefined("arguments.search_text") AND len(arguments.search_text) GT 0>
			
				<cfinvoke component="#APPLICATION.componentsPath#/SearchManager" method="generateSearchText" returnvariable="search_text_re">
					<cfinvokeargument name="text" value="#arguments.search_text#">
				</cfinvoke>
				
			</cfif>
			
			
			<cftransaction>
			
				<cfquery name="areaItemsQuery" datasource="#client_dsn#">
					SELECT <cfif isDefined("arguments.limit")>SQL_CALC_FOUND_ROWS</cfif>
					items.id, items.title, items.user_in_charge, items.creation_date, 
					items.attached_file_name, items.attached_file_id, items.area_id
					<cfif arguments.with_user IS true>
					, users.family_name, users.name AS user_name, users.image_type AS user_image_type
					<cfif arguments.itemTypeId IS 6><!---Tasks--->
					, items.start_date, items.end_date, items.done, items.estimated_value, items.real_value, items.end_date
					, recipient_users.family_name AS recipient_user_family_name, recipient_users.name AS recipient_user_name
					</cfif>					
					</cfif>
					<cfif arguments.itemTypeId IS NOT 1>
					, items.attached_image_id, items.attached_image_name, items.link				
					</cfif>
					<cfif itemTypeId IS 5><!---Events--->
					, items.start_date, items.end_date, items.start_time, items.end_time, items.place
					</cfif>
					<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 3 OR arguments.itemTypeId IS 4><!---Entries, Links, News--->
						, items.position
						<cfif itemTypeId IS 2><!---Entries--->
						, items.display_type_id
						</cfif>
					</cfif>
					
					<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 4 OR arguments.itemTypeId IS 5><!---Entries, News, Events--->	
					, items.iframe_url, items.iframe_display_type_id, iframes_display_types.width AS iframe_width, iframes_display_types.width_unit AS iframe_width_unit, iframes_display_types.height AS iframe_height, iframes_display_types.height_unit AS iframe_height_unit
					</cfif>	 
					
					<cfif arguments.itemTypeId IS 7><!---Consultations--->
					, items.state, items.identifier
					</cfif>
					<cfif arguments.itemTypeId IS 7><!---Consultation--->
					, items.state, items.identifier
					</cfif>
					<cfif format_content EQ "all"><!---format_content EQ all--->
					, items.parent_id, items.parent_kind, items.description
					</cfif>
					<cfif arguments.with_area IS true>
					, areas.name AS area_name
					</cfif>
					FROM #client_abb#_#itemTypeTable# AS items
					<cfif arguments.with_user IS true>
						INNER JOIN #client_abb#_users AS users ON items.user_in_charge = users.id 
						<cfif arguments.itemTypeId IS 6><!---Tasks--->
						INNER JOIN #client_abb#_users AS recipient_users ON items.recipient_user = recipient_users.id
						</cfif>
					</cfif>
					<cfif arguments.with_area IS true>
						INNER JOIN #client_abb#_areas AS areas ON items.area_id = areas.id
					</cfif>
					<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 4 OR arguments.itemTypeId IS 5>
						INNER JOIN #client_abb#_iframes_display_types AS iframes_display_types ON items.iframe_display_type_id = iframes_display_types.iframe_display_type_id
					</cfif>
					WHERE  
					<cfif isDefined("arguments.areas_ids")>
					items.area_id IN (<cfqueryparam value="#arguments.areas_ids#" cfsqltype="cf_sql_varchar" list="yes">)
					<cfelse>
					items.area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
					</cfif>
					<cfif isDefined("arguments.user_in_charge")>
					AND items.user_in_charge = <cfqueryparam value="#arguments.user_in_charge#" cfsqltype="cf_sql_integer">
					</cfif>
					<cfif arguments.itemTypeId IS 6 AND isDefined("arguments.recipient_user")>
					AND items.recipient_user = <cfqueryparam value="#arguments.recipient_user#" cfsqltype="cf_sql_integer">
					</cfif>
					<cfif len(search_text_re) GT 0><!---Search--->
					AND (items.title REGEXP <cfqueryparam value="#search_text_re#" cfsqltype="cf_sql_varchar">
					OR items.description REGEXP <cfqueryparam value=">.*#search_text_re#.*<" cfsqltype="cf_sql_varchar">
					OR items.attached_file_name REGEXP <cfqueryparam value="#search_text_re#" cfsqltype="cf_sql_varchar">
					OR items.link REGEXP <cfqueryparam value="#search_text_re#" cfsqltype="cf_sql_varchar">
					<cfif arguments.itemTypeId IS NOT 1>
					OR items.attached_image_name REGEXP <cfqueryparam value="#search_text_re#" cfsqltype="cf_sql_varchar">
					</cfif>
					)
					</cfif>
					AND status='ok'
					<cfif arguments.listFormat NEQ "true">
					AND parent_kind='area' 
					</cfif>
					<cfif isDefined("arguments.done")>
					AND items.done = <cfqueryparam value="#arguments.done#" cfsqltype="cf_sql_bit">
					</cfif>
					<cfif isDefined("arguments.state")>
					AND items.state = <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">
					</cfif>
					
					

					<cfif isDefined("arguments.from_date")>
					AND items.creation_date >= STR_TO_DATE(<cfqueryparam value="#arguments.from_date#" cfsqltype="cf_sql_varchar">,'#date_format#')
					</cfif>
					<cfif isDefined("arguments.end_date")>
					AND items.creation_date <= STR_TO_DATE(<cfqueryparam value="#arguments.end_date# 23:59:59" cfsqltype="cf_sql_varchar">,'#datetime_format#')
					</cfif>

					
					<cfif (arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 3) AND NOT isDefined("arguments.areas_ids")><!---Entries, Links--->
					ORDER BY items.position ASC, items.creation_date ASC
					<cfelseif arguments.itemTypeId IS 4 AND NOT isDefined("arguments.areas_ids")><!---News--->
					ORDER BY items.position DESC
					<cfelse>
					ORDER BY items.creation_date DESC				
					</cfif>
					
					<cfif isDefined("arguments.limit")>
					LIMIT <cfif isDefined("arguments.offset")>#arguments.offset#, </cfif>#arguments.limit#
					<!---<cfelseif isDefined("arguments.init_item") AND isDefined("arguments.items_page")>
					LIMIT #init_item#, #items_page#--->			
					</cfif>;
				</cfquery>
				
				<cfif isDefined("arguments.limit")>
					<cfquery datasource="#client_dsn#" name="getCount">
						SELECT FOUND_ROWS() AS count;
					</cfquery>
					<cfset count = getCount.count>
				</cfif>
			
			</cftransaction>
		
		<cfreturn {query=areaItemsQuery, count=count}>
		
	</cffunction>
	
	
	<!---  -------------------GET ITEM PARENT----------------------   --->
	<cffunction name="getItemParent" returntype="struct" output="false" access="public">
		<cfargument name="item_id" required="yes" type="numeric">
		<cfargument name="itemTypeId" required="yes" type="numeric">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">
		
		<cfset var method = "getItemParent">
		
		<cfset var parent_area_id = "">
		
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfquery name="getParent" datasource="#client_dsn#">
				SELECT parent_kind, area_id 
				<cfif itemTypeId IS 7><!---Consultations--->
				, state
				</cfif>
				FROM #client_abb#_#itemTypeTable#
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">; 
			</cfquery>
			
			<cfif getParent.recordCount GT 0>
			
				<cfset parent_area_id = getParent.area_id>
				
				<cfif itemTypeId IS NOT 7>
					<cfreturn {parent_area_id=parent_area_id}>
				<cfelse>
					<cfreturn {parent_area_id=parent_area_id, state=getParent.state}>
				</cfif>
				
			<cfelse><!---Item does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#" detail="item_id: #arguments.item_id#">
					
			</cfif>	

		
	</cffunction>
	
	
	<!---  -------------------GET ITEM ROOT----------------------   --->
	<cffunction name="getItemRoot" returntype="query" output="false" access="public">
		<cfargument name="item_id" required="yes" type="numeric">
		<cfargument name="itemTypeId" required="yes" type="numeric">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">
		
		<cfset var method = "getItemRoot">
		
		<cfset var parent_area_id = "">
		
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfquery name="getParentQuery" datasource="#client_dsn#">
				SELECT id, parent_id, parent_kind, area_id, user_in_charge 
				<cfif itemTypeId IS 7><!---Consultations--->
				, state
				</cfif>
				FROM #client_abb#_#itemTypeTable#
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">; 
			</cfquery>
			
			<cfif getParentQuery.recordCount GT 0>
			
				<cfif getParentQuery.parent_kind EQ "area">
					
					<cfreturn getParentQuery>
				
				<cfelse>
				
					<cfinvoke component="AreaItemQuery" method="getItemRoot" returnvariable="getItemRootResult">
						<cfinvokeargument name="item_id" value="#getParentQuery.parent_id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>
					
					<cfreturn getItemRootResult>
					
				</cfif>
				
			<cfelse><!---Item does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#" detail="item_id: #arguments.item_id#">
					
			</cfif>	

		
	</cffunction>
	
	
	<!---listAllAreaItems--->
	
	<cffunction name="listAllAreaItems" output="false" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="area_type" type="string" required="yes">
		<cfargument name="limit" type="numeric" required="no">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "listAllAreaItems">
		
			<cfset commonColums = "id, title, creation_date, description, user_in_charge, attached_file_id, area_id"><!---attached_file_name,--->
								
			<cfquery name="areaItemsQuery" datasource="#client_dsn#">
				SELECT items.*, CONCAT_WS(' ', users.family_name, users.name) AS user_full_name, users.image_type AS user_image_type
				FROM (
				<cfif len(arguments.area_type) IS 0><!---IS NOT WEB--->
					(SELECT #commonColums#, NULL AS attached_image_id, NULL AS position, NULL AS done, 1 AS itemTypeId
					FROM #client_abb#_messages AS messages 
					WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
					AND status='ok')
					<cfif APPLICATION.moduleConsultations IS true>
					UNION ALL
					(SELECT #commonColums#, attached_image_id, NULL AS position, NULL AS done, 7 AS itemTypeId
					FROM #client_abb#_consultations AS consultations
					WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
					AND status='ok')
					</cfif>
				<cfelse><!---WEB--->
					(SELECT #commonColums#, attached_image_id, position, NULL AS done, 2 AS itemTypeId
					FROM #client_abb#_entries AS entries
					WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
					AND status='ok')
					<cfif APPLICATION.identifier EQ "vpnet">
					UNION ALL
					(SELECT #commonColums#, attached_image_id, position, NULL AS done, 3 AS itemTypeId
					FROM #client_abb#_links AS links
					WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
					AND status='ok')
					</cfif>
					UNION ALL
					(SELECT #commonColums#, attached_image_id, position, NULL AS done, 4 AS itemTypeId
					FROM #client_abb#_news AS news
					WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
					AND status='ok')
				</cfif>
				UNION ALL
				(SELECT #commonColums#, attached_image_id, NULL AS position, NULL AS done, 5 AS itemTypeId
				FROM #client_abb#_events AS events
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok')
				UNION ALL
				(SELECT #commonColums#, attached_image_id, NULL AS position, done, 6 AS itemTypeId
				FROM #client_abb#_tasks AS tasks
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok')
				<!---Files--->
				UNION ALL
				(SELECT id, name, association_date, description, user_in_charge, id AS attached_file_id, #area_id# AS area_id, NULL AS attached_image_id, NULL AS position, NULL AS done, 10 AS itemTypeId
				FROM #client_abb#_files AS files
				INNER JOIN #client_abb#_areas_files AS area_files ON files.id = area_files.file_id
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok') 
				) AS items
				INNER JOIN #client_abb#_users AS users
				ON items.user_in_charge = users.id
				ORDER BY items.creation_date DESC
				<cfif isDefined("arguments.limit")>
				LIMIT #arguments.limit#
				</cfif>;
			</cfquery>	
		
		<cfreturn {query=areaItemsQuery}>
		
	</cffunction>
	
	
	
	<!---listAllAreaWebItems--->
	<!---Esta función debe dejar de usarse, se mantiene por retrocompatibilidad--->
	<cffunction name="listAllAreaWebItems" output="false" returntype="query" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="limit" type="numeric" required="no">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "listAllAreaWebItems">
								
			<cfquery name="areaWebItemsQuery" datasource="#client_dsn#">
				(SELECT id, title, creation_date, description, 2 AS type_id, #area_id# AS area_id
				FROM #client_abb#_entries AS entries
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok')
				<cfif APPLICATION.identifier EQ "vpnet">
				UNION ALL
				(SELECT id, title, creation_date, description, 3 AS type_id, #area_id# AS area_id
				FROM #client_abb#_links AS links
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok')
				</cfif>
				UNION ALL
				(SELECT id, title, creation_date, description, 4 AS type_id, #area_id# AS area_id
				FROM #client_abb#_news AS news
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok')
				UNION ALL
				(SELECT id, title, creation_date, description, 5 AS type_id, #area_id# AS area_id
				FROM #client_abb#_events AS events
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok')
				<cfif APPLICATION.identifier EQ "vpnet">
				<!---Files--->
				UNION ALL
				(SELECT id, name, association_date, description, 10 AS type_id, #area_id# AS area_id
				FROM #client_abb#_files AS files
				INNER JOIN #client_abb#_areas_files AS area_files ON files.id = area_files.file_id
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND status='ok')
				</cfif>
				ORDER BY creation_date DESC
				<cfif isDefined("arguments.limit")>
				LIMIT #arguments.limit#
				</cfif>;
			</cfquery>	
		
		<cfreturn areaWebItemsQuery>
		
	</cffunction>
	
	
	
	<!---getAreaItemsLastPosition--->
	
	<cffunction name="getAreaItemsLastPosition" output="false" returntype="struct" access="public">
		<cfargument name="area_id" type="string" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "getAreaItemsLastPosition">
		<cfset var position = 0>
					
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
						
				<cfquery name="areaItemsPositionQuery" datasource="#client_dsn#">
					SELECT MAX(position) AS max_position					
					FROM #client_abb#_#itemTypeTable# AS items
					WHERE items.area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
				</cfquery>
				
				<cfset position = areaItemsPositionQuery.max_position>
		
		<cfreturn {position=position}>
		
	</cffunction>
	
	
	
	<!---  ---------------------- addReadToItem -------------------------------- --->
	
	<cffunction name="addReadToItem" returntype="void" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="user_id" type="numeric" required="yes">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "addReadToItem">
					
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">		
					
			<cfquery name="addReadToItem" datasource="#client_dsn#">		
				INSERT INTO #client_abb#_#itemTypeTable#_readings
				SET #itemTypeName#_id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">,
				user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer">,
				date = NOW();			
			</cfquery>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	<!---  ---------------------- updateItemState -------------------------------- --->
	
	<cffunction name="updateItemState" returntype="void" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="state" type="string" required="yes">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "updateItemState">
					
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">		
			
			<cfquery name="addReadToItem" datasource="#client_dsn#">		
				UPDATE #client_abb#_#itemTypeTable#
				SET	state = <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
				last_update_date = NOW()
				<cfswitch expression="#arguments.state#">
					<cfcase value="read">
						, read_date = NOW()
					</cfcase>
					<cfcase value="answered">
						, answer_date = NOW()
					</cfcase>
					<cfcase value="closed">
						, close_date = NOW()
					</cfcase>
				</cfswitch>
				WHERE
				id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;			
			</cfquery>
			
						
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
    
	
	
	<!---  ---------------------- setItemReadDate -------------------------------- --->
	
	<cffunction name="setItemReadDate" returntype="void" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "setItemReadDate">
					
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">		
			
				<cfquery name="setReadDateQuery" datasource="#client_dsn#">		
					UPDATE #client_abb#_#itemTypeTable#
					SET read_date = NOW()					
					WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;
				</cfquery>	
						
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!---  ---------------------- changeItemsState -------------------------------- --->
	
	<cffunction name="changeItemsState" returntype="void" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="state" type="string" required="yes">
		
		<cfargument name="client_abb" type="string" required="yes">
		<cfargument name="client_dsn" type="string" required="yes">		
		
		<cfset var method = "changeItemsState">
					
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">		
			
			<cfinvoke component="AreaItemQuery" method="updateItemState">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="state" value="#arguments.state#">
				
				<cfinvokeargument name="client_abb" value="#arguments.client_abb#">
				<cfinvokeargument name="client_dsn" value="#arguments.client_dsn#">
			</cfinvoke>
					
			<!---Get sub item--->
			<cfquery name="getSubItem" datasource="#client_dsn#">		
				SELECT id, state
				FROM #client_abb#_#itemTypeTable# 
				WHERE parent_id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">
				AND parent_kind = <cfqueryparam value="#itemTypeName#" cfsqltype="cf_sql_varchar">;			
			</cfquery>
			
			<cfif getSubItem.recordCount GT 0>
				
				<cfinvoke component="AreaItemQuery" method="changeItemsState" returnvariable="changeItemStateResult">
					<cfinvokeargument name="item_id" value="#getSubItem.id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					<cfinvokeargument name="state" value="#arguments.state#">
					
					<cfinvokeargument name="client_abb" value="#arguments.client_abb#">
					<cfinvokeargument name="client_dsn" value="#arguments.client_dsn#">
				</cfinvoke>
										
			</cfif>					
			
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
  
</cfcomponent>