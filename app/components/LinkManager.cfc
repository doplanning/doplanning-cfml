<!---Copyright Era7 Information Technologies 2007-2012
    File created by: alucena
    ColdFusion version required: 8
    Last file change by: alucena
    Date of last file change: 24-04-2012
	
--->
<cfcomponent output="false">
	
	<cfset component = "LinkManager">
	
	<cfset linkTypeId = 3>
	
	
	<!--- ----------------------- CREATE LINK -------------------------------- --->
	
	<cffunction name="createLink" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createLink">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlLink">
				<cfoutput>
				#xmlRequest.request.parameters.link#
				</cfoutput>
			</cfxml>
			
			<!---createItem--->
			<cfinvoke component="AreaItemManager" method="createItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlLink#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- CREATE LINK WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="createLinkWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createLinkWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlLink">
				<cfoutput>
				#xmlRequest.request.parameters.link#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="createItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlLink#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
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
	
	
	<!--- ----------------------- UPDATE LINK -------------------------------- --->
	
	<cffunction name="updateLink" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateLink">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlLink">
				<cfoutput>
				#xmlRequest.request.parameters.link#
				</cfoutput>
			</cfxml>
			
			<!---updateItem--->
			<cfinvoke component="AreaItemManager" method="updateItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlLink#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	
	<!--- ----------------------- UPDATE LINK WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="updateLinkWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateLinkWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlLink">
				<cfoutput>
				#xmlRequest.request.parameters.link#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="updateItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlLink#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
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
	
	
	
	<!--- ----------------------- POST LINK TO TWITTER -------------------------------- --->
	
	<cffunction name="postLinkToTwitter" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "postLinkToTwitter">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlLink">
				<cfoutput>
				#xmlRequest.request.parameters.link#
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
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
				<cfinvokeargument name="item_id" value="#xmlLink.link.xmlAttributes.id#">
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
	
	
	<!---  ---------------------- SELECT LINK -------------------------------- --->
	
	<cffunction name="selectLink" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "selectLink">
		
		<cfset var link_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset link_id = xmlRequest.request.parameters.link.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#link_id#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
				
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
	
	
	
	<!--- ------------------------- DELETE LINK -------------------------------- --->
	
	<cffunction name="deleteLink" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "deleteLink">
		
		<cfset var link_id = "">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset link_id = xmlRequest.request.parameters.link.xmlAttributes.id> 
			
			<cfinvoke component="AreaItemManager" method="deleteItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#link_id#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
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
	
	
	
	<!--- ----------------GET AREA LINKS LIST---------------------------------------   --->
	<cffunction name="getAreaLinksList" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "getAreaLinksList">
		
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
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
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
	<!---<cffunction name="getAreaLinksTree" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
				
		<cfset var method = "getAreaLinksTree">
		
		<cfset var area_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">	
			
			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getAreaItems" returnvariable="xmlResponseContent">
				<cfinvokeargument name="area_id" value="#area_id#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
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
	
	
	<!--- ----------------------- getLinkFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getLinkFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getLinkFileStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
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
	
	
	
	<!--- ----------------------- getLinkImageStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getLinkImageStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getLinkImageStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#linkTypeId#">
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