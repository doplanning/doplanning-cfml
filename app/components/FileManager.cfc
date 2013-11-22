<!---Copyright Era7 Information Technologies 2007-2013

    File created by: ppareja
    ColdFusion version required: 8
    Last file change by: alucena
	
	15-04-2013 alucena: corregido error en deleteFile con archivos con status que no es ok
	13-06-2013 alucena: corregido error con variable files_table (se utilizaba file_table) en deleteImageFile
	
--->
<cfcomponent output="false">	

	<cfset component = "FileManager">
	
	<cfset messageTypeId = 1>
	<cfset fileItemTypeId = 10>
	<cfset typologyTableTypeId = 3>
	
	<!--- ----------------------- XML FILE -------------------------------- --->
	
	<cffunction name="xmlFile" returntype="string" output="false" access="public">		
		<cfargument name="objectFile" type="struct" required="yes">
		
		<cfset var method = "xmlFile">
		
		<cftry>
		
			<cfprocessingdirective suppresswhitespace="true">
			<cfsavecontent variable="xmlResult">
				<cfoutput><file
					<cfif len(objectFile.id) GT 0> 
						id="#objectFile.id#"
					</cfif>
					<cfif objectFile.tree_mode EQ "true">
						name="#xmlFormat(objectFile.name)#"
					</cfif> 
					<cfif len(objectFile.physical_name) GT 0>
						physical_name="#xmlFormat(objectFile.physical_name)#"
					</cfif>
					<cfif len(objectFile.user_in_charge) GT 0> 
						user_in_charge="#objectFile.user_in_charge#" 
					</cfif>
					<cfif len(objectFile.file_size_full) GT 0>
						file_size_full="#objectFile.file_size_full#"
					</cfif>
					<cfif len(objectFile.file_size_kb) GT 0>
						file_size_kb="#objectFile.file_size_kb#"
					</cfif>
					<cfif len(objectFile.file_size) GT 0>
						file_size="#objectFile.file_size#"
					</cfif>
					<cfif len(objectFile.file_type) GT 0> 
						file_type="#objectFile.file_type#"
					</cfif>
					<cfif len(objectFile.uploading_date) GT 0>
						uploading_date="#objectFile.uploading_date#"
					</cfif>
					<cfif len(objectFile.replacement_date) GT 0>
						replacement_date="#objectFile.replacement_date#"
					</cfif>
					<cfif len(objectFile.association_date) GT 0>
						association_date="#objectFile.association_date#"
					</cfif>
					<cfif len(objectFile.status) GT 0>
						status="#objectFile.status#"
					</cfif>
					<cfif len(objectFile.area_id) GT 0>
						area_id="#objectFile.area_id#"
					</cfif>
					<cfif len(objectFile.user_image_type) GT 0>
						user_image_type="#objectFile.user_image_type#"
					</cfif>
					<cfif len(objectFile.typology_id) GT 0>
						typology_id="#objectFile.typology_id#"
					</cfif>
					<cfif len(objectFile.typology_row_id) GT 0>
						typology_row_id="#objectFile.typology_row_id#"
					</cfif>
					>
					<cfif objectFile.tree_mode NEQ "true">
						<cfif len(objectFile.name) GT 0>
						<name><![CDATA[#objectFile.name#]]></name>
						</cfif>
						<cfif len(objectFile.file_name) GT 0>
						<file_name><![CDATA[#objectFile.file_name#]]></file_name>
						</cfif>
						<cfif len(objectFile.description) GT 0>
						<description><![CDATA[#objectFile.description#]]></description>
						</cfif>
						<cfif len(objectFile.user_full_name) GT 0>
						<user_full_name><![CDATA[#objectFile.user_full_name#]]></user_full_name>
						</cfif>
						<cfif len(objectFile.area_name) GT 0>
						<area_name><![CDATA[#objectFile.area_name#]]></area_name>
						</cfif>
						<cfif isDefined("objectFile.file_types_conversion") AND objectFile.file_types_conversion.recordCount GT 0>
							<file_types_conversion>
								<cfloop query="objectFile.file_types_conversion">
									<file_type id="#objectFile.file_types_conversion.file_type#"><name_es><![CDATA[#objectFile.file_types_conversion.name_es#]]></name_es><name_en><![CDATA[#objectFile.file_types_conversion.name_en#]]></name_en></file_type>
								</cfloop>
							</file_types_conversion>
						</cfif> 
					</cfif>
					</file></cfoutput>
			</cfsavecontent>
			</cfprocessingdirective>
			
			<cfreturn xmlResult>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn null>
			</cfcatch>
		</cftry>
		
	</cffunction>
	
	
	<!--- ----------------------- FILE OBJECT -------------------------------- --->
	
	<cffunction name="objectFile" returntype="any" output="false" access="public">	
		
		<cfargument name="xml" type="string" required="no">
		
		<cfargument name="id" type="string" required="no" default="">
		<cfargument name="physical_name" type="string" required="no" default="">		
		<cfargument name="user_in_charge" type="string" required="no" default="">		
		<cfargument name="file_size" type="string" required="no" default="">
		<cfargument name="file_type" type="string" required="no" default="">
		<cfargument name="uploading_date" type="string" required="no" default="">
		<cfargument name="replacement_date" type="string" required="no" default="">
		<cfargument name="association_date" type="string" required="no" default="">
		<cfargument name="name" type="string" required="no" default="">
		<cfargument name="file_name" type="string" required="no" default="">
		<cfargument name="description" type="string" required="no" default="">
		<cfargument name="user_full_name" type="string" required="no" default="">
		<cfargument name="status" type="string" required="no" default="">
		<cfargument name="area_id" type="string" required="no" default="">
		<cfargument name="area_name" type="string" required="no" default="">
		<cfargument name="user_image_type" type="string" required="no" default="">
		<cfargument name="typology_id" type="string" required="false" default="">
		<cfargument name="typology_row_id" type="string" required="false" default="">
		
		<cfargument name="file_types_conversion" type="query" required="no" default="#queryNew("")#">
		
		<cfargument name="tree_mode" type="boolean" required="no" default="false">
		
		<cfargument name="return_type" type="string" required="no">
		
		<cfset var method = "objectFile">
		
		<cfset var object = structNew()>
		
		<cftry>
			
			<cfif isDefined("arguments.xml")>
			
				<cfxml variable="xmlFile">
					<cfoutput>#arguments.xml#</cfoutput>
				</cfxml>
			
				<cfif isDefined("xmlFile.file.XmlAttributes.id")>
					<cfset id=xmlFile.file.XmlAttributes.id>
				</cfif>
				
				<cfif isDefined("xmlFile.file.XmlAttributes.physical_name")>
					<cfset physical_name=xmlFile.file.XmlAttributes.physical_name>
				</cfif>
				<cfif isDefined("xmlFile.file.XmlAttributes.user_in_charge")>
					<cfset user_in_charge=xmlFile.file.XmlAttributes.user_in_charge>
				</cfif>
				<cfif isDefined("xmlFile.file.XmlAttributes.file_size_full")>
					<cfset file_size_full=xmlFile.file.XmlAttributes.file_size_full>
				</cfif>
				<cfif isDefined("xmlFile.file.XmlAttributes.file_size")>
					<cfset file_size=xmlFile.file.XmlAttributes.file_size>
				</cfif>
				<cfif isDefined("xmlFile.file.XmlAttributes.file_type")>
					<cfset file_type=lCase(xmlFile.file.XmlAttributes.file_type)>
				</cfif>
				<cfif isDefined("xmlFile.file.XmlAttributes.uploading_date")>
					<cfset uploading_date=xmlFile.file.XmlAttributes.uploading_date>
				</cfif>
				<cfif isDefined("xmlFile.file.XmlAttributes.replacement_date")>
					<cfset replacement_date=xmlFile.file.XmlAttributes.replacement_date>
				</cfif>
				<cfif isDefined("xmlFile.file.XmlAttributes.association_date")>
					<cfset association_date=xmlFile.file.XmlAttributes.association_date>
				</cfif>
				<cfif tree_mode EQ true AND isDefined("xmlFile.file.XmlAttributes.name")>
					<cfset name=xmlFile.file.XmlAttributes.name>
				</cfif>
				<cfif tree_mode EQ true AND isDefined("xmlFile.file.XmlAttributes.typology_id")>
					<cfset typology_id=xmlFile.file.XmlAttributes.typology_id>
				</cfif>
				<cfif tree_mode EQ true AND isDefined("xmlFile.file.XmlAttributes.typology_row_id")>
					<cfset typology_row_id=xmlFile.file.XmlAttributes.typology_row_id>
				</cfif>
				<cfif isDefined("xmlFile.file.name")>
					<cfset name=xmlFile.file.name.xmlText>
				</cfif>
				<cfif isDefined("xmlFile.file.file_name")>
					<cfset file_name=xmlFile.file.file_name.xmlText>
				</cfif>
				<cfif isDefined("xmlFile.file.description")>
					<cfset description=xmlFile.file.description.xmlText>
				</cfif>
				<cfif isDefined("xmlFile.file.user_full_name")>
					<cfset user_full_name=xmlFile.file.user_full_name.xmlText>
				</cfif>
				<cfif isDefined("xmlFile.file.xmlAttributes.status")>
					<cfset status=xmlFile.file.xmlAttributes.status>
				</cfif>
				<cfif isDefined("xmlFile.file.xmlAttributes.area_id")>
					<cfset area_id=xmlFile.file.xmlAttributes.area_id>
				</cfif>
				<cfif isDefined("xmlFile.file.area_name")>
					<cfset area_name=xmlFile.file.area_name.xmlText>
				</cfif>
				<cfif isDefined("xmlFile.file.xmlAttributes.user_image_type")>
					<cfset user_image_type=xmlFile.file.xmlAttributes.user_image_type>
				</cfif>
				
			</cfif>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringDateUpload">
				<cfinvokeargument name="timestamp_date" value="#uploading_date#">
			</cfinvoke>
			<cfset uploading_date = stringDateUpload>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringDateReplace">
				<cfinvokeargument name="timestamp_date" value="#replacement_date#">
			</cfinvoke>
			<cfset replacement_date = stringDateReplace>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringDateAssociation">
				<cfinvokeargument name="timestamp_date" value="#association_date#">
			</cfinvoke>
			<cfset association_date = stringDateAssociation>
			
			<!---file_size in kilobytes or megabytes--->
			<cfif NOT isDefined("file_size_full") AND len("#file_size#") GT 0>
				<cfset file_size_full = file_size><!---file_size_full is the file_size from database without parse to kilobytes--->
				<!---Get the file size in KB--->
				<cfset file_size_kb = Fix(file_size/1024)>
				<cfif file_size_kb IS 0>
					<cfset file_size_kb = 1>
				</cfif>
				<cfset file_size_kb = file_size_kb&" KB">
				
				
				<cfif file_size_full LT (1024*1024)><!---File size is LT a mega byte--->
				
					<cfset file_size = file_size_kb>
					
				<cfelse>
				
					<cfset file_size = file_size/(1024*1024)>
					<cfset file_size = round(file_size*100)/100>
					
					<cfset file_size = file_size&" MB">
					
				</cfif>
			<cfelse>
				<cfset file_size_full = "">
				<cfset file_size_kb = "">
			</cfif>
					
			<cfset object = {
				id="#id#",
				physical_name="#physical_name#",
				user_in_charge="#user_in_charge#",
				file_size_full="#file_size_full#",
				file_size_kb="#file_size_kb#",
				file_size="#file_size#",
				file_type="#file_type#",
				uploading_date="#uploading_date#",
				replacement_date="#replacement_date#",
				association_date="#association_date#",
				name="#name#",
				file_name="#file_name#",
				description="#description#",
				tree_mode="#tree_mode#",
				user_full_name="#user_full_name#",
				status="#status#",
				area_id="#area_id#",
				area_name="#area_name#",
				file_types_conversion="#file_types_conversion#",
				user_image_type="#user_image_type#",
				typology_id="#typology_id#",
				typology_row_id="#typology_row_id#"
				}>
			
			<cfif isDefined("arguments.return_type")>
			
				<cfif arguments.return_type EQ "object">
				
					<cfreturn object>
					
				<cfelseif arguments.return_type EQ "xml">
				
					<cfinvoke component="FileManager" method="xmlFile" returnvariable="xmlResult">
						<cfinvokeargument name="objectFile" value="#object#">
					</cfinvoke>
					<cfreturn xmlResult>
					
				<cfelse>
					
					<cfreturn object>
					
				</cfif>
				
			<cfelse>
			
				<cfreturn object>
				
			</cfif>
			
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn null>
			</cfcatch>
		</cftry>
		
	</cffunction>
	
	

	<!--- ----------------- GET USER FILE TREE  -------------------------------- --->
	<cffunction name="getUserFileTree" returntype="string" access="public" >	
		
		<cfset var method = "getUserFileTree">
		
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">
		
			<cfinvoke component="FolderManager" method="getUserRootFolderId" returnvariable="root_folder_id">
			</cfinvoke>		
							
				<cfinvoke component="FolderManager" method="getFolderContent" returnvariable="result">
					<cfinvokeargument name="folder_id" value="#root_folder_id#">							
				</cfinvoke> 			
			
				<cfsavecontent variable="xmlResult">
					<cfoutput>
						#result#						
					</cfoutput>
				</cfsavecontent>							
			
			<cfset xmlResponseContent = xmlResult>
		
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>			
		
	</cffunction>


	<!--- ----------------------- DELETE FILE -------------------------------- --->
	
	<cffunction name="deleteFile" returntype="struct" output="false" access="public">		
		<cfargument name="file_id" type="numeric" required="true">
		
		<cfset var method = "deleteFile">
		
		<cfset var response = structNew()>

		<cfset var area_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
						
			<!--- getFile --->
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="getFileQuery">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
				<cfinvokeargument name="with_lock" value="false">
				<cfinvokeargument name="parse_dates" value="true">		

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<!---<cfquery name="getFileQuery" datasource="#client_dsn#">				
				SELECT physical_name, file_size, user_in_charge, status, typology_id, typology_row_id, file_type_id, area_id, locked
				FROM #client_abb#_files
				WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>--->

			<cfif getFileQuery.recordCount GT 0>

				<cfif getFileQuery.file_type_id IS 2><!---Area file--->
					
					<cfset area_id = getFileQuery.area_id>

					<!---checkAreaAccess--->
					<cfinclude template="includes/checkAreaAccess.cfm">

				<cfelse><!--- User file --->

					<!---checkAccess--->
					<cfif getFileQuery.user_in_charge NEQ user_id><!---El usuario del item no es el mismo que el que intenta eliminar--->
						<cfinclude template="includes/checkAdminAccess.cfm">
					</cfif>					

				</cfif>

				<cfif getFileQuery.locked IS true>

					<cfset response = {result=false, file_id=#arguments.file_id#, message="El archivo está bloqueado y no puede ser eliminado"}>

				<cfelse>

					<!---getFileAreas--->
					<cfquery datasource="#client_dsn#" name="getFileAreasQuery">
						SELECT area_id
						FROM #client_abb#_areas_files
						WHERE file_id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
					</cfquery>

					<cftransaction>
									
						<!---Delete typology--->
						<cfif isNumeric(getFileQuery.typology_id) AND isNumeric(getFileQuery.typology_row_id)>
							
							<cfinvoke component="RowManager" method="deleteRow" returnvariable="deleteRowResponse">
								<cfinvokeargument name="row_id" value="#getFileQuery.typology_row_id#"/>
								<cfinvokeargument name="table_id" value="#getFileQuery.typology_id#"/>
								<cfinvokeargument name="tableTypeId" value="#typologyTableTypeId#"/>
							</cfinvoke>

							<cfif deleteRowResponse.result IS false>
								<cfthrow message="#deleteRowResponse.message#">
							</cfif>

						</cfif>

						<!--- Delete association area --->
						<cfquery name="deleteAssociationAreaQuery" datasource="#client_dsn#">
							DELETE 
							FROM #client_abb#_areas_files
							WHERE file_id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
						</cfquery>	

						<!--- Delete areas positions --->
						<cfinvoke component="AreaItemManager" method="deleteItemPosition">
							<cfinvokeargument name="item_id" value="#arguments.file_id#">
							<cfinvokeargument name="itemTypeId" value="#fileItemTypeId#">
						</cfinvoke>
						
						<!--- Delete association folder file --->
						<cfquery name="deleteAssociationFolderQuery" datasource="#client_dsn#">
							DELETE 
							FROM #client_abb#_folders_files
							WHERE file_id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
						</cfquery>		
						
						<!--- Deletion of the row representing the file --->
						<cfquery name="deleteFileQuery" datasource="#client_dsn#">		
							DELETE
							FROM #client_abb#_files 
							WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
						</cfquery>
						
						<cfset path = APPLICATION.filesPath&'/#client_abb#/files/'>	
						<cfset filePath = path & "#getFileQuery.physical_name#">			
						
						<!--- Now we delete physically the file on the server --->
						<cfif FileExists(filePath)><!---If the physical file exist--->
							<cffile action="delete" file="#filePath#">
						<cfelse><!---The physical file does not exist--->
							<!---<cfset error_code = 608>
							<cfthrow errorcode="#error_code#">--->
						</cfif>
						
						<!---Update User Space Used--->
						<cfif getFileQuery.status EQ "ok">
							<cfquery name="updateUserSpaceUsed" datasource="#client_dsn#">
								UPDATE #client_abb#_users
								SET space_used = space_used-#getFileQuery.file_size#
								WHERE id = <cfqueryparam value="#getFileQuery.user_in_charge#" cfsqltype="cf_sql_integer">;
							</cfquery>
						</cfif>
					
					</cftransaction>

					<cfinclude template="includes/logRecord.cfm">

					<cfif getFileAreasQuery.recordCount GT 0>
						
						<cfloop query="getFileAreasQuery">

							<!--- Alert --->
							<cfinvoke component="AlertManager" method="newFile">
								<cfinvokeargument name="objectFile" value="#getFileQuery#">
								<cfinvokeargument name="area_id" value="#getFileAreasQuery.area_id#">
								<cfinvokeargument name="action" value="delete">
							</cfinvoke>
							
						</cfloop>

					</cfif>

					<cfset response = {result=true, file_id=#arguments.file_id#}>

				</cfif>
			
			<cfelse><!---The file does not exist (is not found)--->
				
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>		
		

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>	
		
	</cffunction>

	<!--- ----------------------- UPDATE FILE -------------------------------- --->
	
	<cffunction name="updateFile" returntype="struct" output="false" access="public">		
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		<cfargument name="description" type="string" required="true">
		
		<cfset var method = "updateFile">

		<cfset var response = structNew()>

		<cfset var area_id = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---checkAccess--->
			<cfinvoke component="FileManager" method="getFile" returnvariable="objectFile">				
				<cfinvokeargument name="get_file_id" value="#arguments.file_id#">
			
				<cfinvokeargument name="return_type" value="query">
			</cfinvoke>			

			<cfif objectFile.file_type_id IS 2><!---Area file--->

				<cfset area_id = objectFile.area_id>
				
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">

			<cfelseif objectFile.user_in_charge NEQ user_id>

				<cfset error_code = 103><!---Access denied--->
					
				<cfthrow errorcode="#error_code#">

			</cfif>


			<cfif objectFile.locked IS true AND objectFile.lock_user_id NEQ user_id>

				<cfset response = {result=false, file_id=#arguments.file_id#, message="El archivo está bloqueado y no puede ser modificado"}>

			<cfelseif objectFile.locked IS false AND objectFile.file_type_id IS 2>

				<cfset response = {result=false, file_id=#arguments.file_id#, message="Debe bloquear el archivo para poder modificarlo"}>

			<cfelse>
				
				<!---<cftransaction> No se puede usar aquí transacción porque dentro de setFileTypology hay transacciones--->

				<cfquery name="updateFileQuery" datasource="#client_dsn#">
					UPDATE `#client_abb#_files`
					SET name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
					description = <cfqueryparam value="#arguments.description#" cfsqltype="cf_sql_longvarchar">
					WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
				</cfquery>	

				<!--- setFileTypology --->
				<cfif isDefined("arguments.typology_id") AND isNumeric(arguments.typology_id)>
					
					<cfinvoke component="FileManager" method="setFileTypology" argumentcollection="#arguments#" returnvariable="setFileTypologyResponse">
					</cfinvoke>

					<cfif setFileTypologyResponse.result IS false>

						<cfthrow message="#setFileTypologyResponse.message#">

					</cfif>

					<cfif objectFile.typology_id NEQ arguments.typology_id AND isNumeric(objectFile.typology_row_id)><!---File typology was changed--->
						
						<cfinvoke component="RowManager" method="deleteRow" returnvariable="deleteRowResponse">
							<cfinvokeargument name="row_id" value="#objectFile.typology_row_id#"/>
							<cfinvokeargument name="table_id" value="#objectFile.typology_id#"/>
							<cfinvokeargument name="tableTypeId" value="#typologyTableTypeId#"/>
						</cfinvoke>

						<cfif deleteRowResponse.result IS false>
							<cfthrow message="#deleteRowResponse.message#">
						</cfif>

					</cfif>

				</cfif>		

				<!---</cftransaction>--->				
				
				<cfinclude template="includes/logRecord.cfm">

				<cfset response = {result=true, file_id=#arguments.file_id#}>
			
			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>	
		
	</cffunction>

	
	<!--- ----------------------- MOVE FILE TO FOLDER -------------------------------- --->
	
	<cffunction name="moveFileToFolder" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">		
		
		<cfset var method = "moveFileToFolder">
		
		<cfset var fileXml = "">
		<cfset var file_id = "">
		<cfset var folder_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfxml variable="fileXml">
				<cfoutput>
				#xmlRequest.request.parameters.file#
				</cfoutput>
			</cfxml>
			<cfxml variable="folderXml">
				<cfoutput>
				#xmlRequest.request.parameters.folder#
				</cfoutput>
			</cfxml>
			
			
			<cfquery name="beginQuery" datasource="#client_dsn#">
				BEGIN;
			</cfquery>
			
			<cfset file_id = fileXml.file.xmlAttributes.id>
			<cfset folder_id = folderXml.folder.xmlAttributes.id>
			
			<!---<cfif isDefined("fileXml.file.xmlAttr.xmlText")>
				<cfset desc = "#fileXml.file.description.xmlText#">
				<cfset desc = '#replace(desc,"<![CDATA[","","all")#'>
				<cfset desc = '#replace(desc,"]]>","","all")#'>
				<cfquery name="descriptionQuery" datasource="#client_dsn#">
					UPDATE #client_abb#_files SET description = <cfqueryPARAM value = "#desc#" CFSQLType = "CF_SQL_varchar">
					WHERE id = <cfqueryPARAM value = "#fileXml.file.XmlAttributes.id#" CFSQLType = "CF_SQL_integer">;
				</cfquery>
			</cfif>--->	
			
			<cfquery name="moveFileQuery" datasource="#client_dsn#">
				UPDATE #client_abb#_folders_files SET folder_id = <cfqueryparam value="#folder_id#" cfsqltype="cf_sql_integer">
				WHERE file_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">; 
			</cfquery>
			
			<cfquery name="commitQuery" datasource="#client_dsn#">
				COMMIT;
			</cfquery>						
						
			<cfinvoke method="selectFile" component="FileManager" returnvariable="result">
				<cfinvokeargument name="request" value='<request><parameters><file id="#fileXml.file.xmlAttributes.id#" /></parameters></request>'>
			</cfinvoke>
			
			<cfxml variable="xmlResponse">
				<cfoutput>
				#result#
				</cfoutput>
			</cfxml>
			
			<cfset xmlResponse.response.xmlAttributes.component = component>
			<cfset xmlResponse.response.xmlAttributes.method = method>			
		
			<!---<cfinclude template="includes/functionEnd.cfm">--->
			<cfinclude template="includes/logRecord.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	<!--- ----------------------- ASSOCIATE FILES -------------------------------- --->
	
	<!---Falta por terminar de implementar y por probar--->
	
	<!---<cffunction name="associateFiles" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "associateFiles">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
		
		<cfset var area_id = "">
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>
			
			<cfinclude template="includes/checkAreaAccess.cfm">
			
			<cfset xmlResult = '<files>'>
			
			<cfloop index="indexNode" from="1" to="#ArrayLen(xmlRequest.request.parameters.files.file)#">
			
				<cfinvoke component="FileManager" method="associateFile" returnvariable="associateFileResult">
					<cfinvokeargument name="file_id" value="#xmlRequest.request.parameters.files.file[indexNode].xmlAttributes.id#">
					<cfinvokeargument name="area_id" value="#area_id#">
				</cfinvoke>
				
				<!---<cfxml variable="xmlAssociateFileResult">
					<cfoutput>
					#associateFileResult#
					</cfoutput>
				</cfxml>--->
				
				<cfset xmlResult = xmlResult & associateFileResult>	
			
			</cfloop>
			
			<cfset xmlResult = xmlResult & '</file>'>
			
			<cfset xmlResponseContent = xmlResult>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>--->
	
		
	<!--- ----------------------- ASSOCIATE FILE -------------------------------- --->
	
	<cffunction name="associateFileToAreas" returntype="struct" output="false" access="public">		
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="areas_ids" type="string" required="true">		
		
		<cfset var method = "associateFileToAreas">

		<cfset var response = structNew()>
		
		<cfset var allAreas = true>
		<cfset var successfulAreas = "">
					
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
						
			<cfinvoke component="FileManager" method="getFile" returnvariable="objectFile">				
				<cfinvokeargument name="get_file_id" value="#arguments.file_id#">
			
				<cfinvokeargument name="return_type" value="query">
			</cfinvoke>		
	
			<cfloop list="#arguments.areas_ids#" index="cur_area_id">
				
				<cftry>
				
					<cfinvoke component="FileManager" method="associateFileToArea">				
						<cfinvokeargument name="objectFile" value="#objectFile#">
						<cfinvokeargument name="area_id" value="#cur_area_id#">
					</cfinvoke>	
					
					<cfset successfulAreas = listAppend(successfulAreas, cur_area_id)>	
					
					<cfcatch>
						<cfif isDefined("cfcatch.errorcode") AND cfcatch.errorcode IS 607><!---The file exists in the area--->	
							<cfset allAreas = false>
						<cfelse>
							<cfthrow object="#cfcatch#">					
						</cfif>
					</cfcatch>
				</cftry>
			
			</cfloop>
							
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfset response = {result=true, file_id=#arguments.file_id#, areas_ids=#successfulAreas#, allAreas=#allAreas#}>		

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>			
		
	</cffunction>
	

	<!--- ----------------------- ASSOCIATE FILE -------------------------------- --->
	
	<cffunction name="associateFile" returntype="struct" output="false" access="public">		
		<!---<cfargument name="request" type="string" required="yes">--->
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">				
		
		<cfset var method = "associateFile">
		
		<cfset var response = structNew()>
					
		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
	
			<cfinvoke component="FileManager" method="getFile" returnvariable="objectFile">				
				<cfinvokeargument name="get_file_id" value="#arguments.file_id#">
			
				<cfinvokeargument name="return_type" value="query">
			</cfinvoke>		
			
			<cfinvoke component="FileManager" method="associateFileToArea">				
				<cfinvokeargument name="objectFile" value="#objectFile#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>		
			
			<cfset response = {result=true, file_id=#arguments.file_id#, area_id=#arguments.area_id#}>		

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
		
	</cffunction>
	
	
	<!--- ----------------------- ASSOCIATE FILE TO AREA -------------------------------- --->
	
	<cffunction name="associateFileToArea" returntype="void" output="false" access="package">		
		<cfargument name="objectFile" type="query" required="yes">
		<cfargument name="area_id" type="numeric" required="yes">		
		
		<cfset var method = "associateFileToArea">
					
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<!--- checkAreaAccess --->
			<cfinclude template="includes/checkAreaAccess.cfm">
			
			<cfif objectFile.file_type_id IS 2>
				<!--- checkAreaAccess --->
				<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreaAccess">
					<cfinvokeargument name="area_id" value="#objectFile.area_id#">
				</cfinvoke>
			<cfelseif objectFile.user_in_charge NEQ user_id>
				<cfthrow message="No puede asociar a un área un archivo que no es de su propiedad">
			</cfif>

			<!---Chequea si existe el archivo en el área--->
			<cfquery datasource="#client_dsn#" name="isFileInAreaQuery">
				SELECT file_id
				FROM #client_abb#_areas_files
				WHERE area_id = <cfqueryparam value = "#arguments.area_id#" cfsqltype="cf_sql_integer"> AND 
				file_id = <cfqueryparam value = "#objectFile.id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif isFileInAreaQuery.recordCount IS NOT 0><!---The file exists in the area--->
				<cfset error_code = 607>
			
				<cfthrow errorcode="#error_code#">		
			</cfif>

			<cftransaction>
				
				<cfquery name="associateFileQuery" datasource="#client_dsn#">		
					INSERT INTO #client_abb#_areas_files (area_id, file_id, association_date)
						VALUES(
						<cfqueryparam value = "#arguments.area_id#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value = "#objectFile.id#" cfsqltype="cf_sql_integer">,
						NOW()
					);			
				</cfquery>

				<!---Add items position--->
				<cfinvoke component="AreaItemManager" method="getAreaItemsLastPosition" returnvariable="itemLastPosition">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfinvoke>
				
				<cfset file_position = itemLastPosition+1>

				<cfinvoke component="AreaItemManager" method="insertAreaItemPosition">
					<cfinvokeargument name="item_id" value="#objectFile.id#">
					<cfinvokeargument name="itemTypeId" value="#fileItemTypeId#">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="position" value="#file_position#">
				</cfinvoke>

			</cftransaction>

			<cfinclude template="includes/functionEndOnlyLog.cfm">		
								
			<!--- Alert --->
			<cfinvoke component="AlertManager" method="newFile">
				<cfinvokeargument name="objectFile" value="#objectFile#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfif objectFile.file_type_id IS 1 OR (objectFile.file_type_id IS 2 AND objectFile.area_id NEQ arguments.area_id)>
					<cfinvokeargument name="action" value="associate">
				<cfelse>
					<cfinvokeargument name="action" value="new">
				</cfif>
			</cfinvoke>
		
	</cffunction>
	
	
	<!--- ----------------------- DISSOCIATE FILE -------------------------------- --->
	
	<cffunction name="dissociateFile" returntype="struct" output="false" access="public">		
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">		
		
		<cfset var method = "dissociateFile">
		
		<cfset var response = structNew()>
					
		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<!---checkAreaAccess--->
			<!--- Area accces check in dissociateFileFromArea --->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="getFile">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
				<cfinvokeargument name="with_lock" value="false">
				<cfinvokeargument name="parse_dates" value="true">		

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif getFile.recordCount GT 0>

				<!--- Comprueba si es archivo de área y se está intentando quitar de esa área --->
				<cfif getFile.file_type_id IS 2 AND getFile.area_id IS arguments.area_id>
					<cfset response_message = "Para quitar este archivo de esta área debe eliminarlo.">
					<cfset response = {result=false, message=#response_message#, file_id=#arguments.file_id#, area_id=#arguments.area_id#}>
					<cfreturn response>
				</cfif>

				<!--- dissociateFileFromArea --->
				<cfinvoke component="FileManager" method="dissociateFileFromArea">				
					<cfinvokeargument name="objectFile" value="#getFile#">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfinvoke>		


				<cfset response = {result=true, file_id=#arguments.file_id#, area_id=#arguments.area_id#}>	

			<cfelse><!---File does not exist--->
			
				<cfset error_code = 601>
			
				<cfthrow errorcode="#error_code#">
			
			</cfif>	

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>		
		
	</cffunction>


	<!--- ----------------------- DISSOCIATE FILE FROM AREA -------------------------------- --->
	
	<cffunction name="dissociateFileFromArea" returntype="void" output="false" access="package">		
		<cfargument name="objectFile" type="query" required="yes">
		<cfargument name="area_id" type="numeric" required="yes">		
		
		<cfset var method = "associateFileToArea">
		
		<cfset var file_id = objectFile.file_id>

			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<!--- checkAreaAccess --->
			<cfinclude template="includes/checkAreaAccess.cfm">
			
			<!---Chequea si el archivo está en otra área--->
			<cfquery datasource="#client_dsn#" name="isFileInAreaQuery">
				SELECT file_id
				FROM #client_abb#_areas_files
				WHERE file_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif isFileInAreaQuery.recordCount LT 2><!---The file is only in this area--->
				<!---<cfset response_message = "El archivo solo está asociado en esta área. Para quitarlo debe eliminarlo.">
				<cfset response = {result=false, message=#response_message#, file_id=#arguments.file_id#, area_id=#arguments.area_id#}>
				<cfreturn response>--->
				<cfthrow message="El archivo sólo está asociado en esta área. Para quitarlo debe eliminarlo.">
			</cfif>
			
			<cftransaction>
				
				<cfquery name="dissociateFileQuery" datasource="#client_dsn#">		
					DELETE FROM #client_abb#_areas_files 
					WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
						AND file_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

				<!---DELETE ITEM POSITION--->
				<cfinvoke component="AreaItemManager" method="deleteItemPosition">
					<cfinvokeargument name="item_id" value="#file_id#">
					<cfinvokeargument name="itemTypeId" value="#fileItemTypeId#">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfinvoke>

			</cftransaction>
				
			<cfinclude template="includes/functionEndOnlyLog.cfm">

			<!--- Alert --->
			<cfinvoke component="AlertManager" method="newFile">
				<cfinvokeargument name="objectFile" value="#arguments.objectFile#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="action" value="dissociate">
			</cfinvoke>
		
	</cffunction>


	<!---  ---------------------- changeAreaFileLock -------------------------------- --->
	
	<cffunction name="changeAreaFileLock" returntype="struct" access="public">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="lock" type="boolean" required="true">
		
		<cfset var method = "changeAreaFileLock">

		<cfset var response = structNew()>

		<cftry>
		
			<cfinclude template="includes/functionStartOnlySession.cfm">
						
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="getFile">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
				<cfinvokeargument name="with_lock" value="true">
				<cfinvokeargument name="parse_dates" value="true">		

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif getFile.recordCount GT 0>
				
				<cfset area_id = getFile.area_id>
			
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">
			
				<cfif getFile.locked NEQ arguments.lock>

					<cfif arguments.lock IS false AND getFile.lock_user_id NEQ user_id>
						
						<!---checkAreaResponsibleAccess--->
						<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
							<cfinvokeargument name="area_id" value="#area_id#">
						</cfinvoke>

					</cfif>

					<cftransaction>
						
						<cfquery name="addFileLock" datasource="#client_dsn#">		
							INSERT INTO `#client_abb#_files_locks`
							SET file_id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">,
							user_id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">,
							lock_date = NOW(),
							`lock` = <cfqueryparam value="#arguments.lock#" cfsqltype="cf_sql_bit">;			
						</cfquery>

						<cfquery name="changeAreaFileLock" datasource="#client_dsn#">		
							UPDATE `#client_abb#_files`
							SET	locked = <cfqueryparam value="#arguments.lock#" cfsqltype="cf_sql_bit">
							WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;	
						</cfquery>	

					</cftransaction>
										
					<!---<cfinvoke component="AreaItemManager" method="getItem" returnvariable="getItemResponse">
						<cfinvokeargument name="item_id" value="#arguments.item_id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>
					<cfset objectItem = getItemResponse.item>--->

					<!--- Alert --->
					<cfinvoke component="AlertManager" method="newFile">
						<cfinvokeargument name="objectFile" value="#getFile#">
						<cfinvokeargument name="area_id" value="#area_id#">
						<cfif arguments.lock IS true>
							<cfinvokeargument name="action" value="lock">
						<cfelse>
							<cfinvokeargument name="action" value="unlock">
						</cfif>
					</cfinvoke>

					<cfinclude template="includes/logRecord.cfm">

					<cfset response = {result=true, file_id=#arguments.file_id#, lock=arguments.lock}>
										
				<cfelse>

					<cfif arguments.lock IS true>
						
						<cfthrow message="Error, el archivo ya está bloqueado">

					<cfelse>

						<cfthrow message="Error, el archivo ya está desbloqueado">

					</cfif>
														
				</cfif>
			
			<cfelse><!---File does not exist--->
			
				<cfset error_code = 601>
			
				<cfthrow errorcode="#error_code#">
			
			</cfif>
			
			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	<!--- ----------------------- CONVERT FILE -------------------------------- --->
	
	<cffunction name="convertFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">	
		
		<cfset var method = "convertFile">
		<cfset var file_id = "">
		<cfset var file_type = "">
		
		<cfset var files_directory = "">
		<cfset var files_converted_directory = "">
		<cfset var file_copy = "">
		<cfset var file_converted = "">
		
		<cfset var objectFile = "">
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			<cfset file_type = xmlRequest.request.parameters.file.xmlAttributes.file_type>
			
			<cfinvoke component="FileManager" method="getFile" returnvariable="objectFile">				
				<cfinvokeargument name="get_file_id" value="#file_id#">
			
				<cfinvokeargument name="return_type" value="query">
			</cfinvoke>
			
			<!---checkFileTypeConversion--->			
			<cfinvoke component="FileManager" method="checkFileTypeConversion" returnvariable="file_type_result">
				<cfinvokeargument name="file_type_from" value="#objectFile.file_type#">
				<cfinvokeargument name="file_type_to" value="#file_type#">
			</cfinvoke>	
			
			<cfif file_type_result IS true>
			
				<cfset files_directory = "files">
				<cfset files_converted_directory = "files_converted">
				
				<cfset source = '#APPLICATION.filesPath#/#client_abb#/#files_directory#/#objectFile.physical_name#'>		
				
				<cfif FileExists(source)>
					
					<cfquery datasource="#client_dsn#" name="getFileConverted">
						SELECT file_id, file_type, uploading_date, conversion_date
						FROM #client_abb#_files_converted
						WHERE file_id = <cfqueryparam value="#objectFile.file_id#" cfsqltype="cf_sql_integer">
						AND file_type = <cfqueryparam value="#file_type#" cfsqltype="cf_sql_varchar">;
					</cfquery>
					
					<cfif getFileConverted.recordCount LT 1 OR getFileConverted.uploading_date LT objectFile.uploading_date OR getFileConverted.uploading_date LT objectFile.replacement_date>
	
						<cfsetting requesttimeout="#APPLICATION.filesTimeout#">
							
						<cfset file_copy = '#APPLICATION.filesPath#/#client_abb#/#files_converted_directory#/temp_#objectFile.physical_name#_#user_id##objectFile.file_type#'>
						<cffile action="copy" source="#source#" destination="#file_copy#" nameconflict="overwrite">
						
						<cfif file_type NEQ ".html">
						
							<cfset file_converted = '#APPLICATION.filesPath#/#client_abb#/#files_converted_directory#/#objectFile.physical_name##file_type#'>
						
						<cfelse>
							
							<cfset file_converted = ExpandPath('#APPLICATION.path#/#client_abb#/temp/files/#objectFile.physical_name#_html/#objectFile.physical_name##file_type#')>					
							
						</cfif>
						
						<cfinvoke component="FileConverter" method="convertFile">
							<cfinvokeargument name="inputFilePath" value="#file_copy#">
							<cfinvokeargument name="outputFilePath" value="#file_converted#">
						</cfinvoke>
						
						<cffile action="delete" file="#file_copy#">
				
						<cfquery datasource="#client_dsn#" name="insertConvertedFile">
							REPLACE INTO #client_abb#_files_converted
							(file_id, file_type, uploading_date, conversion_date)
							VALUES (
							<cfqueryparam value="#objectFile.file_id#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#file_type#" cfsqltype="cf_sql_varchar">,
							<cfif isDate(objectFile.replacement_date) AND objectFile.replacement_date GT objectFile.uploading_date>
								<cfqueryparam value="#objectFile.replacement_date#" cfsqltype="cf_sql_timestamp">,
							<cfelse>
								<cfqueryparam value="#objectFile.uploading_date#" cfsqltype="cf_sql_timestamp">,
							</cfif>
							NOW());
						</cfquery>
					
						<cfset file_convert_message = "Archivo generado correctamente.">
					
					<cfelse>
					
						<cfset file_convert_message = "Archivo ya disponible en este formato, puede descargarlo.">
					
					</cfif>
					
					<cfset xmlResponseContent = "<file_convert><message><![CDATA[#file_convert_message#]]></message></file_convert>">
					
					<cfinclude template="includes/functionEndNoLog.cfm">
					
				<cfelse><!---The physical file does not exist--->
							
					<cfset error_code = 608>
					
					<cfthrow errorcode="#error_code#" detail="#source#">
				
				</cfif>
			
			<cfelse><!---The file can't be converted to the selected file type--->
			
				<cfset error_code = 612>
					
				<cfthrow errorcode="#error_code#" detail="#file_type#">
			
			</cfif>
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
				
	</cffunction>
	
	
	<!--- ----------------------- CONVERT PRESENTATION FILE -------------------------------- --->
	
	<!---En este método se convierte el archivo si no ha sido convertido ya en HTML, y después se generan las miniaturas y se obtienen el listado de archivos que forman la presentacion--->
	
	<cffunction name="convertPresentationFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">	
		
		<cfset var method = "convertPresentationFile">
		
		<cfset var xmlResult = "">
		<cfset var xmlResponseContent = "">
		<cfset var xmlResponse = "">
		
		<cfset var file_id = "">
		<cfset var file_type = "">	
		
		<cfset var objectFile = "">	
		<cfset var convertFileResult = "">
		<cfset var xmlConvertFileResult = "">
		<cfset var fileConvertedDirectory = "">
		<cfset var fileThumbsDirectory = "">

		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			<cfset file_type = xmlRequest.request.parameters.file.xmlAttributes.file_type>
			
			<cfinvoke component="FileManager" method="getFile" returnvariable="objectFile">				
				<cfinvokeargument name="get_file_id" value="#file_id#">
			
				<cfinvokeargument name="return_type" value="query">
			</cfinvoke>
			
			<cfif objectFile.file_type EQ ".ppt" AND file_type EQ ".html">
			
				<!---convertFile--->			
				<cfinvoke component="FileManager" method="convertFile" returnvariable="convertFileResult">
					<cfinvokeargument name="request" value="#arguments.request#">
				</cfinvoke>	
				
				<!---check convertFile result--->
				<cfxml variable="xmlConvertFileResult">
					<cfoutput>
						#convertFileResult#
					</cfoutput>
				</cfxml>
				
				<cfif xmlConvertFileResult.response.xmlAttributes.status EQ "error">
					
					<cfset error_code = xmlConvertFileResult.response.error.xmlAttributes.code>
				
					<cfthrow errorcode="#error_code#">
				
				</cfif>
				
				<cfset fileConvertedDirectory = "#APPLICATION.path#/#client_abb#/temp/files/#objectFile.physical_name#_html/">			
				
				<cfif directoryExists(ExpandPath(fileConvertedDirectory))>
					
					<!---getImageFiles--->
					<cfinvoke component="FileConverter" method="getConvertedImages" returnvariable="convertedImages">
						<cfinvokeargument name="directory_path" value="#fileConvertedDirectory#">
						<cfinvokeargument name="return_type" value="list">
					</cfinvoke>	
					
					<cfset fileThumbsDirectory = fileConvertedDirectory&"thumbs/">
					
					<cfif NOT directoryExists(expandPath(fileThumbsDirectory))>
						<cfdirectory action="create" directory="#expandPath(fileThumbsDirectory)#" mode="777">
					</cfif>
					
					<cfset xmlResult = '<file id="#file_id#"><slides>'>
			
					<cfset cont = 0>
					<cfloop list="#convertedImages#" index="imageFile">
						
						<cfset imageName = imageFile>
						<cfset imageThumbName = imageName>
						
						<cfset imagePath = expandPath(fileConvertedDirectory&imageName)>
						<cfset imageThumbPath = expandPath(fileThumbsDirectory&imageThumbName)>
						
						
						<cfif fileExists(imagePath)>
							
							<cfif NOT fileExists(imageThumbPath)>
								<cfimage action="resize" source="#imagePath#" destination="#imageThumbPath#" width="150">
							</cfif>
							
							<cfset xmlResult = xmlResult&'<slide path="#fileConvertedDirectory##imageFile#" thumb="#fileThumbsDirectory##imageThumbName#" index="#cont#" />'>
							
							<cfset cont = cont+1>
							
						</cfif>
						
						
					</cfloop>
				
					<cfset xmlResult = xmlResult&"</slides></file>">	
				
					<cfset xmlResponseContent = xmlResult>
					
					<cfinclude template="includes/functionEnd.cfm">
				
				
				<cfelse><!---The directory does not exist--->
				
					<cfset error_code = 701>
			
					<cfthrow errorcode="#error_code#" detail="#fileConvertedDirectory#">
				
				</cfif>
				
				
			<cfelse><!---The presentation file types are incorrect--->
			
				<cfset error_code = 613>
			
				<cfthrow errorcode="#error_code#" detail="#objectFile.file_type# #file_type#">
			
			</cfif>
			
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
				
	</cffunction>
	
	
	<!--- -------------------------- checkFileTypeConversion -------------------------------- --->
	<!---Comprueba si se puede convertir un tipo de archivo o otro seleccionado--->
	
	<cffunction name="checkFileTypeConversion" returntype="boolean" access="public">
		<cfargument name="file_type_from" type="string" required="yes">
		<cfargument name="file_type_to" type="string" required="yes">
		
		<cfset var method = "checkFileTypeConversion">
		
		<cfset var file_type_result = false>
			
		<cfinclude template="includes/functionStart.cfm">

		<!---getFileTypesConversion--->
		<cfinvoke component="FileTypeManager" method="getFileTypesConversion" returnvariable="queryFileTypes">
			<cfinvokeargument name="file_type" value="#arguments.file_type_from#">
			
			<cfinvokeargument name="return_type" value="query">
		</cfinvoke>
		
		<cfquery dbtype="query" name="checkFileType">
			SELECT file_type
			FROM queryFileTypes
			WHERE file_type = <cfqueryparam value="#arguments.file_type_to#" cfsqltype="cf_sql_varchar">;			
		</cfquery>		
		
		<cfif checkFileType.recordCount GT 0>
			<cfset file_type_result = true>
		<cfelse>
			<cfset file_type_result = false>
		</cfif>
		
		<cfreturn file_type_result>
		
	</cffunction>
	
	
	<!--- ----------------------- SELECT FILE -------------------------------- --->
	
	<cffunction name="selectFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
				
		<cfset var method = "selectFile">
		
		<cfset var file_id = "">
		<cfset var area_id = "">
		<cfset var area_passed = false>
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			<cfif isDefined("xmlRequest.request.parameters.area.xmlAttributes.id")>
				<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>
				<cfset area_passed = true>			
			</cfif>
			
			<cfinvoke component="FileManager" method="getFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="get_file_id" value="#file_id#">
				<cfif area_passed IS true>
				<cfinvokeargument name="area_id" value="#area_id#">
				</cfif>
				<!---<cfinvokeargument name="format_content" value="all">--->
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
	
	
	<!--- ----------------------- GET FILE -------------------------------- --->
	
	<!---Devuelve los datos de un archivo si el usuario logeado tiene acceso a ellos--->
	<!---El usuario administrador tiene acceso a todos los archivos--->
	
	<cffunction name="getFile" output="false" returntype="any" access="public">		
		<cfargument name="get_file_id" type="numeric" required="yes">
		<cfargument name="area_id" type="numeric" required="no">
		<cfargument name="item_id" type="numeric" required="no">
		<cfargument name="fileTypeId" type="numeric" required="false" default="1">
		<cfargument name="itemTypeId" type="numeric" required="no">
		<!---<cfargument name="format_content" type="string" required="no" default="default">--->
        <cfargument name="return_type" type="string" required="no" default="xml"><!---xml/object/query--->
		
		<cfset var method = "getFile">
		
		<cfset var file_id = "">
		<cfset var area_passed = false>
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = arguments.get_file_id>
			
			<cfif isDefined("arguments.area_id")>
				<cfset area_passed = true>
				
				<!--- checkAreaAccess --->
				<cfinclude template="includes/checkAreaAccess.cfm">					
			</cfif>
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="selectFileQuery">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfif area_passed IS true>
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfif>
				<cfif APPLICATION.moduleAreaFilesLite IS true>
					<cfinvokeargument name="with_lock" value="true">
				</cfif>
				<cfinvokeargument name="parse_dates" value="true">		

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfif selectFileQuery.recordCount GT 0>
				
				<!---The area is not checked before and the file is not property of the user--->
				<cfif area_passed IS NOT true AND selectFileQuery.user_in_charge NEQ user_id>
				
					<cfquery name="getFileAreasQuery" datasource="#client_dsn#">
						SELECT area_id
						FROM #client_abb#_areas_files
						WHERE file_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
					</cfquery>

					<cfif selectFileQuery.file_type_id IS 2 AND isNumeric(selectFileQuery.area_id)><!--- Area file --->
						<cfset queryCount = getFileAreasQuery.recordCount>

						<cfset queryAddRow(getFileAreasQuery)>
						<cfset querySetCell(getFileAreasQuery, "area_id", selectFileQuery.area_id, queryCount+1)>
					</cfif>					
					
					<cfif getFileAreasQuery.RecordCount IS 0 AND isDefined("arguments.itemTypeId")><!---The file is not in area--->
					
					
						<!---Aquí comprueba si el archivo está asociado a otro tipo de elemento (entradas, noticias, eventos, etc)--->
						<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
						
						<cfquery name="getFileAreasQuery" datasource="#client_dsn#">
							SELECT area_id
							FROM #client_abb#_#itemTypeTable# AS items
							WHERE (attached_file_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer"> 
							<cfif itemTypeId IS NOT 1>OR attached_image_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer"></cfif>)
							<cfif isDefined("arguments.item_id")>
							AND items.id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">
							</cfif>
							;
						</cfquery>
						
					
					</cfif>
					
					<cfif getFileAreasQuery.RecordCount GT 0>
				
						<cfif getFileAreasQuery.RecordCount IS 1>
						
							<cfset area_id = getFileAreasQuery.area_id>	
					
							<cfinclude template="includes/checkAreaAccess.cfm">
					
						<cfelse>
							
							<cfset fileAreasList = valueList(getFileAreasQuery.area_id)>
							<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreasAccess">
								<cfinvokeargument name="areasList" value="#fileAreasList#">
							</cfinvoke>							
							
						</cfif>
					
					<cfelse>
					
						<cfset error_code = 103>
			
						<cfthrow errorcode="#error_code#">
					
					</cfif>
				
				</cfif>
				
				<cfif arguments.return_type EQ "query">
				
					<cfset xmlResponse = selectFileQuery>				
				
				<cfelse>
					
					<cfif APPLICATION.moduleConvertFiles EQ true>
					
						<!---getFileTypesConversion--->
						<cfinvoke component="FileTypeManager" method="getFileTypesConversion" returnvariable="objectFileTypes">
							<cfinvokeargument name="file_type" value="#selectFileQuery.file_type#">
							
							<cfinvokeargument name="return_type" value="object">
						</cfinvoke>
					
					</cfif>
					
					<cfinvoke component="FileManager" method="objectFile" returnvariable="objectFile">
						<cfinvokeargument name="id" value="#selectFileQuery.file_id#">
						<cfinvokeargument name="physical_name" value="#selectFileQuery.physical_name#">		
						<cfinvokeargument name="user_in_charge" value="#selectFileQuery.user_in_charge#">		
						<cfinvokeargument name="file_size" value="#selectFileQuery.file_size#">
						<cfinvokeargument name="file_type" value="#selectFileQuery.file_type#">
						<cfinvokeargument name="uploading_date" value="#selectFileQuery.uploading_date#">
						<cfif area_passed IS true>
						<cfinvokeargument name="association_date" value="#selectFileQuery.association_date#">
						</cfif>
						<cfinvokeargument name="replacement_date" value="#selectFileQuery.replacement_date#">
						<cfinvokeargument name="name" value="#selectFileQuery.name#">
						<cfinvokeargument name="file_name" value="#selectFileQuery.file_name#">
						<cfinvokeargument name="description" value="#selectFileQuery.description#">
						<cfinvokeargument name="user_full_name" value="#selectFileQuery.family_name# #selectFileQuery.user_name#">
						<cfinvokeargument name="user_image_type" value="#selectFileQuery.user_image_type#">
						<cfif APPLICATION.moduleConvertFiles EQ true>
							<cfinvokeargument name="file_types_conversion" value="#objectFileTypes#">
						</cfif>
						<cfinvokeargument name="status" value="#selectFileQuery.status#">
						<cfinvokeargument name="typology_id" value="#selectFileQuery.typology_id#">
						<cfinvokeargument name="typology_row_id" value="#selectFileQuery.typology_row_id#">
						
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>
					
					
					<cfif arguments.return_type EQ "object">
						
						<cfset xmlResponse = objectFile>
					 
					<cfelse>
					
						<cfinvoke component="FileManager" method="xmlFile" returnvariable="xmlResponseContent">
							<cfinvokeargument name="objectFile" value="#objectFile#">
						</cfinvoke>
						
						<cfset xmlResponse = xmlResponseContent>
					
					</cfif>
				
				</cfif>
				
				
			<cfelse><!---File does not exist--->
			
				<cfset error_code = 601>
			
				<cfthrow errorcode="#error_code#">

			</cfif>					
			
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	<!--- ----------------------------------- getEmptyFile ----------------------------------  --->
	
	<cffunction name="getEmptyFile" output="false" access="public" returntype="struct">
		<cfset var method = "getEmptyFile">

		<cfset var response = structNew()>

		<cfset var file = structNew()>
		
		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfset file.name = "">
			<cfset file.description = "">
			<cfset file.typology_id = "">
			<cfset file.typology_row_id = "">
			
			<cfset response = {result=true, file=#file#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>
	<!---  -------------------------------------------------------------------------------- --->


	<!--- ----------------------------------- getFileLocks ----------------------------------  --->
	
	<!---<cffunction name="getFileLocks" output="false" access="public" returntype="struct">
		<cfargument name="file_id" type="numeric" required="true">

		<cfset var method = "getFileLocks">

		<cfset var response = structNew()>
		
		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
		
			
			<cfset response = {result=true, file=#file#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>--->
	<!---  -------------------------------------------------------------------------------- --->

	
	<!--- ----------------------- DUPLICATE FILE -------------------------------- --->
	
	<!---Duplica un archivo en la aplicación--->
	
	<cffunction name="duplicateFile" output="false" returntype="struct" access="public">		
		<cfargument name="file_id" type="numeric" required="yes">
		
		<cfset var method = "duplicateFile">
		
		<cfset var new_file_id = "">
		<cfset var new_file_physical_name = "">
		<cfset var current_date = "">
					
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="selectFileQuery">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfinvoke component="DateManager" method="getCurrentDateTime" returnvariable="current_date">
			</cfinvoke>
			
			<cftransaction>
				
				<cfquery name="createFileQuery" datasource="#client_dsn#" result="createFileResult">
					INSERT INTO #client_abb#_files
(name,file_name,user_in_charge,file_size,file_type,uploading_date,description,status)
					VALUES(	<cfqueryparam value="#selectFileQuery.name#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#selectFileQuery.file_name#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#selectFileQuery.file_size#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#selectFileQuery.file_type#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">,			
							<cfqueryparam value="#selectFileQuery.description#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="pending" cfsqltype="cf_sql_varchar">
						);
				</cfquery>
	
				<cfquery name="getLastInsertId" datasource="#client_dsn#">
					SELECT LAST_INSERT_ID() AS insert_file_id FROM #client_abb#_files;
				</cfquery>
				<cfset new_file_id = getLastInsertId.insert_file_id>
				<cfset new_file_physical_name = new_file_id>
				
			</cftransaction>
			
			
			<cfset files_directory = "files">
			<cfset original_source = "#APPLICATION.filesPath#/#client_abb#/#files_directory#/#selectFileQuery.physical_name#">
			<cfset new_source = "#APPLICATION.filesPath#/#client_abb#/#files_directory#/#new_file_physical_name#">
			
			<cffile action="copy" destination="#new_source#" source="#original_source#">			
			
			<cfquery name="updateFileQuery" datasource="#client_dsn#">
				UPDATE #client_abb#_files
				SET physical_name = <cfqueryparam value="#new_file_physical_name#" cfsqltype="cf_sql_varchar">,
				status = <cfqueryparam value="ok" cfsqltype="cf_sql_varchar">
				WHERE id = <cfqueryparam value="#new_file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfquery name="updateSpaceUsed" datasource="#client_dsn#">
				UPDATE #client_abb#_users
				SET space_used = space_used+<cfqueryparam value="#selectFileQuery.file_size#" cfsqltype="cf_sql_integer">
				WHERE id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			
			<cfinvoke component="FileManager" method="objectFile" returnvariable="newObjectFile">
				<cfinvokeargument name="id" value="#new_file_id#">
				<cfinvokeargument name="physical_name" value="#new_file_physical_name#">		
				<cfinvokeargument name="user_in_charge" value="#user_id#">		
				<cfinvokeargument name="name" value="#selectFileQuery.name#">
				<cfinvokeargument name="file_name" value="#selectFileQuery.file_name#">

				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>	
			
		
		<cfreturn newObjectFile>		
		
	</cffunction>
	
	
	
	
	
	<!--- ----------------------- GET FILE CONVERTED -------------------------------- --->
	
	<!---Devuelve los datos del archivo convertido--->
	<!---En este método no es necesario comprobar permisos porque esto solo se usa internamente en la aplicación para la conversión de archivos--->
	
	<!---<cffunction name="getFileConverted" output="false" returntype="any" access="public">		
		<cfargument name="get_file_id" type="numeric" required="yes">

        <cfargument name="return_type" type="string" required="no" default="xml">
		
		<cfset var method = "getFileConverted">
		
		<cfset var file_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = arguments.get_file_id>
			
			<cfquery name="selectFileQuery" datasource="#client_dsn#">		
				SELECT physical_name, user_in_charge, file_size, file_type, files.name, file_name, uploading_date, replacement_date, files.description, files.status, users.family_name, files.id AS file_id, users.name AS user_name
				<cfif area_passed IS true>
				, areas_files.association_date
				</cfif>
				FROM #client_abb#_files AS files
				INNER JOIN #client_abb#_users AS users 
				ON files.id=<cfqueryPARAM value="#file_id#" CFSQLType="cf_sql_integer"> AND files.user_in_charge = users.id
				<cfif area_passed IS true>
				INNER JOIN #client_abb#_areas_files AS areas_files 
				ON areas_files.area_id=<cfqueryparam value="#area_id#" cfsqltype="cf_sql_integer"> AND files.id = areas_files.file_id
				</cfif>
				AND status = 'ok';
			</cfquery>
			
			<cfif selectFileQuery.recordCount GT 0>
				
				<cfif arguments.return_type EQ "query">
				
					<cfset xmlResponse = selectFileQuery>				
				
				<cfelse>
					
					<cfinvoke component="FileManager" method="objectFile" returnvariable="objectFile">
							<cfinvokeargument name="id" value="#selectFileQuery.file_id#">
							<cfinvokeargument name="physical_name" value="#selectFileQuery.physical_name#">		
							<cfinvokeargument name="user_in_charge" value="#selectFileQuery.user_in_charge#">		
							<cfinvokeargument name="file_size" value="#selectFileQuery.file_size#">
							<cfinvokeargument name="file_type" value="#selectFileQuery.file_type#">
							<cfinvokeargument name="uploading_date" value="#selectFileQuery.uploading_date#">
							<cfif area_passed IS true>
							<cfinvokeargument name="association_date" value="#selectFileQuery.association_date#">
							</cfif>
							<cfinvokeargument name="replacement_date" value="#selectFileQuery.replacement_date#">
							<cfinvokeargument name="name" value="#selectFileQuery.name#">
							<cfinvokeargument name="file_name" value="#selectFileQuery.file_name#">
							<cfinvokeargument name="description" value="#selectFileQuery.description#">
							<cfinvokeargument name="user_full_name" value="#selectFileQuery.family_name# #selectFileQuery.user_name#">
							<cfinvokeargument name="file_types_conversion" value="#objectFileTypes#">
							<cfinvokeargument name="status" value="#selectFileQuery.status#">
							
							<cfinvokeargument name="return_type" value="object">
					</cfinvoke>	
					
					
					<cfif arguments.return_type EQ "object">
						
						<cfset xmlResponse = objectFile>
					 
					<cfelse>
					
						<cfinvoke component="FileManager" method="xmlFile" returnvariable="xmlResponseContent">
							<cfinvokeargument name="objectFile" value="#objectFile#">
						</cfinvoke>
						
						<cfset xmlResponse = xmlResponseContent>
					
					</cfif>
				
				</cfif>
				
				
			<cfelse><!---File does not exist--->
			
				<cfset error_code = 601>
			
				<cfthrow errorcode="#error_code#">

			</cfif>					
			
		
		<cfreturn xmlResponse>		
		
	</cffunction>--->

	
	<!--- ----------------------- getFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
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
	
	
	<cffunction name="getFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getFileStatus">
		
		<cfset var file_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			
			<cfquery datasource="#client_dsn#" name="getFile">				
				SELECT status, id, physical_name, user_in_charge, file_size, file_type, uploading_date, replacement_date, name, file_name, description
				FROM #client_abb#_files
				WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getFile.recordCount GT 0>
				
				<!---En la base de datos si status_replacement está definido y no es "ok"
				significa que se ha solicitado reeplazar ese archivo--->
				<!---<cfif len(getFile.status_replacement) GT 0 AND getFile.status_replacement NEQ "ok">
					<cfset xmlResult = '<file id="#file_id#" status="#getFile.status_replacement#" />'>
				<cfelse>--->
				
					<cfif getFile.status EQ "ok">
					
						<cfinvoke component="FileManager" method="objectFile" returnvariable="xmlResult">
							<cfinvokeargument name="id" value="#getFile.id#">
							<cfinvokeargument name="physical_name" value="#getFile.physical_name#">		
							<cfinvokeargument name="user_in_charge" value="#getFile.user_in_charge#">		
							<cfinvokeargument name="file_size" value="#getFile.file_size#">
							<cfinvokeargument name="file_type" value="#getFile.file_type#">
							<cfinvokeargument name="uploading_date" value="#getFile.uploading_date#">
							<cfinvokeargument name="replacement_date" value="#getFile.replacement_date#">
							<cfinvokeargument name="name" value="#getFile.name#">
							<cfinvokeargument name="file_name" value="#getFile.file_name#">
							<cfinvokeargument name="description" value="#getFile.description#">
							<cfinvokeargument name="status" value="#getFile.status#">
							
							<cfinvokeargument name="return_type" value="xml">
						</cfinvoke>
					
					
					<cfelse>
						
						<cfset xmlResult = '<file id="#file_id#" status="#getFile.status#" />'>
						
					</cfif>
				
				<!---</cfif>--->
				
				<cfset xmlResponseContent = xmlResult>
				
				<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfelse><!---The file does not exist (is not found)--->
				
				<cfset xmlResponseContent = arguments.request>
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>		
		
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	<!--- ----------------------- getAreaItemFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
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
	
	
	<cffunction name="getAreaItemFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="file_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="file_type" type="string" required="no" default="file"><!---file/image--->
		<cfargument name="send_alert" type="boolean" required="no" default="true">
		<cfargument name="action" type="string" required="no" default="new">
		
		<cfset var method = "getAreaItemFileStatus">
		
		<cfset var item_id = "">
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
						
			<cfquery datasource="#client_dsn#" name="getFile">				
				SELECT status_replacement, status, id, physical_name, user_in_charge, file_size, file_type, uploading_date, replacement_date, name, file_name, description
				FROM #client_abb#_files
				WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getFile.recordCount GT 0>
				
				<!---En la base de datos si status_replacement está definido y no es "ok"
				significa que se ha solicitado reeplazar ese archivo--->
				<cfif len(getFile.status_replacement) GT 0 AND getFile.status_replacement NEQ "ok">
				
					<cfset xmlResult = '<file id="#file_id#" status="#getFile.status_replacement#" />'>
					
				<cfelse>
				
					<cfif getFile.status EQ "ok" OR getFile.status EQ "uploaded"><!---El estado uploaded indica que se ha subido el archivo pero que no se ha notificado--->
						
						<cfif getFile.status EQ "uploaded">
							<cfquery datasource="#client_dsn#" name="getAreaItem">
								SELECT id, status
								FROM #client_abb#_#itemTypeTable#
								<cfif arguments.file_type EQ "file">
								WHERE attached_file_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
								<cfelseif arguments.file_type EQ "image">
								WHERE  attached_image_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
								</cfif>
							</cfquery>
							<cfset item_id = getAreaItem.id>
							
							<cfif arguments.send_alert IS true>
							
								<cfinvoke component="AreaItemManager" method="getItem" returnvariable="getItemResponse">
									<cfinvokeargument name="item_id" value="#item_id#">
									<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
									<cfinvokeargument name="return_type" value="object">
								</cfinvoke>
								
								<cfset objectItem = getItemResponse.item>

								<cfinvoke component="AlertManager" method="newAreaItem">
									<cfinvokeargument name="objectItem" value="#objectItem#">
									<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
									<cfinvokeargument name="action" value="#arguments.action#">
								</cfinvoke>
								
							</cfif>
							
							<cfquery datasource="#client_dsn#" name="updateFileStatus">				
								UPDATE #client_abb#_files
								SET status = 'ok'
								WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
							</cfquery>
							<cfif getAreaItem.status NEQ "ok">
								<cfquery datasource="#client_dsn#" name="updateItemStatus">				
									UPDATE #client_abb#_#itemTypeTable#
									SET status = 'ok'
									WHERE id = <cfqueryparam value="#item_id#" cfsqltype="cf_sql_integer">;
								</cfquery>
							</cfif>
						</cfif>	
						
						<cfinvoke component="FileManager" method="objectFile" returnvariable="xmlResult">
							<cfinvokeargument name="id" value="#getFile.id#">
							<cfinvokeargument name="physical_name" value="#getFile.physical_name#">		
							<cfinvokeargument name="user_in_charge" value="#getFile.user_in_charge#">		
							<cfinvokeargument name="file_size" value="#getFile.file_size#">
							<cfinvokeargument name="file_type" value="#getFile.file_type#">
							<cfinvokeargument name="uploading_date" value="#getFile.uploading_date#">
							<cfinvokeargument name="replacement_date" value="#getFile.replacement_date#">
							<cfinvokeargument name="name" value="#getFile.name#">
							<cfinvokeargument name="file_name" value="#getFile.file_name#">
							<cfinvokeargument name="description" value="#getFile.description#">
							<cfinvokeargument name="status" value="ok">
							
							<cfinvokeargument name="return_type" value="xml">
						</cfinvoke>
					
					
					<cfelse>
						
						<cfset xmlResult = '<file id="#file_id#" status="#getFile.status#" />'>
						
					</cfif>
				
				</cfif>
				
				<cfset xmlResponseContent = xmlResult>
				
				
			
			<cfelse><!---The file does not exist (is not found)--->
				
				<cfset xmlResponseContent = arguments.request>
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>		
		
		
		<cfreturn xmlResponseContent>		
		
	</cffunction>
	
	
	
	<!--- ----------------------- getMessageFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos
	Este método se mantiene por COMPATIBILIDAD con la versión de cliente Flex, pero debe ser sustituido por getAreaItemFileStatus, que se llama desde MessageManager.cfc
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
	
	
	<!--- ----------------------- getReplaceFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos--->
	
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
	
	
	<!---
	<cffunction name="getReplaceFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getReplaceFileStatus">
		
		<cfset var file_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>

			
			<cfquery datasource="#client_dsn#" name="getFile">				
				SELECT files.status_replacement, files.id, files.physical_name, files.user_in_charge, files.file_size, files.file_type, files.uploading_date, files.replacement_date, files.name, files.file_name, files.description, users.name AS user_name, users.family_name AS family_name
				FROM #client_abb#_files AS files,
				#client_abb#_users AS users
				WHERE files.id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">
				AND files.user_in_charge = users.id;
			</cfquery>
			
			<cfif getFile.recordCount GT 0>
				
				<!---En la base de datos si status_replacement está definido y no es "ok"
				significa que se ha solicitado reeplazar ese archivo
				Si es "pending" está pendiente de ser subido, y si es "uploaded" se ha subido,
				pero no se ha notificado el reemplazo--->
				
				<cfif getFile.status_replacement EQ "ok" OR getFile.status_replacement EQ "uploaded"><!---El estado uploaded indica que se ha subido el archivo pero que no se ha notificado de reemplazo--->
					
					<!---Aquí hay que poner user_full_name para pasarlo a AlerManager--->
					<cfinvoke component="FileManager" method="objectFile" returnvariable="objectFile">
						<cfinvokeargument name="id" value="#getFile.id#">
						<cfinvokeargument name="physical_name" value="#getFile.physical_name#">		
						<cfinvokeargument name="user_in_charge" value="#getFile.user_in_charge#">		
						<cfinvokeargument name="file_size" value="#getFile.file_size#">
						<cfinvokeargument name="file_type" value="#getFile.file_type#">
						<cfinvokeargument name="uploading_date" value="#getFile.uploading_date#">
						<cfinvokeargument name="replacement_date" value="#getFile.replacement_date#">
						<cfinvokeargument name="name" value="#getFile.name#">
						<cfinvokeargument name="file_name" value="#getFile.file_name#">
						<cfinvokeargument name="description" value="#getFile.description#">
						<cfinvokeargument name="status" value="ok">
						<cfinvokeargument name="user_full_name" value="#getFile.family_name# #getFile.user_name#">
						
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>
					
					<!---<cfinvoke component="FileManager" method="getFile" returnvariable="objectFile">
						<cfinvokeargument name="get_file_id" value="#file_id#">
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>--->
					
					
					<cfif getFile.status_replacement EQ "uploaded">
						<cfinvoke component="AlertManager" method="replaceFile">
							<cfinvokeargument name="objectFile" value="#objectFile#">
						</cfinvoke>
						<cfquery datasource="#client_dsn#" name="updateFileStatus">				
							UPDATE #client_abb#_files
							SET status_replacement = 'ok'
							WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
						</cfquery>
					</cfif>	
					
					
					<cfinvoke component="FileManager" method="xmlFile" returnvariable="xmlResult">						
						<cfinvokeargument name="objectFile" value="#objectFile#">
					</cfinvoke>
				
				
				<cfelse>
					
					<cfset xmlResult = '<file id="#file_id#" status="#getFile.status_replacement#" />'>
					
				</cfif>
				
				
				<cfset xmlResponseContent = xmlResult>
				
				<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfelse><!---The file does not exist (is not found)--->
				
				<cfset xmlResponseContent = arguments.request>
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>		
		
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>--->
	
	
	
	<!--- ----------------------- getImageFileStatus -------------------------------- --->
	
	<!---Devuelve el campo status del archivo en la base de datos, que representa el estado de la subida del archivo al servidor. Si el archivo tiene el status ok, devuelve sus datos.
	Este método recibe el parámetro type, que puede ser area_image o user_image, y que define el tipo de archivo de imagen sobre el que se hace la petición.--->
	
	<!---
	request:
	<request>
		<parameters>
			<file id=""/>
			<image_type></image_type>
		</parameters>
	</request>
	response:
	<response component="FileManager" method="getImageFileStatus" status="ok">
		<result>
			<file id="" status="pending/uploading/ok/error"/>	
		</result>
	</response>
	--->
	
	
	<cffunction name="getImageFileStatus" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "getImageFileStatus">
		
		<cfset var file_id = "">
		<cfset var type = "">
		
		<cfset var files_table = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			<cfset type = xmlRequest.request.parameters.image_type.xmlText>
			
			<cfswitch expression="#type#">
			
				<cfcase value="area_image">
					<cfset files_table = "#client_abb#_areas_images">
					<!---<cfset files_directory = "areas_images">
					<cfset association_table = "areas">--->
					
				</cfcase>
				
				<cfcase value="user_image">
					<cfset files_table = "#client_abb#_users_images">
					<!---<cfset files_directory = "users_images">
					<cfset association_table = "users">--->
					
				</cfcase>
			
			</cfswitch>
			
				
			<cfquery datasource="#client_dsn#" name="getFile">				
				SELECT *
				FROM #files_table#
				WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getFile.recordCount GT 0>
				
				<!---En la base de datos si status_replacement está definido y no es "ok"
				significa que se ha solicitado reeplazar ese archivo--->
				<cfif len(getFile.status_replacement) GT 0 AND getFile.status_replacement NEQ "ok">
				
					<cfset xmlResult = '<file id="#file_id#" status="#getFile.status_replacement#" />'>
					
				<cfelse>
				
					<cfif getFile.status EQ "ok">
					
						<cfinvoke component="FileManager" method="objectFile" returnvariable="xmlResult">
							<cfinvokeargument name="id" value="#getFile.id#">
							<cfinvokeargument name="physical_name" value="#getFile.physical_name#">			
							<cfinvokeargument name="file_size" value="#getFile.file_size#">
							<cfinvokeargument name="file_type" value="#getFile.file_type#">
							<cfinvokeargument name="uploading_date" value="#getFile.uploading_date#">
							<cfinvokeargument name="replacement_date" value="#getFile.replacement_date#">
							<cfinvokeargument name="file_name" value="#getFile.file_name#">
							<cfinvokeargument name="status" value="#getFile.status#">
							
							<cfinvokeargument name="return_type" value="xml">
						</cfinvoke>
					
					<cfelse>
						
						<cfset xmlResult = '<file id="#file_id#" status="#getFile.status#" />'>
						
					</cfif>
				
				</cfif>
				
				<cfset xmlResponseContent = xmlResult>
				
				<cfinclude template="includes/functionEnd.cfm">
			
			<cfelse><!---The file does not exist (is not found)--->
				
				<cfset xmlResponseContent = arguments.request>
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>	
			
			
			<cfset xmlResponseContent = xmlResult>
					
			<cfinclude template="includes/functionEnd.cfm">							
		
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	<!--- ----------------------- cancelUserFileUpload -------------------------------- --->
	
	<!---Cancela la subida del archivo, y si el archivo ya se ha subido lo borra--->
	
	<!---
	request:
	<request>
		<parameters>
			<file id=""/>
		</parameters>
	</request>
	response:
	<response component="FileManager" method="cancelUserFileUpload" status="ok">
		<result>
			<file id=""/>	
		</result>
	</response>
	--->
	
	
	<cffunction name="cancelUserFileUpload" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "cancelUserFileUpload">
		
		<cfset var file_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
						
			<cfquery datasource="#client_dsn#" name="getFileStatus">				
				SELECT status, status_replacement
				FROM #client_abb#_files
				WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getFileStatus.recordCount GT 0>
				
				<cfif getFileStatus.status EQ "ok"><!---Si el archivo está subido--->
					<cfif len(getFileStatus.status_replacement) GT 0 AND getFileStatus.status_replacement EQ "pending"><!---Si se estaba reemplazando y no se ha completado--->
						<!---Set the status to canceled--->
						<cfquery datasource="#client_dsn#" name="changeFileStatus">
							UPDATE #client_abb#_files
							SET status_replacement = <cfqueryparam value="canceled" cfsqltype="cf_sql_varchar">
							WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
						</cfquery>
					<cfelseif len(getFileStatus.status_replacement) IS 0><!---Se ha subido un nuevo archivo--->
						<!---deleteFile--->
						<cfinvoke component="FileManager" method="deleteFile" returnvariable="resultDeleteFile">
							<!---<cfinvokeargument name="request" value='<request><parameters><file id="#file_id#"/></parameters></request>'>--->
							<cfinvokeargument name="file_id" value="#file_id#">
						</cfinvoke>
						<cfif resultDeleteFile.result IS false>
							<cfthrow message="#resultDeleteFile.message#">
						</cfif>
					</cfif>
				<cfelse><!---Set the status to canceled--->
					<cfquery datasource="#client_dsn#" name="changeFileStatus">
						UPDATE #client_abb#_files
						SET status = <cfqueryparam value="canceled" cfsqltype="cf_sql_varchar">
						WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
					</cfquery>
				</cfif>
				
				<cfset xmlResponseContent = '<file id="#file_id#" />'>
				
				<cfinclude template="includes/functionEnd.cfm">
			
			<cfelse><!---The file does not exist (is not found)--->
				
				<cfset xmlResponseContent = arguments.request>
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>		
		

			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	<!--- ----------------------- cancelImageFileUpload -------------------------------- --->
	
	<!---Cancela la subida del archivo, y si el archivo ya se ha subido lo borra.
	Este método recibe el parámetro type, que puede ser area_image o user_image, y que define el tipo de archivo de imagen sobre el que se hace la petición.--->
	<!---
	request:
	<request>
		<parameters>
			<file id=""/>
			<image_type></image_type>
		</parameters>
	</request>
	response:
	<response component="FileManager" method="cancelImageFileUpload" status="ok">
		<result>
			<file id=""/>	
		</result>
	</response>
	--->
	
	
	<cffunction name="cancelImageFileUpload" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		
		<cfset var method = "cancelUserFileUpload">
		
		<cfset var file_id = "">
		<cfset var type = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			<cfset type = xmlRequest.request.parameters.image_type.xmlText>
			
			<cfswitch expression="#type#">
			
				<cfcase value="area_image">
					<cfset files_table = "#client_abb#_areas_images">
					<!---<cfset files_directory = "areas_images">
					<cfset association_table = "areas">--->
					
				</cfcase>
				
				<cfcase value="user_image">
					<cfset files_table = "#client_abb#_users_images">
					<!---<cfset files_directory = "users_images">
					<cfset association_table = "users">--->
					
				</cfcase>
			
			</cfswitch>
						
			<cfquery datasource="#client_dsn#" name="getFileStatus">				
				SELECT status, status_replacement
				FROM #files_table#
				WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getFileStatus.recordCount GT 0>
				
				<cfif getFileStatus.status EQ "ok">
					<!---deleteFile--->
					<cfinvoke component="FileManager" method="deleteImageFile" returnvariable="resultDeleteFile">
						<cfinvokeargument name="request" value='<request><parameters><file id="#file_id#"/><image_type><![CDATA[#type#]]></image_type></parameters></request>'>
					</cfinvoke>
				<cfelse><!---Set the status to canceled--->
					<cfquery datasource="#client_dsn#" name="changeFileStatus">
						UPDATE #files_table#
						SET status = <cfqueryparam value="canceled" cfsqltype="cf_sql_varchar">
						WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
					</cfquery>
				</cfif>
				
				<cfset xmlResponseContent = '<file id="#file_id#" status="#getFileStatus.status#" />'>
				
				<cfinclude template="includes/functionEnd.cfm">
			
			<cfelse><!---The file does not exist (is not found)--->
				
				<cfset xmlResponseContent = arguments.request>
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>		
		

			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>




	<!--- ----------------------- CREATE FILE -------------------------------- --->
	
	<cffunction name="createFile" returntype="struct" output="false" access="public">
		<cfargument name="fileTypeId" type="numeric" required="true"/>		
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="file_name" type="string" required="true"/>
		<cfargument name="file_size" type="numeric" required="true"/>
		<!---<cfargument name="file_size_full" type="numeric" required="true"/>--->
		<cfargument name="file_type" type="string" required="true"/>
		<cfargument name="description" type="string" required="true"/>
		<cfargument name="area_id" type="numeric" required="false">

		<!---<cfargument name="folder_id" type="numeric" required="false"/>--->
		
		<!---Este parametro se le pasa cuando se adjunta un archivo a un mensaje, que primero se crea el mensaje y luego se sube--->
		<cfargument name="status" type="string" required="no" default="">
		
		<!---Este metodo necesitaba recibir variables de sesión como argumentos porque en cuando se suben archivos en Flex desde Firefox no se puede acceder a las variables de sesion--->		

		<cfset var method = "createFile">

		<cfset var response = structNew()>
		
		<cfset var file_id = "">
				
		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
				
			<cfif arguments.fileTypeId IS 2><!--- area_id required in fileTypeId 2 --->
				
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">

			</cfif>

			<!---<cfinvoke component="FileManager" method="objectFile" returnvariable="objectFile">
				<cfinvokeargument name="name" value="#arguments.name#">
				<cfinvokeargument name="file_name" value="#arguments.file_name#">
				<cfinvokeargument name="file_size" value="#arguments.file_size#">
				<!---<cfinvokeargument name="file_size_full" value="#arguments.file_size_full#">--->
				<cfinvokeargument name="file_type" value="#arguments.file_type#">
				<cfinvokeargument name="description" value="#arguments.description#"/>

				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>--->
			
			<cfinvoke component="DateManager" method="getCurrentDateTime" returnvariable="current_date">
			</cfinvoke>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringCurrentDate">
				<cfinvokeargument name="timestamp_date" value="#current_date#">
			</cfinvoke>

			<!---<cfset objectFile.user_in_charge = user_id>
			<cfset objectFile.uploading_date = stringCurrentDate>--->

			<cfquery name="selectUserFileQuery" datasource="#client_dsn#">
				SELECT family_name, name
				FROM #client_abb#_users
				WHERE id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif selectUserFileQuery.recordCount IS 0><!---the user does not exist--->
			
				<cfset error_code = 204>
				
				<cfthrow errorcode="#error_code#"> 
			
			</cfif>

			<!---<cfset objectFile.user_full_name = "#selectUserFileQuery.family_name# #selectUserFileQuery.name#">--->
			
			<cftransaction>
			
				<cfquery name="createFileQuery" datasource="#client_dsn#" result="createFileResult">
					INSERT INTO `#client_abb#_files`
					SET name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
					file_name = <cfqueryparam value="#arguments.file_name#" cfsqltype="cf_sql_varchar">,
					user_in_charge = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">,
					file_size = <cfqueryparam value="#arguments.file_size#" cfsqltype="cf_sql_integer">,
					file_type = <cfqueryparam value="#arguments.file_type#" cfsqltype="cf_sql_varchar">,
					uploading_date = <cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">,	
					description = <cfqueryparam value="#arguments.description#" cfsqltype="cf_sql_varchar">,
					status = <cfqueryparam value="pending" cfsqltype="cf_sql_varchar">,
					file_type_id = <cfqueryparam value="#arguments.fileTypeId#" cfsqltype="cf_sql_integer">
					<cfif arguments.fileTypeId IS 2>
					, area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
					</cfif>;
				</cfquery>

				<cfquery name="getLastInsertId" datasource="#client_dsn#">
					SELECT LAST_INSERT_ID() AS insert_file_id FROM #client_abb#_files;
				</cfquery>
				<cfset file_id = getLastInsertId.insert_file_id>
				<!---<cfset objectFile.id = getLastInsertId.insert_file_id>
				<cfset objectFile.physical_name = objectFile.id>--->
				
				<cfquery name="updateFileQuery" datasource="#client_dsn#">
					UPDATE #client_abb#_files
					SET physical_name = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_varchar">,
					status = <cfqueryparam value="#arguments.status#" cfsqltype="cf_sql_varchar">
					WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
				</cfquery>
				
				<!---<cfif isDefined("arguments.folder_id")>			
					<cfquery name="associateToFolderFileQuery" datasource="#client_dsn#">
						INSERT INTO #client_abb#_folders_files					
						VALUES(<cfqueryparam value="#arguments.folder_id#" cfsqltype="cf_sql_integer">,
								<cfqueryparam value="#objectFile.id#" cfsqltype="cf_sql_integer">
							);
					</cfquery>
				</cfif>--->
				
				<!--- ------------------ Update User Space Used --------------------- --->
				<!---Esto se hace en la página donde se sube realmente el archivo--->			
			
			</cftransaction>			

			<cfinclude template="includes/logRecord.cfm">

			<!--- getFile --->
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="fileQuery">
				<cfinvokeargument name="file_id" value="#file_id#">
				<cfinvokeargument name="with_lock" value="false">
				<cfinvokeargument name="parse_dates" value="true">
				<cfinvokeargument name="status" value="#arguments.status#">		

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif fileQuery.recordCount IS 0><!---File does not exist--->
			
				<cfset error_code = 601>
			
				<cfthrow errorcode="#error_code#">

			</cfif>		

			<cfset response = {result=true, objectFile=#fileQuery#}>
			
			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>		
		
	</cffunction>
	
	
	<!--- ----------------------- createUserFileTicket -------------------------------- --->
	
	<!---Este método es para la subida de archivos de mis documentos, y crea el archivo en la base de datos con el status=pending, a la espera de que en myFilesUploadFileTicket se suba el archivo físicamente--->
	
	<!---
	request:
	<request>
		<parameters>
			<file>
				<name></name>
				<description></description>
			</file>
			<folder id=""></folder>	
		</parameters>
	</request>
	response:
	<response component="FileManager" method="createUserFileTicket" status="ok">
		<result>
			<file id=""/>	
		</result>
	</response>
	--->
	
	
	<cffunction name="createUserFileTicket" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		<!---Este parametro se le pasa cuando se adjunta un archivo a un mensaje, que primero se crea el mensaje y luego se sube--->

		<cfset var method = "createUserFileTicket">
		
		<cfset var file = "">
		<cfset var folder_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file = xmlRequest.request.parameters.file>
			<cfset folder_id = xmlRequest.request.parameters.folder.xmlAttributes.id>
			
			<cfxml variable="fileXml">
				<cfoutput>
				#file#
				</cfoutput>
			</cfxml>
			
			<cfif isDefined("fileXml.file.name.xmlText") AND isDefined("fileXml.file.description.xmlText")>
				
				<cfinvoke component="FileManager" method="objectFile" returnvariable="objectFile">
					<cfinvokeargument name="xml" value="#fileXml.file#">
					
					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>
				
								
				<cfinvoke component="DateManager" method="getCurrentDateTime" returnvariable="current_date">
				</cfinvoke>
				
				<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringCurrentDate">
					<cfinvokeargument name="timestamp_date" value="#current_date#">
				</cfinvoke>
				
				<cfset objectFile.user_in_charge = user_id>
				<cfset objectFile.uploading_date = stringCurrentDate>
				
				<cfquery name="beginTransaction" datasource="#client_dsn#">
					BEGIN;
				</cfquery>
				
				<cfquery name="createFileQuery" datasource="#client_dsn#" result="createFileResult">
					INSERT INTO #client_abb#_files
(name,user_in_charge,description,status,uploading_date)
					VALUES(<cfqueryparam value="#objectFile.name#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#objectFile.user_in_charge#" cfsqltype="cf_sql_integer">,
							<cfqueryparam value="#objectFile.description#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="pending" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">
						);
				</cfquery>
	
				<!---<cfset objectFile.id = createFileResult.GENERATED_KEY>--->
				
				<!---SELECT LAST_INSERT_ID() AS insert_file_id FROM #client_abb#_files;--->
				<cfquery name="getLastInsertId" datasource="#client_dsn#">
					SELECT LAST_INSERT_ID() AS insert_file_id FROM #client_abb#_files;
				</cfquery>
				<cfset objectFile.id = getLastInsertId.insert_file_id>
				
				
				<cfif isDefined("xmlRequest.request.parameters.folder.xmlAttributes.id")>
				
					<cfset folder_id = xmlRequest.request.parameters.folder.xmlAttributes.id>	
								
					<cfquery name="associateFileQuery" datasource="#client_dsn#">
						INSERT INTO #client_abb#_folders_files					
						VALUES(<cfqueryparam value="#folder_id#" cfsqltype="cf_sql_integer">,
								<cfqueryparam value="#objectFile.id#" cfsqltype="cf_sql_integer">							
							);
					</cfquery>
				
				</cfif>
				
				<!--- ------------------ Update User Space Used --------------------- --->
				<!---Esto hay que hacerlo en la página donde se sube realmente el archivo--->			
							
				<cfquery name="endQuery" datasource="#client_dsn#">
					COMMIT;
				</cfquery>	

				<!---<cfquery name="selectFileQuery" datasource="#client_dsn#">		
					SELECT *
					FROM #client_abb#_files 
					WHERE id=<cfqueryPARAM value = "#createFileResult.GENERATED_KEY#" CFSQLType = "CF_SQL_integer">;
				</cfquery>--->
				<!---<cfif #selectFileQuery.recordCount# GT 0>--->
				
				<!---<cfquery name="selectUserFileQuery" datasource="#client_dsn#">
					SELECT *
					FROM #client_abb#_users
					WHERE id=<cfqueryparam value="#objectFile.user_in_charge#" cfsqltype="cf_sql_integer">;
				</cfquery>
				
				<cfif selectUserFileQuery.recordCount GT 0>
					
					<cfset objectFile.user_full_name = "#selectUserFileQuery.family_name# #selectUserFileQuery.name#">
					
				<cfelse><!---the user does not exist--->
				
					<cfset error_code = 204>
					
					<cfthrow errorcode="#error_code#"> 
				
				</cfif>--->
				
				<cfinvoke component="FileManager" method="xmlFile" returnvariable="xmlResult">
					<cfinvokeargument name="objectFile" value="#objectFile#">
				</cfinvoke>
					
				<cfset xmlResponseContent = xmlResult>
	
				<cfinclude template="includes/functionEnd.cfm">
								

			<cfelse><!---XML receibed is incorrect or incomplete--->
			
				<cfset xmlResponseContent = arguments.request>

				<cfset error_code = 1002>
				
				<cfthrow errorcode="#error_code#">
				
			</cfif>
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
	
	<!--- ----------------------- createUserReplaceFileTicket -------------------------------- --->
	
	<!---Este método es para reemplazar archivos en mis documentos, modifica el archivo en base de datos para cambiar el estado y que indique que está a la espera de ser reemplazado. Si no se reemplaza el archivo no pasa nada, por este estado no afecta al global del archivo, y el archivo no se elimina hasta que se reemplaza.--->
	
	<!---
	request:
	<request>
		<parameters>
			<file>
				<name></name>
				<description></description>
			</file>
			<folder id=""></folder>	
		</parameters>
	</request>
	response:
	<response component="FileManager" method="createUserFileTicket" status="ok">
		<result>
			<file id=""/>	
		</result>
	</response>
	--->
	
	
	<cffunction name="createUserReplaceFileTicket" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		<!---Este parametro se le pasa cuando se adjunta un archivo a un mensaje, que primero se crea el mensaje y luego se sube--->

		<cfset var method = "createUserReplaceFileTicket">
		
		<cfset var file_id = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
		
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
		
			<cfquery name="updateStateFile" datasource="#client_dsn#">
				UPDATE #client_abb#_files
				SET status_replacement = 'pending'
				WHERE id=<cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
						
			<cfset xmlResult = '<file id="#file_id#" status="pending"/>'>
			
			<cfset xmlResponseContent = xmlResult>
			
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>
	
	
		
	<!--- ----------------------- DELETE IMAGE FILE -------------------------------- --->
	
	<cffunction name="deleteImageFile" returntype="string" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		<!---<cfargument name="file_id" type="string" required="yes">--->
		
		<cfset var method = "deleteImageFile">
		
		<cfset var file_id = "">
		
		<cfset var files_table = "">
		<cfset var files_directory = "">
		<cfset var association_table = "">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfset file_id = xmlRequest.request.parameters.file.xmlAttributes.id>
			<cfset type = xmlRequest.request.parameters.image_type>
			
			<cfswitch expression="#type#">
			
				<cfcase value="area_image">
					<cfset files_table = "areas_images">
					<cfset files_directory = "areas_images">
					<cfset association_table = "areas">
					
				</cfcase>
				
				<cfcase value="user_image">
					<cfset files_table = "users_images">
					<cfset files_directory = "users_images">
					<cfset association_table = "users">
					
				</cfcase>
			
			</cfswitch>
			
			
			<!--- Query to get the physical name and file_size of the file --->
			<cfquery name="getFileQuery" datasource="#client_dsn#">				
				SELECT physical_name, file_size, user_in_charge
				FROM #client_abb#_#files_table#
				WHERE id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getFileQuery.recordCount GT 0>

				<cfif getFileQuery.user_in_charge NEQ user_id><!---El usuario del item no es el mismo que el que intenta eliminar--->
					<cfinclude template="includes/checkAdminAccess.cfm">
				</cfif>

				<cftransaction>
					
					<!--- Delete association --->
					<cfquery name="deleteAssociationAreaQuery" datasource="#client_dsn#">
						UPDATE #client_abb#_#association_table#
						SET image_id = <cfqueryparam null="yes" cfsqltype="cf_sql_numeric">
						WHERE image_id = <cfqueryparam value="#file_id#" cfsqltype="cf_sql_integer">;
					</cfquery>			
					
					<!--- Deletion of the row representing the file --->
					<cfquery name="deleteFileQuery" datasource="#client_dsn#">		
						DELETE
						FROM #client_abb#_#files_table#
						WHERE id = <cfqueryparam value="#file_id#" CFSQLType="CF_SQL_integer">;
					</cfquery>
					
					<cfset path = APPLICATION.filesPath&'/#client_abb#/#files_directory#/'>	
					<cfset filePath = path & "#getFileQuery.physical_name#">			
					
					<!--- Now we delete physically the file on the server --->
					<cfif FileExists(filePath)><!---If the physical file exist--->
						<cffile action="delete" file="#filePath#">
					<cfelse><!---The physical file does not exist--->
						<cfset error_code = 608>
					
						<cfthrow errorcode="#error_code#">
					</cfif>
					
					<!---Update User Space Used--->
					<cfquery name="updateUserSpaceUsed" datasource="#client_dsn#">
						UPDATE #client_abb#_users
						SET space_used = space_used-#getFileQuery.file_size#
						WHERE id = #user_id#;
					</cfquery>	
				
				</cftransaction>
			
				<cfset xmlResponseContent = '<file id="#file_id#" />'>
				
				<cfinclude template="includes/functionEnd.cfm">
			
			
			<cfelse><!---The file does not exist (is not found)--->
			
				<cfset xmlResponseContent = arguments.request>
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
							
			</cfif>		
		

			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>		
		
	</cffunction>

	
	
	<!--- ----------------GET ALL AREAS FILES--------------------------------------------   --->
	
	<cffunction name="getAllAreasFiles" output="false" returntype="struct" access="public">
		<cfargument name="search_text" type="string" required="no">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="format_content" type="string" required="no" default="default">
		<cfargument name="with_area" type="boolean" required="no" default="false">
		<cfargument name="limit" type="numeric" required="no">
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
		
		<cfset var method = "getAllAreasFiles">

		<cfset var response = structNew()>

		<cftry>
				
			<cfinclude template="includes/functionStartOnlySession.cfm">
						
			<cfinvoke component="AreaManager" method="getAllUserAreasList" returnvariable="user_areas_ids">
				<cfinvokeargument name="get_user_id" value="#user_id#">
			</cfinvoke>
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getAreaFiles" returnvariable="getAreaFilesResult">
				<cfinvokeargument name="areas_ids" value="#user_areas_ids#">
				<cfinvokeargument name="parse_dates" value="true">
				<cfif isDefined("arguments.search_text")>
					<cfinvokeargument name="search_text" value="#arguments.search_text#">
				</cfif>
				<cfif isDefined("arguments.user_in_charge")>
					<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
				</cfif>
				<cfinvokeargument name="with_user" value="true">
				<cfinvokeargument name="with_area" value="#arguments.with_area#">
				<cfif isDefined("arguments.limit")>
				<cfinvokeargument name="limit" value="#arguments.limit#">
				</cfif>
				
				<cfif isDefined("arguments.from_date")>
				<cfinvokeargument name="from_date" value="#arguments.from_date#">
				</cfif>
				<cfif isDefined("arguments.end_date")>
				<cfinvokeargument name="end_date" value="#arguments.end_date#">
				</cfif>				
				
				<!---<cfif APPLICATION.moduleAreaFilesLite IS true>
					<cfinvokeargument name="with_area_files_lite" value="true">
				</cfif>--->

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfset response = {result=true, files=#getAreaFilesResult.query#}>	

			<!---<cfset areaFilesQuery = getAreaFilesResult.query>
			
			<cfset xmlItems=''>
			<cfif areaFilesQuery.recordCount GT 0>
					
				<cfset xmlItems = '<files>'>
					
				<cfloop query="areaFilesQuery">
					
					<cfinvoke component="FileManager" method="objectFile" returnvariable="xmlResultItem">
						<cfinvokeargument name="id" value="#areaFilesQuery.id#">
						<cfinvokeargument name="name" value="#areaFilesQuery.name#">
						<cfinvokeargument name="user_in_charge" value="#areaFilesQuery.user_in_charge#">
						<cfinvokeargument name="association_date" value="#areaFilesQuery.association_date#">
						<cfinvokeargument name="replacement_date" value="#areaFilesQuery.replacement_date#">
						<cfinvokeargument name="user_full_name" value="#areaFilesQuery.family_name# #areaFilesQuery.user_name#">
						<cfinvokeargument name="file_type" value="#areaFilesQuery.file_type#">
						
						<!---<cfinvokeargument name="description" value="#areaFilesQuery.description#">--->
						
						<cfif arguments.with_area IS true>
							<cfinvokeargument name="area_name" value="#areaFilesQuery.area_name#">
							<cfinvokeargument name="area_id" value="#areaFilesQuery.area_id#">	
						</cfif>

						<cfinvokeargument name="return_type" value="xml">
					</cfinvoke>
					
					<cfset xmlItems = xmlItems&xmlResultItem>
					
				</cfloop>

				<cfset xmlItems = xmlItems&'</files>'>

			<cfelse>	
				<cfset xmlItems='<files/>'>	
			</cfif>			
						
			<cfset xmlResponseContent = xmlItems>
					
			<cfset xmlResponse = xmlResponseContent>
		
		<cfreturn xmlResponse>--->

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->	
	
	
	
	<!--- ----------------------------------- uploadNewFile -------------------------------------- --->

	<cffunction name="uploadNewFile" output="false" returntype="struct" access="public">
		<cfargument name="fileTypeId" type="numeric" required="true"/>
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="description" type="string" required="true"/>
		<cfargument name="Filedata" type="string" required="true"/>
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="typology_id" type="string" required="false">

		<cfset var method = "uploadNewFile">

		<cfset var response = structNew()>

		<!---<cfset var folder_id = "">--->
		<cfset var upload_file_id = "">
					
		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">
		
			<!---Esto es para la asociación de archivos directamente desde las áreas--->
			<!---
			Los directorios de los usuarios ya no se usan
			<cfinvoke component="#APPLICATION.componentsPath#/FolderManager" method="getUserRootFolderId" returnvariable="root_folder_id">
			</cfinvoke>		
			<cfset folder_id = root_folder_id>--->

			<cfset destination = '#APPLICATION.filesPath#/#client_abb#/files/'>

			<cffile action="upload" filefield="Filedata" destination="#destination#" nameconflict="overwrite" result="uploadedFile">
		
			<cfset temp_file="#uploadedFile.clientFileName#.#uploadedFile.clientFileExt#">	
			
			<cfinvoke component="FileManager" method="createFile" returnvariable="createFileResult">
				<cfinvokeargument name="fileTypeId" value="#arguments.fileTypeId#"/>
				<cfinvokeargument name="name" value="#arguments.name#"/>
				<cfinvokeargument name="file_name" value="#uploadedFile.clientFileName#.#uploadedFile.clientFileExt#"/>
				<cfinvokeargument name="file_type" value=".#uploadedFile.clientFileExt#"/>
				<cfinvokeargument name="file_size" value="#uploadedFile.fileSize#"/>
				<cfinvokeargument name="description" value="#arguments.description#"/>
				<cfinvokeargument name="status" value="ok">

				<cfinvokeargument name="area_id" value="#arguments.area_id#"/>
				<!---<cfinvokeargument name="folder_id" value="#folder_id#"/>--->
			</cfinvoke>	

			<cfif createFileResult.result IS true AND isDefined("createFileResult.objectFile.id") AND isNumeric(createFileResult.objectFile.id)>
				
				<cftry>
					
					<cfset objectFile = createFileResult.objectFile>

					<cfset upload_file_id = createFileResult.objectFile.id>

					<!--- setFileTypology --->
					<cfif isDefined("arguments.typology_id") AND isNumeric(arguments.typology_id)>

						<cfset arguments.file_id = upload_file_id>
						
						<cfinvoke component="FileManager" method="setFileTypology" argumentcollection="#arguments#" returnvariable="setFileTypologyResponse">
						</cfinvoke>

						<cfif setFileTypologyResponse.result IS false>

							<cfthrow message="#setFileTypologyResponse.message#">
		
						</cfif>

					</cfif>		


					<!--- associateFileToArea --->
					<cfinvoke component="FileManager" method="associateFileToArea">
						<cfinvokeargument name="objectFile" value="#objectFile#"/>
						<cfinvokeargument name="area_id" value="#arguments.area_id#"/>
					</cfinvoke>

					<!---<cfif arguments.fileTypeId IS 2>

						<!--- newAreaFile --->
						<cfinvoke component="AlertManager" method="newFile">
							<cfinvokeargument name="objectFile" value="#objectFile#">
							<cfinvokeargument name="area_id" value="#arguments.area_id#">
							<cfinvokeargument name="action" value="new">
							<cfinvokeargument name="fileTypeId" value="#arguments.fileTypeId#">
						</cfinvoke>

					</cfif>--->
							
					<!--- ------------------ Update User Space Used --------------------- --->
					<cfquery name="updateSpaceUsed" datasource="#client_dsn#">
						UPDATE #client_abb#_users
						SET space_used = space_used+<cfqueryparam value="#uploadedFile.fileSize#" cfsqltype="cf_sql_integer">
						WHERE id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">;
					</cfquery>

					<cffile action="rename" source="#destination##temp_file#" destination="#destination##upload_file_id#">

					<cfcatch><!---The upload fail--->

						<cfif isDefined("upload_file_id")>
							<cfquery datasource="#client_dsn#" name="changeFileStatus">
								UPDATE #client_abb#_files
								SET status = <cfqueryparam value="failed" cfsqltype="cf_sql_varchar">
								WHERE id = <cfqueryparam value="#upload_file_id#" cfsqltype="cf_sql_integer">;
							</cfquery>
						</cfif>

						<cffile action="delete" file="#destination##temp_file#">
						
						<!---<cfset error_code = 604>--->
				
						<cfthrow object="#cfcatch#">
					
					</cfcatch>
				</cftry>

				<cfset response = {result=true, file_id=#upload_file_id#}>	

			<cfelse><!---File insert fail--->
			
				<cffile action="delete" file="#destination##temp_file#">
			
				<cfset error_code = 602>
				
				<cfthrow errorcode="#error_code#">
			
			</cfif>
		
			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>



	<!--- ----------------------------------- replaceFile -------------------------------------- --->

	<cffunction name="replaceFile" output="false" returntype="struct" access="public">
		<cfargument name="file_id" type="string" required="true"/>
		<cfargument name="Filedata" type="string" required="true"/>
		
		<cfset var method = "replaceFile">

		<cfset var response = structNew()>

		<cfset var destination = '#APPLICATION.filesPath#/#client_abb#/files/'>
					
		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="objectFile" returnvariable="objectFile">
				<cfinvokeargument name="id" value="#arguments.file_id#"/>
				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>

			<cfquery name="getFile" datasource="#client_dsn#">
				SELECT *
				FROM #client_abb#_files
				WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">
				AND status = 'ok';
				<!---AND user_in_charge = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">--->
			</cfquery>--->

			<!--- getFile --->
			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="getFile">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
				<cfif APPLICATION.moduleAreaFilesLite IS true>
					<cfinvokeargument name="with_lock" value="true">
				</cfif>
				<cfinvokeargument name="parse_dates" value="true">		

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
		
			<cfif getFile.recordCount GT 0>

				<cfif getFile.file_type_id IS 1><!---User file--->
						
					 <cfif getFile.user_in_charge NEQ user_id>
					 	<cfthrow message="No tiene permiso para reemplazar este archivo">
					 </cfif>

				<cfelse><!---Area file--->

					<cfset area_id = getFile.area_id>

					<!---checkAreaAccess--->
					<cfinclude template="includes/checkAreaAccess.cfm">

				</cfif>

				<cfif getFile.locked IS true AND getFile.lock_user_id NEQ user_id>

					<cfset response = {result=false, file_id=#arguments.file_id#, message="El archivo está bloqueado y no puede ser reemplazado"}>

				<cfelseif getFile.locked IS false AND getFile.file_type_id IS 2>

					<cfset response = {result=false, file_id=#arguments.file_id#, message="Debe bloquear el archivo para poder reemplazarlo"}>

				<cfelse>

					<cftransaction>
					
						<!---<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="getCurrentDateTime" returnvariable="current_date">
						</cfinvoke>
						
						<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringCurrentDate">
							<cfinvokeargument name="timestamp_date" value="#current_date#">
						</cfinvoke>
						
						<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringDateUpload">
							<cfinvokeargument name="timestamp_date" value="#getFile.uploading_date#">
						</cfinvoke>
						
						<cfset objectFile.name = getFile.name>
						<cfset objectFile.physical_name = getFile.physical_name>
						<cfset objectFile.uploading_date = stringDateUpload>
						
						<cfset objectFile.replacement_date = stringCurrentDate>
						<cfset objectFile.user_in_charge = user_id>--->
						
						<cffile action="delete" file="#destination##getFile.physical_name#">	
						
						<cffile action="upload" filefield="Filedata" destination="#destination#" nameconflict="overwrite" result="uploadedFile">
						
						<cfset file_name = "#uploadedFile.clientFileName#.#uploadedFile.clientFileExt#">
						<cfset file_type = lCase(".#uploadedFile.clientFileExt#")>
						<cfset file_size_full = "#uploadedFile.fileSize#">
						
						<cfset temp_file="#uploadedFile.clientFileName#.#uploadedFile.clientFileExt#">
						
						<cfquery name="updateUploadingFile" datasource="#client_dsn#">
							UPDATE #client_abb#_files
							SET replacement_date = NOW(), 
							file_size = <cfqueryparam value="#file_size_full#" cfsqltype="cf_sql_integer">,
							file_type = <cfqueryparam value="#file_type#" cfsqltype="cf_sql_varchar">,
							file_name = <cfqueryparam value="#file_name#" cfsqltype="cf_sql_varchar">,
							status = 'ok',
							status_replacement = 'uploaded'
							WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
						</cfquery>
						
						<!--- ------------------ Update User Space Used --------------------- --->
						<cfquery name="updateSpaceUsed" datasource="#client_dsn#">
							UPDATE #client_abb#_users
							SET space_used = space_used-#getFile.file_size#+<cfqueryparam value="#file_size_full#" cfsqltype="cf_sql_integer">
							WHERE id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">;
						</cfquery>
					
					</cftransaction>

					<cftry>
						
						<cffile action="rename" source="#destination##temp_file#" destination="#destination##getFile.physical_name#">

						<!--- getFile --->
						<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="fileReplacedQuery">
							<cfinvokeargument name="file_id" value="#arguments.file_id#">
							<cfinvokeargument name="with_lock" value="false">
							<cfinvokeargument name="parse_dates" value="true">		

							<cfinvokeargument name="client_abb" value="#client_abb#">
							<cfinvokeargument name="client_dsn" value="#client_dsn#">
						</cfinvoke>

						<cfif fileReplacedQuery.recordCount IS 0><!---File does not exist--->
			
							<cfset error_code = 601>
						
							<cfthrow errorcode="#error_code#">

						</cfif>
					
						<cfcatch><!---The upload fail--->
						
							<cfquery datasource="#client_dsn#" name="changeFileStatus">
								UPDATE #client_abb#_files
								SET status = 'failed'
								WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
							</cfquery>
							
							<cfset error_code = 604>
					
							<cfthrow errorcode="#error_code#">
						
						</cfcatch>
					</cftry>

					<cfinclude template="includes/logRecord.cfm">

					<!--- Alert --->
					<cfinvoke component="AlertManager" method="replaceFile">
						<cfinvokeargument name="objectFile" value="#fileReplacedQuery#">
					</cfinvoke>
				
					<cfset response = {result=true, file_id=#arguments.file_id#}>

				</cfif>
								
			<cfelse><!---File does not exist--->
			
				<cfset error_code = 601>
				
				<cfthrow errorcode="#error_code#">
				
			</cfif>

		
			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>
	

	<!--- ----------------------------------- setFileTypology -------------------------------------- --->

	<cffunction name="setFileTypology" output="false" returntype="struct" access="public">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="table_id" type="numeric" required="true">
		<cfargument name="tableTypeId" type="numeric" required="true">
		<cfargument name="action" type="string" required="true">

		<cfset var method = "setFileTypology">

		<cfset var response = structNew()>
					
		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="RowManager" method="saveRow" argumentcollection="#arguments#" returnvariable="response">
			</cfinvoke>

			<cfif response.result IS true AND arguments.action IS "create">

				<cfquery datasource="#client_dsn#" name="setFileTypology">
					UPDATE #client_abb#_files
					SET typology_id = <cfqueryparam value="#response.table_id#" cfsqltype="cf_sql_integer">,
					typology_row_id = <cfqueryparam value="#response.row_id#" cfsqltype="cf_sql_integer">
					WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>



	<!--- ----------------------------------- changeFileUser -------------------------------------- --->

	<cffunction name="changeFileUser" output="false" returntype="struct" access="public">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="new_user_in_charge" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="false"><!--- area_id NOT required when changes item file or image --->

		<cfset var method = "changeFileUser">

		<cfset var response = structNew()>
					
		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="fileQuery">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
				<cfif isDefined("arguments.area_id")>
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfif>
				<cfinvokeargument name="parse_dates" value="true">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfif fileQuery.recordCount IS 0><!---File does not exist--->
			
				<cfset error_code = 601>
			
				<cfthrow errorcode="#error_code#">

			</cfif>					

			<cfif fileQuery.user_in_charge NEQ user_id>
				
				<cfif isDefined("arguments.area_id")>
					<!---checkAreaResponsibleAccess--->
					<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
						<cfinvokeargument name="area_id" value="#area_id#">
					</cfinvoke>
				<cfelse>
					<!---checkAdminAccess--->
					<cfinvoke component="AreaManager" method="checkAdminAccess">
					</cfinvoke>
				</cfif>
				
			</cfif>

			<cfif fileQuery.locked IS true>

				<cfset response = {result=false, file_id=#arguments.file_id#, message="El archivo está bloqueado y no puede ser modificado"}>
				<cfreturn response>

			</cfif>

			<cfif fileQuery.user_in_charge EQ arguments.new_user_in_charge>
				
				<cfthrow message="El usuario seleccionado es el propietario del archivo">

			</cfif>			

			<cftransaction>
				
				<cfquery datasource="#client_dsn#" name="changeFileUserInCharge">
					UPDATE #client_abb#_files
					SET user_in_charge = <cfqueryparam value="#arguments.new_user_in_charge#" cfsqltype="cf_sql_integer">
					WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

				<cfquery name="updateOldUserSpaceUsed" datasource="#client_dsn#">
					UPDATE #client_abb#_users
					SET space_used = space_used - #fileQuery.file_size#
					WHERE id = <cfqueryparam value="#fileQuery.user_in_charge#" cfsqltype="cf_sql_integer">;
				</cfquery>

				<cfquery name="updateNewUserSpaceUsed" datasource="#client_dsn#">
					UPDATE #client_abb#_users
					SET space_used = space_used + #fileQuery.file_size#
					WHERE id = <cfqueryparam value="#arguments.new_user_in_charge#" cfsqltype="cf_sql_integer">;
				</cfquery>

			</cftransaction>

			<cfif isDefined("arguments.area_id")>
				
				<!---Send Alert--->
				<cfinvoke component="AlertManager" method="changeFileUser">
					<cfinvokeargument name="objectFile" value="#fileQuery#">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="old_user_id" value="#fileQuery.user_in_charge#">
					<cfinvokeargument name="new_user_id" value="#arguments.new_user_in_charge#">
				</cfinvoke>	

			</cfif>
			

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, file_id=#arguments.file_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>



	<!--- ----------------------------------- changeFileArea -------------------------------------- --->

	<cffunction name="changeFileArea" output="false" returntype="struct" access="public">
		<cfargument name="file_id" type="numeric" required="true">
		<cfargument name="new_area_id" type="numeric" required="true">

		<cfset var method = "changeFileArea">

		<cfset var response = structNew()>
					
		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="fileQuery">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
				<cfinvokeargument name="parse_dates" value="true">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfif fileQuery.recordCount IS 0><!---File does not exist--->
			
				<cfset error_code = 601>
			
				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfif fileQuery.user_in_charge NEQ user_id>
				
				<cfif isDefined("arguments.area_id")>
					<!---checkAreaResponsibleAccess--->
					<cfinvoke component="AreaManager" method="checkAreaResponsibleAccess">
						<cfinvokeargument name="area_id" value="#area_id#">
					</cfinvoke>
				<cfelse>
					<!---checkAdminAccess--->
					<cfinvoke component="AreaManager" method="checkAdminAccess">
					</cfinvoke>
				</cfif>
				
			</cfif>

			<cfif fileQuery.locked IS true>

				<cfset response = {result=false, file_id=#arguments.file_id#, message="El archivo está bloqueado y no puede ser modificado"}>
				<cfreturn response>

			</cfif>

			<cfif fileQuery.file_type_id IS 1>

				<cfthrow message="Para cambiar de área este tipo de archivo debe asociarlo a la nueva área y quitarlo de la actual">

			</cfif>				

			<cfif fileQuery.area_id EQ arguments.new_area_id>
				
				<cfthrow message="El archivo seleccionado es el propietario del archivo">

			</cfif>			

			<!--- associateFileToArea --->
			<cfinvoke component="FileManager" method="associateFileToArea">				
				<cfinvokeargument name="objectFile" value="#fileQuery#">
				<cfinvokeargument name="area_id" value="#arguments.new_area_id#">
			</cfinvoke>	

			<!--- dissociateFile --->
			<cfinvoke component="FileManager" method="dissociateFileFromArea">
				<cfinvokeargument name="objectFile" value="#fileQuery#"/>
				<cfinvokeargument name="area_id" value="#fileQuery.area_id#"/>
			</cfinvoke>

			<cfif fileQuery.file_type_id IS NOT 1>
				
				<!--- Change file area --->
				<cfquery datasource="#client_dsn#" name="changeFileArea">
					UPDATE #client_abb#_files
					SET area_id = <cfqueryparam value="#arguments.new_area_id#" cfsqltype="cf_sql_integer">
					WHERE id = <cfqueryparam value="#arguments.file_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

			</cfif>

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, file_id=#arguments.file_id#, new_area_id=#arguments.new_area_id#, old_area_id=#fileQuery.area_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>
	

</cfcomponent>