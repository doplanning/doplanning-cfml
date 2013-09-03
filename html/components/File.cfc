<!---Copyright Era7 Information Technologies 2007-2012

	Date of file creation: 02-10-2008
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 23-08-2012
	
--->
<cfcomponent output="false">

	<cfset component = "File">
	<cfset request_component = "FileManager">
	
	
	<!--- ---------------------------------- selectFile -------------------------------------- --->
	
	<cffunction name="selectFile" returntype="xml" access="public">
		<cfargument name="file_id" type="numeric" required="true">
		
		<cfset var method = "selectFile">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#"/>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ---------------------------------- getFile -------------------------------------- --->
	
	<cffunction name="getFile" returntype="struct" access="public">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="false">
		<cfargument name="item_id" type="numeric" required="false">
		<cfargument name="itemTypeId" type="numeric" required="false">
		
		<cfset var method = "getFile">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cfset var objectFile = structNew()>
		
		<cftry>
			
			<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getFile" returnvariable="objectFile">				
				<cfinvokeargument name="get_file_id" value="#arguments.file_id#">
				<cfif isDefined("arguments.area_id")>
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfif>
				<cfif isDefined("arguments.item_id")>
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				</cfif>
				<cfif isDefined("arguments.itemTypeId")>
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				</cfif>
				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn objectFile>
		
	</cffunction>
	
	
	<!--- ---------------------------------- convertFile -------------------------------------- --->
	
	<cffunction name="convertFile" returntype="xml" access="public">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="file_type" type="string" required="true">
		
		<cfset var method = "convertFile">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#" file_type="#arguments.file_type#"/>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ---------------------------------- associateFile -------------------------------------- --->
	
	<cffunction name="associateFile" returntype="void" access="remote">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="return_path" type="string" required="yes">
		
		<cfset var method = "associateFile">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#"/>
					<area id="#arguments.area_id#"/>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfset msg = "Archivo asociado al área.">
			<cfset msg = URLEncodedFormat(msg)>
			
			<!---<cflocation url="#arguments.return_path#files.cfm?area=#arguments.area_id#&msg=#msg#&res=1" addtoken="no">--->
			<cflocation url="#arguments.return_path#area_items.cfm?area=#arguments.area_id#&msg=#msg#&res=1" addtoken="no">
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	<!--- ---------------------------------- associateFileToAreas -------------------------------------- --->
	
	<cffunction name="associateFileToAreas" access="public" returntype="struct">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="areas_ids" type="array" required="true">
		
		<cfset var method = "associateFileToAreas">
		
		<cfset var request_parameters = "">
		<cfset var response_message = "">
		<cfset var response = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#"/>
					<areas>
					<cfloop array="#arguments.areas_ids#" index="area_id">
						<area id="#area_id#"/>
					</cfloop>
					</areas>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfxml variable="xmlAreas">
				<cfoutput>
					#xmlResponse.response.result.areas#
				</cfoutput>
			</cfxml>
			
			<cfif xmlAreas.areas.xmlAttributes.all IS true>
				<cfif arrayLen(areas_ids) IS 1>
					<cfset response_message = "Archivo asociado al área.">
				<cfelse>
					<cfset response_message = "Archivo asociado a las áreas.">
				</cfif>
			<cfelse>
				<cfset response_message = "Archivo asociado a las áreas. En una o varias de las areas seleccionadas ya estaba asociado.">
			</cfif>
			<cfset response = {result="true", message=#response_message#}>				
			
			
			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirect.cfm">
				
				<cfset response_message = error_message>
				<cfset response = {result="false", message=#response_message#}>
			</cfcatch>										
			
		</cftry>
		
		<cfreturn #response#>
		
	</cffunction>
	
	
	<!--- ---------------------------------- dissociateFile -------------------------------------- --->
	
	<cffunction name="dissociateFile" returntype="void" access="remote">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="return_path" type="string" required="yes">
		
		<cfset var method = "dissociateFile">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#"/>
					<area id="#arguments.area_id#"/>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfset msg = "Archivo quitado del área.">
			<cfset msg = URLEncodedFormat(msg)>
			
			<!---<cflocation url="#APPLICATION.htmlPath#/files.cfm?area=#arguments.area_id#&message=#msg#" addtoken="no">--->
			<cflocation url="#arguments.return_path#files.cfm?area=#arguments.area_id#&msg=#msg#&res=1" addtoken="no">
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	<!--- ---------------------------------- updateFile -------------------------------------- --->
	
	<!---Este método solo se usa desde Mis documentos y debe dejar de usarse en futuras versiones--->
	
	<cffunction name="updateFile" returntype="void" access="remote">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="folder_id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="description" type="string" required="true">
		
		<cfset var method = "updateFile">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfset response_page = "my_files_file.cfm?folder=#arguments.folder_id#&file=#arguments.file_id#">

			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#">
						<name><![CDATA[#arguments.name#]]></name>
						<description><![CDATA[#arguments.description#]]></description>
					</file>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfset message = "Archivo modificado.">
			<cfset message = URLEncodedFormat(message)>
            
            <cflocation url="#APPLICATION.htmlPath#/#response_page#&msg=#message#&res=1" addtoken="no">
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ---------------------------------- updateFileRemote -------------------------------------- --->
	
	<cffunction name="updateFileRemote" returntype="void" access="remote">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="description" type="string" required="true">
		<cfargument name="return_path" type="string" required="true">
		
		<cfset var method = "updateFileRemote">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<!---<cfset response_page = "files.cfm?area=#arguments.area_id#&file=#arguments.file_id#">--->
			<cfset response_page = "area_items.cfm?area=#arguments.area_id#&file=#arguments.file_id#">

			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#">
						<name><![CDATA[#arguments.name#]]></name>
						<description><![CDATA[#arguments.description#]]></description>
					</file>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="updateFile">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfset message = "Archivo modificado.">
			<cfset message = URLEncodedFormat(message)>
            
            <cflocation url="#arguments.return_path##response_page#&msg=#message#&res=1" addtoken="no">
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ---------------------------------- deleteFile -------------------------------------- --->
	
	<!---Este método solo se usa desde Mis documentos y debe dejar de usarse en futuras versiones--->
	
	<cffunction name="deleteFile" returntype="void" access="remote">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="folder_id" type="numeric" required="true">
		
		<cfset var method = "deleteFile">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfset response_page = "my_files.cfm?folder=#arguments.folder_id#">
			
			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#"/>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="#method#">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfset message = "Archivo eliminado.">
			<cfset message = URLEncodedFormat(message)>
            
            <cflocation url="#APPLICATION.htmlPath#/#response_page#&msg=#message#&res=1" addtoken="no">
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	<!--- ---------------------------------- deleteFileRemote -------------------------------------- --->
	
	<cffunction name="deleteFileRemote" returntype="void" access="remote">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="return_path" type="string" required="true">
		
		<cfset var method = "deleteFileRemote">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
		
		<cftry>
			
			<cfset response_page = "files.cfm?area=#arguments.area_id#">
			
			<cfsavecontent variable="request_parameters">
				<cfoutput>
					<file id="#arguments.file_id#"/>
				</cfoutput>
			</cfsavecontent>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#request_component#">
				<cfinvokeargument name="request_method" value="deleteFile">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>
			
			<cfset message = "Archivo eliminado.">
			<cfset message = URLEncodedFormat(message)>
            
            <cflocation url="#arguments.return_path##response_page#&msg=#message#&res=1" addtoken="no">
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	<!--- ----------------------- GET ALL AREAS FILES -------------------------------- --->
	
	<cffunction name="getAllAreasFiles" returntype="string" access="public">
		<cfargument name="search_text" type="string" required="no">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="limit" type="numeric" required="no">
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
				
		<cfset var method = "getAllAreasFiles">
		
		<cfset var request_parameters = "">
		
		<cftry>
			
			
			<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getAllAreasFiles" returnvariable="xmlResponseContent">
				<cfif isDefined("arguments.search_text")>
				<cfinvokeargument name="search_text" value="#arguments.search_text#">
				</cfif>
				<cfif isDefined("arguments.user_in_charge")>
				<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
				</cfif>
				<cfif isDefined("arguments.limit")>
				<cfinvokeargument name="limit" value="#arguments.limit#">
				</cfif>
				<cfinvokeargument name="with_area" value="true">
				<cfif isDefined("arguments.from_date")>
				<cfinvokeargument name="from_date" value="#arguments.from_date#">
				</cfif>
				<cfif isDefined("arguments.end_date")>
				<cfinvokeargument name="end_date" value="#arguments.end_date#">
				</cfif>				
			</cfinvoke>	
			
			<cfreturn xmlResponseContent>
            
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
</cfcomponent>