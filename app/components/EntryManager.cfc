<!---Copyright Era7 Information Technologies 2007-2012
    File created by: alucena
    ColdFusion version required: 8
    Last file change by: alucena
    Date of last file change: 24-04-2012
	
--->
<cfcomponent output="false">
	
	<cfset component = "EntryManager">
	
	<cfset entryTypeId = 2>
	
	
	<!--- ----------------------- CREATE ENTRY -------------------------------- --->
	
	<cffunction name="createEntry" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createEntry">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlEntry">
				<cfoutput>
				#xmlRequest.request.parameters.entry#
				</cfoutput>
			</cfxml>
			
			<!---createItem--->
			<cfinvoke component="AreaItemManager" method="createItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlEntry#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- CREATE ENTRY WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="createEntryWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createEntryWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlEntry">
				<cfoutput>
				#xmlRequest.request.parameters.entry#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="createItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlEntry#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
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
	
	
	<!--- ----------------------- UPDATE ENTRY -------------------------------- --->
	
	<cffunction name="updateEntry" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateEntry">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlEntry">
				<cfoutput>
				#xmlRequest.request.parameters.entry#
				</cfoutput>
			</cfxml>
			
			<!---updateItem--->
			<cfinvoke component="AreaItemManager" method="updateItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlEntry#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- UPDATE ENTRY WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="updateEntryWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateEntryWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlEntry">
				<cfoutput>
				#xmlRequest.request.parameters.entry#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="updateItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlEntry#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
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
	
	
	
	<!--- ----------------------- POST ENTRY TO TWITTER -------------------------------- --->
	
	<cffunction name="postEntryToTwitter" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "postEntryToTwitter">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlEntry">
				<cfoutput>
				#xmlRequest.request.parameters.entry#
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
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
				<cfinvokeargument name="item_id" value="#xmlEntry.entry.xmlAttributes.id#">
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
	
	
	<!---  ---------------------- SELECT ENTRY -------------------------------- --->
	
	<cffunction name="selectEntry" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "selectEntry">
		
		<cfset var entry_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset entry_id = xmlRequest.request.parameters.entry.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#entry_id#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
				
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
	
	
	
	<!--- ------------------------- DELETE ENTRY -------------------------------- --->
	
	<cffunction name="deleteEntry" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "deleteEntry">
		
		<cfset var entry_id = "">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset entry_id = xmlRequest.request.parameters.entry.xmlAttributes.id> 
			
			<cfinvoke component="AreaItemManager" method="deleteItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#entry_id#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
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
	
	
	
	<!--- ----------------GET AREA ENTRIES LIST---------------------------------------   --->
	<cffunction name="getAreaEntriesList" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "getAreaEntriesList">
		
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
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
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
	<!---<cffunction name="getAreaEntrysTree" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
				
		<cfset var method = "getAreaEntrysTree">
		
		<cfset var area_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">	
			
			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getAreaItems" returnvariable="xmlResponseContent">
				<cfinvokeargument name="area_id" value="#area_id#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
				<cfinvokeargument name="listFormat" value="false">
			</cfinvoke>		
						
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
				
	</cffunction>--->
	<!--- ------------------------------------------------------------------------------  --->
	
	
	<!--- ----------------------- getEntryFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getEntryFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getEntryFileStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
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
	
	
	
	<!--- ----------------------- getEntryImageStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getEntryImageStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getEntryImageStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#entryTypeId#">
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