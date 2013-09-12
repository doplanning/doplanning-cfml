<!---Copyright Era7 Information Technologies 2007-2013
    File created by: alucena
    ColdFusion version required: 8
    Last file change by: alucena
    Date of last file change: 12-02-2013
	
--->
<cfcomponent output="false">
	
	<cfset component = "ConsultationManager">
	
	<cfset consultationTypeId = 7>
	
	
	<!--- ----------------------- CREATE CONSULTATION -------------------------------- --->
	
	<cffunction name="createConsultation" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createConsultation">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlConsultation">
				<cfoutput>
				#xmlRequest.request.parameters.consultation#
				</cfoutput>
			</cfxml>
			
			<!---createItem--->
			<cfinvoke component="AreaItemManager" method="createItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlConsultation#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- CREATE CONSULTATION WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="createConsultationWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "createConsultationWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlConsultation">
				<cfoutput>
				#xmlRequest.request.parameters.consultation#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="createItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlConsultation#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
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
	
	
	<!--- ----------------------- UPDATE CONSULTATION -------------------------------- --->
	
	<cffunction name="updateConsultation" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateConsultation">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlConsultation">
				<cfoutput>
				#xmlRequest.request.parameters.consultation#
				</cfoutput>
			</cfxml>
			
			<!---updateItem--->
			<cfinvoke component="AreaItemManager" method="updateItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlConsultation#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
			</cfinvoke>
			
			<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
			</cfinvoke>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ----------------------- UPDATE CONSULTATION WITH ATTACHED -------------------------------- --->
	
<!---	<cffunction name="updateConsultationWithAttachedFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "updateConsultationWithAttachedFile">
				
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfxml variable="xmlConsultation">
				<cfoutput>
				#xmlRequest.request.parameters.consultation#
				</cfoutput>
			</cfxml>
			
			<!---Aquí no se envía la notificación porque el status del mensaje no es ok--->
			<cfinvoke component="AreaItemManager" method="updateItemWithAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="xmlItem" value="#xmlConsultation#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
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
	
	
	<!--- ----------------------- POST CONSULTATION TO TWITTER -------------------------------- --->
	
	<cffunction name="postConsultationToTwitter" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "postConsultationToTwitter">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="xmlConsultation">
				<cfoutput>
				#xmlRequest.request.parameters.consultation#
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
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
				<cfinvokeargument name="item_id" value="#xmlConsultation.consultation.xmlAttributes.id#">
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
	
	
	<!---  ---------------------- SELECT CONSULTATION -------------------------------- --->
	
	<cffunction name="selectConsultation" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "selectConsultation">
		
		<cfset var consultation_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset consultation_id = xmlRequest.request.parameters.consultation.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#consultation_id#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
				
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
	
	
	
	<!--- ------------------------- DELETE CONSULTATION -------------------------------- --->
	
	<cffunction name="deleteConsultation" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "deleteConsultation">
		
		<cfset var consultation_id = "">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset consultation_id = xmlRequest.request.parameters.consultation.xmlAttributes.id> 
			
			<cfinvoke component="AreaItemManager" method="deleteItem" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#consultation_id#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
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
	
	
	
	<!--- ----------------GET AREA CONSULTATIONS LIST---------------------------------------   --->
	<cffunction name="getAreaConsultationsList" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "getAreaConsultationsList">
		
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
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
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
	
	
	
	<!--- ----------------GET AREA CONSULTATIONS TREE---------------------------------------   --->
	<cffunction name="getAreaConsultationsTree" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
				
		<cfset var method = "getAreaConsultationsTree">
		
		<cfset var area_id = "">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">	
			
			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>
			
			<cfinvoke component="AreaItemManager" method="getAreaItems" returnvariable="xmlResponseContent">
				<cfinvokeargument name="area_id" value="#area_id#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
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
	
	
	
	
	<!--- ----------------------- getConsultationFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getConsultationFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getConsultationFileStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
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
	
	
	
	<!--- ----------------------- getConsultationImageStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
	<cffunction name="getConsultationImageStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getConsultationImageStatus">
		
		<cfset var file_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			
			<cfinvoke component="FileManager" method="getAreaItemFileStatus" returnvariable="xmlResponseContent">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="itemTypeId" value="#consultationTypeId#">
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