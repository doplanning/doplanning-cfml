<!---Copyright Era7 Information Technologies 2007-2012
    File created by: alucena
    ColdFusion version required: 8
    Last file change by: alucena
    Date of last file change: 12-07-2012
	
--->
<cfcomponent output="false">
	
	<cfset component = "TaskManager">
	
	<cfset taskTypeId = 6>
	
	
	<!--- ----------------------- CREATE TASK -------------------------------- --->
	
	<cffunction name="createTask" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createTask">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlTask">
				<cfoutput>
				#xmlRequest.request.parameters.task#
				</cfoutput>
			</cfxml>
			
			<!---createItem--->
			<cfinvoke component="AreaItemManager" method="createItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlTask#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- CREATE TASK WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="createTaskWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createTaskWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlTask">
				<cfoutput>
				#xmlRequest.request.parameters.task#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="createItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlTask#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
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
	
	
	<!--- ----------------------- UPDATE TASK -------------------------------- --->
	
	<cffunction name="updateTask" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateTask">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlTask">
				<cfoutput>
				#xmlRequest.request.parameters.task#
				</cfoutput>
			</cfxml>
			
			<!---updateItem--->
			<cfinvoke component="AreaItemManager" method="updateItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlTask#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- UPDATE TASK WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="updateTaskWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateTaskWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlTask">
				<cfoutput>
				#xmlRequest.request.parameters.task#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="updateItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlTask#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
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
	
	
	<!--- ----------------------- POST TASK TO TWITTER -------------------------------- --->
	
	<cffunction name="postTaskToTwitter" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "postTaskToTwitter">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlTask">
				<cfoutput>
				#xmlRequest.request.parameters.task#
				</cfoutput>
			</cfxml>
			
			<cfxml variable="xmlArea">
				<cfoutput>
				#xmlRequest.request.parameters.area#
				</cfoutput>
			</cfxml>
			
			<cfxml variable="xmlTweet">
				<cfoutput>
				#xmlRequest.request.parameters.tweet#
				</cfoutput>
			</cfxml>
			
			<!---postItemToTwitter--->
			<cfinvoke component="AreaItemManager" method="postItemToTwitter">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
				<cfinvokeargument name="item_id" value="#xmlTask.task.xmlAttributes.id#">
				<cfinvokeargument name="area_id" value="#xmlArea.area.xmlAttributes.id#">
				<cfinvokeargument name="content" value="#xmlTweet.tweet.content.xmlText#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!---  ---------------------- SELECT TASK -------------------------------- --->
	
	<cffunction name="selectTask" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "selectTask">
		
		<cfset var task_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset task_id = xmlRequest.request.parameters.task.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#task_id#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
				
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
	
	
	
	<!--- ------------------------- DELETE TASK -------------------------------- --->
	
	<cffunction name="deleteTask" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "deleteTask">
		
		<cfset var task_id = "">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset task_id = xmlRequest.request.parameters.task.xmlAttributes.id> 
			
			<cfinvoke component="AreaItemManager" method="deleteItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#task_id#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
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
	
	
	
	<!--- ----------------GET AREA TASKS LIST---------------------------------------   --->
	<cffunction name="getAreaTasksList" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "getAreaTasksList">
		
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
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
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
	
	
	
	<!--- ----------------------- getTaskFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getTaskFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getTaskFileStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
				<cfinvokeargument name="file_type" value="file">
			</cfinvoke>
			
			<cfinclude template="includes/functionEndNoLog.cfm">
		
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	
	<!--- ----------------------- getTaskImageStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getTaskImageStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getTaskImageStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#taskTypeId#">
				<cfinvokeargument name="file_type" value="image">
			</cfinvoke>
			
			<cfinclude template="includes/functionEndNoLog.cfm">
		
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	

</cfcomponent>