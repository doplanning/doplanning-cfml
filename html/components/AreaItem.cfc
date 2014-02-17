<!---Copyright Era7 Information Technologies 2007-2012

	Date of file creation: 02-10-2008
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 18-02-2013
	
--->
<cfcomponent output="true">

	<cfset component = "Item">
	<cfset request_component = "AreaItemManager">
	
	<!--- ----------------------------------- getItem -------------------------------------- --->

	<!---Este método no hay que usarlo en páginas en las que su contenido se cague con JavaScript (páginas de html_content) porque si hay un error este método redirige a otra página. En esas páginas hay que obtener el Item directamente del AreaItemManager y comprobar si result es true o false para ver si hay error y mostrarlo correctamente--->

	<cffunction name="getItem" output="false" returntype="query" access="public">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">

		<cfset var method = "getItem">

		<cfset var response = structNew()>
					
		<cftry>
	
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getItem" returnvariable="response">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				
				<!---<cfinvokeargument name="return_type" value="object">--->
				<cfinvokeargument name="return_type" value="query">
			</cfinvoke>
			
			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>									
			
		</cftry>
		
		<cfreturn response.item>
			
	</cffunction>
    


	<!--- ----------------------------------- getEmptyItem -------------------------------------- --->

	<cffunction name="getEmptyItem" output="false" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">

		<cfset var method = "getEmptyItem">

		<cfset var response = structNew()>
					
		<cftry>
	
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getEmptyItem" returnvariable="response">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#"/>
			</cfinvoke>
			
			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>									
			
		</cftry>
		
		<cfreturn response.item>
			
	</cffunction>
	
	
	
	<!--- -------------------------------createItem-------------------------------------- --->
	
	<cffunction name="createItem" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="link" type="string" required="true">
		<cfargument name="link_target" type="string" required="false">
        <cfargument name="description" type="string" required="false" default="">
        <cfargument name="parent_id" type="numeric" required="true">
        <cfargument name="parent_kind" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="true">
        <cfargument name="Filedata" type="any" required="false" default="">
		<cfargument name="imagedata" type="any" required="false" default="">
		<cfargument name="notify_by_sms" type="boolean" required="false">
		<cfargument name="post_to_twitter" type="boolean" required="false">
		<cfargument name="creation_date" type="string" required="false">
		<cfargument name="start_date" type="string" required="false">
		<cfargument name="end_date" type="string" required="false">
		<cfargument name="start_hour" type="numeric" required="false">
		<cfargument name="start_minute" type="numeric" required="false">
		<cfargument name="end_hour" type="numeric" required="false">
		<cfargument name="end_minute" type="numeric" required="false">
		<cfargument name="place" type="string" required="false">
		<cfargument name="recipient_user" type="numeric" required="false">
		<cfargument name="estimated_value" type="numeric" required="false">
		<cfargument name="real_value" type="numeric" required="false">
		<cfargument name="done" type="boolean" required="no" default="false">
		<!---<cfargument name="position" type="numeric" required="false">--->
		<cfargument name="display_type_id" type="numeric" required="false">
		<cfargument name="iframe_url" type="string" required="false">
		<cfargument name="iframe_display_type_id" type="numeric" required="false">
		<cfargument name="identifier" type="string" required="false">
		<cfargument name="structure_available" type="boolean" required="false" default="false">
		<cfargument name="general" type="boolean" required="false" default="false">
		<cfargument name="publication_scope_id" type="numeric" required="false">
		<cfargument name="publication_date" type="string" required="false">
		<cfargument name="publication_hour" type="numeric" required="false">
		<cfargument name="publication_minute" type="numeric" required="false">
		<cfargument name="publication_validated" type="boolean" required="false">
		
		<cfset var method = "createItem">
				
		<cfset var with_attached = false>
		<cfset var with_image = false>
		
		<cfset var createdItemId = "">
		
		<cfset var file_id = "">
		<cfset var file_physical_name = "">
		
		<cfset var image_id = "">
		<cfset var image_physical_name = "">
		
		<cfset var response_message = "">
		
		
		<cftry>

			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfif len(arguments.Filedata) GT 0>
				<cfset with_attached = true>
			</cfif>
            
			<cfif len(arguments.imagedata) GT 0>
				<cfset with_image = true>
			</cfif>
						
            <!---
            <cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="objectItem" returnvariable="objectItem">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
                <cfinvokeargument name="title" value="#arguments.title#">
				<cfinvokeargument name="link" value="#arguments.link#">
				<cfif isDefined("arguments.link_target")>
					<cfinvokeargument name="link_target" value="#arguments.link_target#">
				</cfif>
                <cfinvokeargument name="description" value="#arguments.description#">
                <cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">
                <cfinvokeargument name="parent_id" value="#arguments.parent_id#">
                <cfinvokeargument name="parent_kind" value="#arguments.parent_kind#">
				<!---<cfif with_attached IS false>
                	<cfinvokeargument name="attached_file_id" value="-1">
                    <cfinvokeargument name="attached_file_name" value="NULL">
         		<cfelse>
                 	<cfinvokeargument name="attached_file_id" value="NULL">
                    <cfinvokeargument name="attached_file_name" value="(Pendiente de subir el archivo)">
                </cfif>
				<cfif with_image IS false>
					<cfinvokeargument name="attached_image_id" value="-1">
					<cfinvokeargument name="attached_image_name" value="NULL">
				<cfelse>
					<cfinvokeargument name="attached_image_id" value="NULL">
                    <cfinvokeargument name="attached_image_name" value="(Pendiente de subir el archivo)">
				</cfif>--->
                <cfif isDefined("arguments.notify_by_sms")>
					<cfinvokeargument name="notify_by_sms" value="#arguments.notify_by_sms#">
				</cfif>
				<cfif isDefined("arguments.post_to_twitter")>
					<cfinvokeargument name="post_to_twitter" value="#arguments.post_to_twitter#">
				</cfif>
				<cfif isDefined("arguments.creation_date")>
					<cfinvokeargument name="creation_date" value="#arguments.creation_date#">
				</cfif>
				<cfif isDefined("arguments.start_date")>
					<cfinvokeargument name="start_date" value="#arguments.start_date#">
				</cfif>
				<cfif isDefined("arguments.end_date")>
					<cfinvokeargument name="end_date" value="#arguments.end_date#">
				</cfif>
				<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
					<cfinvokeargument name="start_time" value="#arguments.start_hour#:#arguments.start_minute#">
				</cfif>
				<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
					<cfinvokeargument name="end_time" value="#arguments.end_hour#:#arguments.end_minute#">
				</cfif>
				<cfif isDefined("arguments.place")>
					<cfinvokeargument name="place" value="#arguments.place#">
				</cfif>
				<cfif isDefined("arguments.recipient_user")>
					<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
				</cfif>
				<cfif isDefined("arguments.estimated_value")>
					<cfinvokeargument name="estimated_value" value="#arguments.estimated_value#">
				</cfif>
				<cfif isDefined("arguments.real_value")>
					<cfinvokeargument name="real_value" value="#arguments.real_value#">
				</cfif>
				<cfinvokeargument name="done" value="#arguments.done#">
				<!---<cfif isDefined("arguments.position")>
					<cfinvokeargument name="position" value="#arguments.position#">
				</cfif>--->
				<cfif isDefined("arguments.display_type_id")>
					<cfinvokeargument name="display_type_id" value="#arguments.display_type_id#">
				</cfif>
				<cfif isDefined("arguments.iframe_url")>
					<cfinvokeargument name="iframe_url" value="#arguments.iframe_url#">
				</cfif>
				<cfif isDefined("arguments.iframe_display_type_id")>
					<cfinvokeargument name="iframe_display_type_id" value="#arguments.iframe_display_type_id#">
				</cfif>
				<cfif isDefined("arguments.identifier")>
					<cfinvokeargument name="identifier" value="#arguments.identifier#">
				</cfif>
				<cfif isDefined("arguments.structure_available")>
					<cfinvokeargument name="structure_available" value="#arguments.structure_available#">
				</cfif>
				<cfif isDefined("arguments.general")>
					<cfinvokeargument name="general" value="#arguments.general#">
				</cfif>
				                                
                <cfinvokeargument name="return_type" value="object">
            </cfinvoke>--->
          
		  
         	<cfif with_attached IS true>
            	<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="objectFile" returnvariable="objectFile">		
					<cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">		
					<cfinvokeargument name="file_name" value="(Pendiente de subir el archivo)">
					<cfinvokeargument name="file_type" value="pending">
					<cfinvokeargument name="name" value=" ">
					<cfinvokeargument name="description" value=" ">
					<cfinvokeargument name="file_size" value="0">
					
					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>
				
				<!---<cfset objectFile.file_size = "0">--->
				
				<!---<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="xmlFile" returnvariable="xmlFileResult">		
						<cfinvokeargument name="objectFile" value="#objectFile#">
				</cfinvoke>--->
            </cfif>
            
			
            <!---Aunque haya imagen el elemento se crea llamando a este método, porque en el contenido del elemento se incluye que hay una imagen, lo que hace que al crearse el elemento este se marque como pendiente de subir.--->
            <cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="createItem" returnvariable="createItemResponse">
				<!--- <cfinvokeargument name="objectItem" value="#objectItem#"/> --->

				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
                <cfinvokeargument name="title" value="#arguments.title#">
				<cfinvokeargument name="link" value="#arguments.link#">
				<cfinvokeargument name="link_target" value="#arguments.link_target#">
                <cfinvokeargument name="description" value="#arguments.description#">
                <cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">
                <cfinvokeargument name="parent_id" value="#arguments.parent_id#">
                <cfinvokeargument name="parent_kind" value="#arguments.parent_kind#">
				<cfinvokeargument name="notify_by_sms" value="#arguments.notify_by_sms#">
				<cfinvokeargument name="post_to_twitter" value="#arguments.post_to_twitter#">
				<cfinvokeargument name="creation_date" value="#arguments.creation_date#">
				<cfinvokeargument name="start_date" value="#arguments.start_date#">
				<cfinvokeargument name="end_date" value="#arguments.end_date#">
				<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
					<cfinvokeargument name="start_time" value="#arguments.start_hour#:#arguments.start_minute#">
				</cfif>
				<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
					<cfinvokeargument name="end_time" value="#arguments.end_hour#:#arguments.end_minute#">
				</cfif>
				<cfinvokeargument name="place" value="#arguments.place#">
				<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
				<cfinvokeargument name="estimated_value" value="#arguments.estimated_value#">
				<cfinvokeargument name="real_value" value="#arguments.real_value#">
				<cfinvokeargument name="done" value="#arguments.done#">
				<cfinvokeargument name="display_type_id" value="#arguments.display_type_id#">
				<cfinvokeargument name="iframe_url" value="#arguments.iframe_url#">
				<cfinvokeargument name="iframe_display_type_id" value="#arguments.iframe_display_type_id#">
				<cfinvokeargument name="identifier" value="#arguments.identifier#">
				<cfinvokeargument name="structure_available" value="#arguments.structure_available#">
				<cfinvokeargument name="general" value="#arguments.general#">
				<cfinvokeargument name="publication_scope_id" value="#arguments.publication_scope_id#">
				<cfinvokeargument name="publication_date" value="#arguments.publication_date#">
				<cfif isDefined("arguments.publication_hour") AND isDefined("arguments.publication_minute")>
					<cfinvokeargument name="publication_time" value="#arguments.publication_hour#:#arguments.publication_minute#">
				</cfif>
				<cfinvokeargument name="publication_validated" value="#arguments.publication_validated#">

				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfif with_attached IS true OR with_image IS true><!---Hay archivo para subir--->
					<cfinvokeargument name="status" value="pending"/>
				</cfif>	
			</cfinvoke>

			<cfif createItemResponse.result IS true>
				<cfset createdItemId = createItemResponse.item_id>					
			<cfelse>
				<cfthrow message="#createItemResponse.message#">
			</cfif>
			
			<cfif itemTypeId IS NOT 7 OR arguments.parent_kind EQ "area">
				<cfif itemTypeGender EQ "male">
					<cfset response_message = "#itemTypeNameEs# insertado.">
				<cfelse>
					<cfset response_message = "#itemTypeNameEs# insertada.">
				</cfif>
			<cfelse><!---Consultation--->
				<cfset response_message = "Respuesta a #itemTypeNameEs# insertada.">
			</cfif>

            <cfif with_attached IS true><!---Hay archivo para subir--->

				<!---<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="createItemWithAttachedFile" returnvariable="createItemWithAttachedResponse">
					<!---<cfinvokeargument name="xmlItem" value="#xmlResultItem#"/>--->
					<cfinvokeargument name="objectItem" value="#objectItem#"/>
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#"/>	
					<cfinvokeargument name="file_name" value="#objectFile.name#">
					<cfinvokeargument name="file_file_name" value="#objectFile.file_name#">
					<cfinvokeargument name="file_type" value="#objectFile.file_type#">
					<cfinvokeargument name="file_size" value="#objectFile.file_size#">
					<cfinvokeargument name="file_description" value="#objectFile.description#">
				</cfinvoke>

				<cfif createItemWithAttachedResponse.result IS true>
					<cfset createdItemId = createItemWithAttachedResponse.objectItem.id>					
				<cfelse>
					<cfthrow message="#createItemWithAttachedResponse.message#">
				</cfif>

				<cfset file_id = createItemWithAttachedResponse.objectFile.id>
				<cfset file_physical_name = createItemWithAttachedResponse.objectFile.physical_name>--->

				<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="createFile" returnvariable="createFileResponse">
					<cfinvokeargument name="name" value="#objectFile.name#">		
					<cfinvokeargument name="file_name" value="#objectFile.file_name#">
					<cfinvokeargument name="file_type" value="#objectFile.file_type#">
					<cfinvokeargument name="file_size" value="#objectFile.file_size_full#">
					<cfinvokeargument name="description" value="#objectFile.description#">
					<cfinvokeargument name="fileTypeId" value="1">
				</cfinvoke>			
			
				<cfif createFileResponse.result IS true>
			
					<cfset file_id = createFileResponse.objectFile.id>
					<cfset file_physical_name = createFileResponse.objectFile.physical_name>
					
					<cftry>
					
						<!---Aquí el archivo se sube, pero no se marca como que se ha completado (eso se hace después en la llamada a getItemFileStatus--->
						<cfinvoke component="AreaItemFile" method="uploadItemFile">
		                    <cfinvokeargument name="item_id" value="#createdItemId#">
		                    <cfinvokeargument name="itemTypeId" value="#itemTypeId#">
		                    <cfinvokeargument name="itemTypeName" value="#itemTypeName#">
							<cfinvokeargument name="file_type" value="item_file_html">
							<cfinvokeargument name="file_id" value="#file_id#">
							<cfinvokeargument name="file_physical_name" value="#file_physical_name#">
							<cfinvokeargument name="Filedata" value="#arguments.Filedata#">
		                </cfinvoke>
						
						<cfcatch><!---Este catch se utiliza para cuando un archivo no es una imagen--->
						
							<cfset response = {result="false", message="El archivo no es una imagen. "&#cfcatch.message#, item_id=#createdItemId#}>	
							<cfreturn response>
						
						</cfcatch>
						
					</cftry>
					
				<cfelse>
				
					<cfset response_message = "Error al crear el archivo.">

					<cfset response = {result=false, message=#response_message#}>	
					<cfreturn response>
					
				</cfif>
				
					
			</cfif>
			
			<!---Subida de IMAGEN--->
			<cfif with_image IS true>
				<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="objectFile" returnvariable="objectFileImage">		
					<cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">		
					<cfinvokeargument name="file_name" value="(Pendiente de subir la imagen)">
					<cfinvokeargument name="file_type" value="pending">
					<cfinvokeargument name="name" value=" ">
					<cfinvokeargument name="description" value=" ">
					<cfinvokeargument name="file_size" value="0">
					
					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>

				<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="createFile" returnvariable="createImageResponse">
					<cfinvokeargument name="name" value="#objectFileImage.name#">		
					<cfinvokeargument name="file_name" value="#objectFileImage.file_name#">
					<cfinvokeargument name="file_type" value="#objectFileImage.file_type#">
					<cfinvokeargument name="file_size" value="#objectFileImage.file_size_full#">
					<cfinvokeargument name="description" value="#objectFileImage.description#">
					<cfinvokeargument name="fileTypeId" value="1">
				</cfinvoke>			
			
				<cfif createImageResponse.result IS true>
			
					<cfset image_id = createImageResponse.objectFile.id>
					<cfset image_physical_name = createImageResponse.objectFile.physical_name>
					
					<cftry>
					
						<!---Aquí la imagen se sube, pero no se marca como que se ha completado el proceso de creación del elemento (eso se hace después en la llamada a getItemFileStatus--->
						<cfinvoke component="AreaItemFile" method="uploadItemFile">
							<cfinvokeargument name="item_id" value="#createdItemId#">
							<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
							<cfinvokeargument name="itemTypeName" value="#itemTypeName#">
							<cfinvokeargument name="file_type" value="item_image_html">
							<cfinvokeargument name="file_id" value="#image_id#">
							<cfinvokeargument name="file_physical_name" value="#image_physical_name#">
							<cfinvokeargument name="Filedata" value="#arguments.imagedata#">
						</cfinvoke>
						
						<cfcatch><!---Este catch se utiliza para cuando un archivo no es una imagen--->
						
							<cfset response = {result="false", message="El archivo no es una imagen. "&#cfcatch.message#, item_id=#createdItemId#}>	
							<cfreturn response>
						
						</cfcatch>
						
					</cftry>
					
				<cfelse>
				
					<cfset response_message = "Error al crear la imagen.">

					<cfset response = {result=false, message=#response_message#}>	
					<cfreturn response>
					
				</cfif>
			
			</cfif>
			
			
			<!---Ahora se marca que el archivo y/o la imagen se han subido--->		
			<cfif with_attached IS true>
				<!---Obtiene el status de la subida del archivo para comprobar que se ha subido correctamente. Si se ha completado la subida, se marca el archivo y el elemento que lo lleva adjunto como subido.--->

				<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getAreaItemFileStatus" returnvariable="xmlGetFileResponseContent">
					<cfinvokeargument name="file_id" value="#file_id#">
					<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
					<cfinvokeargument name="file_type" value="file">
				</cfinvoke>
				
				<cfif itemTypeGender EQ "male">
					<cfset response_message = "#itemTypeNameEs# insertado.">
				<cfelse>
					<cfset response_message = "#itemTypeNameEs# insertada.">
				</cfif>
					

			</cfif>
			
			<cfif with_image IS true>
				
				<!---<cftry>--->
				
					<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getAreaItemFileStatus" returnvariable="xmlGetImageResponseContent">
						<cfinvokeargument name="file_id" value="#image_id#">
						<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
						<cfinvokeargument name="file_type" value="image">
						<cfif with_attached IS true><!---Esto es para que no se envíen 2 notificaciones--->
							<cfinvokeargument name="send_alert" value="false">
						<cfelse>
							<cfinvokeargument name="send_alert" value="true">
						</cfif>
					</cfinvoke>
					
					<cfif itemTypeGender EQ "male">
						<cfset response_message = "#itemTypeNameEs# insertado.">
					<cfelse>
						<cfset response_message = "#itemTypeNameEs# insertada.">
					</cfif>
					
					<!---<cfcatch>
						
						<cfset response_message = "Ha ocurrido un error al subir la imagen.">

						<cfset response = {result=false, message=#response_message#}>	
						<cfreturn response>
					
					</cfcatch>
				
				</cftry>--->
				
				
			</cfif>
			
			<cfset response = {result="true", message=#response_message#, item_id=#createdItemId#}>

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
			</cfcatch>										
			
		</cftry>

		<cfreturn response>
		
	</cffunction>
	
	<!--- -------------------------------updateItem-------------------------------------- --->

 	<cffunction name="updateItem" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="link" type="string" required="false" default="">
		<cfargument name="link_target" type="string" required="false">
        <cfargument name="description" type="string" required="true">
        <cfargument name="Filedata" type="any" required="false" default="">
		<cfargument name="imagedata" type="any" required="false" default="">
		<cfargument name="notify_by_sms" type="string" required="no">
		<cfargument name="post_to_twitter" type="boolean" required="no">
		<cfargument name="creation_date" type="string" required="no">
		<cfargument name="start_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
		<cfargument name="start_hour" type="string" required="no">
		<cfargument name="start_minute" type="string" required="no">
		<cfargument name="end_hour" type="string" required="no">
		<cfargument name="end_minute" type="string" required="no">
		<cfargument name="place" type="string" required="no">
		<cfargument name="recipient_user" type="numeric" required="no">
		<cfargument name="estimated_value" type="numeric" required="no">
		<cfargument name="real_value" type="numeric" required="no">
		<cfargument name="done" type="boolean" required="no" default="false">
		<cfargument name="position" type="numeric" required="no">
		<cfargument name="display_type_id" type="numeric" required="no">
		<cfargument name="iframe_url" type="string" required="no">
		<cfargument name="iframe_display_type_id" type="numeric" required="no">
		<cfargument name="identifier" type="string" required="false">
		<cfargument name="structure_available" type="boolean" required="false" default="false">
		<cfargument name="general" type="boolean" required="false" default="false">
		<cfargument name="publication_scope_id" type="numeric" required="false">
		<cfargument name="publication_date" type="string" required="false">
		<cfargument name="publication_hour" type="numeric" required="false">
		<cfargument name="publication_minute" type="numeric" required="false">
		<cfargument name="publication_validated" type="boolean" required="false">

		<cfset var method = "updateItem">
				
		<cfset var with_attached = false>
		<cfset var with_image = false>
				
		<cfset var file_id = "">
		<cfset var file_physical_name = "">
		
		<cfset var image_id = "">
		<cfset var image_physical_name = "">
		
		<cfset var response_message = "">
		
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfif len(arguments.Filedata) GT 0>
				<cfset with_attached = true>
			</cfif>
			
			<cfif len(arguments.imagedata) GT 0>
				<cfset with_image = true>
			</cfif>
            
			
			<!---<cfset description_html = insertBR(arguments.description)>--->
			
            <cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="objectItem" returnvariable="objectItem">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="id" value="#arguments.item_id#">
                <cfinvokeargument name="title" value="#arguments.title#">
                <cfinvokeargument name="link" value="#arguments.link#">
				<cfif isDefined("arguments.link_target")>
					<cfinvokeargument name="link_target" value="#arguments.link_target#">
				</cfif>
                <cfinvokeargument name="description" value="#arguments.description#">
                <cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">
                <cfif isDefined("arguments.notify_by_sms")>
					<cfinvokeargument name="notify_by_sms" value="#arguments.notify_by_sms#">
				</cfif>
				<cfif isDefined("arguments.post_to_twitter")>
					<cfinvokeargument name="post_to_twitter" value="#arguments.post_to_twitter#">
				</cfif>
				<cfif isDefined("arguments.creation_date")>
					<cfinvokeargument name="creation_date" value="#arguments.creation_date#">
				</cfif>
				<cfif isDefined("arguments.start_date")>
					<cfinvokeargument name="start_date" value="#arguments.start_date#">
				</cfif>
				<cfif isDefined("arguments.end_date")>
					<cfinvokeargument name="end_date" value="#arguments.end_date#">
				</cfif>
				<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
					<cfinvokeargument name="start_time" value="#arguments.start_hour#:#arguments.start_minute#">
				</cfif>
				<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
					<cfinvokeargument name="end_time" value="#arguments.end_hour#:#arguments.end_minute#">
				</cfif>
				<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
					<cfinvokeargument name="start_hour" value="#arguments.start_hour#">
					<cfinvokeargument name="start_minute" value="#arguments.start_minute#">
				</cfif>
				<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
					<cfinvokeargument name="end_hour" value="#arguments.end_hour#">
					<cfinvokeargument name="end_minute" value="#arguments.end_minute#">
				</cfif>
				<cfif isDefined("arguments.place")>
					<cfinvokeargument name="place" value="#arguments.place#">
				</cfif>
				<cfif isDefined("arguments.recipient_user")>
					<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
				</cfif>
				<cfif isDefined("arguments.estimated_value")>
					<cfinvokeargument name="estimated_value" value="#arguments.estimated_value#">
				</cfif>
				<cfif isDefined("arguments.real_value")>
					<cfinvokeargument name="real_value" value="#arguments.real_value#">
				</cfif>
				<cfinvokeargument name="done" value="#arguments.done#">
				<cfif isDefined("arguments.position")>
					<cfinvokeargument name="position" value="#arguments.position#">
				</cfif>       
				<cfif isDefined("arguments.display_type_id")>
					<cfinvokeargument name="display_type_id" value="#arguments.display_type_id#">
				</cfif> 
				<cfif isDefined("arguments.iframe_url")>
					<cfinvokeargument name="iframe_url" value="#arguments.iframe_url#">
				</cfif>
				<cfif isDefined("arguments.iframe_display_type_id")>
					<cfinvokeargument name="iframe_display_type_id" value="#arguments.iframe_display_type_id#">
				</cfif>
				<cfif isDefined("arguments.identifier")>
					<cfinvokeargument name="identifier" value="#arguments.identifier#">
				</cfif>
				<cfif isDefined("arguments.structure_available")>
					<cfinvokeargument name="structure_available" value="#arguments.structure_available#">
				</cfif>
				<cfif isDefined("arguments.general")>
					<cfinvokeargument name="general" value="#arguments.general#">
				</cfif>
					                            
                <cfinvokeargument name="return_type" value="object">
            </cfinvoke>
          
		  
         	<cfif with_attached IS true>

            	<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="objectFile" returnvariable="objectFile">		
					<cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">		
					<cfinvokeargument name="file_name" value="(Pendiente de subir el archivo)"><!---Este nombre sale en la notificación--->
					<cfinvokeargument name="file_type" value="pending">
					<cfinvokeargument name="name" value=" ">
					<cfinvokeargument name="description" value=" ">
					
					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>
				
				<cfset objectFile.file_size = "0">
			
            </cfif>
			
            <cfif with_attached IS false>
			
				<!---Aunque haya imagen el elemento se crea llamando a este método, porque en el contenido del elemento se incluye que hay una imagen, lo que hace que al crearse el elemento este se marque como pendiente de subir.--->			

                <cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="updateItem" returnvariable="updateItemResponse">
					<cfinvokeargument name="objectItem" value="#objectItem#"/>
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#"/>

					<cfinvokeargument name="publication_scope_id" value="#arguments.publication_scope_id#">
					<cfinvokeargument name="publication_date" value="#arguments.publication_date#">
					<cfif isDefined("arguments.publication_hour") AND isDefined("arguments.publication_minute")>
						<cfinvokeargument name="publication_time" value="#arguments.publication_hour#:#arguments.publication_minute#">
					</cfif>
					<cfinvokeargument name="publication_validated" value="#arguments.publication_validated#">
				</cfinvoke>

				<cfif updateItemResponse.result IS NOT true>
					<cfthrow message="#updateItemResponse.message#">
				</cfif>
				
				<cfif itemTypeGender EQ "male">
					<cfset response_message = "#itemTypeNameEs# modificado.">
				<cfelse>
					<cfset response_message = "#itemTypeNameEs# modificada.">
				</cfif>				
								
			<cfelse><!---Hay archivo para subir--->
					
				<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="updateItemWithAttachedFile" returnvariable="updateItemWithAttachedResponse">
					<cfinvokeargument name="objectItem" value="#objectItem#"/>
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#"/>
					<cfinvokeargument name="publication_scope_id" value="#arguments.publication_scope_id#">		
					<cfinvokeargument name="file_name" value="#objectFile.name#">
					<cfinvokeargument name="file_file_name" value="#objectFile.file_name#">
					<cfinvokeargument name="file_type" value="#objectFile.file_type#">
					<cfinvokeargument name="file_size" value="#objectFile.file_size#">
					<cfinvokeargument name="file_description" value="#objectFile.description#">

					<cfinvokeargument name="publication_date" value="#arguments.publication_date#">
					<cfif isDefined("arguments.publication_hour") AND isDefined("arguments.publication_minute")>
						<cfinvokeargument name="publication_time" value="#arguments.publication_hour#:#arguments.publication_minute#">
					</cfif>
					<cfinvokeargument name="publication_validated" value="#arguments.publication_validated#">
				</cfinvoke>

				<cfif updateItemWithAttachedResponse.result IS true>
					<cfset createdItemId = updateItemWithAttachedResponse.objectItem.id>					
				<cfelse>
					<cfthrow message="#updateItemWithAttachedResponse.message#">
				</cfif>

				<cfset file_id = updateItemWithAttachedResponse.objectFile.id>
				<cfset file_physical_name = updateItemWithAttachedResponse.objectFile.physical_name>
				
				<!---Aquí el archivo se sube, pero no se marca como que se ha completado (eso se hace después en la llamada a getItemFileStatus--->
				<cfinvoke component="AreaItemFile" method="uploadItemFile">
                    <cfinvokeargument name="item_id" value="#createdItemId#">
                    <cfinvokeargument name="itemTypeId" value="#itemTypeId#">
                    <cfinvokeargument name="itemTypeName" value="#itemTypeName#">
					<cfinvokeargument name="file_type" value="item_file_html">
					<cfinvokeargument name="file_id" value="#file_id#">
					<cfinvokeargument name="file_physical_name" value="#file_physical_name#">
					<cfinvokeargument name="Filedata" value="#arguments.Filedata#">
                </cfinvoke>	
				
			</cfif>
			
			
			<!---Subida de IMAGEN--->
			<cfif with_image IS true>
			
				<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="objectFile" returnvariable="objectFileImage">		
					<cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">		
					<cfinvokeargument name="file_name" value="(Pendiente de subir la imagen)">
					<cfinvokeargument name="file_type" value="pending">
					<cfinvokeargument name="name" value=" ">
					<cfinvokeargument name="description" value=" ">
					<cfinvokeargument name="file_size" value="0">
					
					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>			

				<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="createFile" returnvariable="createImageFileResponse">
					<cfinvokeargument name="name" value="#objectFileImage.name#">		
					<cfinvokeargument name="file_name" value="#objectFileImage.file_name#">
					<cfinvokeargument name="file_type" value="#objectFileImage.file_type#">
					<cfinvokeargument name="file_size" value="#objectFileImage.file_size_full#">
					<cfinvokeargument name="description" value="#objectFileImage.description#">
					<cfinvokeargument name="fileTypeId" value="1">
				</cfinvoke>			
			
				<cfif createImageFileResponse.result IS true>
			
					<cfset image_id = createImageFileResponse.objectFile.id>
					<cfset image_physical_name = createImageFileResponse.objectFile.physical_name>
					
					<cftry>
					
						<!---Aquí la imagen se sube, pero no se marca como que se ha completado el proceso de creación del elemento (eso se hace después en la llamada a getItemFileStatus--->
						<cfinvoke component="AreaItemFile" method="uploadItemFile">
							<cfinvokeargument name="item_id" value="#arguments.item_id#">
							<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
							<cfinvokeargument name="itemTypeName" value="#itemTypeName#">
							<cfinvokeargument name="file_type" value="item_image_html">
							<cfinvokeargument name="file_id" value="#image_id#">
							<cfinvokeargument name="file_physical_name" value="#image_physical_name#">
							<cfinvokeargument name="Filedata" value="#arguments.imagedata#">
						</cfinvoke>
						
						<cfcatch><!---Este catch se utiliza para cuando un archivo no es una imagen--->
							
							<!---IMPORTANTE: aquí da error si la sesión ha caducado--->
							<cfset response_message = "Ha ocurrido un error al subir el archivo. El archivo no es una imagen.">
							<!---<cfset response_message = URLEncodedFormat(response_message)>
							<cflocation url="#arguments.return_path##itemTypeNameP#.cfm?area=#arguments.area_id#&msg=#response_message#&res=0" addtoken="no">--->

							<cfset response = {result=false, message=#response_message#}>	
							<cfreturn response>
							
						</cfcatch>
						
					</cftry>
					
				<cfelse>

					<cfset response_message = "Error al crear la imagen.">

					<cfset response = {result=false, message=#response_message#}>	
					<cfreturn response>

					
				</cfif>
			
			</cfif>
			
			
			
			<!---Ahora se marca que el archivo y/o la imagen se han subido--->		
			<cfif with_attached IS true>
				<!---Obtiene el status de la subida del archivo para comprobar que se ha subido correctamente. Si se ha completado la subida, se marca el archivo y el elemento que lo lleva adjunto como subido.--->
				
				<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getAreaItemFileStatus" returnvariable="xmlGetFileResponseContent">
					<cfinvokeargument name="file_id" value="#file_id#">
					<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
					<cfinvokeargument name="file_type" value="file">
					<cfinvokeargument name="send_alert" value="true">
					<cfinvokeargument name="action" value="update">
				</cfinvoke>
				
					
				<cfif itemTypeGender EQ "male">
					<cfset response_message = "#itemTypeNameEs# modificado.">
				<cfelse>
					<cfset response_message = "#itemTypeNameEs# modificada.">
				</cfif>
				
			</cfif>
			
			
			<cfif with_image IS true>
				<!---Obtiene el status de la subida de la imagen para comprobar que se ha subido correctamente. Si se ha completado la subida, se marca el archivo y el elemento que lo lleva adjunto como subido.--->
				
				<!---<cftry>--->
				
					<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getAreaItemFileStatus" returnvariable="xmlGetImageResponseContent">
						<cfinvokeargument name="file_id" value="#image_id#">
						<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
						<cfinvokeargument name="file_type" value="image">
						<cfif with_attached IS true><!---Esto es para que no se envíen 2 notificaciones--->
							<cfinvokeargument name="send_alert" value="false">
						<cfelse>
							<cfinvokeargument name="send_alert" value="true">
						</cfif>
						<cfinvokeargument name="action" value="update">
					</cfinvoke>
					
					<cfif itemTypeGender EQ "male">
						<cfset response_message = "#itemTypeNameEs# modificado.">
					<cfelse>
						<cfset response_message = "#itemTypeNameEs# modificada.">
					</cfif>
					
					<!---<cfcatch>
						
						<!---IMPORTANTE: aquí da error si la sesión ha caducado--->

						<cfset response_message = "Ha ocurrido un error al subir la imagen.">

						<cfset response = {result=false, message=#response_message#}>	
						<cfreturn response>
					
					</cfcatch>
				
				</cftry>--->
				
			</cfif>
			 
			<cfset response = {result=true, message=#response_message#, item_id=#arguments.item_id#}>

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
			</cfcatch>										
			
		</cftry>

		<cfreturn response>
		
	</cffunction>


	<!--- ---------------------------------- changeItemUser -------------------------------------- --->
	
	<cffunction name="changeItemUser" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="new_user_in_charge" type="numeric" required="true">
		
		<cfset var method = "changeItemUser">
		
		<cfset var response = structNew()>
		
		<cftry>
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="changeItemUser" argumentcollection="#arguments#" returnvariable="response">
			</cfinvoke>
			
			<cfif response.result IS true>
				<cfset response.message = "Propietario modificado">
			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">

			</cfcatch>										
			
		</cftry>
		
		<cfreturn response>
				
	</cffunction>


	<!--- ---------------------------------- changeItemArea -------------------------------------- --->
	
	<cffunction name="changeItemArea" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="new_area_id" type="numeric" required="true">
		
		<cfset var method = "changeItemArea">
		
		<cfset var response = structNew()>
		
		<cftry>
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="changeItemArea" argumentcollection="#arguments#" returnvariable="response">
			</cfinvoke>
			
			<cfif response.result IS true>
				<cfif itemTypeGender EQ "male">
					<cfset response.message = "#itemTypeNameEs# cambiado de área.">
				<cfelse>
					<cfset response.message = "#itemTypeNameEs# cambiada de área.">
				</cfif>
			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">

			</cfcatch>										
			
		</cftry>
		
		<cfreturn response>
				
	</cffunction>
	
	
	<!--- ---------------------------------copyItemToAreas------------------------------- --->
	
	<cffunction name="copyItemToAreas" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="link" type="string" required="false" default="">
        <cfargument name="description" type="string" required="false" default="">
        <cfargument name="Filedata" type="any" required="false" default="">
		<cfargument name="imagedata" type="any" required="false" default="">
		<cfargument name="notify_by_sms" type="boolean" required="no">
		<cfargument name="post_to_twitter" type="boolean" required="no">
		<cfargument name="copy_attached_file_id" type="numeric" required="no">
		<cfargument name="copy_attached_image_id" type="numeric" required="no">				
		<cfargument name="areas_ids" type="array" required="true">
		<cfargument name="creation_date" type="string" required="no">
		<cfargument name="start_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
		<cfargument name="start_hour" type="string" required="no">
		<cfargument name="start_minute" type="string" required="no">
		<cfargument name="end_hour" type="string" required="no">
		<cfargument name="end_minute" type="string" required="no">
		<cfargument name="place" type="string" required="no">
		<cfargument name="recipient_user" type="numeric" required="no">
		<cfargument name="estimated_value" type="numeric" required="no">
		<cfargument name="real_value" type="numeric" required="no">
		<cfargument name="done" type="boolean" required="no" default="false">
		<cfargument name="position" type="numeric" required="no">
		<cfargument name="display_type_id" type="numeric" required="no">
		<cfargument name="iframe_url" type="string" required="no">
		<cfargument name="iframe_display_type_id" type="numeric" required="no">
		<cfargument name="identifier" type="string" required="no">
		
		<cfset var method = "copyItemToAreas">
		
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
		  
		  	<cfloop index="cur_area" array="#arguments.areas_ids#">
		  		
				<!---Esto habría que cambiarlo: si existe archivo, primero hay que duplicarlo y subirlo para que al crear el item se notifique que tiene un adjunto (ahora mismo en la notificacion no viene que hay un archivo adjunto)--->
				
				<cfinvoke component="AreaItem" method="createItem" returnvariable="createItemResult">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					<cfinvokeargument name="title" value="#arguments.title#">
					<cfinvokeargument name="link" value="#arguments.link#">
					<cfinvokeargument name="description" value="#arguments.description#">
					<cfinvokeargument name="parent_id" value="#cur_area#">
					<cfinvokeargument name="parent_kind" value="area">
					<cfinvokeargument name="area_id" value="#cur_area#">
					<cfinvokeargument name="Filedata" value="#arguments.Filedata#">
					<cfinvokeargument name="imagedata" value="#arguments.imagedata#">
					<!---<cfif isDefined("arguments.copy_attached_file_id")>
					<cfinvokeargument name="copy_attached_file_id" value="#FORM.copy_attached_file_id#">
					</cfif>--->
					<cfif isDefined("arguments.notify_by_sms")>
					<cfinvokeargument name="notify_by_sms" value="#arguments.notify_by_sms#">
					</cfif>
					<cfif isDefined("arguments.post_to_twitter")>
					<cfinvokeargument name="post_to_twitter" value="#arguments.post_to_twitter#">
					</cfif>
					<cfif isDefined("arguments.creation_date")>
						<cfinvokeargument name="creation_date" value="#arguments.creation_date#">
					</cfif>
					<cfif isDefined("arguments.start_date")>
						<cfinvokeargument name="start_date" value="#arguments.start_date#">
					</cfif>
					<cfif isDefined("arguments.end_date")>
						<cfinvokeargument name="end_date" value="#arguments.end_date#">
					</cfif>
					<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
						<cfinvokeargument name="start_hour" value="#arguments.start_hour#">
						<cfinvokeargument name="start_minute" value="#arguments.start_minute#">
					</cfif>
					<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
						<cfinvokeargument name="end_hour" value="#arguments.end_hour#">
						<cfinvokeargument name="end_minute" value="#arguments.end_minute#">
					</cfif>
					<cfif isDefined("arguments.place")>
						<cfinvokeargument name="place" value="#arguments.place#">
					</cfif>
					<cfif isDefined("arguments.recipient_user")>
						<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
					</cfif>
					<cfif isDefined("arguments.estimated_value")>
						<cfinvokeargument name="estimated_value" value="#arguments.estimated_value#">
					</cfif>
					<cfif isDefined("arguments.real_value")>
						<cfinvokeargument name="real_value" value="#arguments.real_value#">
					</cfif>
					<cfif isDefined("arguments.done")>
						<cfinvokeargument name="done" value="#arguments.done#">
					</cfif>
					<cfif isDefined("arguments.position")>
						<cfinvokeargument name="position" value="#arguments.position#">
					</cfif>
					<cfif isDefined("arguments.display_type_id")>
						<cfinvokeargument name="display_type_id" value="#arguments.display_type_id#">
					</cfif>
					<cfif isDefined("arguments.iframe_url")>
						<cfinvokeargument name="iframe_url" value="#arguments.iframe_url#">
					</cfif>
					<cfif isDefined("arguments.iframe_display_type_id")>
						<cfinvokeargument name="iframe_display_type_id" value="#arguments.iframe_display_type_id#">
					</cfif>
					<cfif isDefined("arguments.identifier")>
						<cfinvokeargument name="identifier" value="#arguments.identifier#">
					</cfif>
				</cfinvoke>
				
				<cfif createItemResult.result IS NOT true>
					
					<cfset response_message = "Ha ocurrido un error al copiar el #itemTypeNameEs#. #createItemResult.message#">
					<cfset response = {result="false", message=#response_message#}>
					<cfreturn response>
					
				</cfif>
			
				<!---Copia el archivo adjunto (si no se adjunta uno nuevo)--->
				<cfif len(arguments.Filedata) IS 0 AND isDefined("arguments.copy_attached_file_id")>
					<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="addFileToItem" returnvariable="objectFile">
						<cfinvokeargument name="file_id" value="#arguments.copy_attached_file_id#">
						<cfinvokeargument name="item_id" value="#createItemResult.item_id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="file_type" value="file">
					</cfinvoke>				
				</cfif>
				
				<!---Copia la imagen (si no se adjunta una nueva)--->
				<cfif len(arguments.imagedata) IS 0 AND isDefined("arguments.copy_attached_image_id")>
					<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="addFileToItem" returnvariable="objectImage">
						<cfinvokeargument name="file_id" value="#arguments.copy_attached_image_id#">
						<cfinvokeargument name="item_id" value="#createItemResult.item_id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="file_type" value="image">
					</cfinvoke>				
				</cfif>
				
			</cfloop>
		  	
			<cfif itemTypeGender IS "male">
				<cfset response_message = "#itemTypeNameEs# copiado a las áreas seleccionadas.">
			<cfelse>
				<cfset response_message = "#itemTypeNameEs# copiada a las áreas seleccionadas.">
			</cfif>
			<cfset response = {result="true", message=#response_message#}>
			<cfreturn response>			
            
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	
	
	<!--- --------------------------------tweetItem----------------------------------- --->
	
	<cffunction name="postItemToTwitter" returntype="void" access="remote">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="content" type="string" required="true">
		<cfargument name="return_path" type="string" required="true">
		
		<cfset var method = "postItemToTwitter">
		
		<cfset var response_page= "">
		<cfset var request_parameters = "">
		<cfset var msg = "">
		
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<!---<cfset request_parameters = '<#itemTypeName# id="#arguments.item_id#"/>'>
			<cfset request_parameters = request_parameters&'<area id="#arguments.area_id#"/>'>
			<cfset request_parameters = request_parameters&'<tweet><content><![CDATA[#arguments.content#]]></content></tweet>'>
			
			<cfinvoke component="Request" method="doRequest" returnvariable="xmlResponse">
				<cfinvokeargument name="request_component" value="#itemTypeNameU#Manager">
				<cfinvokeargument name="request_method" value="post#itemTypeNameU#ToTwitter">
				<cfinvokeargument name="request_parameters" value="#request_parameters#">
			</cfinvoke>--->

			<!---postItemToTwitter--->
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="postItemToTwitter">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="content" value="#arguments.content#">
			</cfinvoke>
			
			<cfif itemTypeGender EQ "male">
				<cfset msg = "#itemTypeNameEs# publicado en Twitter.">
			<cfelse>
				<cfset msg = "#itemTypeNameEs# publicada en Twitter.">
			</cfif>
			<cfset msg = URLEncodedFormat(msg)>
            
            <cflocation url="#return_path##itemTypeNameP#.cfm?area=#arguments.area_id#&msg=#msg#&res=1" addtoken="no">	
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	<cffunction name="deleteItem" returntype="void" access="remote">
		<cfargument name="item_id" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="return_page" type="string" required="true">
		
		<cfset var method = "deleteItem">
		
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfif len(arguments.item_id) IS 0 OR NOT isValid("integer",arguments.item_id)>
			
				<cfset item = "#itemTypeNameEs# incorrecto.">
				<cfset item = URLEncodedFormat(item)>
				<cflocation url="#APPLICATION.htmlPath#/#arguments.return_page#&item=#item#" addtoken="no">
			
			</cfif>
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="deleteItem" returnvariable="deleteItemResponse">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
			</cfinvoke>	

			<cfif deleteItemResponse.result IS true>

				<cfif itemTypeGender EQ "male">
					<cfset msg = "#itemTypeNameEs# eliminado.">
				<cfelse>
					<cfset msg = "#itemTypeNameEs# eliminada.">
				</cfif>
				<cfset msg = URLEncodedFormat(msg)>
            

				<cflocation url="#arguments.return_page#&msg=#msg#&res=1" addtoken="no">	

			<cfelse>

				<cfset msg = URLEncodedFormat(deleteItemResponse.message)>

				<cflocation url="#arguments.return_page#&msg=#msg#&res=0" addtoken="no">	
				
			</cfif>

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	<!--- ----------------------- DELETE ITEM ATTACHED FILE -------------------------------- --->
	
	<cffunction name="deleteItemAttachedFileRemote" returntype="void" access="remote">
		<cfargument name="item_id" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="return_page" type="string" required="true">
		
		<cfset var method = "deleteItemAttachedFile">
		
		<cfset var request_parameters = "">
		
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfif len(arguments.item_id) IS 0 OR NOT isValid("integer",arguments.item_id)>
				
				<cfif itemTypeGender EQ "male">
					<cfset msg = "#itemTypeNameEs# incorrecto.">
				<cfelse>
					<cfset msg = "#itemTypeNameEs# incorrecta.">
				</cfif>
				<cfset msg = URLEncodedFormat(msg)>
				<cflocation url="#arguments.return_page#&res=0&msg=#msg#" addtoken="no">
			
			</cfif>
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="deleteItemAttachedFile" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
			</cfinvoke>	
			
			
			<cfset msg = "Archivo eliminado.">
			<cfset msg = URLEncodedFormat(msg)>
            
            <cflocation url="#arguments.return_page#&res=1&msg=#msg#" addtoken="no">	
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	<!--- ----------------------- DELETE ITEM ATTACHED IMAGE -------------------------------- --->
	
	<cffunction name="deleteItemAttachedImageRemote" returntype="void" access="remote">
		<cfargument name="item_id" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="return_page" type="string" required="true">
		
		<cfset var method = "deleteItemAttachedImage">
		
		<cfset var request_parameters = "">
		
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfif len(arguments.item_id) IS 0 OR NOT isValid("integer",arguments.item_id)>
			
				<cfif itemTypeGender EQ "male">
					<cfset msg = "#itemTypeNameEs# incorrecto.">
				<cfelse>
					<cfset msg = "#itemTypeNameEs# incorrecta.">
				</cfif>
				<cfset msg = URLEncodedFormat(msg)>
				<cflocation url="#arguments.return_page#&res=0&msg=#msg#" addtoken="no">
			
			</cfif>
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="deleteItemAttachedImage" returnvariable="xmlResponseContent">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
			</cfinvoke>	
			
			
			<cfset msg = "Imagen eliminada.">
			<cfset msg = URLEncodedFormat(msg)>
            
            <cflocation url="#arguments.return_page#&res=1&msg=#msg#" addtoken="no">	
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>


	<!--- ------------------------------ changeItemPublicationValidation ----------------------------------- --->
	
    <cffunction name="changeItemPublicationValidation" returntype="void" access="remote">
    	<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="validate" type="boolean" required="true">
		
		<cfargument name="return_path" type="string" required="yes">
		
		<cfset var method = "changeItemPublicationValidation">

		<cfset var response = structNew()>
		
		<cftry>
					
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="changeItemPublicationValidation" returnvariable="response">
				<cfinvokeargument name="item_id" value="#arguments.item_id#"/>
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#"/>
				<cfinvokeargument name="validate" value="#arguments.validate#"/>
			</cfinvoke>
			
			<cfif response.result IS true>
				<cfif arguments.validate IS true>
					<cfset response.message = "Publicación aprobada">
				<cfelse>
					<cfset response.message = "Publicación invalidada">
				</cfif>
			</cfif>
			
			<cfset msg = URLEncodedFormat(response.message)>
			
			<cflocation url="#arguments.return_path#&res=#response.result#&msg=#msg#" addtoken="no">		
            
			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	


	<!---  ---------------------- changeAreaItemPosition -------------------------------- --->

	<cffunction name="changeAreaItemPosition" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="other_item_id" type="numeric" required="true">
		<cfargument name="other_itemTypeId" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="action" type="string" required="true"><!---increase/decrease--->
		
		<cfset var method = "changeAreaItemPosition">

		<cfset var response = structNew()>
		
		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="changeAreaItemPosition" returnvariable="response">
				<cfinvokeargument name="a_item_id" value="#arguments.item_id#">
				<cfinvokeargument name="a_itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="b_item_id" value="#arguments.other_item_id#">
				<cfinvokeargument name="b_itemTypeId" value="#arguments.other_itemTypeId#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="action" value="#arguments.action#">
			</cfinvoke>

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
			</cfcatch>										
			
		</cftry>

		<cfreturn response>
		
	</cffunction>

	
	
	<!--- ----------------------------------- getAreaItemsList ------------------------------------- --->
	
	<cffunction name="getAreaItemsList" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		
		<cfset var method = "getAreaItemsList">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
			
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAreaItems" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<!---<cfinvokeargument name="listFormat" value="true">--->
				<cfinvokeargument name="format_content" value="default">
			</cfinvoke>
			
			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn response>
		
	</cffunction>
	
	
	
	<!--- ----------------------------------- getAreaItemsTree ------------------------------------- --->
	
	<cffunction name="getAreaItemsTree" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		
		<cfset var method = "getAreaItemsTree">
		
		<cfset var request_parameters = "">
		<cfset var xmlResponse = "">
			
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAreaItemsTree" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="listFormat" value="false">
				<cfinvokeargument name="format_content" value="default">
			</cfinvoke>
			
			<cfinclude template="includes/responseHandlerStruct.cfm">
			
			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>										
			
		</cftry>

		<cfreturn response>
		
	</cffunction>
	
	

	<!--- ----------------------- GET ALL AREAS ITEMS -------------------------------- --->
	
	<cffunction name="getAllAreasItems" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="search_text" type="string" required="no">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="recipient_user" type="numeric" required="no">
		<cfargument name="limit" type="numeric" required="no">
		<cfargument name="done" type="numeric" required="no">
		<cfargument name="state" type="string" required="no">
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
				
		<cfset var method = "getAllAreasItems">
		
		<cfset var response = structNew()>
		
		<cftry>
			
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAllAreasItems" returnvariable="response">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfif isDefined("arguments.search_text")>
				<cfinvokeargument name="search_text" value="#arguments.search_text#">
				</cfif>
				<cfif isDefined("arguments.user_in_charge")>
				<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
				</cfif>
				<cfif isDefined("arguments.recipient_user")>
				<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
				</cfif>
				<cfif isDefined("arguments.limit")>
				<cfinvokeargument name="limit" value="#arguments.limit#">
				</cfif>
				<cfif isDefined("arguments.done")>
				<cfinvokeargument name="done" value="#arguments.done#">
				</cfif>
				<cfif isDefined("arguments.state")>
				<cfinvokeargument name="state" value="#arguments.state#">
				</cfif>
				<cfif isDefined("arguments.from_date")>
				<cfinvokeargument name="from_date" value="#arguments.from_date#">
				</cfif>
				<cfif isDefined("arguments.end_date")>
				<cfinvokeargument name="end_date" value="#arguments.end_date#">
				</cfif>
				<cfinvokeargument name="with_area" value="true">
			</cfinvoke>	

			<cfinclude template="includes/responseHandlerStruct.cfm">
            
			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>										
			
		</cftry>

		<cfreturn response>
		
	</cffunction>
	
	
	
	
	<!--- ----------------------- GET ALL AREA ITEMS -------------------------------- --->
	
	<cffunction name="getAllAreaItems" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="area_type" type="string" required="yes">
		<cfargument name="limit" type="numeric" required="no">
				
		<cfset var method = "getAllAreaItems">

		<cfset var response = structNew()>
		
		<cftry>
			
			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAllAreaItems" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="area_type" value="#arguments.area_type#">
				<cfif isDefined("arguments.limit")>
				<cfinvokeargument name="limit" value="#arguments.limit#">
				</cfif>
			</cfinvoke>	

			<cfinclude template="includes/responseHandlerStruct.cfm">
            
			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>										
			
		</cftry>

		<cfreturn response>
		
	</cffunction>
	
	
		
	
	<cffunction name="outputItem" returntype="void" output="true" access="public">
		<cfargument name="objectItem" type="object" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="itemTypeName" type="string" required="true">
		<cfargument name="area_type" type="string" required="true">
		
		<cfset var method = "outputItem">
		
		<cftry>
			
			<cfif len(objectItem.description) GT 0>
		
				<cfset objectItem.description = REReplace(objectItem.description,'[[:space:]]SIZE="',' style="font-size:',"ALL")>
			
			</cfif>
			
			<cfoutput>
				<!---<div class="div_message_page_title">#objectItem.title#</div>
				<div class="div_separator"><!-- --></div>--->
				<div class="div_message_page_message">
					<div class="div_message_page_label"><!---De:---> 
					
						<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.user_in_charge#"><cfif len(objectItem.user_image_type) GT 0>
							<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#objectItem.user_in_charge#&type=#objectItem.user_image_type#&small=" alt="#objectItem.user_full_name#" class="item_img" style="margin-right:2px;"/>									
						<cfelse>							
							<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#objectItem.user_full_name#" class="item_img_default" style="margin-right:2px;"/>
						</cfif></a>
						
						<!---<span class="text_message_page">#objectItem.user_full_name#</span>--->
						<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.user_in_charge#">#objectItem.user_full_name#</a>
					</div>
					
					<cfif itemTypeId IS 6><!---Tasks--->
						<div class="div_message_page_label"><span lang="es">Asignada a:</span> 
						
						<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.recipient_user#"><cfif len(objectItem.recipient_user_image_type) GT 0>
							<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#objectItem.recipient_user#&type=#objectItem.recipient_user_image_type#&small=" alt="#objectItem.recipient_user_full_name#" class="item_img"/>									
						<cfelse>							
							<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#objectItem.recipient_user_full_name#" class="item_img_default" />
						</cfif></a>

						<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.recipient_user#">#objectItem.recipient_user_full_name#</a></div>
					</cfif>
					
					<div class="div_message_page_label"><span lang="es">Fecha de creación:</span> <span class="text_message_page">#objectItem.creation_date#</span></div>
					<cfif itemTypeId IS NOT 1 AND itemTypeId IS NOT 7>
						<cfif len(objectItem.last_update_date) GT 0>
						<div class="div_message_page_label"><span lang="es">Fecha de última modificación:</span> <span class="text_message_page">#objectItem.last_update_date#</span></div>
						</cfif>
					</cfif>

					<cfif len(area_type) GT 0><!--- WEB --->

						<cfif len(objectItem.publication_date) GT 0>
							<div class="div_message_page_label"><span>Fecha de publicación:</span> <span class="text_message_page">#objectItem.publication_date#</span>
								<span lang="es">Hora:</span> <span class="text_message_page">#TimeFormat(objectItem.publication_time,"HH:mm")#</span>
							</div>
						</cfif>
						<cfif APPLICATION.publicationValidation IS true AND len(objectItem.publication_validated) GT 0>
							<div class="div_message_page_label"><span>Publicación aprobada:</span> <span class="text_message_page" lang="es"><cfif objectItem.publication_validated IS true>Sí<cfelse><b>No</b></cfif></span>
							</div>
						</cfif>

					</cfif>
					
					<cfif itemTypeId IS 7><!---Consultation--->
					<div class="div_message_page_label"><span lang="es">Estado:</span> <span class="text_message_page" lang="es"><cfswitch expression="#objectItem.state#">
							<cfcase value="created">Enviada</cfcase>
							<cfcase value="read">Leída</cfcase>
							<cfcase value="answered">Respondida</cfcase>
							<cfcase value="closed"><strong lang="es">Cerrada</strong></cfcase>
						</cfswitch></span></div>
						
						<cfif objectItem.state NEQ "read">
							<div class="div_message_page_label"><span lang="es">Fecha de <cfswitch expression="#objectItem.state#"><cfcase value="created">envío</cfcase>
								<cfcase value="read">lectura</cfcase>
								<cfcase value="answered">respuesta</cfcase>
								<cfcase value="closed">cierre</cfcase>
							</cfswitch>:</span> <span class="text_message_page">#objectItem.last_update_date#</span></div>
						</cfif>
					</cfif>
					
					<!---<div class="div_message_page_date"></div>--->
					<cfif itemTypeId IS 5 OR itemTypeId IS 6><!---Events, Tasks--->
					<div class="div_message_page_label"><span lang="es">Fecha de inicio<cfif itemTypeId IS 5> del evento</cfif>:</span> <span class="text_message_page">#<!---DateFormat(--->objectItem.start_date<!---,APPLICATION.dateFormat)--->#</span>
					<cfif itemTypeId IS 5><span lang="es">Hora:</span> <span class="text_message_page">#TimeFormat(objectItem.start_time,"HH:mm")#</span></cfif>
					</div>
					<div class="div_message_page_label"><span lang="es">Fecha de fin<cfif itemTypeId IS 5> del evento</cfif>:</span> <span class="text_message_page">#<!---DateFormat(--->objectItem.end_date<!---,APPLICATION.dateFormat)--->#</span> 
					<cfif itemTypeId IS 5><span lang="es">Hora:</span> <span class="text_message_page">#TimeFormat(objectItem.end_time,"HH:mm")#</span></cfif>
					</div>
					
						<cfif itemTypeId IS 5><!---Events--->
						<div class="div_message_page_label"><span lang="es">Lugar:</span> <span class="text_message_page">#objectItem.place#</span></div>
						<cfelse><!---Tasks--->
						<div class="div_message_page_label"><span lang="es">Valor estimado:</span> <span class="text_message_page">#objectItem.estimated_value#</span></div>
						<div class="div_message_page_label"><span lang="es">Valor real:</span> <span class="text_message_page">#objectItem.real_value#</span></div>
						<div class="div_message_page_label"><span lang="es">Realizada:</span> <span class="text_message_page"><cfif objectItem.done IS true>Sí<cfelse>No</cfif></span></div>
						</cfif>
					
					</cfif>				
					
							
					<cfif isNumeric(objectItem.attached_file_id)>
					<div class="div_message_page_label"><span lang="es">Archivo:</span> <a href="#APPLICATION.htmlPath#/file_download.cfm?id=#objectItem.attached_file_id#&#itemTypeName#=#objectItem.id#" onclick="return downloadFileLinked(this,event)">#objectItem.attached_file_name#</a></div>
					</cfif>
					<cfif arguments.itemTypeId IS NOT 1 AND isNumeric(objectItem.attached_image_id)>
					<div class="div_message_page_label"><span lang="es">Imagen:</span> <a href="#APPLICATION.htmlPath#/file_download.cfm?id=#objectItem.attached_image_id#&#itemTypeName#=#objectItem.id#" onclick="return downloadFileLinked(this,event)">#objectItem.attached_image_name#</a></div>
					</cfif>
					
					
									
					<cfif len(objectItem.link) GT 0>
					<div class="div_message_page_label"><span lang="es"><cfif itemTypeId IS 3>URL del enlace<cfelse>Más información</cfif>:</span><br/> <a href="#objectItem.link#" target="_blank">#objectItem.link#</a></div>
					</cfif>
					<cfif isDefined("objectItem.iframe_url") AND len(objectItem.iframe_url) GT 0>
					<div class="div_message_page_label"><span lang="es">URL contenido incrustado:</span><br/> <a href="#objectItem.iframe_url#" target="_blank">#objectItem.iframe_url#</a></div>
					</cfif>
					
					<cfif isDefined("objectItem.identifier") AND len(objectItem.identifier) GT 0>
					<div class="div_message_page_label"><span lang="es">Identificador:</span> <span class="text_message_page">#objectItem.identifier#</span></div>
					</cfif>
					
					<div class="div_message_page_label"><span lang="es"><cfif itemTypeId IS 3>Descripción<cfelse>Contenido</cfif>:</span></div> 
					<div class="div_message_page_description">#objectItem.description#</div>

					<cfif APPLICATION.publicationScope IS true AND itemTypeId IS 11 OR itemTypeId IS 12>

						<div class="div_message_page_label">Ámbito de publicación: <span class="text_message_page">#objectItem.publication_scope_name#</span></div>

					</cfif>

					<!---itemUrl--->
					<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getAreaItemUrl" returnvariable="areaItemUrl">
						<cfinvokeargument name="item_id" value="#objectItem.id#">
						<cfinvokeargument name="itemTypeName" value="#itemTypeName#">
						<cfinvokeargument name="area_id" value="#objectItem.area_id#">

						<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
					</cfinvoke>

					<div class="div_message_page_label"><span lang="es">URL en DoPlanning:</span></div>
					<input type="text" value="#areaItemUrl#" onClick="this.select();" class="form-control" readonly="readonly" style="cursor:text"/>

					<cfif SESSION.client_abb EQ "hcs"><!---DoPlanning HCS--->

						<cfif (area_type EQ "web" OR area_type EQ "intranet") AND (itemTypeId IS 4 OR itemTypeId IS 5)>

							<!---itemWebUrl--->
							<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getItemWebPage" returnvariable="itemPage">
								<cfinvokeargument name="item_id" value="#objectItem.id#">
								<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
								<cfinvokeargument name="title" value="#objectItem.title#">
							</cfinvoke>
							<cfset itemWebUrl = "/#area_type#/#itemPage#">

							<div class="div_message_page_label"><span lang="es">URL relativa en la #area_type#:</span></div>
							<input type="text" value="#itemWebUrl#" onClick="this.select();" class="form-control" readonly="readonly" style="cursor:text"/>
						</cfif>
						
					</cfif>
				</div>
			</cfoutput>								
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	<cffunction name="outputItemsList" returntype="void" output="true" access="public">
		<cfargument name="itemsQuery" type="query" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="full_content" type="boolean" required="no" default="false">
		<cfargument name="return_page" type="string" required="no">
		<cfargument name="app_version" type="string" required="true">
		
		<cfset var method = "outputItemsList">

		<cftry>
		
			<!---Required vars
				page_type
				
				page_types:

			--->
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfset numItems = itemsQuery.recordCount>
			
			<cfif numItems GT 0>
			
				<script type="text/javascript">
					$(document).ready(function() { 
						
						<!---$.tablesorter.addParser({
							id: "datetime",
							is: function(s) {
								return false; 
							},
							format: function(s,table) {
								s = s.replace(/\-/g,"/");
								s = s.replace(/(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})/, "$3/$2/$1");
								return $.tablesorter.formatFloat(new Date(s).getTime());
							},
							type: "numeric"
						});--->
						
						$("##listTable").tablesorter({ 
							<cfif arguments.full_content IS false>
							widgets: ['zebra','filter','select'],
							<cfelse>
							widgets: ['zebra','select'],
							</cfif>
							
							<cfif itemTypeId IS 6><!---Tasks--->
								<cfif arguments.full_content IS false>
								sortList: [[8,1]] ,
								<cfelse>
								sortList: [[8,0]] , <!---[9,0]] ,--->
								</cfif>
							<cfelseif arguments.full_content IS true>
								sortList: [[4,1]] ,							
							<cfelseif itemTypeId IS 2 OR itemTypeId IS 3><!---Entries, Links Order by position--->
								sortList: [[5,0]] ,
							<cfelseif itemTypeId IS 4><!---News Order by position--->
								sortList: [[5,1]] ,
							<cfelse>
								sortList: [[4,1]] ,
							</cfif>
							headers: { 
								<cfif itemTypeId IS NOT 6>
								0: { 
									sorter: false 
								},
								4: { 
									sorter: "datetime" 
								}
								<cfelse><!---Tasks--->
									<!---<cfif arguments.full_content IS false>
									7: { 
										sorter: "datetime" 
									}
									<cfelse>--->
									7: { 
										sorter: "datetime" 
									},
									8: { 
										sorter: "datetime" 
									}
									<!---</cfif>--->
								</cfif>
							}
							<cfif arguments.full_content IS false>
							, widgetOptions : {
								filter_childRows : false,
								filter_columnFilters : true,
								filter_cssFilter : 'tablesorter-filter',
								filter_filteredRow   : 'filtered',
								filter_formatter : null,
								filter_functions : null,
								filter_hideFilters : false,
								filter_ignoreCase : true,
								filter_liveSearch : true,
								//filter_reset : 'button.reset',
								filter_searchDelay : 300,
								filter_serversideFiltering: false,
								filter_startsWith : false,
								filter_useParsedData : false
						    }
						   </cfif>
						});
						
						//  Adds "over" class to rows on mouseover
						$("##listTable tr").mouseover(function(){
						  $(this).addClass("over");
						});
					
						//  Removes "over" class from rows on mouseout
						$("##listTable tr").mouseout(function(){
						  $(this).removeClass("over");
						});
						
					}); 
				</script>
				
				
				<cfoutput>
				
				<table id="listTable" class="tablesorter">
					<thead>
						<tr>
							<cfif itemTypeId IS NOT 6>
								<th style="width:35px" class="filter-false"></th>
								<cfif arguments.full_content IS false>
									<cfif itemTypeId IS 1><!---Messages--->
										<th style="width:55%" lang="es">Asunto</th>
									<cfelseif itemTypeId IS 2 OR itemTypeId IS 3><!---Entries, Links--->
										<th style="width:49%" lang="es">Título</th>
									<cfelse>
										<th style="width:55%" lang="es">Título</th>
									</cfif>
									<th style="width:5%" class="filter-false"></th>
									<th style="width:23%" lang="es">De</th>
									<th style="width:12%" lang="es">Fecha</th>
									<cfif itemTypeId IS 5>
										<th style="width:8%" lang="es">Inicio</th>		
										<th style="width:4%" lang="es">Fin</th>
									</cfif>
									<cfif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News--->
									<th style="width:6%" class="filter-false">##</th>
									</cfif>
								<cfelse>
									<th style="width:39%" lang="es"><cfif itemTypeId IS 1>Asunto<cfelse>Título</cfif></th>
									<th style="width:5%" class="filter-false"></th>
									<th style="width:19%" lang="es">De</th>
									<th style="width:10%" lang="es">Fecha</th>
									<cfif itemTypeId IS 5>
										<th style="width:5%" lang="es">Inicio</th>		
										<th style="width:5%" lang="es">Fin</th>
									</cfif>
									<th style="width:23%" lang="es">Área</th>
								</cfif>
							<cfelse><!---Tasks--->
								<th style="width:34px" class="filter-false"></th>
								<cfif arguments.full_content IS false>
								<th style="width:27%" lang="es">Título</th>
								<th style="width:4%" class="filter-false"></th>
								<th style="width:17%" lang="es">De</th>
								<th style="width:17%" lang="es">Para</th>
								<th style="width:5%" lang="es">VE</th>
								<th style="width:5%" lang="es">VR</th>
								<th style="width:10%" lang="es">Inicio</th>		
								<th style="width:10%" lang="es">Fin</th>
								<cfelse>
								<th style="width:16%" lang="es">Título</th>
								<th style="width:4%"></th>
								<th style="width:15%" lang="es">De</th>
								<th style="width:15%" lang="es">Para</th>
								<th style="width:6%" lang="es">VE</th>
								<th style="width:6%" lang="es">VR</th>	
								<th style="width:10%" lang="es">Inicio</th>		
								<th style="width:10%" lang="es">Fin</th>
								<th style="width:14%" lang="es">Área</th>
								</cfif>					
							</cfif>
						</tr>
					</thead>
					
					<tbody>
					
					<cfset alreadySelected = false>
					
					<cfloop query="itemsQuery">
						
						<cfif isDefined("arguments.return_page")>
							<cfset rpage = arguments.return_page>
						<cfelse>
							<cfset rpage = "#lCase(itemTypeNameP)#.cfm?area=#itemsQuery.area_id#">
						</cfif>
						<cfset item_page_url = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&return_page=#URLEncodedFormat(rpage)#">
						
						<!---Item selection--->
						<cfset itemSelected = false>
						
						<cfif alreadySelected IS false>
						
							<cfif isDefined("URL.#itemTypeName#")>
							
								<cfif URL[itemTypeName] IS itemsQuery.id>
									<!---Esta acción solo se completa si está en la versión HTML2--->
									<script type="text/javascript">
										openUrlHtml2('#item_page_url#','itemIframe');
									</script>
									<cfset itemSelected = true>
								</cfif>
								
							<cfelseif itemsQuery.currentRow IS 1>
							
								<cfif app_version NEQ "mobile">
								
									<!---Esta acción solo se completa si está en la versión HTML2--->
									<script type="text/javascript">
										openUrlHtml2('#item_page_url#','itemIframe');
									</script>
									<cfset itemSelected = true>
									
								</cfif>
								
							</cfif>
							
							<cfif itemSelected IS true>
								<cfset alreadySelected = true>
							</cfif>
							
						</cfif>
						
						<!---Para lo de seleccionar el primero, en lugar de como está hecho, se puede llamar a un método JavaScript que compruebe si el padre es el HTML2, y si lo es seleccionar el primero--->
											
						<tr <cfif itemSelected IS true>class="selected"</cfif> onclick="openUrl('#item_page_url#','itemIframe',event)">
							<td style="text-align:center">
								<cfif itemTypeId IS 6><!---Tasks--->
									
									<cfif itemsQuery.done IS true>
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#_done.png" alt="Tarea realizada" title="Tarea realizada" class="item_img"/>
										<span class="hidden">1</span>
									<cfelse>
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#_not_done.png" alt="Tarea no realizada" title="Tarea no realizada" class="item_img"/><span class="hidden">0</span>
									</cfif>
									
								<cfelseif itemTypeId IS NOT 3><!---No es link--->
								
									<cfif APPLICATION.identifier NEQ "vpnet"><!---Message AND DP--->	
										<cfif len(itemsQuery.user_image_type) GT 0>
											<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#itemsQuery.user_in_charge#&type=#itemsQuery.user_image_type#&small=" alt="#itemsQuery.user_full_name#" class="item_img"/>									
										<cfelse>							
											<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#itemsQuery.user_full_name#" class="item_img_default" />
										</cfif>
									
									<cfelse>
								
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#.png" class="item_img" alt="#itemTypeNameEs#"/>
										
									</cfif>
									
								<cfelse><!---style="max-width:none;" Requerido para corregir un bug con Bootstrap en Chrome--->
									<a href="#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#" style="float:left;" target="_blank" title="Visitar el enlace" onclick="event.stopPropagation()"><img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#.png" class="item_img"/></a>
								</cfif>
							</td>							
							<td>
								<cfset titleClass = "text_item">
								<cfif itemTypeId IS 6 AND itemsQuery.done IS false><!--- Task not done --->
									<cfinvoke component="#APPLICATION.coreComponentsPath#/DateManager" method="createDateFromString" returnvariable="endDate">
										<cfinvokeargument name="strDate" value="#itemsQuery.end_date#">
									</cfinvoke>
									<cfif dateCompare(now(), endDate, "d") IS 1>
										<cfset titleClass = titleClass&" text_red"> 
									</cfif>
								</cfif>
								<a href="#item_page_url#" class="#titleClass#">#itemsQuery.title#</a></td>
							<td><!---Attached files--->
								<cfif isNumeric(itemsQuery.attached_file_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_file_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar archivo adjunto"><i class="icon-paper-clip"></i><span class="hidden">1</span></a>
								</cfif>
								<cfif itemTypeId IS NOT 1 AND isNumeric(itemsQuery.attached_image_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_image_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar imagen adjunta"><i class="icon-camera"></i><span class="hidden">2</span></a>
								
								</cfif>
							</td>
							<td>
								<cfif len(itemsQuery.user_image_type) GT 0>
									<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#itemsQuery.user_in_charge#&type=#itemsQuery.user_image_type#&small=" alt="#itemsQuery.user_full_name#" class="item_img"/>									
								<cfelse>							
									<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#itemsQuery.user_full_name#" class="item_img_default" />
								</cfif>
								<span>#itemsQuery.user_full_name#</span></td>
							<cfif arguments.itemTypeId IS 6><!---Tasks--->
							<td>
								<cfif len(itemsQuery.recipient_user_image_type) GT 0>
									<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#itemsQuery.recipient_user#&type=#itemsQuery.recipient_user_image_type#&small=" alt="#itemsQuery.recipient_user_full_name#" class="item_img"/>									
								<cfelse>							
									<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#itemsQuery.recipient_user_full_name#" class="item_img_default" />
								</cfif>
								<span>#itemsQuery.recipient_user_full_name#</span></td>
							<td><span>#itemsQuery.estimated_value#</span></td>
							<td><span>#itemsQuery.real_value#</span></td>
							</cfif>
							<cfif arguments.itemTypeId IS NOT 6>
							<td><cfset spacePos = findOneOf(" ", itemsQuery.creation_date)>
								<span>#left(itemsQuery.creation_date, spacePos)#</span>
								<span class="hidden">#right(itemsQuery.creation_date, len(itemsQuery.creation_date)-spacePos)#</span>
							</td>
							</cfif>
							<cfif arguments.itemTypeId IS 5 OR arguments.itemTypeId IS 6><!---Event OR Task--->
							<td><span>#itemsQuery.start_date#</span></td>
							<td><span>#itemsQuery.end_date#</span></td>
							</cfif>
							
							<cfif arguments.full_content IS true>
								<td><a onclick="openUrl('#itemTypeNameP#.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#','areaIframe',event)" class="link_blue">#itemsQuery.area_name#</a></td>
							<cfelse>
								<cfif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News--->
								<td style="vertical-align:middle"><span style="line-height:30px;">#itemsQuery.position#</span><!---Opciones de ordenar anteriores<div style="float:right;clear:none;"><a onclick="openUrl('area_item_position_up.cfm?item=#itemsQuery.id#&type=#itemTypeId#&area=#itemsQuery.area_id#','areaIframe',event)"><img src="#APPLICATION.htmlPath#/assets/icons/up.jpg" alt="Subir" title="Subir"/></a><div style="clear:both; height:0px;"><!-- --></div><a onclick="openUrl('area_item_position_down.cfm?item=#itemsQuery.id#&type=#itemTypeId#&area=#itemsQuery.area_id#','areaIframe',event)"><img src="#APPLICATION.htmlPath#/assets/icons/down.jpg" alt="Bajar" title="Bajar"/></a></div>---></td>
								</cfif>
							</cfif>
							
						</tr>
					</cfloop>
					</tbody>
				
				</table>
				</cfoutput>
			</cfif>
								
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
	
	<cffunction name="outputConsultationsList" returntype="void" output="true" access="public">
		<cfargument name="itemsQuery" type="query" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="full_content" type="boolean" required="no" default="false">
		<cfargument name="return_page" type="string" required="no">
		<cfargument name="app_version" type="string" required="true">
		
		<cfset var method = "outputConsultationsList">

		<cftry>
		
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
			
			<cfset numItems = itemsQuery.recordCount>
			
			<cfif numItems GT 0>
			
				<script type="text/javascript">
					$(document).ready(function() { 
						
						$("##listTable").tablesorter({ 
							<cfif arguments.full_content IS false>
							widgets: ['zebra','filter','select'],
							<cfelse>
							widgets: ['zebra','select'],
							</cfif>
							sortList: [[1,1]],
							headers: { 
								/*0: { 
									sorter: false 
								},*/
								1: { 
									sorter: "datetime" 
								}
							}
							<cfif arguments.full_content IS false>
							, widgetOptions : {
								filter_childRows : false,
								filter_columnFilters : true,
								filter_cssFilter : 'tablesorter-filter',
								filter_filteredRow   : 'filtered',
								filter_formatter : null,
								filter_functions : null,
								filter_hideFilters : false,
								filter_ignoreCase : true,
								filter_liveSearch : true,
								//filter_reset : 'button.reset',
								filter_searchDelay : 300,
								filter_serversideFiltering: false,
								filter_startsWith : false,
								filter_useParsedData : false
						    } 
						    </cfif> 
						});
						
						//  Adds "over" class to rows on mouseover
						$("##listTable tr").mouseover(function(){
						  $(this).addClass("over");
						});
					
						//  Removes "over" class from rows on mouseout
						$("##listTable tr").mouseout(function(){
						  $(this).removeClass("over");
						});
						
					}); 
				</script>
				
				
				<cfoutput>
				
				<table id="listTable" class="tablesorter">
					<thead>
						<tr>
							<th style="width:23%" lang="es">De</th>
							<th style="width:12%" lang="es">Fecha</th>
							<cfif arguments.full_content IS false>
							<th style="width:35%" lang="es">Asunto</th>
							<cfelse>
							<th style="width:23%" lang="es">Asunto</th>
							</cfif>
							<th style="width:5%" class="filter-false"></th>
							<th style="width:10%">##</th>
							<th style="width:10%" lang="es">Estado</th>
							<cfif arguments.full_content IS true>
							<th style="width:12%" lang="es">Área</th>
							</cfif>
						</tr>
					</thead>
					
					<tbody>
					
					<cfset alreadySelected = false>
					
					<cfloop query="itemsQuery">
						
						<cfif isDefined("arguments.return_page")>
							<cfset rpage = arguments.return_page>
						<cfelse>
							<cfset rpage = "#lCase(itemTypeNameP)#.cfm?area=#itemsQuery.area_id#">
						</cfif>
						<cfset item_page_url = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&return_page=#URLEncodedFormat(rpage)#">
						
						<!---Item selection--->
						<cfset itemSelected = false>
						
						<cfif alreadySelected IS false>
						
							<cfif isDefined("URL.#itemTypeName#")>
							
								<cfif URL[itemTypeName] IS itemsQuery.id>
								
									<!---Esta acción solo se completa si está en la versión HTML2--->
									<script type="text/javascript">
										openUrlHtml2('#item_page_url#','itemIframe');
									</script>
									<cfset itemSelected = true>
									
								</cfif>
								
							<cfelseif itemsQuery.currentRow IS 1>
							
								<cfif app_version NEQ "mobile">
									<!---Esta acción solo se completa si está en la versión HTML2--->
									<script type="text/javascript">
										openUrlHtml2('#item_page_url#','itemIframe');
									</script>
									<cfset itemSelected = true>
								</cfif>
								
							</cfif>
							
							<cfif itemSelected IS true>
								<cfset alreadySelected = true>
							</cfif>
							
						</cfif>
						
						<!---Para lo de seleccionar el primero, en lugar de como está hecho, se puede llamar a un método JavaScript que compruebe si el padre es el HTML2, y si lo es seleccionar el primero--->
											
						<tr <cfif itemSelected IS true>class="selected"</cfif> onclick="openUrl('#item_page_url#','itemIframe',event)">
							<!---<td style="text-align:center">
								<i class="icon-exchange" style="font-size:15px; color:##0088CC"></i>
							</td>--->
							<td><cfif len(itemsQuery.user_image_type) GT 0>
									<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#itemsQuery.user_in_charge#&type=#itemsQuery.user_image_type#&small=" alt="#itemsQuery.user_full_name#" class="item_img"/>									
								<cfelse>							
									<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#itemsQuery.user_full_name#" class="item_img_default" />
								</cfif>
								<span>#itemsQuery.user_full_name#</span></td>
							<td><span>#itemsQuery.creation_date#</span></td>							
							<td><a href="#item_page_url#" class="text_item">#itemsQuery.title#</a></td>
							<td><!---Attached files--->
								<cfif len(itemsQuery.attached_file_name) GT 0 AND itemsQuery.attached_file_name NEQ "-">
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_file_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar archivo adjunto"><i class="icon-paper-clip"></i><span class="hidden">1</span></a>
								</cfif>
								<cfif len(itemsQuery.attached_image_id) GT 0>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_image_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar imagen adjunta"><i class="icon-camera"></i><span class="hidden">2</span></a>							
								</cfif>
							</td>
							<td><span>#itemsQuery.identifier#</span></td>							
							<td><span lang="es"><cfswitch expression="#itemsQuery.state#">
								<cfcase value="created">Enviada</cfcase>
								<cfcase value="read">Leída</cfcase>
								<cfcase value="answered">Respondida</cfcase>
								<cfcase value="closed">Cerrada</cfcase>
							</cfswitch></span></td>
							
							<cfif arguments.full_content IS true>
								<td><a onclick="openUrl('#itemTypeNameP#.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#','areaIframe',event)" class="link_blue">#itemsQuery.area_name#</a></td>
							</cfif>
							
						</tr>
					</cfloop>
					</tbody>
				
				</table>
				</cfoutput>
			</cfif>
								
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	<cffunction name="outputAllItemsList" returntype="void" output="true" access="public">
		<cfargument name="itemsQuery" type="query" required="true">
		<cfargument name="area_type" type="string" required="true">
		<cfargument name="return_page" type="string" required="false">
		<cfargument name="app_version" type="string" required="true">
		
		<cfset var method = "outputAllItemsList">
		
		<cfset var selectFirst = true>

		<cftry>
		
			<cfif StructCount(URL) GT 1>
				<cfset selectFirst = false>
			</cfif>
								
			<cfset numItems = itemsQuery.recordCount>
			
			<cfif numItems GT 0>
			
				<script type="text/javascript">
					$(document).ready(function() { 
						
						$("##listTable").tablesorter({ 
							widgets: ['zebra','filter','select'],
							<cfif len(area_type) GT 0><!--- WEB --->
							sortList: [[5,1]] ,
							<cfelse>
							sortList: [[4,1]] ,
							</cfif>
							headers: { 
								4: { 
									sorter: "datetime" 
								}
							},

   							//widthFixed : true,
							widgetOptions : {

								filter_childRows : false,
								filter_columnFilters : true,
								filter_cssFilter : 'tablesorter-filter',
								filter_filteredRow   : 'filtered',
								filter_formatter : null,
								filter_functions : null,
								filter_hideFilters : false,
								filter_ignoreCase : true,
								filter_liveSearch : true,
								//filter_reset : 'button.reset',
								filter_searchDelay : 300,
								filter_serversideFiltering: false,
								filter_startsWith : false,
								filter_useParsedData : false

						     	<!---filter_formatter : {
									
							 		// Date (one input)
							        4 : function($cell, indx){
							          return $.tablesorter.filterFormatter.uiDateCompare( $cell, indx, {
							            // defaultDate : '1/1/2014', // default date
							            //cellText : 'dates >= ', // text added before the input
							            cellText : '',
							            changeMonth : true,
							            changeYear : true,
							            compare : '=',
							            dateFormat : 'dd-mm-yy',
							          });
							        },

							        // Date (two inputs)
							        /*4 : function($cell, indx){
							          return $.tablesorter.filterFormatter.uiDatepicker( $cell, indx, {
							            // from : '08/01/2013', // default from date
							            // to   : '1/18/2014',  // default to date
							            changeMonth : true,
							            changeYear : true
							          });
							        }*/

						    	},--->
						    }
						});
						
						//  Adds "over" class to rows on mouseover
						$("##listTable tr").mouseover(function(){
						  $(this).addClass("over");
						});
					
						//  Removes "over" class from rows on mouseout
						$("##listTable tr").mouseout(function(){
						  $(this).removeClass("over");
						});
						
					}); 
				</script>
				
				<cfoutput>
				
				<table id="listTable" class="tablesorter">
					<thead>
						<tr>
							<th style="width:35px" class="filter-false"></th>
							<cfif len(area_type) IS 0>
							<th style="width:55%" lang="es">Título</th>
							<cfelse>
							<th style="width:49%" lang="es">Título</th>
							</cfif>
							<th style="width:5%" class="filter-false"></th>
							<th style="width:23%" lang="es">De</th>
							<th style="width:12%" lang="es">Fecha</th>
							<cfif len(area_type) GT 0>
							<th style="width:6%" class="filter-false">##</th>
							</cfif>
						</tr>
					</thead>
					
					<tbody>
					
					<cfset alreadySelected = false>
					
					<cfloop query="itemsQuery">
						
						<cfset itemTypeId = itemsQuery.itemTypeId>
						
						<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">
					
						<cfif isDefined("arguments.return_page")>
							<cfset rpage = arguments.return_page>
						<cfelse>
							<cfset rpage = "#lCase(itemTypeNameP)#.cfm?area=#itemsQuery.area_id#">
						</cfif>
						
						<cfif itemTypeId NEQ 10>
							<cfset item_page_url = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&return_page=#URLEncodedFormat(rpage)#">
						<cfelse><!---Files--->
							<cfset item_page_url = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&area=#area_id#&return_page=#URLEncodedFormat(rpage)#">
						</cfif>
						
						<!---Item selection--->
						<cfset itemSelected = false>
						
						<cfif alreadySelected IS false>

							<cfif ( isDefined("URL.#itemTypeName#") AND (URL[itemTypeName] IS itemsQuery.id) ) OR ( selectFirst IS true AND itemsQuery.currentrow IS 1 AND app_version NEQ "mobile" ) >

								<!---Esta acción solo se completa si está en la versión HTML2--->
								<script type="text/javascript">
									openUrlHtml2('#item_page_url#','itemIframe');
								</script>

								<cfset itemSelected = true>
								<cfset alreadySelected = true>
																				
							</cfif>
							
						</cfif>
						
						<!---Para lo de seleccionar el primero, en lugar de como está hecho, se puede llamar a un método JavaScript que compruebe si el padre es el HTML2, y si lo es seleccionar el primero--->
											
						<tr <cfif itemSelected IS true>class="selected"</cfif> onclick="openUrl('#item_page_url#','itemIframe',event)">
							<td style="text-align:center">
								<cfif itemTypeId IS 6><!---Tasks--->
									
									<cfif itemsQuery.done IS true>
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#_done.png" alt="Tarea realizada" title="Tarea realizada" class="item_img"/>
									<cfelse>
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#_not_done.png" alt="Tarea no realizada" title="Tarea no realizada" class="item_img"/>
									</cfif>
									
								<cfelseif itemTypeId IS 7><!--- Consultation --->
								
									<i class="icon-exchange" style="font-size:25px; color:##0088CC"></i>

								<cfelseif itemTypeId IS 10><!--- File --->

									<cfif itemsQuery.file_type_id IS 1><!--- User file --->
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#.png" class="item_img" alt="#itemTypeNameEs#" title="#itemTypeNameEs#"/>
									<cfelseif itemsQuery.file_type_id IS 2><!--- Area file --->
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#_area.png" class="item_img" alt="#itemTypeNameEs# del área" title="#itemTypeNameEs# del área"/>
									<cfelseif itemsQuery.file_type_id IS 3>
										<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#_edited.png" class="item_img" alt="#itemTypeNameEs# del área en edición" title="#itemTypeNameEs# del área en edición"/>
									</cfif>

								<cfelseif itemTypeId IS NOT 3><!---No es link--->
								
									<img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#.png" class="item_img" alt="#itemTypeNameEs#" title="#itemTypeNameEs#"/>
										
								<cfelse><!---style="max-width:none;" Requerido para corregir un bug con Bootstrap en Chrome--->
									<a href="#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#" style="float:left;" target="_blank" title="Visitar el enlace" onclick="openUrl('#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#','_self',event)"><img src="#APPLICATION.htmlPath#/assets/icons/#itemTypeName#.png" class="item_img"/></a>
								</cfif>
								<span class="hidden">#itemTypeId#</span>								
							</td>							
							<td>
								<cfset titleClass = "text_item">
								<cfif itemTypeId IS 6 AND itemsQuery.done IS false><!--- Task not done --->
									<cfif dateCompare(now(), itemsQuery.end_date, "d") IS 1>
										<cfset titleClass = titleClass&" text_red"> 
									</cfif>
								</cfif>
								<a href="#item_page_url#" class="#titleClass#">#itemsQuery.title#</a>
							</td>
							<td>
								<cfif itemTypeId IS 11 OR itemTypeId IS 12 OR itemTypeId IS 14 OR itemTypeId IS 15 OR itemTypeId IS 16><!---Lists, Forms And Views--->
									<a href="#itemTypeName#_rows.cfm?#itemTypeName#=#itemsQuery.id#" onclick="openUrl('#itemTypeName#_rows.cfm?#itemTypeName#=#itemsQuery.id#','_self',event)" title="Registros"><i class="icon-list" style="font-size:15px;"></i></a>
								</cfif>

								<!---Attached files--->
								<cfif itemTypeId IS 10><!--- File --->
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar archivo"><i class="icon-download-alt" style="font-size:13px;"></i><span class="hidden">3</span></a>
								<cfelseif isNumeric(itemsQuery.attached_file_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_file_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar archivo adjunto"><i class="icon-paper-clip" style="font-size:14px;"></i><span class="hidden">1</span></a>
								</cfif>
								<cfif isNumeric(itemsQuery.attached_image_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_image_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar imagen adjunta"><i class="icon-camera" style="font-size:13px;"></i><span class="hidden">2</span></a>
								
								</cfif>
							</td>
							<td>
								<cfif itemsQuery.itemTypeId IS NOT 10 OR itemsQuery.file_type_id IS 1>
									<cfif len(itemsQuery.user_image_type) GT 0>
										<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#itemsQuery.user_in_charge#&type=#itemsQuery.user_image_type#&small=" alt="#itemsQuery.user_full_name#" class="item_img"/>									
									<cfelse>							
										<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#itemsQuery.user_full_name#" class="item_img_default" />
									</cfif>
									<span>#itemsQuery.user_full_name#</span>
								<cfelse><!--- Area files --->
									<i><span lang="es">Área</span></i>
								</cfif>	
							</td>
							<td>
							
							<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringDate">
								<cfinvokeargument name="timestamp_date" value="#itemsQuery.creation_date#">
							</cfinvoke>							
							<cfset spacePos = findOneOf(" ", stringDate)>
							<span>
							<cfif spacePos GT 0>
							#left(stringDate, spacePos)#
							<cfelse><!---Esto es para que no de error en versiones antiguas de DoPlanning que tienen la fecha en otro formato--->
							#stringDate#
							</cfif>
							</span>
							<cfif spacePos GT 0>
							<span class="hidden">#right(stringDate, len(stringDate)-spacePos)#</span>
							</cfif>
							</td>
							
							<cfif len(arguments.area_type) GT 0>
								
							<td><div class="item_position">#itemsQuery.position#</div><div class="change_position"><cfif itemsQuery.currentRow NEQ 1>
								<cfset up_item_id = itemsQuery.id[itemsQuery.currentRow-1]>
								<cfset up_item_type = itemsQuery.itemTypeId[itemsQuery.currentRow-1]>
								<a onclick="openUrl('area_item_position_up.cfm?item=#itemsQuery.id#&type=#itemTypeId#&oitem=#up_item_id#&otype=#up_item_type#&area=#itemsQuery.area_id#','areaIframe',event)"><img src="#APPLICATION.htmlPath#/assets/icons/up.jpg" alt="Subir" title="Subir"/></a><cfelse><br></cfif><!--- <div style="clear:both; height:0px;"><!-- --></div> ---><cfif itemsQuery.currentRow NEQ itemsQuery.recordCount>
									<cfset down_item = itemsQuery.id[itemsQuery.currentRow+1]>
									<cfset down_item_type = itemsQuery.itemTypeId[itemsQuery.currentRow+1]>
									<a onclick="openUrl('area_item_position_down.cfm?item=#itemsQuery.id#&type=#itemTypeId#&oitem=#down_item#&otype=#down_item_type#&area=#itemsQuery.area_id#','areaIframe',event)"><img src="#APPLICATION.htmlPath#/assets/icons/down.jpg" alt="Bajar" title="Bajar"/></a>
								</cfif></div></td>

							</cfif>
							
						</tr>
					</cfloop>
					</tbody>
				
				</table>
				</cfoutput>
			</cfif>
								
			
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
	</cffunction>
	
	
	
</cfcomponent>