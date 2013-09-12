<!---Copyright Era7 Information Technologies 2007-2012
    File created by: ppareja
    ColdFusion version required: 8
    Last file change by: alucena
    Date of last file change: 24-04-2012
	
--->
<cfcomponent output="false">
	
	<cfset component = "MessageManager">
	
	<cfset messageTypeId = 1>
	
	
	<!--- ----------------------- CREATE MESSAGE -------------------------------- --->
	
	<cffunction name="createMessage" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createMessage">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlMessage">
				<cfoutput>
				#xmlRequest.request.parameters.message#
				</cfoutput>
			</cfxml>
			
			<!---createItem--->
			<cfinvoke component="AreaItemManager" method="createItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlMessage#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- CREATE MESSAGE WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="createMessageWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createMessageWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlMessage">
				<cfoutput>
				#xmlRequest.request.parameters.message#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="createItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlMessage#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
				<cfinvokeargument name="request" value="#xmlRequest#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
	
	</cffunction>--->
	
	
	<!---  ---------------------- SELECT MESSAGE -------------------------------- --->
	
	<cffunction name="selectMessage" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "selectMessage">
		
		<cfset var message_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset message_id = xmlRequest.request.parameters.message.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#message_id#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
				
				<cfinvokeargument name="return_type" value="xml">
			</cfinvoke>
				
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!--- ------------------------- DELETE MESSAGE -------------------------------- --->
	
	<cffunction name="deleteMessage" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "deleteMessage">
		
		<cfset var message_id = "">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset message_id = xmlRequest.request.parameters.message.xmlAttributes.id> 
			
			<cfinvoke component="AreaItemManager" method="deleteItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#message_id#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
			</cfinvoke>

			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
				
	</cffunction>
	<!--- ------------------------------------------------------------------------ --->
	
	
	
	<!--- ----------------GET AREA MESSAGES LIST---------------------------------------   --->
	<cffunction name="getAreaMessagesList" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "getAreaMessagesList">
		
		<cfset var area_id = "">
		<cfset var format_content = "">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>
			
			<cfif isDefined("xmlRequest.request.parameters.format.xmlAttributes.content")>
				<cfset format_content = xmlRequest.request.parameters.format.xmlAttributes.content>
			</cfif>
			
			<cfinvoke component="AreaItemManager" method="getAreaItems" returnvariable="xmlResponseContent">
				<cfinvokeargument name="area_id" value="#area_id#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
				<cfinvokeargument name="listFormat" value="true">
				<cfif isDefined("format_content")>
				<cfinvokeargument name="format_content" value="#format_content#">
				</cfif>
			</cfinvoke>
							
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>	
												
		</cftry>
	
	<cfreturn xmlResponse>
			
	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->
	
	
	<!--- ----------------GET AREA MESSAGES TREE---------------------------------------   --->
	<cffunction name="getAreaMessagesTree" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
				
		<cfset var method = "getAreaMessagesTree">
		
		<cfset var area_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">	
			
			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getAreaItems" returnvariable="xmlResponseContent">
				<cfinvokeargument name="area_id" value="#area_id#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
				<cfinvokeargument name="listFormat" value="false">
			</cfinvoke>		
						
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
				
	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->
	
	
	
	<!--- ----------------------- getMessageFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos
	--->
	
	<!---
	request:
	<request>
		<parameters>
			<file id=""/>
		</parameters>
	</request>
	response:
	<response component="FileManager" method="getFileStatus" status="ok">
		<result>
			<file id="" status="pending/uploading/ok/error"/>	
		</result>
	</response>
	--->
	
	
	<cffunction name="getMessageFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getMessageFileStatus">
		
		<cfset var file_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEndNoLog.cfm">
		
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	
	<!--- -------------------------- GET SUB MESSAGES ------------------------------------------ --->
	<!---<cffunction name="getSubMessages" returntype="string" access="public">
		<cfargument name="message_id" type="String">	
		<cfargument name="listFormat" type="boolean">
		<cfargument name="format_content" type="string" required="no" default="default">
		
		<cfset var method = "getSubMessages">
		
		<cfset var xmlResponseContent = "">
		
		<cftry>	
		
			<cfinclude template="includes/functionStart.cfm">
			
			
			<cfinvoke component="AreaItemManager" method="getSubItems" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
				<cfinvokeargument name="listFormat" value="#arguments.listFormat#">
				<cfinvokeargument name="format_content" value="#arguments.format_content#">
			</cfinvoke>
								
			<cfreturn xmlResponseContent>
			
		
			<cfcatch>
				<cfset xmlResponseContent = "">
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn xmlResponse>
			</cfcatch>										
		
		</cftry>
	
	</cffunction>--->
	<!--- -----------------------------------------------------------------------------------------  --->
	
	
	
	<!--- ------------------------- GET SUB MESSAGES ARRAY ----------------------------------------- --->
	<!---<cffunction name="getSubMessagesArray" returntype="array" access="public">
		<cfargument name="message_id" type="String" required="yes">	
		<cfargument name="format_content" type="string" required="no" default="default">
		<cfargument name="arrayMessages" type="array" required="yes">
		<cfargument name="order_by" type="string" required="yes">
		<cfargument name="order_type" type="string" required="yes"> 
		
		<cfset var method = "getSubMessagesArray">
		
		<cfset var arrayMessagesUpdated = arrayNew(1)>


			<cfinvoke component="AreaItemManager" method="getSubItemsArray" returnvariable="arrayMessagesUpdated">
				<cfinvokeargument name="item_id" value="#arguments.message_id#">
				<cfinvokeargument name="itemTypeId" value="#messageTypeId#">
				<cfinvokeargument name="format_content" value="#arguments.format_content#">
				<cfinvokeargument name="arrayMessages" value="#arguments.arrayMessages#">
				<cfinvokeargument name="order_by" value="#arguments.order_by#">
				<cfinvokeargument name="order_type" value="#arguments.order_type#">
			</cfinvoke>
									
		<cfreturn arrayMessagesUpdated>		
	
	</cffunction>--->
	<!--- -----------------------------------------------------------------------------------------  --->
	
	
	
	<!---  -------------------GET MESSAGE PARENT AREA----------------------   --->
	<!---<cffunction name="getMessageParentArea" returntype="numeric" output="false" access="public">
		<cfargument name="message_id" required="yes" type="numeric">
		
		<cfset var method = "getMessageParentArea">
		
		<cfset var message_parent_id = "">
		
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfquery name="getParent" datasource="#client_dsn#">
				SELECT parent_kind, area_id 
				FROM #client_abb#_messages
				WHERE id = <cfqueryparam value="#arguments.message_id#" cfsqltype="cf_sql_integer">; 
			</cfquery>
			
			<cfif getParent.recordCount GT 0>
			
				<!---<cfif getParent.parent_kind EQ "message">
					<cfinvoke component="MessageManager" method="getMessageParentArea" returnvariable="message_parent_id">
						<cfinvokeargument name="message_id" value="#getParent.parent_id#">
					</cfinvoke>	
				<cfelse>
					<cfif getParent.parent_kind EQ "area">
						<cfset message_parent_id = getParent.parent_id>	
					
					<cfelse><!---Message parent area not found--->
			
						<cfset error_code = 505>
					
						<cfthrow errorcode="#error_code#" detail="messsage_id: #arguments.message_id#">
						
					</cfif>
				</cfif>--->
				<cfset message_parent_id = getParent.area_id>
				<cfreturn message_parent_id>
				
			<cfelse><!---Message does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#" detail="message_id: #arguments.message_id#">
					
			</cfif>	

		
	</cffunction>--->	
	
	
	
	<!---  ---------------------- getMessage -------------------------------- --->
	
	<!---<cffunction name="getMessage" returntype="any" access="public">
		<cfargument name="message_id" type="string" required="yes">
		<cfargument name="return_type" type="string" required="no" default="xml">
		
		<cfset var method = "getMessage">
		
		<cfset var id = arguments.message_id>
		<cfset var area_id = "">
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfquery name="selectMessageQuery" datasource="#client_dsn#">
				SELECT messages.parent_id, messages.parent_kind, messages.user_in_charge, messages.creation_date, attached_file_id, message_read, attached_file_name, file_type, messages.title, messages.description, users.family_name, messages.area_id, messages.id AS message_id, users.name AS user_name
				FROM #client_abb#_messages AS messages
				INNER JOIN #client_abb#_users AS users ON messages.user_in_charge = users.id
				LEFT JOIN #client_abb#_files AS files ON files.id = messages.attached_file_id
				WHERE messages.id= <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">; 
			</cfquery>
			<!---AND status='ok'???? Esto no se pone por si se necesitan obtener mensajes desde la aplicación con el status pending--->
			
			<cfif selectMessageQuery.recordCount GT 0>

				<cfset area_id = selectMessageQuery.area_id>
			
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">
				
				<cfinvoke component="MessageManager" method="objectMessage" returnvariable="result">
					<cfinvokeargument name="id" value="#selectMessageQuery.message_id#">
					<cfinvokeargument name="parent_id" value="#selectMessageQuery.parent_id#">
					<cfinvokeargument name="parent_kind" value="#selectMessageQuery.parent_kind#">
					<cfinvokeargument name="area_id" value="#area_id#">
					<cfinvokeargument name="user_in_charge" value="#selectMessageQuery.user_in_charge#">
					<cfinvokeargument name="creation_date" value="#selectMessageQuery.creation_date#">
					<cfinvokeargument name="attached_file_id" value="#selectMessageQuery.attached_file_id#">
					<cfinvokeargument name="message_read" value="#selectMessageQuery.message_read#">
					<!---<cfinvokeargument name="area_name" value="">--->
					<cfif selectMessageQuery.attached_file_name EQ "NULL">
						<cfinvokeargument name="attached_file_name" value="-">
					<cfelse>
						<cfinvokeargument name="attached_file_name" value="#selectMessageQuery.attached_file_name#">
					</cfif>
					<cfinvokeargument name="attached_file_type" value="#selectMessageQuery.file_type#">
					<cfinvokeargument name="title" value="#selectMessageQuery.title#">
					<cfinvokeargument name="description" value="#selectMessageQuery.description#">
					<cfinvokeargument name="user_full_name" value="#selectMessageQuery.family_name# #selectMessageQuery.user_name#">
					
					<cfinvokeargument name="return_type" value="#return_type#">
				</cfinvoke>
			
				
				<cfset xmlResponse = result>
				
				
			<cfelse><!---Message does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#">
					
			</cfif>		
		
			
		<cfreturn xmlResponse>
		
	</cffunction>--->
	<!---  ------------------------------------------------------------------------ --->
	

</cfcomponent>