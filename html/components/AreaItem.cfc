<!---Copyright Era7 Information Technologies 2007-2015

	Date of file creation: 02-10-2008
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 18-02-2013

--->
<cfcomponent output="true">

	<cfset component = "AreaItem">
	<cfset request_component = "AreaItemManager">

	<!--- ----------------------------------- getItem -------------------------------------- --->

	<!---Este método no hay que usarlo en páginas en las que su contenido se cague con JavaScript (páginas de html_content) porque si hay un error este método redirige a otra página. En esas páginas hay que obtener el Item directamente del AreaItemManager y comprobar si result es true o false para ver si hay error y mostrarlo correctamente--->

	<cffunction name="getItem" output="false" returntype="any" access="public">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="status" type="string" required="false">

		<cfargument name="with_lock" type="boolean" required="false" default="false">
		<cfargument name="with_categories" type="boolean" required="false" default="false">

		<cfset var method = "getItem">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getItem" returnvariable="response">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">

				<cfinvokeargument name="with_lock" value="#arguments.with_lock#">
				<cfinvokeargument name="with_categories" value="#arguments.with_categories#">

				<!---<cfinvokeargument name="return_type" value="object">--->
				<cfinvokeargument name="return_type" value="query">

				<cfif isDefined("arguments.status")>
					<cfinvokeargument name="status" value="#arguments.status#">
				</cfif>
			</cfinvoke>

			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

		<cfif arguments.with_categories IS false>
			<cfreturn response.item>
		<cfelse>
			<cfreturn {result=true, item=response.item, categories=response.categories}>
		</cfif>



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


	<!--- ----------------------------------- getItemCategories -------------------------------------- --->

	<cffunction name="getItemCategories" output="false" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">

		<cfset var method = "getItemCategories">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getItemCategories" returnvariable="response">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
			</cfinvoke>

			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>



	</cffunction>



	<!--- -------------------------------createItem-------------------------------------- --->

	<cffunction name="createItem" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="link" type="string" required="false">
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
		<cfargument name="display_type_id" type="numeric" required="false">
		<cfargument name="iframe_url" type="string" required="false">
		<cfargument name="iframe_display_type_id" type="numeric" required="false">
		<cfargument name="identifier" type="string" required="false">
		<cfargument name="structure_available" type="boolean" required="false" default="false">
		<cfargument name="list_rows_by_default" type="boolean" required="false" default="false">
		<cfargument name="general" type="boolean" required="false" default="false">
		<cfargument name="publication_scope_id" type="numeric" required="false">
		<cfargument name="publication_date" type="string" required="false">
		<cfargument name="publication_hour" type="numeric" required="false">
		<cfargument name="publication_minute" type="numeric" required="false">
		<cfargument name="publication_validated" type="boolean" required="false">
		<cfargument name="publication_restricted" type="boolean" required="false">
		<cfargument name="price" type="numeric" required="false">
		<cfargument name="sub_type_id" type="numeric" required="false">
		<cfargument name="area_editable" type="boolean" required="false" default="false">
		<cfargument name="categories_ids" type="array" required="false">
		<cfargument name="no_notify" type="boolean" required="false" default="false">

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

      </cfif>


      <!---Aunque haya imagen el elemento se crea llamando a este método, porque en el contenido del elemento se incluye que hay una imagen, lo que hace que al crearse el elemento este se marque como pendiente de subir.--->
      <cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="createItem" argumentcollection="#arguments#" returnvariable="createItemResponse">
				<cfinvokeargument name="user_in_charge" value="#SESSION.user_id#">

				<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
					<cfinvokeargument name="start_time" value="#arguments.start_hour#:#arguments.start_minute#">
				</cfif>
				<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
					<cfinvokeargument name="end_time" value="#arguments.end_hour#:#arguments.end_minute#">
				</cfif>
				<cfif isDefined("arguments.publication_date")>
					<cfinvokeargument name="publication_date" value="#arguments.publication_date# #arguments.publication_hour#:#arguments.publication_minute#">
				</cfif>

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
					<cfset response_message = "#itemTypeNameEs# enviado.">
				<cfelse>
					<cfset response_message = "#itemTypeNameEs# enviada.">
				</cfif>
			<cfelse><!---Consultation--->
				<cfset response_message = "Respuesta a #itemTypeNameEs# enviado.">
			</cfif>

      <cfif with_attached IS true><!---Hay archivo para subir--->

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

							<cfset response = {result="false", message="Error al subir el archivo, compruebe el formato. "&#cfcatch.message#, item_id=#createdItemId#}>
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
					<cfif arguments.no_notify IS false>
						<cfinvokeargument name="send_alert" value="true">
					<cfelse>
						<cfinvokeargument name="send_alert" value="false">
					</cfif>
				</cfinvoke>

				<cfif itemTypeGender EQ "male">
					<cfset response_message = "#itemTypeNameEs# enviado.">
				<cfelse>
					<cfset response_message = "#itemTypeNameEs# enviada.">
				</cfif>


			</cfif>

			<cfif with_image IS true>

				<!---<cftry>--->

					<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getAreaItemFileStatus" returnvariable="xmlGetImageResponseContent">
						<cfinvokeargument name="file_id" value="#image_id#">
						<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
						<cfinvokeargument name="file_type" value="image">
						<cfif arguments.no_notify IS true OR with_attached IS true><!---Esto es para que no se envíen 2 notificaciones--->
							<cfinvokeargument name="send_alert" value="false">
						<cfelse>
							<cfinvokeargument name="send_alert" value="true">
						</cfif>
					</cfinvoke>

					<cfif itemTypeGender EQ "male">
						<cfset response_message = "#itemTypeNameEs# enviado.">
					<cfelse>
						<cfset response_message = "#itemTypeNameEs# enviada.">
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
		<cfargument name="list_rows_by_default" type="boolean" required="false" default="false">
		<cfargument name="general" type="boolean" required="false" default="false">
		<cfargument name="publication_scope_id" type="numeric" required="false">
		<cfargument name="publication_date" type="string" required="false">
		<cfargument name="publication_hour" type="numeric" required="false">
		<cfargument name="publication_minute" type="numeric" required="false">
		<cfargument name="publication_validated" type="boolean" required="false">
		<cfargument name="publication_restricted" type="boolean" required="false">
		<cfargument name="price" type="numeric" required="false">
		<cfargument name="sub_type_id" type="numeric" required="false">
		<cfargument name="area_editable" type="boolean" required="false" default="false">
		<cfargument name="unlock" type="boolean" required="false" default="false">
		<cfargument name="categories_ids" type="array" required="false">
		<cfargument name="no_notify" type="boolean" required="false" default="false">

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

	        <cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="updateItem" argumentcollection="#arguments#" returnvariable="updateItemResponse">

						<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
							<cfinvokeargument name="start_time" value="#arguments.start_hour#:#arguments.start_minute#">
						</cfif>
						<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
							<cfinvokeargument name="end_time" value="#arguments.end_hour#:#arguments.end_minute#">
						</cfif>
						<cfif isDefined("arguments.publication_date") AND len(arguments.publication_date) GT 0>
							<cfinvokeargument name="publication_date" value="#arguments.publication_date# #arguments.publication_hour#:#arguments.publication_minute#">
						</cfif>

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

				<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="updateItemWithAttachedFile" argumentcollection="#arguments#" returnvariable="updateItemWithAttachedResponse">
					<cfinvokeargument name="file_name" value="#objectFile.name#">
					<cfinvokeargument name="file_file_name" value="#objectFile.file_name#">
					<cfinvokeargument name="file_type" value="#objectFile.file_type#">
					<cfinvokeargument name="file_size" value="#objectFile.file_size#">
					<cfinvokeargument name="file_description" value="#objectFile.description#">

					<cfif isDefined("arguments.start_hour") AND isDefined("arguments.start_minute")>
						<cfinvokeargument name="start_time" value="#arguments.start_hour#:#arguments.start_minute#">
					</cfif>
					<cfif isDefined("arguments.end_hour") AND isDefined("arguments.end_minute")>
						<cfinvokeargument name="end_time" value="#arguments.end_hour#:#arguments.end_minute#">
					</cfif>
					<cfif isDefined("arguments.publication_date")>
						<cfinvokeargument name="publication_date" value="#arguments.publication_date# #arguments.publication_hour#:#arguments.publication_minute#">
					</cfif>
				</cfinvoke>

				<cfif updateItemWithAttachedResponse.result IS true>
					<cfset createdItemId = updateItemWithAttachedResponse.item_id>
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
					<cfif arguments.no_notify IS false>
						<cfinvokeargument name="send_alert" value="true">
					<cfelse>
						<cfinvokeargument name="send_alert" value="false">
					</cfif>
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
						<cfif arguments.no_notify IS true OR with_attached IS true><!---Esto es para que no se envíen 2 notificaciones--->
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


	<!--- ---------------------------------- changeItemsUser -------------------------------------- --->

	<cffunction name="changeItemsUser" returntype="struct" access="public">
		<cfargument name="items_ids" type="string" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="new_user_in_charge" type="numeric" required="true">

		<cfset var method = "changeItemsUser">

		<cfset var response = structNew()>

		<cfset var response_message = "">
		<cfset var response_messages = "">

		<cftry>

			<cfloop list="#arguments.items_ids#" index="item_id">

				<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="changeItemUser" returnvariable="changeItemUserResponse">
					<cfinvokeargument name="item_id" value="#item_id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					<cfinvokeargument name="new_user_in_charge" value="#arguments.new_user_in_charge#">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfinvoke>

				<cfif changeItemUserResponse.result IS true>

					<cfset response_message = "Propietario modificado.">

				<cfelse>

					<cfset response_message = changeItemUserResponse.message>

				</cfif>

				<cfif listLen(arguments.items_ids) GT 1>

					<cfif isDefined("changeItemUserResponse.item_title")>
						<cfset response_messages = response_messages&"<b>#changeItemUserResponse.item_title#</b>: #response_message#<br>">
					<cfelse>
						<cfset response_messages = response_messages&response_message&"<br>">
					</cfif>

				<cfelse>
					<cfset response = {result=changeItemUserResponse.result, message=#response_message#, item_id=#arguments.items_ids#}>
					<cfreturn response>
				</cfif>

			</cfloop>

			<cfset response = {result=true, message=#response_messages#, item_id=#arguments.items_ids#}>

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



	<!--- ----------------------------------- exportICalendarItem -------------------------------------- --->

	<cffunction name="exportICalendarItem" output="false" returntype="struct" access="public">
		<cfargument name="item_id" type="string" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="itemQuery" type="query" required="false">

		<cfset var method = "exportICalendarItem">

		<cfset var response = structNew()>

		<cftry>

			<cfset client_dsn = APPLICATION.identifier&"_"&SESSION.client_abb>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemManager" method="exportICalendarItem" returnvariable="response">
				<cfinvokeargument name="item_id" value="#item_id#">
				<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
				<cfinvokeargument name="itemQuery" value="#arguments.itemQuery#">

				<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ---------------------------------copyItemToAreas------------------------------- --->

	<cffunction name="copyItemToAreas" returntype="struct" access="public">
		<cfargument name="areas_ids" type="array" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="link" type="string" required="false" default="">
		<cfargument name="link_target" type="string" required="false">
    <cfargument name="description" type="string" required="false" default="">
    <cfargument name="Filedata" type="any" required="false" default="">
		<cfargument name="imagedata" type="any" required="false" default="">
		<cfargument name="notify_by_sms" type="boolean" required="no">
		<cfargument name="post_to_twitter" type="boolean" required="no">
		<cfargument name="copy_attached_file_id" type="numeric" required="no">
		<cfargument name="copy_attached_image_id" type="numeric" required="no">
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
		<cfargument name="price" type="numeric" required="false">
		<cfargument name="sub_type_id" type="numeric" required="false">
		<cfargument name="area_editable" type="boolean" required="false" default="false">
		<cfargument name="categories_ids" type="array" required="false">
		<cfargument name="no_notify" type="boolean" required="false" default="false">

		<cfset var method = "copyItemToAreas">

		<cftry>

			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

		  	<cfloop index="cur_area" array="#arguments.areas_ids#">

				<!---Esto habría que cambiarlo: si existe archivo, primero hay que duplicarlo y subirlo para que al crear el item se notifique que tiene un adjunto (ahora mismo en la notificacion no viene que hay un archivo adjunto)--->

				<cfinvoke component="AreaItem" method="createItem" argumentcollection="#arguments#" returnvariable="createItemResult">
					<cfinvokeargument name="parent_id" value="#cur_area#">
					<cfinvokeargument name="parent_kind" value="area">
					<cfinvokeargument name="area_id" value="#cur_area#">
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


	<!--- ---------------------------------- canUserDeleteItem -------------------------------------- --->

	<cffunction name="canUserDeleteItem" output="false" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="itemQuery" type="query" required="true">
		<cfargument name="area_id" type="numeric" required="false">

		<cfset var method = "canUserDeleteItem">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="canUserDeleteItem" returnvariable="response">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="itemQuery" value="#arguments.itemQuery#">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- deleteItem --->
	<cffunction name="deleteItem" returntype="void" access="remote">
		<cfargument name="item_id" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="moveToBin" type="boolean" required="false" default="true">
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
				<cfinvokeargument name="moveToBin" value="#arguments.moveToBin#">
			</cfinvoke>

			<cfif deleteItemResponse.result IS true>

				<cfif itemTypeGender EQ "male">
					<cfset msg = "#itemTypeNameEs# eliminado.">
				<cfelse>
					<cfset msg = "#itemTypeNameEs# eliminada.">
				</cfif>
				<cfset msg = URLEncodedFormat(msg)>

				<cfif findOneOf(arguments.return_page, "?") GT 0>
					<cflocation url="#arguments.return_page#&msg=#msg#&res=1" addtoken="no">
				<cfelse>
					<cflocation url="#arguments.return_page#?msg=#msg#&res=1" addtoken="no">
				</cfif>

			<cfelse>

				<cfset msg = URLEncodedFormat(deleteItemResponse.message)>

				<cfif findOneOf(arguments.return_page, "?") GT 0>
					<cflocation url="#arguments.return_page#&msg=#msg#&res=0" addtoken="no">
				<cfelse>
					<cflocation url="#arguments.return_page#?msg=#msg#&res=0" addtoken="no">
				</cfif>

			</cfif>

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

	</cffunction>


	<!--- deleteItems --->

	<cffunction name="deleteItems" returntype="struct" access="public">
		<cfargument name="items_ids" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">

		<cfset var method = "deleteItems">

		<cfset var response = structNew()>

		<cfset var response_message = "">
		<cfset var response_messages = "">

		<cftry>

			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

			<!--- getClient --->
			<cfinvoke component="#APPLICATION.htmlPath#/components/Client" method="getClient" returnvariable="clientQuery">
				<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
			</cfinvoke>

			<cfloop list="#arguments.items_ids#" index="item_id">

				<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="deleteItem" returnvariable="deleteItemResponse">
					<cfinvokeargument name="item_id" value="#item_id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					<cfinvokeargument name="moveToBin" value="#clientQuery.bin_enabled#">
				</cfinvoke>

				<cfif deleteItemResponse.result IS true>

					<cfif itemTypeGender EQ "male">
						<cfset response_message = "#itemTypeNameEs# eliminado.">
					<cfelse>
						<cfset response_message = "#itemTypeNameEs# eliminada.">
					</cfif>

				<cfelse>

					<cfset response_message = deleteItemResponse.message>

				</cfif>

				<cfif listLen(arguments.items_ids) GT 1>

					<cfif isDefined("deleteItemResponse.item_title")>
						<cfset response_messages = response_messages&"<b>#deleteItemResponse.item_title#</b>: #response_message#<br>">
					<cfelse>
						<cfset response_messages = response_messages&response_message&"<br>">
					</cfif>

				<cfelse>
					<cfset response = {result=deleteItemResponse.result, message=#response_message#}>
					<cfreturn response>
				</cfif>

			</cfloop>

			<cfset response = {result=true, message=#response_messages#}>

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>

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

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="deleteItemAttachedFile" returnvariable="deleteAttachedFileResponse">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">

				<cfinvokeargument name="file_type" value="file"/>
			</cfinvoke>

			<cfif deleteAttachedFileResponse.result IS true>
				<cfset msg = "Archivo eliminado.">
			<cfelse>
				<cfset msg = deleteAttachedFileResponse.message>
			</cfif>

			<cfset msg = URLEncodedFormat(msg)>

            <cflocation url="#arguments.return_page#&res=#deleteAttachedFileResponse.result#&msg=#msg#" addtoken="no">

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

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="deleteItemAttachedFile" returnvariable="deleteAttachedFileResponse">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">

				<cfinvokeargument name="file_type" value="image"/>
			</cfinvoke>

			<cfif deleteAttachedFileResponse.result IS true>
				<cfset msg = "Archivo de imagen eliminado.">
			<cfelse>
				<cfset msg = deleteAttachedFileResponse.message>
			</cfif>

			<cfset msg = URLEncodedFormat(msg)>

      <cflocation url="#arguments.return_page#&res=#deleteAttachedFileResponse.result#&msg=#msg#" addtoken="no">

			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>

		</cftry>

	</cffunction>


	<!--- deleteAreaItems --->
	<cffunction name="deleteAreaItems" returntype="struct" access="remote">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="moveToBin" type="boolean" required="false" default="true">
		<cfargument name="return_page" type="string" required="true">

		<cfset var method = "deleteAreaItems">

		<cftry>

			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="deleteAreaItems">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="moveToBin" value="#arguments.moveToBin#">
			</cfinvoke>

			<cfset msg = "Elementos eliminados">

			<cflocation url="#arguments.return_page#&res=1&msg=#msg#" addtoken="no">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

	</cffunction>


	<!--- ------------------------------ changeAreaItemDone ----------------------------------- --->

    <cffunction name="changeAreaItemDone" returntype="void" access="remote">
    	<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="done" type="boolean" required="true">

		<cfargument name="return_path" type="string" required="yes">

		<cfset var method = "changeAreaItemDone">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="changeAreaItemDone" returnvariable="response">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="done" value="#arguments.done#">
			</cfinvoke>

			<cfset msg = URLEncodedFormat(response.message)>

			<cflocation url="#arguments.return_path#&res=#response.result#&msg=#msg#" addtoken="no">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
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
		<cfargument name="area_type" type="string" required="false">
		<cfargument name="itemTypeId" type="numeric" required="true">

		<cfset var method = "getAreaItemsList">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAreaItems" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="area_type" value="#arguments.area_type#">
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


	<!--- ----------------------------------- getAreaItems ------------------------------------- --->

	<cffunction name="getAreaItems" returntype="struct" returnformat="json" access="remote">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="recipient_user" type="numeric" required="no">
		<cfargument name="limit" type="numeric" required="no">
		<cfargument name="done" type="boolean" required="no">
		<cfargument name="parse_dates" type="boolean" required="false">

		<cfset var method = "getAreaItems">

		<cfset var response = structNew()>

		<cftry>

			<!---<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">--->

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAreaItems" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="format_content" value="default">
				<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
				<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
				<cfinvokeargument name="limit" value="#arguments.limit#">
				<cfinvokeargument name="done" value="#arguments.done#">
				<cfinvokeargument name="parse_dates" value="#arguments.parse_dates#">
			</cfinvoke>

			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
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
		<cfargument name="to_end_date" type="string" required="no">
		<cfargument name="identifier" type="string" required="false">
		<cfargument name="categories_ids" type="array" required="false">

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
				<cfif isDefined("arguments.to_end_date")>
				<cfinvokeargument name="to_end_date" value="#arguments.to_end_date#">
				</cfif>
				<cfinvokeargument name="identifier" value="#arguments.identifier#">
				<cfinvokeargument name="categories_ids" value="#arguments.categories_ids#">
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
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="area_type" type="string" required="true">
		<cfargument name="limit" type="numeric" required="false">
		<cfargument name="full_content" type="boolean" required="false">

		<cfset var method = "getAllAreaItems">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAllAreaItems" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="area_type" value="#arguments.area_type#">
				<cfinvokeargument name="limit" value="#arguments.limit#">
				<cfinvokeargument name="full_content" value="#arguments.full_content#">
			</cfinvoke>

			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ----------------------- GET ALL ITEMS -------------------------------- --->

	<cffunction name="getAllItems" returntype="struct" access="public">
		<cfargument name="limit" type="numeric" required="false">
		<cfargument name="full_content" type="boolean" required="false">
		<cfargument name="withArea" type="boolean" required="false">

		<cfset var method = "getAllItems">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getAllItems" returnvariable="response">
				<cfinvokeargument name="limit" value="#arguments.limit#">
				<cfinvokeargument name="full_content" value="#arguments.full_content#">
				<cfinvokeargument name="withArea" value="#arguments.withArea#">
			</cfinvoke>

			<cfinclude template="includes/responseHandlerStruct.cfm">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- lockAreaItem --->

	<cffunction name="lockAreaItem" returntype="void" access="remote">
		<cfargument name="item_id" type="string" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="lock" type="boolean" required="true">
		<cfargument name="return_path" type="string" required="true">

		<cfset var method = "lockAreaItem">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="changeAreaItemLock" returnvariable="response">
				<cfinvokeargument name="item_id" value="#arguments.item_id#"/>
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#"/>
				<cfinvokeargument name="lock" value="#arguments.lock#"/>
			</cfinvoke>

			<cfif response.result IS true>
				<cfif arguments.lock IS true>
					<cfset msg = "Documento bloqueado.">
				<cfelse>
					<cfset msg = "Documento desbloqueado.">
				</cfif>
			<cfelse>
				<cfset msg = response.message>
			</cfif>

			<cfset msg = URLEncodedFormat(msg)>
			<!---<cflocation url="#arguments.return_path#area_items.cfm?area=#arguments.area_id#&#itemTypeName#=#arguments.item_id#&res=#response.result#&msg=#msg#" addtoken="no">--->
			<cflocation url="#arguments.return_path##itemTypeName#.cfm?area=#arguments.area_id#&#itemTypeName#=#arguments.item_id#&res=#response.result#&msg=#msg#" addtoken="no">

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

	</cffunction>



	<!--- sendAreaItem --->

	<cffunction name="sendAreaItem" output="false" returntype="struct" returnformat="json" access="remote">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="send_to_test_users" type="boolean" required="false">

		<cfset var method = "sendAreaItem">

		<cfset var response = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="sendAreaItem" argumentcollection="#arguments#" returnvariable="response">
			</cfinvoke>

			<cfif response.result IS true>
				<cfset response.message = "Boletín enviado a usuarios del área.">
			</cfif>

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>



	<cffunction name="outputItem" returntype="void" output="true" access="public">
		<cfargument name="objectItem" type="object" required="true">
		<cfargument name="categories" type="query" required="false">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="itemTypeName" type="string" required="false">
		<cfargument name="area_type" type="string" required="true">
		<cfargument name="webPath" type="string" required="false">
		<cfargument name="area_id" type="numeric" required="false">
		<cfargument name="internal_user" type="boolean" required="false">

		<cfset var method = "outputItem">

		<cftry>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemManager" method="getAreaItemTypeStruct" returnvariable="itemTypeStruct">
				<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
			</cfinvoke>

			<cfif NOT isDefined("arguments.itemTypeName")>
				<cfset itemTypeName = itemTypeStruct.name>
			</cfif>

			<cfif len(objectItem.description) GT 0>

				<cfset objectItem.description = REReplace(objectItem.description,'[[:space:]]SIZE="',' style="font-size:',"ALL")>

			</cfif>

			<cfif itemTypeId IS 8 AND isNumeric(objectItem.sub_type_id)>

				<cfinvoke component="#APPLICATION.componentsPath#/ItemSubTypeManager" method="getSubType" returnvariable="subTypeQuery">
					<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
					<cfinvokeargument name="sub_type_id" value="#objectItem.sub_type_id#">
				</cfinvoke>

			</cfif>

			<cfoutput>
				<!---<div class="div_message_page_title">#objectItem.title#</div>
				<div class="div_separator"><!-- --></div>--->

				<div class="panel panel-default"><!---class="div_message_page_message"--->
					<div class="panel-body" style="word-wrap:break-word;overflow-x:auto">

						<div class="row">

							<div class="col-xs-12">

						   		<div class="media"><!--- item user name and date --->

						   			<div class="media-left">
											<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.user_in_charge#">

											<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
												<cfinvokeargument name="user_id" value="#objectItem.user_in_charge#">
												<cfinvokeargument name="user_full_name" value="#objectItem.user_full_name#">
												<cfinvokeargument name="user_image_type" value="#objectItem.user_image_type#">
											</cfinvoke>

											</a>
										</div>

										<div class="media-body">

											<!---<span class="text_message_page">#objectItem.user_full_name#</span>--->
											<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.user_in_charge#" class="link_user">#objectItem.user_full_name#</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<cfset spacePos = findOneOf(" ", objectItem.creation_date)>
											<span class="text_date">#left(objectItem.creation_date, spacePos)#</span>
											&nbsp;&nbsp;&nbsp;
											<span class="text_hour">#right(objectItem.creation_date, len(objectItem.creation_date)-spacePos)#</span>

										</div>

								</div><!--- END media --->

							</div><!--- END col-xs-12 --->

						</div><!--- END row --->

						<!---
							<div class="div_message_page_label"><span lang="es">Fecha de creación:</span> <span class="text_message_page">#objectItem.creation_date#</span></div>
						--->

						<cfif isDefined("objectItem.last_update_user_id") AND isNumeric(objectItem.last_update_user_id)>

							<hr style="margin-top:3px;margin-bottom:5px;">

							<div class="row">

								<div class="col-xs-12">

							   		<div class="media"><!--- Usuario última modificación --->

							   			<div class="media-left">
											<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.last_update_user_id#">

												<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
													<cfinvokeargument name="user_id" value="#objectItem.last_update_user_id#">
													<cfinvokeargument name="user_full_name" value="#objectItem.last_update_user_full_name#">
													<cfinvokeargument name="user_image_type" value="#objectItem.last_update_user_image_type#">
												</cfinvoke>

											</a>
										</div>

										<div class="media-body">

											<!---<span class="text_message_page">#objectItem.user_full_name#</span>--->
											<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.last_update_user_id#" class="link_user">#objectItem.last_update_user_full_name#</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<cfset spacePos = findOneOf(" ", objectItem.last_update_date)>
											<span class="text_date">#left(objectItem.last_update_date, spacePos)#</span>
											&nbsp;&nbsp;&nbsp;
											<span class="text_hour">#right(objectItem.last_update_date, len(objectItem.last_update_date)-spacePos)#</span>
											<span class="label label-info" lang="es">Modificación</span>

										</div>


									</div><!--- END media --->

								</div><!--- END col-xs-12 --->

							</div><!--- END row --->

							<hr style="margin-top:3px;">

						<cfelse>

							<hr style="margin-top:3px;">

						</cfif>


						<div class="media">

							<cfif len(objectItem.attached_file_thumbnail_format) GT 0 OR (isDefined("objectItem.attached_image_thumbnail_format") AND len(objectItem.attached_image_thumbnail_format) GT 0)>
								<div class="media-left">
									<cfif len(objectItem.attached_file_thumbnail_format) GT 0>
										<img src="#APPLICATION.htmlPath#/file_download.cfm?id=#objectItem.attached_file_id#&#itemTypeName#=#objectItem.id#&thumbnail=1" alt="Thumbnail" class="media-object img-thumbnail"/>
									</cfif>
									<cfif isDefined("objectItem.attached_image_thumbnail_format") GT 0 AND len(objectItem.attached_image_thumbnail_format) GT 0>
										<img src="#APPLICATION.htmlPath#/file_download.cfm?id=#objectItem.attached_image_id#&#itemTypeName#=#objectItem.id#&thumbnail=1" alt="Thumbnail" class="media-object img-thumbnail"/>
									</cfif>
								</div>
							</cfif>

							<div class="media-body">


								<cfif ( itemTypeId IS 11 OR itemTypeId IS 12 OR itemTypeId IS 13 ) AND objectItem.general IS true>
									<div class="row">
										<div class="col-xs-12">
											<h6><span class="label label-info" lang="es">#itemTypeStruct.label# global</span></h6>

											<cfif itemTypeId IS 13 OR ( (itemTypeId IS 11 OR itemTypeId IS 12) AND objectItem.general IS true )><!--- Lists, Forms AND Typologies --->

												<cfif isDefined("arguments.internal_user")>

													<div class="div_message_page_label">

													<cfset table_area_allowed = false>

													<cfif arguments.internal_user IS false>

														<!---area_allowed--->
														<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="canUserAccessToArea" returnvariable="table_area_allowed">
															<cfinvokeargument name="area_id" value="#objectItem.area_id#">
														</cfinvoke>

													</cfif>

													<cfif arguments.internal_user IS true OR table_area_allowed>

														<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="getArea" returnvariable="tableArea">
															<cfinvokeargument name="area_id" value="#objectItem.area_id#">
														</cfinvoke>

														<span lang="es">Propiedad del área:</span>
														<cfif itemTypeId IS 13>
															<a href="typologies.cfm?area=#objectItem.area_id#&#itemTypeName#=#objectItem.id#">#tableArea.name#</a>
														<cfelse>
															<a href="area_items.cfm?area=#objectItem.area_id####itemTypeName##objectItem.id#">#tableArea.name#</a>
														</cfif>

													</cfif>

													</div>

												</cfif>

											</cfif>

										</div>
									</div>
								</cfif>

								<cfif isDefined("arguments.categories")>

									<cfif arguments.categories.recordCount GT 0>

										<div class="row">

											<div class="col-xs-12">

												<div class="div_message_page_label"><span lang="es">Categorías</span>:

												<cfloop query="#categories#">

													<span class="label label-default">#categories.category_name#</span>

												</cfloop>

												</div>

											</div>

										</div>

									</cfif>

								</cfif>

								<div class="clearfix">

									<cfif isNumeric(objectItem.attached_file_id)><!--- Attached file --->

										<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFileIcon" returnvariable="attached_file_icon">
											<cfinvokeargument name="file_name" value="#objectItem.attached_file_name#"/>
										</cfinvoke>

										<div><!---<span lang="es">Archivo:</span>---><a href="#APPLICATION.htmlPath#/file_download.cfm?id=#objectItem.attached_file_id#&#itemTypeName#=#objectItem.id#" onclick="return downloadFileLinked(this,event)" class="link_attached"> <i class="#attached_file_icon#"></i>  #objectItem.attached_file_name#</a></div>

									</cfif>

									<cfif arguments.itemTypeId IS NOT 1 AND isNumeric(objectItem.attached_image_id)><!--- Attached image --->

										<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFileIcon" returnvariable="attached_image_icon">
											<cfinvokeargument name="file_name" value="#objectItem.attached_image_name#"/>
										</cfinvoke>

										<div><a href="#APPLICATION.htmlPath#/file_download.cfm?id=#objectItem.attached_image_id#&#itemTypeName#=#objectItem.id#" onclick="return downloadFileLinked(this,event)" class="link_attached"><i class="#attached_image_icon#"></i> #objectItem.attached_image_name#</a></div>
									</cfif>


									<cfif len(objectItem.link) GT 0>

										<div><cfif SESSION.client_abb EQ "omars" AND find("/html/download_gtrabajo.cfm?area=", objectItem.link) GT 0>

											<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFileIcon" returnvariable="attached_file_icon">
												<cfinvokeargument name="file_name" value="#objectItem.link#"/>
											</cfinvoke>

											<a href="#objectItem.link#" target="_blank" class="link_attached" onclick="return downloadFileLinked(this,event)" title="Descargar"><i class="#attached_file_icon#"></i>
											#listLast(objectItem.link, "=")#</a>

										<cfelse>

											<a href="#objectItem.link#" target="_blank" class="link_external"><i class="icon-link"></i> #objectItem.link#</a>

										</cfif></div>


									</cfif>

									<cfif itemTypeId IS 8 AND len(objectItem.identifier) GT 0 AND isNumeric(objectItem.sub_type_id) AND subTypeQuery.recordCount GT 0 AND subTypeQuery.sub_type_id IS 1>
										<cfset pubMedUrl = "http://www.ncbi.nlm.nih.gov/pubmed/"&objectItem.identifier>
										<div> <span class="text_message_page"><a href="#pubMedUrl#" target="_blank" class="link_external"><i class="icon-external-link-sign"></i> #pubMedUrl#</a></span></div>
									</cfif>

									<cfif isDefined("objectItem.iframe_url") AND len(objectItem.iframe_url) GT 0>
										<div><span lang="es">URL contenido incrustado:</span><br/> <a href="#objectItem.iframe_url#" target="_blank">#objectItem.iframe_url#</a></div>
									</cfif>

									<cfif NOT isDefined("objectItem.last_update_user_id") OR NOT isNumeric(objectItem.last_update_user_id)>

										<cfif itemTypeId IS NOT 1 AND itemTypeId IS NOT 7>
											<cfif len(objectItem.last_update_date) GT 0>
											<div class="div_message_page_label"><span lang="es">Fecha de última modificación:</span> <span class="text_message_page">#objectItem.last_update_date#</span></div>
											</cfif>
										</cfif>

									</cfif>


									<cfif itemTypeId IS 6><!---Tasks--->
										<div class="div_message_page_label"><span lang="es">Asignada a:</span>

										<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.recipient_user#"><cfif len(objectItem.recipient_user_image_type) GT 0>
											<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#objectItem.recipient_user#&type=#objectItem.recipient_user_image_type#&small=" alt="#objectItem.recipient_user_full_name#" class="item_img"/>
										<cfelse>
											<img src="#APPLICATION.htmlPath#/assets/v3/icons/user_default.png" alt="#objectItem.recipient_user_full_name#" class="item_img_default" />
										</cfif></a>

										<a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.recipient_user#">#objectItem.recipient_user_full_name#</a></div>
									</cfif>

									<cfif APPLICATION.moduleWeb IS true AND itemTypeId NEQ 13 AND ( len(area_type) GT 0 OR itemTypeId IS 11 OR itemTypeId IS 12 )><!--- WEB --->
										<!--- Debe poder mostrarse el estado de publicación en las listas y formularios aunque no estén en áreas web para poder publicar sus vistas en áreas web --->

										<cfif len(objectItem.publication_date) GT 0>
											<div class="div_message_page_label"><span lang="es">Fecha de publicación:</span> <span class="text_message_page">#objectItem.publication_date#</span>
												<!---<span lang="es">Hora:</span> <span class="text_message_page">#TimeFormat(objectItem.publication_time,"HH:mm")#</span>--->
											</div>
										</cfif>
										<cfif APPLICATION.publicationValidation IS true AND len(objectItem.publication_validated) GT 0>
											<div class="div_message_page_label"><span lang="es">Publicación aprobada:</span> <span class="text_message_page" lang="es"><cfif objectItem.publication_validated IS true>Sí<cfelse><b>No</b></cfif></span>
											</div>
										</cfif>
										<cfif APPLICATION.publicationRestricted IS true AND len(objectItem.publication_restricted) GT 0>
											<div class="div_message_page_label"><span lang="es">Publicación visible sólo para usuarios identificados:</span> <span class="text_message_page" lang="es"><cfif objectItem.publication_restricted IS true>Sí<cfelse><b>No</b></cfif></span>
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

									<cfelseif itemTypeId IS 17><!--- Mailing --->

										<div class="div_message_page_label"><span lang="es">Estado:</span> <cfswitch expression="#objectItem.state#">
											<cfcase value="created"><span class="label label-default" lang="es">Creado</span></cfcase>
											<cfcase value="modified"><span class="label label-default" lang="es">Modificado</span></cfcase>
											<cfcase value="sent_to_test"><span class="label label-default" lang="es">Enviado a destinatarios para pruebas</span></cfcase>
											<cfcase value="sent"><span class="label label-success" lang="es">Enviado</span></cfcase>
										</cfswitch></div>

										<cfif objectItem.state NEQ "created" AND objectItem.state NEQ "modified">
											<div class="div_message_page_label"><span lang="es">Fecha de <cfswitch expression="#objectItem.state#">
												<cfcase value="sent_to_test">envío para pruebas</cfcase>
												<cfcase value="sent">envío</cfcase>
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
										<div class="div_message_page_label"><span lang="es">Realizada:</span> <span class="text_message_page" lang="es"><cfif objectItem.done IS true>Sí<cfelse>No</cfif></span></div>
										</cfif>

									</cfif>

									<cfif itemTypeId IS 7 OR itemTypeId IS 8><!---Consultations, Publications --->

										<cfif itemTypeId IS 8 AND isNumeric(objectItem.sub_type_id)>
											<cfif subTypeQuery.recordCount GT 0>
												<div class="div_message_page_label"><span lang="es">Tipo:</span> <span class="text_message_page" lang="es">#subTypeQuery.sub_type_title_es#</span></div>
											</cfif>
										</cfif>

										<cfif len(objectItem.identifier) GT 0>
										<div class="div_message_page_label"><span lang="es">Identificador:</span> <span class="text_message_page">#objectItem.identifier#</span></div>
										</cfif>

										<cfif itemTypeId IS 8 AND ( subTypeQuery.recordCount IS 0 OR subTypeQuery.sub_type_id NEQ 1 )>

											<div class="div_message_page_label"><span lang="es">Valor:</span> <span class="text_message_page">#objectItem.price#</span></div>

										</cfif>

									</cfif>

									<cfif itemTypeId IS 5><!---Events--->
										<div class="div_message_page_label"><span lang="es">Valor:</span> <span class="text_message_page">#objectItem.price#</span></div>
									</cfif>


									<cfif APPLICATION.publicationScope IS true AND ( itemTypeId IS 11 OR itemTypeId IS 12 )>
										<div class="div_message_page_label"><span lang="es">Ámbito de publicación:</span> <span class="text_message_page">#objectItem.publication_scope_name#</span></div>
									</cfif>


								</div><!--- END div class clearfix --->


								<cfif itemTypeId NEQ 1 OR isNumeric(objectItem.attached_file_id) OR len(objectItem.link) GT 0>
									<!---<hr>--->
								</cfif>



								<cfif itemTypeId IS 17><!--- Mailing --->

									<div style="padding-top:10px">

										<textarea name="description" id="description" style="height:500px;" readonly="readonly">
											#objectItem.head_content#

											<div style="#objectItem.content_styles#">
												#objectItem.description#
											</div>

											#objectItem.foot_content#
										</textarea>

									</div>

								<cfelseif itemTypeId IS 20><!--- DP Document --->
									<div class="div_message_page_description" style="margin-top:10px">
										#objectItem.description#
									</div>
								<cfelse>
									<div class="lead div_message_page_description">
										#objectItem.description#
									</div>
								</cfif>


							</div><!--- END media-body --->
						</div><!--- END media --->



						<!---itemUrl--->
						<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getAreaItemUrl" returnvariable="areaItemUrl">
							<cfinvokeargument name="item_id" value="#objectItem.id#">
							<cfinvokeargument name="itemTypeName" value="#itemTypeName#">
							<cfif isDefined("arguments.area_id")>
								<cfinvokeargument name="area_id" value="#arguments.area_id#">
							<cfelse>
								<cfinvokeargument name="area_id" value="#objectItem.area_id#">
							</cfif>

							<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
						</cfinvoke>

						<div class="clearfix">

							<!---<div class="div_message_page_label"><span lang="es">URL en #APPLICATION.title#:</span></div>--->
							<div class="input-group">

								<span class="input-group-addon" style="padding-left:0"><i class="fa fa-share-alt" style="font-size: 16px;"></i></span>
								<input type="text" value="#areaItemUrl#" onClick="this.select();" class="form-control item_url_dp" readonly="readonly" style="cursor:text"/>

							</div>

							<cfif (area_type EQ "web" OR area_type EQ "intranet") AND isDefined("arguments.webPath")>

								<cfif itemTypeId IS 4 OR itemTypeId IS 5><!--- News AND Events --->

									<!---itemWebUrl--->
									<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getItemWebPage" returnvariable="itemPage">
										<cfinvokeargument name="item_id" value="#objectItem.id#">
										<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
										<cfinvokeargument name="title" value="#objectItem.title#">
									</cfinvoke>
									<cfset itemWebUrl = "/#arguments.webPath#/#itemPage#">

									<div class="div_message_page_label"><span lang="es">URL relativa en la <b>#area_type#</b>:</span></div>
									<input type="text" value="#itemWebUrl#" onClick="this.select();" class="form-control item_url_dp" readonly="readonly" style="cursor:text"/>

								<cfelseif itemTypeId IS 9 AND isNumeric(objectItem.attached_image_id)><!--- Images --->

									<!---fileWebUrl--->
									<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getAttachedFileWebPage" returnvariable="filePage">
										<cfinvokeargument name="file_id" value="#objectItem.attached_image_id#">
										<cfinvokeargument name="item_id" value="#objectItem.item_id#">
										<cfinvokeargument name="itemTypeName" value="#itemTypeName#">
									</cfinvoke>
									<cfset fileWebUrl = "/#arguments.webPath#/#filePage#">

									<div class="div_file_page_label"><span lang="es">URL</span> <b lang="es">relativa para enlazar el archivo en la #area_type#</b><cfif APPLICATION.publicationValidation IS true AND objectItem.publication_validated IS false>(publicación de archivo <b>no aprobada</b>)</cfif></span>:</div>
									<div class="div_file_page_user"><input type="text" value="#fileWebUrl#" onClick="this.select();" class="form-control item_url_dp" readonly="readonly" style="cursor:text"/></div>

								</cfif>

							</cfif>

						</div>

					</div><!--- END panel-body --->
				</div><!--- END panel panel-default --->
			</cfoutput>



			<cfif itemTypeId IS 17><!--- Mailing --->

				<cfinvoke component="#APPLICATION.htmlComponentsPath#/CKEditorManager" method="loadComponent">
					<cfinvokeargument name="name" value="description">
					<cfinvokeargument name="language" value="#SESSION.user_language#"/>
					<cfinvokeargument name="height" value="500"/>
					<cfinvokeargument name="toolbar" value="DP_document"/>
					<cfinvokeargument name="readOnly" value="true"/>
					<cfinvokeargument name="toolbarCanCollapse" value="true"/>
					<cfinvokeargument name="toolbarStartupExpanded" value="false"/>
					<cfinvokeargument name="removePlugins" value="elementspath,wordcount,toolbar"/>
					<cfinvokeargument name="allowedContent" value="true">
					<cfinvokeargument name="resize_enabled" value="false">
				</cfinvoke>

				<cfoutput>
				<script>
					CKEDITOR.config.contentsCss = '#APPLICATION.htmlPath#/mailing_styles.cfm?mailing=#objectItem.id#';
				</script>
				</cfoutput>

			</cfif>

			<!---
			<cfif itemTypeId IS 20><!--- DoPlanning Document --->

				<cfinvoke component="#APPLICATION.htmlComponentsPath#/CKEditorManager" method="loadComponent">
					<cfinvokeargument name="name" value="description">
					<cfinvokeargument name="language" value="#SESSION.user_language#"/>
					<cfinvokeargument name="height" value="500"/>
					<cfinvokeargument name="readOnly" value="true"/>
					<cfinvokeargument name="toolbarStartupExpanded" value="false"/>
					<cfinvokeargument name="toolbarCanCollapse" value="true"/>
				</cfinvoke>

			</cfif>
			--->

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
		<cfargument name="openItemOnSelect" type="boolean" required="false" default="true">
		<cfargument name="select_enabled" type="boolean" required="false" default="false">

		<cfset var method = "outputItemsList">

		<cftry>

			<!---Required vars
				page_type

				page_types:

			--->
			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

			<cfset numItems = itemsQuery.recordCount>

			<cfif numItems GT 0>

			<cfif arguments.select_enabled IS true>
				<cfset baseCol = 1>
			<cfelse>
				<cfset baseCol = 0>
			</cfif>

			<cfoutput>

				<script>

					$(document).ready(function() {

						$("##listTable").tablesorter({

							<cfif arguments.full_content IS false>
								<cfif itemTypeId IS 6><!---Tasks--->
									widgets: ['filter','stickyHeaders','math'],
								<cfelse>
									widgets: ['filter','stickyHeaders'],
								</cfif>
							</cfif>

							<cfif itemTypeId IS 6><!---Tasks--->
								<cfif arguments.full_content IS false>
								sortList: [[#baseCol+8#,1]] ,
								<cfelse>
								sortList: [[#baseCol+8#,0]] ,
								</cfif>
							<cfelseif arguments.full_content IS true>
								sortList: [[#baseCol+4#,1]] ,
							<cfelseif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News Order by position--->
								sortList: [[#baseCol+5#,1]] ,
							<cfelse>
								sortList: [[#baseCol+4#,1]] ,
							</cfif>
							headers: {
								<cfif itemTypeId IS NOT 6>
								#baseCol+0#: {
									sorter: false
								},
								#baseCol+1#: {
									sorter: "text"
								},
								#baseCol+4#: {
									sorter: "datetime"
								}
								<cfelse><!---Tasks--->
									#baseCol+1#: {
										sorter: "text"
									},
									#baseCol+7#: {
										sorter: "datetime"
									},
									#baseCol+8#: {
										sorter: "datetime"
									}
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

								<cfif itemTypeId IS 6><!---Tasks--->
									, math_data     : 'math' // data-math attribute
								    , math_ignore   : [0,1,2,3,4,7,8,9]
								    <!---. math_mask     : '##,####0.00'--->
								    <!---, math_complete : function($cell, wo, result, value, arry) {
								        var txt = '<span class="align-decimal"> ' + result + '</span>';
								        if ($cell.attr('data-math') === 'all-sum') {
								          // when the "all-sum" is processed, add a count to the end
								          return txt + ' (Sum of ' + arry.length + ' cells)';
								        }
								        return txt;
								    } --->
								</cfif>

						    }
						   </cfif>
						});

						<cfif arguments.openItemOnSelect IS true>
						<!--- https://code.google.com/p/tablesorter-extras/wiki/TablesorterSelect --->
						<!---$('##listTable').bind('select.tablesorter.select', function(event, ts){
						    var itemUrl= $(ts.elem).data("item-url");
						    openUrlLite(itemUrl,'itemIframe');
						});--->

							$('##listTable tbody tr').on('click', function(e) {

					        var row = $(this);
					        var itemUrl = row.data("item-url");
					        goToUrl(itemUrl);

					    });

						</cfif>

						<cfif arguments.select_enabled IS true>

							$('##listTable tbody input[type=checkbox]').on('click', function(e) {

					    	stopPropagation(e);

					    	if( $('##listTable tbody tr:visible input[type=checkbox]:checked').length > 0 ){
									$('##actionItemsNavBar').show();
									$('##actionItemsHelpText').hide();
								}else{
									$('##actionItemsNavBar').hide();
									$('##actionItemsHelpText').show();
								}

					    });

						</cfif>


					});
				</script>

				<table id="listTable" class="table table-hover table-bordered table-striped tablesorter-bootstrap">
					<thead>
						<tr>
							<cfif select_enabled IS true>
								<th style="width:35px;" class="filter-false"></th>
							</cfif>
							<cfif itemTypeId IS NOT 6>
								<th style="width:35px" class="filter-false"></th>
								<cfif arguments.full_content IS false>
									<cfif itemTypeId IS 1><!---Messages--->
										<th style="width:55%"><span lang="es">Asunto</span></th>
									<cfelseif itemTypeId IS 2 OR itemTypeId IS 3><!---Entries, Links--->
										<th style="width:49%"><span lang="es">Título</span></th>
									<cfelse>
										<th style="width:55%"><span lang="es">Título</span></th>
									</cfif>
									<th style="width:5%" class="filter-false"></th>
									<th style="width:23%"><span lang="es">De</span></th>
									<th style="width:12%"><span lang="es">Fecha</span></th>
									<cfif itemTypeId IS 5><!---Events--->
										<th style="width:8%"><span lang="es">Inicio</span></th>
										<th style="width:4%"><span lang="es">Fin</span></th>
									<cfelseif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News--->
									<th style="width:6%" class="filter-false">##</th>
									<cfelseif itemTypeId IS 8><!---Publications---><!---itemTypeId IS 7 OR --->
									<th style="width:6%"><span lang="es">Identificador</span></th>
									</cfif>
								<cfelse>
									<th style="width:39%"><span lang="es"><cfif itemTypeId IS 1>Asunto<cfelse>Título</cfif></span></th>
									<th style="width:5%" class="filter-false"></th>
									<th style="width:19%"><span lang="es">De</span></th>
									<th style="width:10%"><span lang="es">Fecha</span></th>
									<cfif itemTypeId IS 5><!---Events--->
										<th style="width:5%"><span lang="es">Inicio</span></th>
										<th style="width:5%"><span lang="es">Fin</span></th>
									<cfelseif itemTypeId IS 8><!---Publications--->
										<th style="width:6%"><span lang="es">Identificador</span></th>
									</cfif>
									<th style="width:23%" lang="es"><span lang="es">Área</span></th>
								</cfif>
							<cfelse><!---Tasks--->
								<th style="width:34px" class="filter-false"></th>
								<cfif arguments.full_content IS false>
								<th style="width:27%"><span lang="es">Título</span></th>
								<th style="width:4%" class="filter-false"></th>
								<th style="width:17%"><span lang="es">De</span></th>
								<th style="width:17%"><span lang="es">Para</span></th>
								<th style="width:5%"><span lang="es">VE</span></th>
								<th style="width:5%"><span lang="es">VR</span></th>
								<th style="width:10%"><span lang="es">Inicio</span></th>
								<th style="width:10%"><span lang="es">Fin</span></th>
								<cfelse>
								<th style="width:16%"><span lang="es">Título</span></th>
								<th style="width:4%"></th>
								<th style="width:15%"><span lang="es">De</span></th>
								<th style="width:15%"><span lang="es">Para</span></th>
								<th style="width:6%"><span lang="es">VE</span></th>
								<th style="width:6%"><span lang="es">VR</span></th>
								<th style="width:10%"><span lang="es">Inicio</span></th>
								<th style="width:10%"><span lang="es">Fin</span></th>
								<th style="width:14%"><span lang="es">Área</span></th>
								</cfif>
							</cfif>
						</tr>
					</thead>

					<cfif arguments.full_content IS false AND itemTypeId IS 6><!---Tasks--->
					<tfoot>
					   <tr>
							<cfif select_enabled IS true>
		 						<th></th>
		 					</cfif>
					   	<th></th>
					   	<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th data-math="col-sum"></th>
							<th data-math="col-sum"></th>
							<th></th>
							<th></th>
						</tr>
					</tfoot>
					</cfif>

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

						<cfif arguments.openItemOnSelect IS true AND alreadySelected IS false>

							<cfif isDefined("URL.#itemTypeName#")>

								<cfif URL[itemTypeName] IS itemsQuery.id>

									<!--- ESTO PUESTO AQUÍ HACE QUE FALLE EL TABLESORTER PARA LAS SUMAS --->
									<!---<script type="text/javascript">
										openUrlHtml2('#item_page_url#','itemIframe');
									</script>--->

									<cfset onpenUrlHtml2 = item_page_url>

									<cfset itemSelected = true>
								</cfif>

							<!---<cfelseif itemsQuery.currentRow IS 1>


								<cfif app_version NEQ "mobile">

									<!--- ESTO PUESTO AQUÍ HACE QUE FALLE EL TABLESORTER PARA LAS SUMAS --->
									<!---<script type="text/javascript">
										openUrlHtml2('#item_page_url#','itemIframe');
									</script>--->

									<cfset onpenUrlHtml2 = item_page_url>

									<cfset itemSelected = true>

								</cfif>
								--->

							</cfif>

							<cfif itemSelected IS true>
								<cfset alreadySelected = true>
							</cfif>

						</cfif>

						<!---Para lo de seleccionar el primero, en lugar de como está hecho, se puede llamar a un método JavaScript que compruebe si el padre es el HTML2, y si lo es seleccionar el primero--->


						<tr <cfif itemSelected IS true>class="selected"</cfif> data-item-url="#item_page_url#" data-item-id="#itemsQuery.id#" onclick="stopEvent(event)"><!--- id: usado para cuando se tiene que obtener el id del elemento seleccionado (al seleccionar un listado de elementos)--->
							<cfif select_enabled IS true>
								<td style="text-align:center" onclick="stopEvent(event)">
									<input type="checkbox" name="selected_file_#itemsQuery.id#" value="#itemsQuery.id#">
								</td>
							</cfif>
							<td style="text-align:center">
								<cfif itemTypeId IS 6><!---Tasks--->

									<cfif itemsQuery.done IS true>
										<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_done.png" alt="Tarea realizada" title="Tarea realizada" class="item_img" style="width:30px" lang="es"/>
										<span class="hidden">1</span>
									<cfelse>
										<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_not_done.png" alt="Tarea no realizada" title="Tarea no realizada" class="item_img" style="width:30px" lang="es"/><span class="hidden">0</span>
									</cfif>

								<cfelseif itemTypeId IS NOT 3><!---No es link--->

									<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
										<cfinvokeargument name="user_id" value="#itemsQuery.user_in_charge#">
										<cfinvokeargument name="user_full_name" value="#itemsQuery.user_full_name#">
										<cfinvokeargument name="user_image_type" value="#itemsQuery.user_image_type#">
										<cfinvokeargument name="width_px" value="40">
									</cfinvoke>

								<cfelse><!---style="max-width:none;" Requerido para corregir un bug con Bootstrap en Chrome--->
									<a href="#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#" style="float:left;" target="_blank" title="Visitar el enlace" onclick="event.stopPropagation()"><img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" class="item_img" style="width:30px"/></a>
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
								<a href="#APPLICATION.path#/html/#item_page_url#" class="#titleClass#">#itemsQuery.title#</a></td>
							<td><!---Attached files--->
								<cfif isNumeric(itemsQuery.attached_file_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_file_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar archivo adjunto"><i class="icon-paper-clip"></i><span class="hidden">1</span></a>
								</cfif>
								<cfif itemTypeId IS NOT 1 AND isNumeric(itemsQuery.attached_image_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_image_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar imagen adjunta"><i class="icon-camera"></i><span class="hidden">2</span></a>

								</cfif>
							</td>
							<td>
								<cfif itemTypeId IS 6><!---Tasks--->
									<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
										<cfinvokeargument name="user_id" value="#itemsQuery.user_in_charge#">
										<cfinvokeargument name="user_full_name" value="#itemsQuery.user_full_name#">
										<cfinvokeargument name="user_image_type" value="#itemsQuery.user_image_type#">
										<cfinvokeargument name="width_px" value="40">
									</cfinvoke>
								</cfif>
								<span>#itemsQuery.user_full_name#</span></td>
							<cfif arguments.itemTypeId IS 6><!---Tasks--->
							<td>
								<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
									<cfinvokeargument name="user_id" value="#itemsQuery.recipient_user#">
									<cfinvokeargument name="user_full_name" value="#itemsQuery.recipient_user_full_name#">
									<cfinvokeargument name="user_image_type" value="#itemsQuery.recipient_user_image_type#">
									<cfinvokeargument name="width_px" value="40">
								</cfinvoke>
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
							<cfelseif itemTypeId IS 8><!---Publications---><!---itemTypeId IS 7 OR --->
								<td>#itemsQuery.identifier#</td>
							</cfif>



							<cfif arguments.full_content IS true>
								<!---#itemTypeNameP#.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#--->
								<td><a onclick="openUrl('area_items.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#','areaIframe',event)" class="link_blue">#itemsQuery.area_name#</a></td>
							<cfelse>
								<cfif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News--->
								<td style="vertical-align:middle"><span style="line-height:30px;">#itemsQuery.position#</span></td>
								</cfif>
							</cfif>

						</tr>
					</cfloop>
					</tbody>

				</table>

				<cfif isDefined("onpenUrlHtml2")>

					<!---Esta acción sólo se completa si está en la versión HTML2--->
					<script>
						openUrlHtml2('#onpenUrlHtml2#','itemIframe');
					</script>

				</cfif>

				</cfoutput>
			</cfif>


			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>

		</cftry>

	</cffunction>


	<!--- outputConsultationsList --->

	<cffunction name="outputConsultationsList" returntype="void" output="true" access="public">
		<cfargument name="itemsQuery" type="query" required="true">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="full_content" type="boolean" required="no" default="false">
		<cfargument name="return_page" type="string" required="no">
		<cfargument name="app_version" type="string" required="true">
		<cfargument name="openItemOnSelect" type="boolean" required="false" default="true">
		<cfargument name="select_enabled" type="boolean" required="false" default="false">

		<cfset var method = "outputConsultationsList">

		<cftry>

			<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

			<cfset numItems = itemsQuery.recordCount>

			<cfif numItems GT 0>

				<script type="text/javascript">
					$(document).ready(function() {

						$("##listTable").tablesorter({
							<cfif arguments.full_content IS false>
							widgets: ['zebra','uitheme','filter'],<!---,'select'--->
							<cfelse>
							widgets: ['zebra','uitheme'],<!---,'select'--->
							</cfif>
							theme : "bootstrap",
							headerTemplate : '{content} {icon}',
							sortList: [[1,1]],
							headers: {
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

						<cfif arguments.openItemOnSelect IS true>
						<!--- https://code.google.com/p/tablesorter-extras/wiki/TablesorterSelect --->
						<!---$('##listTable').bind('select.tablesorter.select', function(event, ts){
						    var itemUrl= $(ts.elem).data("item-url");
						    openUrlLite(itemUrl,'itemIframe');
						});--->

						$('##listTable tbody tr').on('click', function(e) {

					        var row = $(this);
					        var itemUrl = row.data("item-url");
					        goToUrl(itemUrl);

					    });
						</cfif>

						<cfif arguments.select_enabled IS true>

							$('##listTable tbody input[type=checkbox]').on('click', function(e) {

					    	stopPropagation(e);

					    	if( $('##listTable tbody tr:visible input[type=checkbox]:checked').length > 0 ){
									$('##actionItemsNavBar').show();
									$('##actionItemsHelpText').hide();
								}else{
									$('##actionItemsNavBar').hide();
									$('##actionItemsHelpText').show();
								}

					    });

						</cfif>

					});
				</script>


				<cfoutput>

				<table id="listTable" class="tablesorter">
					<thead>
						<tr>
							<cfif select_enabled IS true>
								<th style="width:35px;" class="filter-false"></th>
							</cfif>
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

						<!---Para lo de seleccionar el primero, en lugar de como está hecho, se puede llamar a un método JavaScript que compruebe si el padre es el HTML2, y si lo es seleccionar el primero--->

						<tr <cfif itemSelected IS true>class="selected"</cfif> data-item-url="#item_page_url#" data-item-id="#itemsQuery.id#" onclick="stopEvent(event)"><!--- id: usado para cuando se tiene que obtener el id del elemento seleccionado (al seleccionar un listado de elementos)--->
							<cfif select_enabled IS true>
								<td style="text-align:center" onclick="stopEvent(event)">
									<input type="checkbox" name="selected_file_#itemsQuery.id#" value="#itemsQuery.id#">
								</td>
							</cfif>
							<td>
								<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
									<cfinvokeargument name="user_id" value="#itemsQuery.user_in_charge#">
									<cfinvokeargument name="user_full_name" value="#itemsQuery.user_full_name#">
									<cfinvokeargument name="user_image_type" value="#itemsQuery.user_image_type#">
									<cfinvokeargument name="width_px" value="40">
								</cfinvoke>
								&nbsp;<span>#itemsQuery.user_full_name#</span></td>
							<td><span>#itemsQuery.creation_date#</span></td>
							<td><a href="#APPLICATION.path#/html/#item_page_url#" class="text_item">#itemsQuery.title#</a></td>
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
								<td><a onclick="openUrl('area_items.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#','areaIframe',event)" class="link_blue">#itemsQuery.area_name#</a></td>
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


	<!--- outputAllItemsList --->

	<cffunction name="outputAllItemsList" returntype="void" output="true" access="public">
		<cfargument name="itemsQuery" type="query" required="true">
		<cfargument name="area_type" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="false">
		<cfargument name="return_page" type="string" required="false">
		<cfargument name="app_version" type="string" required="true">

		<cfset var method = "outputAllItemsList">

		<cfset var selectFirst = true>

		<cftry>

			<cfset var numUrlParams = StructCount(URL)>

			<cfif numUrlParams GT 1 AND NOT (numUrlParams EQ 2 AND isDefined("URL.abb"))>
				<cfset selectFirst = false>
			</cfif>

			<cfset numItems = itemsQuery.recordCount>

			<cfif numItems GT 0>

				<cfif isDefined("arguments.area_id")>
					<cfset area_param = "area=#arguments.area_id#">
				<cfelse>
					<cfset area_param = "area=#itemsQuery.area_id#">
				</cfif>

				<script>

					$(document).ready(function() {

						$("##listTable").tablesorter({
							widgets: ['filter'],
							<cfif len(area_type) GT 0><!--- WEB --->
							sortList: [[5,1]] ,
							<cfelseif numItems LT 500><!---Cuando hay muchos elementos el ordenar por fecha da error y aparecen errores en Firefox--->
							sortList: [[4,1]] ,
							</cfif>
							headers: {
								1: {
									sorter: "text"
								}
								<cfif numItems GT 610>
								, 4: {
									sorter: "false"
								}
								<cfelse>
								, 4: {
									sorter: "datetime"
								}
								</cfif>

								<cfif len(area_type) GT 0><!--- WEB --->
								, 6: {
									sorter: "false"
								}
								</cfif>
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

						$('##listTable tbody tr').on('click', function(e) {

					        var row = $(this);

					        if(!row.hasClass("selected")) {
					        	$('##listTable tbody tr').removeClass("selected");
					        	row.addClass("selected");
					        }

					        var itemUrl = row.data("item-url");
					        var itemTypeId = row.data("item-type-id");

					        if(itemTypeId == 11 || itemTypeId == 12 || itemTypeId == 14 || itemTypeId == 15){
					        	openUrlLite(itemUrl,'areaIframe');
					        } else {
					        	openUrlLite(itemUrl,'itemIframe');
					        }


					    });

					});
				</script>

				<table id="listTable" class="table table-hover table-bordered table-striped tablesorter-bootstrap">
					<thead>
						<tr>
							<th style="width:35px" class="filter-false"></th>
							<cfif len(area_type) IS 0>
							<th style="width:56%"><span lang="es">Título</span></th>
							<cfelse>
							<th style="width:47%"><span lang="es">Título/Contenido</span></th>
							</cfif>
							<th style="width:5%" class="filter-false"></th>
							<th style="width:23%"><span lang="es">De</span></th>
							<th style="width:12%"><span lang="es">Fecha</span></th>
							<cfif len(area_type) GT 0>
							<th style="width:5%" class="filter-false">##</th>
							<th style="width:3%" class="filter-false"></th>
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

						<cfif itemTypeId EQ 10><!---Files--->
							<cfset item_page_url = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&#area_param#&return_page=#URLEncodedFormat(rpage)#">
						<cfelseif itemTypeId EQ 11 OR itemTypeId EQ 12 OR itemTypeId EQ 14 OR itemTypeId EQ 15><!--- List AND Forms --->
							<cfset item_page_url = "#itemTypeName#_rows.cfm?#itemTypeName#=#itemsQuery.id#&#area_param#">
						<cfelse>
							<cfset item_page_url = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&return_page=#URLEncodedFormat(rpage)#">
						</cfif>

						<!---Item selection--->
						<cfset itemSelected = false>

						<cfif alreadySelected IS false>

							<cfif ( isDefined("URL.#itemTypeName#") AND (URL[itemTypeName] IS itemsQuery.id) ) OR ( selectFirst IS true AND itemsQuery.currentrow IS 1 AND app_version NEQ "mobile" ) >

								<cfif isDefined("URL.reply")>
									<cfset onpenUrlHtml2 = "#itemTypeName#_new.cfm?#itemTypeName#=#itemsQuery.id#&return_page=#URLEncodedFormat(rpage)#">
								<cfelseif itemTypeId EQ 11 OR itemTypeId EQ 12 OR itemTypeId EQ 14 OR itemTypeId EQ 15><!--- List AND Forms --->
									<cfset onpenUrlHtml2 = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&return_page=#URLEncodedFormat(rpage)#">
								<cfelse>
									<cfset onpenUrlHtml2 = item_page_url>
								</cfif>

								<!---Esta acción solo se completa si está en la versión HTML2--->
								<script>
									openUrlHtml2('#onpenUrlHtml2#','itemIframe');
								</script>

								<cfset itemSelected = true>
								<cfset alreadySelected = true>

							</cfif>

						</cfif>

						<!---Para lo de seleccionar el primero, en lugar de como está hecho, se puede llamar a un método JavaScript que compruebe si el padre es el HTML2, y si lo es seleccionar el primero--->

						<tr <cfif itemSelected IS true>class="selected"</cfif> data-item-url="#item_page_url#" data-item-type-id="#itemsQuery.itemTypeId#"><!--- onclick="openUrl('#item_page_url#','itemIframe',event)"--->
							<td style="text-align:center">
								<cfif itemTypeId IS 6><!---Tasks--->

									<cfif itemsQuery.done IS true>
										<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_done.png" alt="Tarea realizada" title="Tarea realizada" class="item_img" style="width:35px"/>
									<cfelse>
										<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_not_done.png" alt="Tarea no realizada" title="Tarea no realizada" class="item_img" style="width:35px"/>
									</cfif>

								<cfelseif itemTypeId IS 10><!--- File --->

									<cfif itemsQuery.file_type_id IS 1><!--- User file --->
										<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" class="item_img" alt="#itemTypeNameEs#" title="#itemTypeNameEs#" style="width:35px"/>
									<cfelseif itemsQuery.file_type_id IS 2><!--- Area file --->

										<cfif itemsQuery.locked IS true>
											<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_area_locked.png" class="item_img" alt="#itemTypeNameEs# del área bloqueado" title="#itemTypeNameEs# del área bloqueado" style="width:35px"/>
										<cfelse>
											<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_area.png" class="item_img" alt="#itemTypeNameEs# del área" title="#itemTypeNameEs# del área" style="width:35px"/>
										</cfif>

									<cfelseif itemsQuery.file_type_id IS 3>

										<cfif itemsQuery.locked IS true>
											<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_edited_locked.png" class="item_img" alt="#itemTypeNameEs# del área bloqueado" title="#itemTypeNameEs# del área bloqueado" style="width:35px"/>
										<cfelse>
											<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_edited.png" class="item_img" alt="#itemTypeNameEs# del área en edición" title="#itemTypeNameEs# del área en edición" style="width:35px"/>
										</cfif>

									</cfif>

								<cfelseif itemTypeId IS NOT 3><!---No es link--->

									<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" class="item_img" alt="#itemTypeNameEs#" title="#itemTypeNameEs#" style="width:35px"/>

								<cfelse><!---style="max-width:none;" Requerido para corregir un bug con Bootstrap en Chrome--->
									<a href="#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#" style="float:left;" target="_blank" title="Visitar el enlace" onclick="openUrl('#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#','_self',event)"><img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" class="item_img" style="width:35px"/></a>
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

								<cfset titleContent = itemsQuery.title>

								<cfif len(titleContent) IS 0>

									<cfset itemDescription = itemsQuery.description>

									<!---<cfinvoke component="#APPLICATION.htmlComponentsPath#/Interface" method="removeHTML" returnvariable="itemDescription">
										<cfinvokeargument name="string" value="#itemDescription#">
									</cfinvoke>--->
									<cfinvoke component="#APPLICATION.coreComponentsPath#/Utils" method="removeHTML" returnvariable="itemDescription">
										<cfinvokeargument name="string" value="#itemDescription#">
									</cfinvoke>

									<cfif len(itemsQuery.description) GT 100>
										<cfinvoke component="#APPLICATION.coreComponentsPath#/Utils" method="leftToNextSpace" returnvariable="itemContent">
											<cfinvokeargument name="str" value="#itemDescription#">
											<cfinvokeargument name="count" value="100">
										</cfinvoke>
										<cfset titleContent = "<i>#itemContent#...</i>">
									<cfelse>
										<cfset titleContent = "<i>#itemDescription#</i>">
									</cfif>

								</cfif>

								<a href="#APPLICATION.path#/html/#item_page_url#" onclick="preventEventDefault(event)" class="#titleClass#">#titleContent#</a>
							</td>
							<td>
								<cfif itemTypeId IS 11 OR itemTypeId IS 12 OR itemTypeId IS 14 OR itemTypeId IS 15 OR itemTypeId IS 16><!---Lists, Forms And Views--->
									<!---<a href="#itemTypeName#_rows.cfm?#itemTypeName#=#itemsQuery.id#" onclick="openUrl('#itemTypeName#_rows.cfm?#itemTypeName#=#itemsQuery.id#','_self',event)" title="Registros"><i class="icon-list" style="font-size:15px;"></i></a>--->
									<!--- onclick="openUrl('#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#','itemIframe',event)"--->
									<a href="#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&#area_param#" title="Más información de #itemTypeNameEs#"><i class="icon-info-sign" style="font-size:15px;"></i></a>
								</cfif>

								<!---Attached files--->
								<cfif itemTypeId IS 10><!--- File --->
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.id#&area=#itemsQuery.area_id#" onclick="return downloadFileLinked(this,event)" title="Descargar archivo"><i class="icon-download-alt" style="font-size:16px;"></i><span class="hidden">3</span></a>
								<cfelseif isNumeric(itemsQuery.attached_file_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_file_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar archivo adjunto"><i class="icon-paper-clip" style="font-size:16px;"></i><span class="hidden">1</span></a>
								</cfif>
								<cfif isNumeric(itemsQuery.attached_image_id)>
								<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_image_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" title="Descargar imagen adjunta"><i class="icon-camera" style="font-size:14px;"></i><span class="hidden">2</span></a>

								</cfif>
							</td>
							<td>

								<cfif itemsQuery.itemTypeId IS NOT 10 OR itemsQuery.file_type_id IS 1>

									<!---<cfif len(itemsQuery.user_image_type) GT 0>
										<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#itemsQuery.user_in_charge#&type=#itemsQuery.user_image_type#&small=" alt="#itemsQuery.user_full_name#" class="user_img"/>
									<cfelse>
										<img src="#APPLICATION.htmlPath#/assets/v3/icons/user_default.png" alt="#itemsQuery.user_full_name#" class="user_img_default" />
									</cfif>--->
									<div style="float:left;margin-right:5px;">
										<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
											<cfinvokeargument name="user_id" value="#itemsQuery.user_in_charge#">
											<cfinvokeargument name="user_full_name" value="#itemsQuery.user_full_name#">
											<cfinvokeargument name="user_image_type" value="#itemsQuery.user_image_type#">
											<cfinvokeargument name="width_px" value="40">
										</cfinvoke>
									</div>
									<span>#itemsQuery.user_full_name#</span>

								<cfelse><!--- Area files --->
									<i><span lang="es">Área</span></i>
								</cfif>

							</td>
							<td>
								<!---<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringDate">
									<cfinvokeargument name="timestamp_date" value="#itemsQuery.creation_date#">
								</cfinvoke>--->
								<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringDate">
									<cfinvokeargument name="timestamp_date" value="#itemsQuery.last_update_date#">
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

							<td><div class="item_position">#itemsQuery.position#</div></td>

							<td style="text-align:center">
								<div class="change_position"><cfif itemsQuery.currentRow NEQ 1>
								<cfset up_item_id = itemsQuery.id[itemsQuery.currentRow-1]>
								<cfset up_item_type = itemsQuery.itemTypeId[itemsQuery.currentRow-1]>
								<!---onclick="openUrl('area_item_position_up.cfm?item=#itemsQuery.id#&type=#itemTypeId#&oitem=#up_item_id#&otype=#up_item_type#&area=#itemsQuery.area_id#','areaIframe',event)"--->
								<a href="area_item_position_up.cfm?item=#itemsQuery.id#&type=#itemTypeId#&oitem=#up_item_id#&otype=#up_item_type#&area=#itemsQuery.area_id#&mode=list"><img src="#APPLICATION.htmlPath#/assets/v3/icons/up.jpg" alt="Subir" title="Subir"/></a><cfelse><br></cfif><cfif itemsQuery.currentRow NEQ itemsQuery.recordCount>
									<cfset down_item = itemsQuery.id[itemsQuery.currentRow+1]>
									<cfset down_item_type = itemsQuery.itemTypeId[itemsQuery.currentRow+1]>
									<!---onclick="openUrl('area_item_position_down.cfm?item=#itemsQuery.id#&type=#itemTypeId#&oitem=#down_item#&otype=#down_item_type#&area=#itemsQuery.area_id#','areaIframe',event)"--->
									<a href="area_item_position_down.cfm?item=#itemsQuery.id#&type=#itemTypeId#&oitem=#down_item#&otype=#down_item_type#&area=#itemsQuery.area_id#&mode=list"><img src="#APPLICATION.htmlPath#/assets/v3/icons/down.jpg" alt="Bajar" title="Bajar"/></a>
								</cfif></div>
							</td>

							</cfif>

						</tr>
					</cfloop>
					</tbody>

				</table>
			</cfif>


			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>

		</cftry>

	</cffunction>


	<!--- outputAllItemsFullList --->

	<cffunction name="outputAllItemsFullList" returntype="void" output="true" access="public">
		<cfargument name="itemsQuery" type="query" required="true">
		<cfargument name="area_id" type="numeric" required="false">
		<cfargument name="area_read_only" type="boolean" required="false">
		<cfargument name="area_type" type="string" required="false">
		<cfargument name="return_path" type="string" required="true">
		<cfargument name="return_page" type="string" required="false">
		<cfargument name="showLastUpdate" type="boolean" required="false" default="false">
		<cfargument name="generatePdf" type="boolean" required="false" default="false"><!--- true = Generate PDF --->
		<cfargument name="generateWord" type="boolean" required="false" default="false">
		<cfargument name="deletedItems" type="boolean" required="false" default="false"><!--- true = Elementos de la papelera --->
		<cfargument name="app_version" type="string" required="false" default="html2">

		<cfset var method = "outputAllItemsFullList">

		<cftry>

			<cfoutput>

			<div class="elements_container">

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
					<cfset item_page_url = "#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&area=#itemsQuery.area_id#&return_page=#URLEncodedFormat(rpage)#">
				</cfif>

				<cfif isDefined("arguments.area_id")>
					<cfset area_param = "&area=#arguments.area_id#">
				<cfelse>
					<cfset area_param = "&area=#itemsQuery.area_id#">
				</cfif>

				<div class="row element_item #itemTypeName#"><!--- row item container --->
					<div class="col-sm-12">

						<a name="#itemTypeName##itemsQuery.id#" class="item_anchor"></a>

						<div class="panel panel-default">
						  <div class="panel-body">

						   	<div class="row">

						   		<div class="col-xs-10 col-sm-11">

							   		<div class="media"><!--- item user name and date --->

							   			<a class="media-left">

										  	<cfif itemsQuery.itemTypeId IS 10>

										  		<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFile" returnvariable="objectFile">
													<cfinvokeargument name="file_id" value="#itemsQuery.id#">
													<cfinvokeargument name="area_id" value="#itemsQuery.area_id#">
													<cfif arguments.deletedItems IS true>
														<cfinvokeargument name="status" value="deleted">
													</cfif>
												</cfinvoke>

										  	</cfif>

										    <cfif itemsQuery.itemTypeId IS NOT 10 OR itemsQuery.file_type_id IS 1>

										    	<cfif arguments.showLastUpdate IS false OR NOT isNumeric(itemsQuery.last_update_user_id) OR itemsQuery.user_in_charge EQ itemsQuery.last_update_user_id>
										    		<cfset userInCharge = itemsQuery.user_in_charge>
										    		<cfset userImageType = itemsQuery.user_image_type>
										    		<cfset userFullName = itemsQuery.user_full_name>
										    	<cfelse>
										    		<!--- Last update user --->
										    		<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="getUser" returnvariable="objectUser">
														<cfinvokeargument name="user_id" value="#itemsQuery.last_update_user_id#">
													</cfinvoke>

													<cfset userInCharge = objectUser.id>
													<cfset userImageType = objectUser.image_type>
													<cfset userFullName = objectUser.user_full_name>
										    	</cfif>


											<cfelse><!--- Area files --->

												<cfif arguments.showLastUpdate IS true AND isNumeric(objectFile.replacement_user)>
													<cfset userInCharge = objectFile.replacement_user>
													<cfset userImageType = objectFile.replacement_user_image_type>
													<cfset userFullName = objectFile.replacement_user_full_name>
												<cfelse>
													<cfset userInCharge = itemsQuery.user_in_charge>
											    	<cfset userImageType = itemsQuery.user_image_type>
											    	<cfset userFullName = itemsQuery.user_full_name>
												</cfif>

												<!---<i><span lang="es">Área</span></i>--->
											</cfif>


											<cfif arguments.generatePdf IS false>

												<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserImage">
													<cfinvokeargument name="user_id" value="#userInCharge#">
													<cfinvokeargument name="user_full_name" value="#userFullName#">
													<cfinvokeargument name="user_image_type" value="#userImageType#">
													<cfinvokeargument name="width_px" value="48">
												</cfinvoke>

											</cfif>

									 	</a>
									 	<div class="media-body">

											<cfif arguments.generatePdf IS true>
												<i>#itemTypeNameEs#</i><br/><br/>

												<span>#userFullName#</span>

											<cfelse>

												<a href="area_user.cfm?area=#itemsQuery.area_id#&user=#itemsQuery.user_in_charge#" class="link_user">#userFullName#</a>

											</cfif>

											<span class="hidden-xs">&nbsp;&nbsp;&nbsp;&nbsp;</span>

											<cfif arguments.showLastUpdate IS false OR itemTypeId EQ 1 OR itemTypeId EQ 7 OR itemsQuery.creation_date EQ itemsQuery.last_update_date><!--- Creation date --->

												<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringDate">
													<cfinvokeargument name="timestamp_date" value="#itemsQuery.creation_date#">
												</cfinvoke>
												<cfset spacePos = findOneOf(" ", stringDate)>
												<span class="text_date">
													<cfif spacePos GT 0>
													#left(stringDate, spacePos)#
													<cfelse><!---Esto es para que no de error en versiones antiguas de DoPlanning que tienen la fecha en otro formato--->
													#stringDate#
													</cfif>
												</span>&nbsp;&nbsp;&nbsp;
												<cfif spacePos GT 0>
													<span  class="text_hour">#right(stringDate, len(stringDate)-spacePos)#</span>
												</cfif>

											<cfelse><!--- Last update date --->

												<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringLastDate">
													<cfinvokeargument name="timestamp_date" value="#itemsQuery.last_update_date#">
												</cfinvoke>
												<cfset spacePosLast = findOneOf(" ", stringLastDate)>
												<span class="text_date">
													#left(stringLastDate, spacePosLast)#
												</span>&nbsp;&nbsp;&nbsp;
												<cfif spacePosLast GT 0>
													<span class="text_hour">#right(stringLastDate, len(stringLastDate)-spacePosLast)#</span>
												</cfif>

											</cfif>

											<cfif arguments.showLastUpdate IS true>
												&nbsp;&nbsp;
												<cfif itemsQuery.itemTypeId IS 10><!---Files---->
													<cfif  isNumeric(objectFile.replacement_user)>
														<span class="label label-info" lang="es">Nueva versión</span>
													</cfif>
												<cfelseif itemTypeId NEQ 1 AND itemTypeId NEQ 7 AND itemsQuery.creation_date NEQ itemsQuery.last_update_date>

													<span class="label label-info" lang="es">Modificación</span>

												</cfif>

											</cfif>

											<cfif arguments.deletedItems IS true><!--- Bin items --->

												<br/><b>Fecha de eliminación</b>

												<cfinvoke component="#APPLICATION.componentsPath#/DateManager" method="timestampToString" returnvariable="stringDeleteDate">
													<cfinvokeargument name="timestamp_date" value="#itemsQuery.delete_date#">
												</cfinvoke>
												<cfset spacePosLast = findOneOf(" ", stringDeleteDate)>
												<span>
													#left(stringDeleteDate, spacePosLast)#
												</span>
												<cfif spacePosLast GT 0>
													<span>#right(stringDeleteDate, len(stringDeleteDate)-spacePosLast)#</span>
												</cfif>

											</cfif>

										</div><!--- END div class="media-body" --->

									</div><!--- END div class="media" --->

									<cfif arguments.generatePdf IS true><!---PDF--->

										<cfif arguments.generateWord IS false>
										<br/><br/>
										</cfif>

									<cfelse>

										<hr style="margin:0;margin-top:5px;"/>

									</cfif>

								</div>

								<div class="col-xs-2 col-sm-1"><!--- item type icon --->

										<cfif arguments.generatePdf IS false>

											<div class="pull-right">

												<cfif arguments.deletedItems IS false>
													<a href="#APPLICATION.htmlPath#/#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id##area_param#">
												</cfif>


												<cfif itemTypeId IS 6><!---Tasks--->

													<cfif itemsQuery.done IS true>
														<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_done.png" alt="Tarea realizada" title="Tarea realizada" style="width:60px;" lang="es"/>
													<cfelse>
														<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_not_done.png" alt="Tarea no realizada" title="Tarea no realizada" style="width:60px;" lang="es"/>
													</cfif>

												<cfelseif itemTypeId IS 10><!--- File --->

													<cfif itemsQuery.file_type_id IS 1><!--- User file --->
														<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" alt="#itemTypeNameEs#" title="#itemTypeNameEs#" style="width:60px"/>

													<cfelseif itemsQuery.file_type_id IS 2><!--- Area file --->

														<cfif itemsQuery.locked IS true>
															<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_area_locked.png" alt="#itemTypeNameEs# del área bloqueado" title="#itemTypeNameEs# del área bloqueado" style="width:60px;"/>
														<cfelse>
															<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_area.png" alt="#itemTypeNameEs# del área" title="#itemTypeNameEs# del área" style="width:60px;"/>
														</cfif>

													<cfelseif itemsQuery.file_type_id IS 3>

														<cfif itemsQuery.locked IS true>
															<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_edited_locked.png" alt="#itemTypeNameEs# del área bloqueado" title="#itemTypeNameEs# del área bloqueado" style="width:60px;"/>
														<cfelse>
															<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_edited.png" alt="#itemTypeNameEs# del área en edición" title="#itemTypeNameEs# del área en edición" style="width:60px;"/>
														</cfif>

													</cfif>

												<cfelseif itemTypeId IS NOT 3><!---No es link--->

													<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" alt="#itemTypeNameEs#" title="#itemTypeNameEs#" lang="es" style="width:60px;"/>

												<cfelse><!---style="max-width:none;" Requerido para corregir un bug con Bootstrap en Chrome--->
													<a href="#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#" style="float:left;" target="_blank" title="Visitar el enlace" onclick="openUrl('#APPLICATION.htmlPath#/go_to_link_link.cfm?#itemTypeName#=#itemsQuery.id#','_self',event)"><img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" style="width:60px;"/></a>
												</cfif>


												<cfif arguments.deletedItems IS false>
													</a>
												</cfif>

											</div>

										</cfif>

								</div>
							</div>

							<div class="row">

								<div class="col-xs-12">


									<div class="media">

										<cfif len(itemsQuery.thumbnail_format) GT 0>
										  <div class="media-left">
												<img src="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.id#&thumbnail=1<cfif arguments.deletedItems IS true>&bin=true</cfif>" alt="Thumbnail" class="media-object img-thumbnail"/>
										  </div>
										</cfif>

									  <div class="media-body">


											<cfset titleContent = itemsQuery.title>

											<cfif arguments.generatePdf IS true>
												<h3>#titleContent#</h3>
											<cfelse>
												<h4>#titleContent#</h4>
											</cfif>

											<cfif itemTypeId EQ 10><!--- Files --->

												<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFileIcon" returnvariable="file_icon">
													<cfinvokeargument name="file_name" value="#itemsQuery.file_name#"/>
												</cfinvoke>

												<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.id#&area=#arguments.area_id#<cfif arguments.deletedItems IS true>&bin=true</cfif>" target="_blank" onclick="return downloadFileLinked(this,event)" title="Descargar" class="link_attached"><i class="#file_icon#"></i> #itemsQuery.file_name#</a><br>

											<cfelse>


												<cfif isNumeric(itemsQuery.attached_file_id) OR isNumeric(itemsQuery.attached_image_id) OR (len(itemsQuery.link) GT 0 AND itemsQuery.link NEQ "http://")>

													<div style="clear:both;margin-bottom:5px;">

														<cfif isNumeric(itemsQuery.attached_file_id)>

															<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFileIcon" returnvariable="attached_file_icon">
																<cfinvokeargument name="file_name" value="#itemsQuery.attached_file_name#"/>
															</cfinvoke>

															<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_file_id#&#itemTypeName#=#itemsQuery.id#" target="_blank" onclick="return downloadFileLinked(this,event)" class="link_attached" title="Descargar"><i class="#attached_file_icon#"></i> #itemsQuery.attached_file_name#</a><br/>

															<!---<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_file_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" class="btn btn-sm btn-default" title="Descargar archivo adjunto"><i class="icon-paper-clip" style="font-size:14px;"></i></a>--->

															<!---<span class="divider">&nbsp;</span>--->
														</cfif>

														<cfif isNumeric(itemsQuery.attached_image_id)>

															<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFileIcon" returnvariable="attached_image_icon">
																<cfinvokeargument name="file_name" value="#itemsQuery.attached_image_name#"/>
															</cfinvoke>

															<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_image_id#&#itemTypeName#=#itemsQuery.id#" target="_blank" onclick="return downloadFileLinked(this,event)" class="link_attached" title="Descargar"><i class="#attached_image_icon#"></i> #itemsQuery.attached_image_name#</a><br/>

															<!---<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.attached_image_id#&#itemTypeName#=#itemsQuery.id#" onclick="return downloadFileLinked(this,event)" class="btn btn-sm btn-default" title="Descargar imagen adjunta"><i class="icon-camera" style="font-size:13px;"></i></a>--->

															<!---<span class="divider">&nbsp;</span>--->
														</cfif>

														<cfif len(itemsQuery.link) GT 0 AND itemsQuery.link NEQ "http://">

															<cfif SESSION.client_abb EQ "omars" AND find("/html/download_gtrabajo.cfm?area=", itemsQuery.link) GT 0>

																<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="getFileIcon" returnvariable="attached_file_icon">
																	<cfinvokeargument name="file_name" value="#itemsQuery.link#"/>
																</cfinvoke>

																<a href="#itemsQuery.link#" target="_blank" onclick="return downloadFileLinked(this,event)" class="link_attached" title="Descargar"><i class="#attached_file_icon#"></i> #listLast(itemsQuery.link, "=")#</a><br/>

															<cfelse>
																<a href="#itemsQuery.link#" target="_blank" class="link_external"><i class="icon-link"></i></a>
																<a href="#itemsQuery.link#" target="_blank" class="link_external">#itemsQuery.link#</a><br/>
															</cfif>

														</cfif>

													</div>

												</cfif>


											</cfif>


											<cfset titleClass = "text_item">

											<cfif itemTypeId IS 6 AND itemsQuery.done IS false><!--- Task not done --->
												<cfif dateCompare(now(), itemsQuery.end_date, "d") IS 1>
													<cfset titleClass = titleClass&" text_red">
												</cfif>
											</cfif>

											<cfif itemTypeId IS 5 OR itemTypeId IS 6><!--- Events, Tasks --->

												<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="getItem" returnvariable="objectItem">
													<cfinvokeargument name="item_id" value="#itemsQuery.id#">
													<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
													<cfif arguments.deletedItems IS true>
														<cfinvokeargument name="status" value="deleted">
													</cfif>
												</cfinvoke>

												<div style="font-size: 16px">

													<b lang="es">Fecha de inicio</b> <span>#objectItem.start_date#
													<cfif itemTypeId IS 5>#TimeFormat(objectItem.start_time,"HH:mm")#</cfif></span>&nbsp;

													<b lang="es">Fecha de fin</b> <span>#objectItem.end_date#
													<cfif itemTypeId IS 5>#TimeFormat(objectItem.end_time,"HH:mm")#</cfif></span>&nbsp;


													<cfif itemTypeId IS 5><!---Events--->
														<b lang="es">Lugar</b> <span>#objectItem.place#</span>
													<cfelse><!---Tasks--->
														<b lang="es">Realizada</b> <span lang="es"><cfif objectItem.done IS true>Sí<cfelse>No</cfif></span>
													</cfif>

												</div>

											<cfelseif itemTypeId IS 7><!--- Consultations --->

												<div style="font-size: 16px">

													<b lang="es">Estado</b> <span lang="es"><cfswitch expression="#itemsQuery.state#">
														<cfcase value="created">Enviada</cfcase>
														<cfcase value="read">Leída</cfcase>
														<cfcase value="answered">Respondida</cfcase>
														<cfcase value="closed"><strong lang="es">Cerrada</strong></cfcase>
													</cfswitch></span>

												</div>

											<cfelseif itemTypeId IS 17><!--- Mailings --->

												<div style="font-size: 16px">

													<b lang="es">Estado</b> <cfswitch expression="#itemsQuery.state#">
														<cfcase value="created"><span class="label label-default" lang="es">Creado</span></cfcase>
														<cfcase value="modified"><span class="label label-default" lang="es">Modificado</span></cfcase>
														<cfcase value="sent_to_test"><span class="label label-default" lang="es">Enviado a destinatarios para pruebas</span></cfcase>
														<cfcase value="sent"><span class="label label-success" lang="es">Enviado</span></cfcase>
													</cfswitch>

													<!---<cfif itemsQuery.state NEQ "created" AND itemsQuery.state NEQ "modified"><br/>
														<b lang="es">Fecha de <cfswitch expression="#itemsQuery.state#">
															<cfcase value="sent_to_test">envío para pruebas</cfcase>
															<cfcase value="sent">envío</cfcase>
														</cfswitch>:</b> <span>#itemsQuery.last_update_date#</span>
													</cfif>--->

												</div>

											<cfelseif itemTypeId IS 8><!--- Publications --->

												<cfif len(itemsQuery.identifier) GT 0>
												<!---<b lang="es">Identificador:</b> <span>#itemsQuery.identifier#</span>--->

													<cfif isNumeric(itemsQuery.identifier) AND isNumeric(itemsQuery.sub_type_id) AND itemsQuery.sub_type_id IS 1>
														<cfset pubMedUrl = "http://www.ncbi.nlm.nih.gov/pubmed/"&itemsQuery.identifier>
														<div><!---<span>PubMed URL:</span>---><a href="#pubMedUrl#" target="_blank" class="link_external"><i class="icon-external-link-sign"></i> #pubMedUrl#</a>
														</div>
													</cfif>
												</cfif>

											</cfif>

											<cfif itemTypeId EQ 17><!--- Mailing --->

												<div style="margin-top:10px;<cfif arguments.generatePdf IS false>margin-bottom:10px;</cfif>">
													#itemsQuery.description#
												</div>

											<cfelseif itemTypeId EQ 20><!--- DP Document --->

												<div class="dp_document_container" <cfif arguments.generatePdf IS false>style="height:500px; overflow:scroll;margin-bottom:10px;"</cfif>>
													#itemsQuery.description#
												</div>

											<cfelse>

												<div class="lead item_description" style="<cfif arguments.generatePdf IS false>margin-bottom:10px;</cfif>">
													#itemsQuery.description#
												</div>

											</cfif>

											<!---<div class="lead" style="clear:both;<cfif arguments.generatePdf IS false>margin-bottom:10px;</cfif>">
												<cfif itemTypeId NEQ 20 OR arguments.generatePdf IS true>
													<p>#itemsQuery.description#</p>
												<cfelse>
													<!---<textarea name="description_#itemTypeId#_#itemsQuery.id#" class="form-control" readonly style="height:500px;">#itemsQuery.description#</textarea>

													<cfinvoke component="#APPLICATION.htmlComponentsPath#/CKEditorManager" method="loadComponent">
														<cfinvokeargument name="name" value="description_#itemTypeId#_#itemsQuery.id#">
														<cfinvokeargument name="language" value="#SESSION.user_language#"/>
														<cfinvokeargument name="height" value="500"/>
														<cfinvokeargument name="toolbar" value="DP_document"/>
														<cfinvokeargument name="readOnly" value="true"/>
														<cfinvokeargument name="toolbarStartupExpanded" value="false"/>
														<cfinvokeargument name="toolbarCanCollapse" value="true"/>
													</cfinvoke>--->
												</cfif>
											</div>--->

										</div><!--- END media-body --->

									</div><!--- END media	--->



								</div><!--- END col-xs-12 --->

							</div><!--- END row --->

							<cfif arguments.deletedItems IS false>
							<div class="row">
								<div class="col-sm-12"><!--- URL --->

									<!---itemUrl--->
									<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getAreaItemUrl" returnvariable="areaItemUrl">
										<cfinvokeargument name="item_id" value="#itemsQuery.id#">
										<cfinvokeargument name="itemTypeName" value="#itemTypeName#">
										<cfinvokeargument name="area_id" value="#itemsQuery.area_id#">

										<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
									</cfinvoke>

									<cfif arguments.generatePdf IS false>

										<div style="margin-bottom:15px;">

											<div class="input-group">

												<span class="input-group-addon" style="padding-left:0"><i class="fa fa-share-alt" style="font-size: 16px;"></i></span>
												<input type="text" value="#areaItemUrl#" onClick="this.select();" class="form-control item_url_dp" readonly="readonly" style="cursor:text;border-bottom:none"/>

											</div>

										</div>

									<cfelse>

										<div style="margin-top:10px;">
											<a href="#areaItemUrl#" target="_blank">#areaItemUrl#</a>
										</div>

										<hr style="margin-bottom:40px;margin-top:40px;"/>

									</cfif>


								</div>
							</div>
							</cfif>


							<cfif arguments.generatePdf IS false>
							<div class="row">
								<div class="col-sm-12">

									<!---Attached files--->
									<cfif itemTypeId IS 10><!--- File --->
										<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#itemsQuery.id#&area=#arguments.area_id#<cfif arguments.deletedItems IS true>&bin=true</cfif>" onclick="return downloadFileLinked(this,event)" class="btn btn-sm btn-primary" title="Descargar archivo"><i class="icon-download-alt" style="font-size:16px;"></i> <span lang="es">Descargar</span></a>
										<span class="divider">&nbsp;</span>
									</cfif>

									<cfif arguments.deletedItems IS true><!--- Bin items --->

										<!---<cfif isDefined("itemsQuery.area_name")>--->

											<!---<img src="#APPLICATION.htmlPath#/assets/v3/icons_dp/area_small.png" alt="Area" title="Ver área"> Área: <a onclick="openUrl('area_items.cfm?area=#itemsQuery.area_id#','areaIframe',event)" style="cursor:pointer"><span lang="es">#itemsQuery.area_name#</span></a>&nbsp;<a onclick="openUrl('area_items.cfm?area=#itemsQuery.area_id#','areaIframe',event)" class="btn btn-sm btn-info" title="Ir al área"><span lang="es">Ir al área</span></a>--->
										<p>
											<span lang="es">Área</span>: <a href="#APPLICATION.htmlPath#/index.cfm?abb=#SESSION.client_abb#&area=#itemsQuery.area_id#" target="_parent">#itemsQuery.area_name#</a><br/>
										</p>


										<!---</cfif>--->


										<cfset url_return_page = "&return_page="&URLEncodedFormat("#return_path#bin.cfm")>

										<a href="#APPLICATION.htmlComponentsPath#/Bin.cfc?method=restoreBinItem&item_id=#itemsQuery.id#&itemTypeId=#itemTypeId##url_return_page#" onclick="return confirmReversibleAction('restaurar');" class="btn btn-sm btn-primary" title="Restaurar" lang="es"><i class="icon-undo"></i> Restaurar</a>

										<a href="#APPLICATION.htmlComponentsPath#/Bin.cfc?method=deleteBinItem&item_id=#itemsQuery.id#&itemTypeId=#itemTypeId##url_return_page#" onclick="return confirmAction('eliminar');" class="btn btn-sm btn-danger" title="Eliminar definitivamente" lang="es"><i class="icon-remove"></i> Eliminar definitivamente</a>


									<cfelseif itemTypeId NEQ 10>

										<cfif itemTypeId IS 11 OR itemTypeId IS 12 OR itemTypeId IS 14 OR itemTypeId IS 15 OR itemTypeId IS 16><!---Lists, Forms And Views--->

											<a href="#itemTypeName#_rows.cfm?#itemTypeName#=#itemsQuery.id##area_param#" class="btn btn-sm btn-primary" title="Registros" lang="es"><i class="icon-list" style="font-size:15px;"></i> <span lang="es">Registros</span></a>

										<!---<cfelseif itemTypeId IS 13>

											<a href="#itemTypeName#_fields.cfm?#itemTypeName#=#itemsQuery.id#" class="btn btn-sm btn-primary" title="Campos"><i class="icon-list" style="font-size:15px;"></i> <span lang="es">Campos</span></a>--->

										<cfelseif ( isDefined("arguments.area_read_only") AND arguments.area_read_only IS false ) OR ( isDefined("itemsQuery.area_read_only") AND itemsQuery.area_read_only IS false )>


											<cfif itemTypeId IS 1 OR itemTypeId IS 7><!---Solo para mensajes y consultas--->

												<cfif itemTypeId IS 1 OR itemsQuery.state NEQ "closed">

													<cfif app_version EQ "mobile">

														<a href="#itemTypeName#_new.cfm?#itemTypeName#=#itemsQuery.id#" class="btn btn-sm btn-primary" title="Responder" lang="es"><i class="icon-reply"></i> <span lang="es">Responder</span></a>

													<cfelse>

														<a onclick="openUrl('area_items.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#&reply','areaIframe',event)" class="btn btn-sm btn-primary" title="Responder" lang="es"><i class="icon-reply"></i> <span lang="es">Responder</span></a>

													</cfif>

												</cfif>

											<cfelseif itemTypeId IS 20><!--- DPDocuments --->


												<cfif itemsQuery.area_editable IS false AND itemsQuery.user_in_charge EQ SESSION.user_id>

													<a href="#itemTypeName#_modify.cfm?#itemTypeName#=#itemsQuery.id#" class="btn btn-sm btn-primary" title="Modificar" lang="es"><i class="icon-pencil"></i> <span lang="es">Modificar</span></a>

												<cfelseif itemsQuery.area_editable IS true>

													<cfif itemsQuery.locked IS true>

														<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="getItem" returnvariable="dpDocumentObject">
															<cfinvokeargument name="item_id" value="#itemsQuery.id#">
															<cfinvokeargument name="itemTypeId" value="#itemTypeId#">

															<cfinvokeargument name="with_lock" value="true">
														</cfinvoke>

													</cfif>

													<cfif itemsQuery.locked IS false OR dpDocumentObject.lock_user_id IS SESSION.user_id>

														<a href="#itemTypeName#_modify.cfm?#itemTypeName#=#itemsQuery.id#" class="btn btn-sm btn-primary" title="Modificar" lang="es"><i class="icon-pencil"></i> <span lang="es">Modificar</span></a>

													</cfif>

												</cfif>


											<cfelseif itemTypeId IS 17><!--- Mailing --->

													<cfif itemsQuery.state NEQ "sent" AND itemsQuery.user_in_charge EQ SESSION.user_id>

														<a href="#itemTypeName#_modify.cfm?#itemTypeName#=#itemsQuery.id#" class="btn btn-sm btn-primary" title="Modificar" lang="es"><i class="icon-pencil"></i> <span lang="es">Modificar</span></a>

													</cfif>

											<cfelse>


												<cfif ( isDefined("arguments.area_type") AND len(area_type) GT 0 ) OR itemsQuery.user_in_charge EQ SESSION.user_id OR (itemTypeId IS 6 AND itemsQuery.recipient_user EQ SESSION.user_id)><!---Si es el propietario o es tarea y es el destinatario de la misma---> <!--- --->

													<a href="#itemTypeName#_modify.cfm?#itemTypeName#=#itemsQuery.id#" class="btn btn-sm btn-primary" title="Modificar" lang="es"><i class="icon-pencil"></i> <span lang="es">Modificar</span></a>

												</cfif>


											</cfif>


										</cfif>

									</cfif>


									<div class="pull-right">

										<cfif arguments.deletedItems IS false>

											<cfif arguments.app_version NEQ "mobile">
												<a href="#APPLICATION.htmlPath#/#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&area=#itemsQuery.area_id#" title="Abrir en nueva ventana" target="_blank" class="btn btn-default btn-sm" lang="es"><i class="icon-external-link"></i></a>
											</cfif>

											<span class="divider">&nbsp;</span>

											<cfif NOT isDefined("arguments.area_id")>

												<cfif app_version EQ "mobile">

													<a href="area_items.cfm?area=#itemsQuery.area_id####itemTypeName##itemsQuery.id#" class="btn btn-sm btn-info" title="Ir al área"><img src="#APPLICATION.htmlPath#/assets/v3/icons_dp/area_small_white.png" alt="Area" title="Ver en área"> <span lang="es">Ver en área</span></a>

												<cfelse>
													<!---onclick="openUrl('area_items.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#','areaIframe',event)"--->

													<a href="area_items.cfm?area=#itemsQuery.area_id#&#itemTypeName#=#itemsQuery.id#" class="btn btn-sm btn-info" title="Ir al área"><img src="#APPLICATION.htmlPath#/assets/v3/icons_dp/area_small_white.png" alt="Area" title="Ver en área"> <span lang="es">Ver en área</span></a>

												</cfif>
											<cfelse>
												<!---onclick="openUrl('#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id#&area=#itemsQuery.area_id#','itemIframe',event)"--->
												<a href="#itemTypeName#.cfm?#itemTypeName#=#itemsQuery.id##area_param#" class="btn btn-sm btn-info" title="Ver #itemTypeNameEs#"><span lang="es">Ver</span> <span lang="es">#itemTypeNameEs#</span></a>
											</cfif>

										<cfelse><!--- Deleted item --->

											<a href="#APPLICATION.htmlPath#/index.cfm?abb=#SESSION.client_abb#&area=#itemsQuery.area_id#" target="_parent" class="btn btn-sm btn-info" title="Ir al área"><img src="#APPLICATION.htmlPath#/assets/v3/icons_dp/area_small_white.png" alt="Area" title="Ver área"> <span lang="es">Ir al área</span></a>

										</cfif>

									</div>

								</div>
							</div>
							</cfif>

							</div>
						</div>

					</div><!--- END col --->
				</div><!---END row item container--->
			</cfloop>
			</div>
			</cfoutput>



			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>

		</cftry>

	</cffunction>


	<!--- -------------------------------exportAreaItemsDownload-------------------------------------- --->

    <cffunction name="exportAreaItemsDownload" returntype="void" access="remote">
    	<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="delimiter" type="string" required="false" default=";">
		<cfargument name="ms_excel_compatibility" type="boolean" required="false" default="false">

		<cfset var method = "exportAreaItemsDownload">

		<cfset var exportAreaResponse = structNew()>

		<cftry>

			<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="exportAreaItems" returnvariable="exportAreaResponse">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfif exportAreaResponse.result IS true><!---The export is success--->

				<cfif arguments.delimiter EQ "tab">
					<cfset contentDisposition = "attachment; filename=#tableTypeName#_#area_id#.txt;">
					<cfset contentType = "text/plain; charset=Windows-1252">
				<cfelse>
					<cfset contentDisposition = "attachment; filename=area_items_#area_id#.csv;">
					<cfset contentType = "text/csv; charset=Windows-1252">
				</cfif>

				<cfheader name="Content-Disposition" value="#contentDisposition#" charset="Windows-1252"><!---iso-8859-1--->
				<cfcontent type="#contentType#"><cfoutput>#exportAreaResponse.content#</cfoutput></cfcontent>

			<cfelse>
				<!---There is an error in the export--->
				<cfoutput>
					Error: #exportAreaResponse.message#
				</cfoutput>
			</cfif>

			<cfcatch>
				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

	</cffunction>


	<!--- -------------------------------importItems-------------------------------------- --->

	<cffunction name="importItems" returntype="struct" access="public">
			<cfargument name="area_id" type="numeric" required="true">
			<cfargument name="itemTypeId" type="numeric" required="true">
			<cfargument name="delimiter" type="string" required="true">
			<cfargument name="start_row" type="numeric" required="false">
			<cfargument name="delete_rows" type="boolean" required="false">
			<cfargument name="cancel_on_error" type="boolean" required="false">

			<cfset var method = "importAreaItems">

			<cfset var response = structNew()>

			<cftry>

				<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="importItems" argumentcollection="#arguments#" returnvariable="response">
				</cfinvoke>

				<cfif response.result IS true>
					<cfset response.message = "#response.itemsCount# elementos importados">
				</cfif>

				<cfcatch>
					<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
				</cfcatch>

			</cftry>

			<cfreturn response>

	</cffunction>


	<!---    getPublicationInPubMed     --->
	<!---remote function--->
	<cffunction name="getPublicationInPubMed" output="false" access="remote" returntype="xml">
		<cfargument name="pubmed_id" type="string" required="true">

		<cfset var method = "getPublicationInPubMed">
		<cfset var xmlResult = xmlNew()>

		<cftry>
			<cfhttp throwonerror="yes" url="http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=#arguments.pubmed_id#&retmode=xml" method="get" result="requestResult">
			</cfhttp>

			<cfset xmlResult = xmlParse(requestResult.FileContent)>

			<cfcatch>
				<cfinclude template="includes/errorHandlerNoRedirectStruct.cfm">
			</cfcatch>
		</cftry>

		<cfreturn xmlResult>

	</cffunction>


	<!--- outputItemPageHead --->

	<cffunction name="outputItemPageHead" returntype="void" output="true" access="public">
		<cfargument name="item_id" type="numeric" required="true"/>
		<cfargument name="item" type="any" required="true">
		<cfargument name="itemTypeName" type="string" required="true">
		<cfargument name="itemTypeNameEs" type="string" required="true">
		<cfargument name="area_id" type="numeric" required="true">

		<cfset var head_col_1_class = "col-xs-offset-2 col-xs-10 col-sm-offset-1 col-sm-2 col-md-offset-0 col-md-1">
		<cfset var head_col_2_class = "col-xs-12 col-sm-9 col-md-11">

		<cfoutput>

		<div class="#head_col_1_class#">
			<a href="#APPLICATION.htmlPath#/#itemTypeName#.cfm?#itemTypeName#=#arguments.item_id#&area=#arguments.area_id#">
				<cfif itemTypeName IS "task">

					<cfif item.done IS true>
						<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_done.png" alt="#itemTypeNameEs#" title="#itemTypeNameEs#" />
					<cfelse>
						<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#_not_done.png" alt="#itemTypeNameEs#" title="#itemTypeNameEs#" />
					</cfif>

				<cfelse>
					<img src="#APPLICATION.htmlPath#/assets/v3/icons/#itemTypeName#.png" alt="#itemTypeNameEs#" title="#itemTypeNameEs#" />
				</cfif>
			</a>
		</div>

		<div class="#head_col_2_class#">

			<div class="page-header" style="border-bottom-color:##019ED3">

			 	<div class="row row_page_head_title">
					<div class="col-sm-10">
						<h1 style="color:##009ED2;">#arguments.item.title#</h1>
					</div>
					<div class="col-sm-2">
						<a href="area_items.cfm?area=#area_id####itemTypeName##arguments.item_id#" class="btn btn-sm btn-info pull-right"><img src="#APPLICATION.htmlPath#/assets/v3/icons_dp/area_small_white.png" alt="Área" lang="es"/> <span lang="es">Ver en área</span></a>
					</div>
				</div>

			</div>

		</div>

		</cfoutput>

	</cffunction>


	<!--- ----------------------- outputItemSmall -------------------------------- --->

	<cffunction name="outputItemSmall" returntype="void" output="true" access="public">
		<cfargument name="itemQuery" type="query" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="alertMessage" type="string" required="false">
		<cfargument name="alertClass" type="string" required="false" default="alert alert-warning">

		<cfset var method = "outputItemSmall">

		<div class="well well-sm">

			<div>

					<div>
						<strong>#itemQuery.title#</strong>
					</div>

					<div>
						<span lang="es">Propietario</span>:
						<strong>#itemQuery.user_full_name#</strong>
					</div>

					<cfif isDefined("arguments.alertMessage") AND len(arguments.alertMessage)>
						<div class="#arguments.alertClass#" role="alert" style="margin-bottom:0" lang="es">
							#arguments.alertMessage#
						</div>
					</cfif>

			</div>

		</div>

	</cffunction>


</cfcomponent>
