<!---Copyright Era7 Information Technologies 2007-2014

    File created by: ppareja
    ColdFusion version required: 8
    Last file change by: alucena
    Date of last file change: 15-11-2012

	07-09-2012 alucena: añadido eliminación de nuevos elementos al eliminar área
	29-09-2012 alucena: reemplazado "true" por true en comparaciones de booleanos
	15-11-2012 alucena: cambiado getAreaImageId
	14-01-2012 alucena: quitado description de los archivos en getAreaFiles
	19-06-2013 alucena: cambios por errores en comprobación de permisos al realizar importación de usuarios

--->
<cfcomponent output="false">

	<cfset component = "AreaManager">

	<cfset messageTypeId = 1>

	<cfinclude template="includes/functions.cfm">

	<!--- ----------------------- XML AREA -------------------------------- --->

	<cffunction name="xmlArea" returntype="string" output="false" access="public">
		<cfargument name="objectArea" type="struct" required="yes">

		<cfset var method = "xmlArea">

		<cftry>

			<cfprocessingdirective suppresswhitespace="true">
			<cfsavecontent variable="xmlResult"><cfoutput><area id="#objectArea.id#"
				 parent_id="#objectArea.parent_id#"
				 user_in_charge="#objectArea.user_in_charge#"
				 creation_date="#objectArea.creation_date#"
				<cfif len(objectArea.image_id) GT 0>
				 image_id="#objectArea.image_id#"
				</cfif>
				<cfif len(objectArea.with_image) GT 0>
				 with_image="#objectArea.with_image#"
				</cfif>
				<cfif len(objectArea.link) GT 0>
				 link="#objectArea.link#"
				</cfif>
				<cfif len(objectArea.with_link) GT 0>
				 with_link="#objectArea.with_link#"
				</cfif>
				<cfif len(objectArea.type) GT 0>
				 type="#objectArea.type#"
				</cfif>
				<cfif len(objectArea.default_typology_id) GT 0>
				 default_typology_id="#objectArea.default_typology_id#"
				</cfif>>
				<name><![CDATA[#objectArea.name#]]></name>
				<description><![CDATA[#objectArea.description#]]></description>
				<cfif len(objectArea.user_full_name) GT 0>
				<user_full_name><![CDATA[#objectArea.user_full_name#]]></user_full_name>
				</cfif></area></cfoutput></cfsavecontent>
			</cfprocessingdirective>
			<!---<cfif len(objectArea.image_background_color) GT 0>
			 image_background_color="#objectArea.image_background_color#"
			</cfif>--->

			<cfreturn xmlResult>

			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn null>
			</cfcatch>
		</cftry>

	</cffunction>


	<!--- ----------------------- AREA OBJECT -------------------------------- --->

	<cffunction name="objectArea" returntype="any" output="false" access="public">

		<cfargument name="xml" type="string" required="no">

		<cfargument name="id" type="string" required="no" default="">
		<cfargument name="parent_id" type="string" required="no" default="">
		<cfargument name="parent_kind" type="string" required="no" default="">
		<cfargument name="user_in_charge" type="string" required="no" default="">
		<cfargument name="creation_date" type="string" required="no" default="">
		<cfargument name="name" type="string" required="no" default="">
		<cfargument name="image_id" type="string" required="no" default="">
		<cfargument name="with_image" type="string" required="no" default="">
		<!---<cfargument name="image_background_color" type="string" required="no" default="">--->
		<cfargument name="link" type="string" required="no" default="">
		<cfargument name="with_link" type="string" required="no" default="">
		<cfargument name="description" type="string" required="no" default="">
		<cfargument name="user_full_name" type="string" required="no" default="">
		<cfargument name="type" type="string" required="no" default="">
		<cfargument name="default_typology_id" type="string" required="false" default="">
		<cfargument name="hide_in_menu" type="string" required="no" default="">
		<cfargument name="menu_type_id" type="string" required="no" default="">
		<cfargument name="list_mode" type="string" required="no" default="">


		<cfargument name="return_type" type="string" required="no">

		<cfset var method = "objectArea">

		<cftry>

			<cfif isDefined("arguments.xml")>

				<cfxml variable="xmlArea">
				<cfoutput>
				#arguments.xml#
				</cfoutput>
				</cfxml>

				<cfif isDefined("xmlArea.area.XmlAttributes.id")>
					<cfset id=#xmlArea.area.XmlAttributes.id#>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.parent_id")>
					<cfset parent_id=#xmlArea.area.XmlAttributes.parent_id#>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.user_in_charge")>
					<cfset user_in_charge="#xmlArea.area.XmlAttributes.user_in_charge#">
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.creation_date")>
					<cfset creation_date="#xmlArea.area.XmlAttributes.creation_date#">
				</cfif>

				<cfif isDefined("xmlArea.area.name.xmlText")>
					<cfset name="#xmlArea.area.name.xmlText#">
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.image_id")>
					<cfset image_id=xmlArea.area.XmlAttributes.image_id>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.with_image")>
					<cfset with_image=xmlArea.area.XmlAttributes.with_image>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.link")>
					<cfset link=xmlArea.area.XmlAttributes.link>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.with_link")>
					<cfset with_link=xmlArea.area.XmlAttributes.with_link>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.type")>
					<cfset type=xmlArea.area.XmlAttributes.type>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.default_typology_id")>
					<cfset default_typology_id=xmlArea.area.XmlAttributes.default_typology_id>
				</cfif>

				<cfif isDefined("xmlArea.area.description.xmlText")>
					<cfset description="#xmlArea.area.description.xmlText#">
				</cfif>

				<cfif isDefined("xmlArea.area.user_full_name.xmlText")>
					<cfset user_full_name="#xmlArea.area.user_full_name.xmlText#">
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.hide_in_menu")>
					<cfset hide_in_menu=xmlArea.area.XmlAttributes.hide_in_menu>
				</cfif>

				<cfif isDefined("xmlArea.area.XmlAttributes.menu_type_id")>
					<cfset menu_type_id=xmlArea.area.XmlAttributes.menu_type_id>
				</cfif>

			<cfelseif NOT isDefined("arguments.id")>
				<cfreturn null>
			</cfif>

			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringDate">
				<cfinvokeargument name="timestamp_date" value="#creation_date#">
			</cfinvoke>
			<cfset creation_date = stringDate>

			<cfset object = {
				id="#id#",
				parent_id="#parent_id#",
				user_in_charge="#user_in_charge#",
				creation_date="#creation_date#",
				name="#name#",
				image_id="#image_id#",
				with_image="#with_image#",
				link="#link#",
				with_link="#with_link#",
				type="#type#",
				default_typology_id="#default_typology_id#",
				description="#description#",
				user_full_name="#user_full_name#",
				hide_in_menu="#hide_in_menu#",
				menu_type_id ="#menu_type_id#",
				list_mode="#list_mode#"
				}>


			<cfif isDefined("arguments.return_type") AND arguments.return_type EQ "xml">

				<cfinvoke component="AreaManager" method="xmlArea" returnvariable="xmlResult">
					<cfinvokeargument name="objectArea" value="#object#">
				</cfinvoke>
				<cfreturn xmlResult>

			<cfelse>

				<cfreturn object>

			</cfif>

			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn null>
			</cfcatch>
		</cftry>

	</cffunction>


	<!--- -------------------------- GET AREA PATH -------------------------------- --->
	<!---Devuelve la dirección completa del área pasada como id--->
	<!---A este método accede cualquier usuario, sea interno o no, ya que de él se obtiene el path para enviar las notificaciones por email--->

	<cffunction name="getAreaPath" returntype="string" access="public">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="separator" type="string" required="false" default="/">
		<cfargument name="from_area_id" type="numeric" required="false">
		<cfargument name="include_from_area" type="boolean" required="false">

		<cfargument name="with_base_link" type="string" required="false">
		<cfargument name="cur_area_link_class" type="string" required="false">

		<cfset var method = "getAreaPath">

		<cfinclude template="includes/functionStartOnlySession.cfm">

		<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreaPath" returnvariable="area_path">
			<cfinvokeargument name="area_id" value="#arguments.area_id#">
			<cfinvokeargument name="separator" value="#arguments.separator#"/>

			<cfinvokeargument name="from_area_id" value="#arguments.from_area_id#"><!---Define el área a partir de la cual se muestra la ruta--->
			<cfinvokeargument name="include_from_area" value="#arguments.include_from_area#">

			<cfinvokeargument name="with_base_link" value="#arguments.with_base_link#">
			<cfinvokeargument name="cur_area_link_class" value="#arguments.cur_area_link_class#">

			<cfinvokeargument name="client_abb" value="#client_abb#">
			<cfinvokeargument name="client_dsn" value="#client_dsn#">
		</cfinvoke>

		<cfreturn area_path>

	</cffunction>


	<!--- -------------------------- getAreaType -------------------------------- --->
	<!---Obtiene el tipo del área, si el área no la tiene definida la busca en sus áreas superiores--->

	<cffunction name="getAreaType" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="yes">

		<cfset var method = "getAreaType">

		<cfset var areaType = "">

		<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreaType" returnvariable="getAreaTypeResult">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset areaType = getAreaTypeResult.areaType>

			<cfif len(getAreaTypeResult.areaType) GT 0><!---Get web path URL--->

				<cfinvoke component="#APPLICATION.coreComponentsPath#/WebQuery" method="getWeb" returnvariable="getWebQuery">
					<cfinvokeargument name="area_id" value="#getAreaTypeResult.typeAreaId#">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfset getAreaTypeResult.webPath = getWebQuery.path>
				<cfset getAreaTypeResult.webPathUrl = getWebQuery.path_url>

			</cfif>


		<cfreturn getAreaTypeResult>

	</cffunction>



	<!--- -------------------------- getAreaTypeWeb -------------------------------- --->
	<!---Obtiene el tipo del área y otros valores del área--->

	<cffunction name="getAreaTypeWeb" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="yes">

		<cfset var method = "getAreaTypeWeb">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">


			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreaTypeWeb" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>




	<!--- -------------------------- CHECK ADMIN ACCESS -------------------------------- --->
	<!---Comprueba si el usuario es el administrador de la organización y si no lanza un error--->

	<cffunction name="checkAdminAccess" returntype="void" access="public">

		<cfset var method = "checkAdminAccess">

		<cfset var user_id = "">

		<!---<cfinclude template="includes/initVars.cfm">--->

		<cfinclude template="includes/functionStart.cfm">

		<cfif SESSION.client_administrator NEQ user_id><!---user logged in is not an administrator user--->
			<cfset error_code = 106>

			<cfthrow errorcode="#error_code#">

		</cfif>

	</cffunction>


	<!--- -------------------------- CAN THE USER ACCESS -------------------------------- --->
	<!---Obtiene si el usuario puede acceder al área a partir de la lista pasada--->

	<cffunction name="canTheUserAccess" returntype="boolean" access="public">
 		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="allUserAreasList" type="string" required="yes">

		<cfset var method = "canTheUserAccess">

		<cfinclude template="includes/functionStart.cfm">

		<cfset areaIndex = listFind(arguments.allUserAreasList, #arguments.area_id#)>
		<cfif areaIndex LT 1>
			<cfreturn false>
		<cfelse>
			<cfreturn true>
		</cfif>

		<cfreturn access_result>

	</cffunction>


	<!--- -------------------------- CHECK AREA ACCESS -------------------------------- --->
	<!---Comprueba si el usuario puede acceder al área y si no puede lanza un error--->
	<!---Los administradores pueden acceder a todas las áreas aunque no estén en ellas--->

	<cffunction name="checkAreaAccess" returntype="void" access="public">
		<cfargument name="area_id" type="numeric" required="yes">

		<cfset var method = "checkAreaAccess">

		<cfset var access_result = "">

		<cfinclude template="includes/functionStart.cfm">

		<cfif SESSION.client_administrator NEQ SESSION.user_id><!---Is not an administrator user--->

			<cfinvoke component="AreaManager" method="canUserAccessToArea" returnvariable="access_result">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfif access_result IS NOT true>
				<cfset error_code = 104>

				<cfthrow errorcode="#error_code#">
			</cfif>

		</cfif>

	</cffunction>


	<!--- -------------------------- CHECK AREAS ACCESS -------------------------------- --->
	<!---Comprueba si el usuario puede acceder a algún área de la lista--->

	<cffunction name="checkAreasAccess" returntype="struct" output="false" access="public">
		<cfargument name="areasList" type="string" required="true">

		<cfargument name="throwError" type="boolean" required="false" default="true">

		<cfset var method = "checkAreasAccess">

		<cfset var current_area = "">
		<cfset var access_result = false>
		<cfset var curAccessResult = "">
		<cfset var areasCheckedList = "">
		<cfset var area_id = "">

		<cfinclude template="includes/functionStartOnlySession.cfm">

		<!--- Obtiene las áreas del usuario --->
		<cfquery name="userAreasQuery" datasource="#client_dsn#">
			SELECT area_id
			FROM #client_abb#_areas_users
			WHERE user_id = <cfqueryparam value="#SESSION.user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>

		<cfif userAreasQuery.recordCount GT 0>

			<!--- Comprueba si el usuario está directamente asociado a alguna de las áreas --->
			<cfquery name="isUserInAreasQuery" dbtype="query">
				SELECT area_id
				FROM userAreasQuery
				WHERE area_id IN (<cfqueryparam value="#arguments.areasList#" cfsqltype="cf_sql_varchar" list="true">);
			</cfquery>

			<cfif isUserInAreasQuery.recordCount GT 0>

				<cfset access_result = true>
				<cfset area_id = isUserInAreasQuery.area_id>

			<cfelse><!--- El usuario no está asociado directamente en ninguna de las áreas anteriores --->

				<cfloop list="#arguments.areasList#" index="current_area">

					<cfif listFind(areasCheckedList, current_area) IS 0>

						<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaManager" method="canUserAccessToAreaExtended" returnvariable="curAccessResult">
							<cfinvokeargument name="area_id" value="#current_area#">
							<cfinvokeargument name="user_id" value="#SESSION.user_id#">

							<cfinvokeargument name="client_abb" value="#client_abb#">
							<cfinvokeargument name="client_dsn" value="#client_dsn#">
						</cfinvoke>

						<cfif curAccessResult.accessResult IS true>

							<cfset access_result = true>
							<cfset area_id = current_area>

							<cfbreak>

						<cfelse>

							<cfset areasCheckedList = listAppend(areasCheckedList, curAccessResult.checkedAreasIds)>

						</cfif>

					</cfif>

				</cfloop>

			</cfif><!--- END isUserInAreasQuery.recordCount GT 0 --->

		</cfif><!--- END userAreasQuery.recordCount GT 0 --->

		<cfif arguments.throwError IS true AND access_result IS NOT true>
			<cfset error_code = 104>

			<cfthrow errorcode="#error_code#">
		</cfif>

		<cfset response = {result=access_result, area_id=area_id}>

		<cfreturn response>

	</cffunction>


	<!--- -------------------------- canUserAccessToArea -------------------------------- --->
	<!---Comprueba si el usuario puede acceder al área, y devuelve el resultado en una variable--->

	<cffunction name="canUserAccessToArea" returntype="boolean" access="public">
		<cfargument name="area_id" type="numeric" required="yes">

		<cfset var method = "canUserAccessToArea">

		<cfset var access_result = false>

		<cfinclude template="includes/functionStartOnlySession.cfm">

		<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaManager" method="canUserAccessToArea" returnvariable="access_result">
			<cfinvokeargument name="area_id" value="#arguments.area_id#">
			<cfinvokeargument name="user_id" value="#SESSION.user_id#">

			<cfinvokeargument name="client_abb" value="#client_abb#">
			<cfinvokeargument name="client_dsn" value="#client_dsn#">
		</cfinvoke>

		<cfreturn access_result>

	</cffunction>



	<!--- -------------------------- CHECK AREA ADMIN ACCESS -------------------------------- --->
	<!---Comprueba si el usuario es administrador del área al que quiere acceder y si no lanza un error--->

	<cffunction name="checkAreaAdminAccess" returntype="void" access="public">
		<cfargument name="area_id" type="numeric" required="yes">

		<cfset var method = "checkAreaAdminAccess">

		<cfset var access_result = false>

		<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="isUserAreaAdministrator" returnvariable="isAdministratorResponse">
			<cfinvokeargument name="area_id" value="#arguments.area_id#"/>
			<cfinvokeargument name="user_id" value="#SESSION.user_id#"/>
		</cfinvoke>

		<cfif isAdministratorResponse.isUserAdministrator IS NOT true>
			<cfset error_code = 105>

			<cfthrow errorcode="#error_code#">
		</cfif>

	</cffunction>


	<!--- -------------------------- CHECK AREA ADMIN ACCESS -------------------------------- --->
	<!---Comprueba si el usuario es administrador del área al que quiere acceder--->

	<cffunction name="isUserAreaAdministrator" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="user_id" type="numeric" required="true">

		<cfset var method = "isUserAreaAdministrator">

		<cfset var response = structNew()>

		<cfset var allUserAreasAdminList = "">
		<cfset var access_result = false>

		<cfif SESSION.client_administrator NEQ arguments.user_id><!---Is not general administrator user--->

			<cfinvoke component="AreaManager" method="getAllUserAreasAdminList" returnvariable="allUserAreasAdminList">
				<cfinvokeargument name="get_user_id" value="#arguments.user_id#">
			</cfinvoke>

			<cfinvoke component="AreaManager" method="canTheUserAccess" returnvariable="access_result">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="allUserAreasList" value="#allUserAreasAdminList#">
			</cfinvoke>

			<cfset response = {result=true, isUserAdministrator=#access_result#}>

		<cfelse>

			<cfset response = {result=true, isUserAdministrator=true}>

		</cfif>

		<cfreturn response>

	</cffunction>



	<!--- -------------------------- isUserAssociatedAsAdministrator -------------------------------- --->
	<!---Comprueba si el usuario es administrador de un área concreta, independientemente de si lo es de un área superior--->

	<cffunction name="isUserAssociatedAsAdministrator" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="check_user_id" type="numeric" required="true">

		<cfset var method = "isUserAssociatedAsAdministrator">

		<cfset var response = structNew()>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---isUserInArea--->
			<cfquery name="isUserInAreaAdministrators" datasource="#client_dsn#">
				SELECT user_id
				FROM #client_abb#_areas_administrators
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				AND user_id = <cfqueryparam value="#arguments.check_user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif isUserInAreaAdministrators.recordCount GT 0><!--- The user is in the area  --->
				<cfset response = {result=true, isUserAdministrator=true}>
			<cfelse>
				<cfset response = {result=true, isUserAdministrator=false}>
			</cfif>

		<cfreturn response>

	</cffunction>


	<!--- -------------------------- isUserAreaResponsible -------------------------------- --->
	<!---Comprueba si el usuario es responsable del área, y devuelve el resultado en una variable--->
	<!---El administrador general tiene permiso de responsable en todas las áreas--->

	<cffunction name="isUserAreaResponsible" returntype="boolean" access="public">
		<cfargument name="area_id" type="numeric" required="true">

		<cfset var method = "isUserAreaResponsible">

		<cfset var access_result = false>

		<cfinclude template="includes/functionStartOnlySession.cfm">

		<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaManager" method="isUserAreaResponsible" returnvariable="access_result">
			<cfinvokeargument name="area_id" value="#arguments.area_id#">
			<cfinvokeargument name="user_id" value="#SESSION.user_id#">
			<cfinvokeargument name="client_administrator" value="#SESSION.client_administrator#">

			<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
			<cfinvokeargument name="client_dsn" value="#client_dsn#">
		</cfinvoke>

		<cfreturn access_result>

	</cffunction>


	<!--- -------------------------- CHECK AREA RESPONSIBLE ACCESS -------------------------------- --->
	<!---Comprueba si el usuario es responsable del área y si no lanza un error--->
	<!---El administrador general tiene permiso de responsable en todas las áreas--->

	<cffunction name="checkAreaResponsibleAccess" returntype="void" access="public">
		<cfargument name="area_id" type="numeric" required="true">

		<cfset var method = "checkAreaResponsibleAccess">

		<cfif SESSION.client_administrator NEQ SESSION.user_id><!---Is not an administrator user--->

			<cfinvoke component="AreaManager" method="isUserAreaResponsible" returnvariable="access_result">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfif access_result IS NOT true>
				<cfset error_code = 105>

				<cfthrow errorcode="#error_code#">
			</cfif>

		</cfif>

	</cffunction>


	<!--- -------------------------- getNearestAreaUserAssociated -------------------------------- --->

	<cffunction name="getNearestAreaUserAssociated" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="user_id" type="numeric" required="yes">

		<cfargument name="userType" type="string" required="false" default="users"><!---users/administrators--->

		<cfset var method = "getNearestAreaUserAssociated">

		<cfset var response = structNew()>

		<cftry>

			<cfset var client_dsn = APPLICATION.identifier&"_"&SESSION.client_abb>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaManager" method="getNearestAreaUserAssociated" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="user_id" value="#arguments.user_id#">

				<cfinvokeargument name="userType" value="#arguments.userType#">

				<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- -------------------------- getHighestAreaUserAssociated -------------------------------- --->

	<cffunction name="getHighestAreaUserAssociated" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="user_id" type="numeric" required="yes">

		<cfargument name="userType" type="string" required="false" default="users"><!---users/administrators--->

		<cfset var method = "getHighestAreaUserAssociated">

		<cfset var response = structNew()>

		<cftry>

			<cfset var client_dsn = APPLICATION.identifier&"_"&SESSION.client_abb>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaManager" method="getHighestAreaUserAssociated" returnvariable="response">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="user_id" value="#arguments.user_id#">

				<cfinvokeargument name="userType" value="#arguments.userType#">

				<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>



	<!--- ---------------------------- getRootAreaId ---------------------------------- --->

	<cffunction name="getRootAreaId" returntype="numeric" access="public">

		<cfset var method = "getRootAreaId">

		<cfset var root_area_id = "">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getRootArea" returnvariable="rootAreaQuery">
				<cfinvokeargument name="onlyId" value="true">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset root_area_id = rootAreaQuery.id>

		<cfreturn root_area_id>

	</cffunction>


    <!--- ---------------------------- getRootArea ---------------------------------- --->

	<cffunction name="getRootArea" returntype="query" access="public">

		<cfset var method = "getRootArea">

		<cfset var root_area = structNew()>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getRootArea" returnvariable="rootAreaQuery">
				<cfinvokeargument name="onlyId" value="false">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

		<cfreturn rootAreaQuery>

	</cffunction>



	<!--- ---------------------------- userSeeTheWholeTree ---------------------------------- --->

	<cffunction name="userSeeTheWholeTree" returntype="boolean" access="public">
		<cfargument name="get_user_id" type="numeric" required="false" default="#SESSION.user_id#">

		<cfset var method = "userSeeTheWholeTree">

		<cfset var user_id = "">

		<cfset var internal_user = false>
		<cfset var whole_tree_visible = false>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---<cfinvoke component="UserManager" method="isInternalUser" returnvariable="internal_user">
				<cfinvokeargument name="get_user_id" value="#user_id#">
			</cfinvoke>--->

			<cfquery datasource="#client_dsn#" name="getUserAttQuery">
				SELECT internal_user, hide_not_allowed_areas
				FROM #client_abb#_users AS users
				WHERE users.id = <cfqueryparam value="#arguments.get_user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif getUserAttQuery.internal_user IS true AND getUserAttQuery.hide_not_allowed_areas IS false>

				<cfset whole_tree_visible = true>

			</cfif>

		<cfreturn whole_tree_visible>

	</cffunction>


	<!--- ---------------------------- getUserAreasArray ---------------------------------- --->
	<!---Obtiene las áreas donde el usuario está en la lista de usuarios--->
	<!---A esta función siempre la llama otra funcion de ColdFusion, por lo que no tiene que tener try catch, ya que la otra fucion que llame a esta lo tendrá.--->

	<!---Obtiene las áreas del usuario pasado como parámetro--->

	<cffunction name="getUserAreasArray" returntype="array" access="public">
		<cfargument name="get_user_id" type="numeric" required="true">

		<cfset var method = "getUserAreasArray">

		<cfset var areasArray = ArrayNew(1)>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---<cfquery name="getUserAreas" datasource="#client_dsn#">
				SELECT area_id
				FROM #client_abb#_areas_users
				WHERE user_id = <cfqueryparam value="#arguments.get_user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif getUserAreas.RecordCount GT 0>

				<cfloop query="getUserAreas">
					<cfset ArrayAppend(areasArray,#getUserAreas.area_id#)>
				</cfloop>

			<cfelse><!---The user has no areas--->

				<cfset xmlResponseContent = "">

				<cfset error_code = 403>

				<cfthrow errorcode="#error_code#">

			</cfif>--->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaManager" method="getUserAreasArray" returnvariable="areasArray">
				<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif arrayLen(areasArray) IS 0><!---The user has no areas--->

				<cfset error_code = 403>

				<cfthrow errorcode="#error_code#">

			</cfif>

		<cfreturn areasArray>

	</cffunction>


	<!--- ---------------------------- loopUserAreas ---------------------------------- --->

	<cffunction name="loopUserAreas" returntype="string" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="areasArray" type="array" required="yes">
		<cfargument name="allAreasList" type="string" required="yes">
		<cfargument name="allowed" type="boolean" required="no" default="false">

		<cfset var method = "loopUserAreas">

		<cfset var allAreasList = "">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaManager" method="loopUserAreas" returnvariable="allAreasList">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="areasArray" value="#arguments.areasArray#">
				<cfinvokeargument name="allAreasList" value="#arguments.allAreasList#">
				<cfinvokeargument name="allowed" value="#arguments.allowed#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfreturn allAreasList>


	</cffunction>


	<!--- ---------------------------- getAllUserAreasList ---------------------------------- --->
	<!---Obtiene la lista de todas las areas donde el usuario tiene acceso--->
	<!---Obtiene las áreas del usuario pasado como parámetro--->

	<cffunction name="getAllUserAreasList" returntype="string" access="public">
		<cfargument name="get_user_id" type="numeric" required="yes">
		<cfargument name="cached" type="boolean" required="false" default="#APPLICATION.cacheTree#">

		<cfset var method = "getAllUserAreasList">

		<cfset var user_id = "">

		<cfset var rootAreaId = "">
		<cfset var rootAreaVersion = "">
		<cfset var root_user = "">
		<cfset var areasArray = "">
		<cfset var allAreasListUpdated = "">
		<cfset var allAreasList = "">

		<!---<cfinclude template="includes/initVars.cfm">--->

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---<cfinvoke component="AreaManager" method="getRootAreaId" returnvariable="root_area_id">
			</cfinvoke>--->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getRootArea" returnvariable="rootAreaQuery">
				<cfinvokeargument name="onlyId" value="false">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset rootAreaId = rootAreaQuery.id>
			<cfset rootAreaVersion = rootAreaQuery.version_tree>

			<cfif arguments.cached IS true>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="getCacheAreasList" returnvariable="getCacheQuery">
					<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
					<cfinvokeargument name="area_id" value="#rootAreaId#">
					<cfinvokeargument name="version" value="#rootAreaVersion#">
					<cfinvokeargument name="tree_type" value="default">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif getCacheQuery.recordCount GT 0 AND len(getCacheQuery.areas_with_access) GT 0>

					<cfset allAreasList = getCacheQuery.areas_with_access>

				</cfif>

			</cfif>

			<cfif len(allAreasList) IS 0>

				<cfinvoke component="UserManager" method="isRootUser" returnvariable="root_user">
					<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					<cfinvokeargument name="root_area_id" value="#rootAreaId#">
				</cfinvoke>


				<cfif root_user IS true><!---Is root user--->

					<cfquery name="getAllAreasQuery" datasource="#client_dsn#">
						SELECT id
						FROM #client_abb#_areas;
					</cfquery>

					<cfif getAllAreasQuery.RecordCount GT 0>

						<cfset allAreasList = valueList(getAllAreasQuery.id)>

					</cfif>

				<cfelse><!---Is not root user--->

					<cfinvoke component="AreaManager" method="getUserAreasArray" returnvariable="areasArray">
						<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					</cfinvoke>

					<cfinvoke component="AreaManager" method="loopUserAreas" returnvariable="allAreasListUpdated">
						<cfinvokeargument name="area_id" value="#rootAreaId#">
						<cfinvokeargument name="areasArray" value="#areasArray#">
						<cfinvokeargument name="allAreasList" value="#allAreasList#">
					</cfinvoke>

					<cfset allAreasList = allAreasListUpdated>

				</cfif>


				<cfif arguments.cached IS true>

					<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="saveCacheAreasList">
						<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
						<cfinvokeargument name="area_id" value="#rootAreaId#">
						<cfinvokeargument name="version" value="#rootAreaVersion#">
						<cfinvokeargument name="tree_type" value="default">
						<cfinvokeargument name="areas_with_access" value="#allAreasList#">

						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

				</cfif>


			</cfif>


		<cfreturn allAreasList>

	</cffunction>



	<!--- ---------------------------- getUserAreasAdminArray ---------------------------------- --->
	<!---Obtiene las áreas donde el usuario es administrador--->

	<cffunction name="getUserAreasAdminArray" returntype="array" access="private">
		<cfargument name="get_user_id" type="numeric" required="true">

		<cfset var method = "getUserAreasAdminArray">

		<cfset var areasAdminArray = ArrayNew(1)>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfquery name="getUserAreasAdmin" datasource="#client_dsn#">
				SELECT area_id
				FROM #client_abb#_areas_administrators
				WHERE user_id = <cfqueryparam value="#arguments.get_user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif getUserAreasAdmin.RecordCount GT 0>

				<cfloop query="getUserAreasAdmin">
					<cfscript>
						ArrayAppend(areasAdminArray,#getUserAreasAdmin.area_id#);
					</cfscript>
				</cfloop>

			</cfif>

		<cfreturn areasAdminArray>

	</cffunction>


	<!--- ---------------------------- getAllUserAreasAdminList ---------------------------------- --->
	<!---Obtiene la lista de todas las areas donde el usuario es ADMINISTRADOR--->

	<cffunction name="getAllUserAreasAdminList" returntype="string" access="public">
		<cfargument name="get_user_id" type="numeric" required="false">
		<cfargument name="cached" type="boolean" required="false" default="#APPLICATION.cacheTree#">

		<cfset var method = "getAllUserAreasAdminList">

		<cfset var rootAreaId = "">
		<cfset var allAreasAdminList = "">
		<cfset var areasAdminArray = "">

		<!---<cfinclude template="includes/initVars.cfm">--->

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---<cfinvoke component="AreaManager" method="getRootAreaId" returnvariable="root_area_id">
			</cfinvoke>--->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getRootArea" returnvariable="rootAreaQuery">
				<cfinvokeargument name="onlyId" value="false">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset rootAreaId = rootAreaQuery.id>
			<cfset rootAreaVersion = rootAreaQuery.version_tree>

			<cfif arguments.cached IS true>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="getCacheAreasList" returnvariable="getCacheQuery">
					<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
					<cfinvokeargument name="area_id" value="#rootAreaId#">
					<cfinvokeargument name="version" value="#rootAreaVersion#">
					<cfinvokeargument name="tree_type" value="admin">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif getCacheQuery.recordCount GT 0 AND len(getCacheQuery.areas_with_access) GT 0>

					<cfset allAreasAdminList = getCacheQuery.areas_with_access>

				</cfif>

			</cfif>

			<cfif len(allAreasAdminList) IS 0>

				<cfinvoke component="AreaManager" method="getUserAreasAdminArray" returnvariable="areasAdminArray">
					<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
				</cfinvoke>

				<cfinvoke component="AreaManager" method="loopUserAreas" returnvariable="allAreasListUpdated">
					<cfinvokeargument name="area_id" value="#rootAreaId#">
					<cfinvokeargument name="areasArray" value="#areasAdminArray#">
					<cfinvokeargument name="allAreasList" value="#allAreasAdminList#">
				</cfinvoke>

				<cfset allAreasAdminList = allAreasListUpdated>

				<cfif arguments.cached IS true>

					<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="saveCacheAreasList">
						<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
						<cfinvokeargument name="area_id" value="#rootAreaId#">
						<cfinvokeargument name="version" value="#rootAreaVersion#">
						<cfinvokeargument name="tree_type" value="admin">
						<cfinvokeargument name="areas_with_access" value="#allAreasAdminList#">

						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

				</cfif>

			</cfif>


		<cfreturn allAreasAdminList>

	</cffunction>


	<!--- ---------------------------- getUserRootAreas ---------------------------------- --->

	<cffunction name="getUserRootAreas" returntype="query" access="public">
		<cfargument name="get_user_id" type="numeric" required="true">

		<cfset var method = "getUserRootAreas">

		<cfset var allUserAreasList = "">
		<cfset var userRootAreasQuery = "">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="getAllUserAreasList" returnvariable="allUserAreasList">
				<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
			</cfinvoke>

			<!---Se obtienen las áreas raices del usuario, debe hacerse así para obtenerlas ordenadas por nombre--->
			<cfquery name="userRootAreasQuery" datasource="#client_dsn#">
				SELECT areas.id
				FROM #client_abb#_areas AS areas
				INNER JOIN #client_abb#_areas_users AS areas_users
				ON areas_users.user_id = <cfqueryparam value="#arguments.get_user_id#" cfsqltype="cf_sql_integer">
				AND areas.id = areas_users.area_id
				AND areas.parent_id NOT IN (<cfqueryparam value="#allUserAreasList#" list="true" cfsqltype="cf_sql_varchar">)
				ORDER BY areas.name ASC;
			</cfquery>

		<cfreturn userRootAreasQuery>

	</cffunction>


	<!--- ------------------------------------- getMainTree -------------------------------------  --->

	<cffunction name="getMainTree" output="false" access="public" returntype="struct">
		<cfargument name="cached" type="boolean" required="false" default="#APPLICATION.cacheTree#">
		<cfargument name="get_user_id" type="numeric" required="false" default="#SESSION.user_id#">

		<cfset var method = "getMainTree">

		<cfset var response = structNew()>

		<cfset var with_sub_areas = true>
		<cfset var rootAreaId = "">
		<cfset var rootAreaVersion = "">
		<cfset var areasArray = ArrayNew(1)>
		<cfset var whole_tree = false>

		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">

		<cfset var visibleRootAreas = "">
		<cfset var userRootAreas = "">
		<cfset var areasContent = "">
		<cfset var areasXml = "">
		<cfset var allUserAreasList = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfif arguments.get_user_id NEQ SESSION.user_id>

				<!--- checkUserAdminAccess --->
				<cfinclude template="includes/checkUserAdminAccess.cfm">

			</cfif>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getRootArea" returnvariable="rootAreaQuery">
				<cfinvokeargument name="onlyId" value="false">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset rootAreaId = rootAreaQuery.id>
			<cfset rootAreaVersion = rootAreaQuery.version_tree>

			<cfif arguments.cached IS true>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="getCacheTree" returnvariable="getCacheQuery">
					<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
					<cfinvokeargument name="area_id" value="#rootAreaId#">
					<cfinvokeargument name="version" value="#rootAreaVersion#">
					<cfinvokeargument name="tree_type" value="default">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif getCacheQuery.recordCount GT 0 AND len(getCacheQuery.cache_content) GT 0>

					<cfset areasXml = '<areas cached="true" root_area_id="#rootAreaId#">#getCacheQuery.cache_content#</areas>'>

				</cfif>

			</cfif>

			<cfif len(areasXml) IS 0>

				<cfinvoke component="AreaManager" method="userSeeTheWholeTree" returnvariable="whole_tree">
					<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
				</cfinvoke>

				<!---Se obtiene si el usuario está en el área raiz--->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/UserManager" method="isRootUser" returnvariable="userInRootArea">
					<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					<cfinvokeargument name="root_area_id" value="#rootAreaId#">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif whole_tree IS false AND userInRootArea IS false>

					<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="getUserRootAreas" returnvariable="userRootAreasQuery">
						<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					</cfinvoke>

					<cfset userRootAreas = valueList(userRootAreasQuery.id, ",")>

					<!---Este loop se hace sobre la lista porque daba problemas hacerlo sobre la consulta (¿por los otros loops que ya existen sobre consultas?)--->
					<cfloop list="#userRootAreas#" index="visibleRootAreaId">

						<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreaType" returnvariable="getAreaTypeResult">
							<cfinvokeargument name="area_id" value="#visibleRootAreaId#">

							<cfinvokeargument name="client_abb" value="#client_abb#">
							<cfinvokeargument name="client_dsn" value="#client_dsn#">
						</cfinvoke>

						<cfinvoke component="AreaManager" method="getAreaContent" returnvariable="areasResult">
							<cfinvokeargument name="area_id" value="#visibleRootAreaId#">
							<cfinvokeargument name="allowed" value="true">
							<cfinvokeargument name="whole_tree" value="false">
							<cfinvokeargument name="list_type" value="default">
							<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
							<cfinvokeargument name="areaType" value="#getAreaTypeResult.areaType#">
						</cfinvoke>

						<cfset areasContent = areasContent&areasResult>

					</cfloop>

				<cfelse>

					<!---Se obtiene la lista de las áreas raices visibles (la raiz real no se muestra en el árbol de la aplicación)--->
					<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getVisibleRootAreas" returnvariable="rootAreasQuery">
						<cfinvokeargument name="root_area_id" value="#rootAreaid#">
						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

					<cfset visibleRootAreas = valueList(rootAreasQuery.id, ",")>

					<!---Este loop se hace sobre la lista porque daba problemas hacerlo sobre la consulta (¿por los otros loops que ya existen sobre consultas?)--->
					<cfloop list="#visibleRootAreas#" index="visibleRootAreaId">

						<cfinvoke component="AreaManager" method="getAreaContent" returnvariable="areasResult">
							<cfinvokeargument name="area_id" value="#visibleRootAreaId#">
							<cfinvokeargument name="allowed" value="#userInRootArea#">
							<cfinvokeargument name="whole_tree" value="#whole_tree#">
							<cfinvokeargument name="list_type" value="default">
							<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
						</cfinvoke>

						<cfset areasContent = areasContent&areasResult>

					</cfloop>

				</cfif>

				<cfif arguments.cached IS true>

					<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="saveCacheTree">
						<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
						<cfinvokeargument name="area_id" value="#rootAreaId#">
						<cfinvokeargument name="version" value="#rootAreaVersion#">
						<cfinvokeargument name="tree_type" value="default">
						<cfinvokeargument name="cache_content" value="#areasContent#">

						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

				</cfif>

				<cfset areasXml = '<areas cached="false">#areasContent#</areas>'>

			</cfif>

			<cfset response = {result=true, message="", areasXml=#areasXml#}>


			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>

	<!---  --->

	<!--- ------------------------------------- getMainTreeAdmin -------------------------------------  --->

	<cffunction name="getMainTreeAdmin" access="public" returntype="struct">
		<cfargument name="cached" type="boolean" required="false" default="#APPLICATION.cacheTree#">
		<cfargument name="get_user_id" type="numeric" required="false" default="#SESSION.user_id#">

		<cfset var method = "getMainTreeAdmin">

		<cfset var response = structNew()>

		<cfset var rootAreaId = "">
		<cfset var rootAreaVersion = "">
		<cfset var whole_tree = false>

		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">

		<cfset var rootAreas = "">
		<cfset var areasContent = "">
		<cfset var areasXml = "">
		<cfset var allUserAreasAdminList = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfif arguments.get_user_id NEQ SESSION.user_id AND SESSION.area_admin_administrator IS false>

				<cfset error_code = 106>

				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getRootArea" returnvariable="rootAreaQuery">
				<cfinvokeargument name="onlyId" value="false">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset rootAreaId = rootAreaQuery.id>
			<cfset rootAreaVersion = rootAreaQuery.version_tree>

			<cfif arguments.cached IS true>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="getCacheTree" returnvariable="getCacheQuery">
					<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
					<cfinvokeargument name="area_id" value="#rootAreaId#">
					<cfinvokeargument name="version" value="#rootAreaVersion#">
					<cfinvokeargument name="tree_type" value="admin">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif getCacheQuery.recordCount GT 0 AND len(getCacheQuery.cache_content) GT 0>

					<cfset areasXml = '<areas cached="true" root_area_id="#rootAreaId#">#getCacheQuery.cache_content#</areas>'>

				</cfif>

			</cfif>

			<cfif len(areasXml) IS 0>

				<cfif SESSION.client_administrator EQ arguments.get_user_id>
					<cfset whole_tree = true>
				<cfelse>
					<cfset whole_tree = false>

					<cfquery name="getUserAreasAdmin" datasource="#client_dsn#">
						SELECT area_id
						FROM #client_abb#_areas_administrators
						WHERE user_id = <cfqueryparam value = "#arguments.get_user_id#" cfsqltype="cf_sql_varchar">;
					</cfquery>

					<cfif getUserAreasAdmin.RecordCount IS 0><!---The user has no areas--->

						<cfset error_code = 404>

						<cfthrow errorcode="#error_code#">

					</cfif>
				</cfif>

				<!---Se obtiene si el usuario está de administrador en el área raiz--->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/UserManager" method="isRootUserAdmin" returnvariable="userInRootAreaAdmin">
					<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					<cfinvokeargument name="root_area_id" value="#rootAreaId#">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif whole_tree IS false AND userInRootAreaAdmin IS false>

					<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="getAllUserAreasAdminList" returnvariable="allUserAreasAdminList">
						<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					</cfinvoke>

					<!---Se obtienen las áreas raices del usuario, debe hacerse así para obtenerlas ordenadas por nombre--->
					<cfquery name="getUserRootAreasAdmin" datasource="#client_dsn#">
						SELECT areas.id
						FROM #client_abb#_areas AS areas
						INNER JOIN #client_abb#_areas_administrators AS areas_administrators
						ON areas_administrators.user_id = <cfqueryparam value="#arguments.get_user_id#" cfsqltype="cf_sql_integer">
						AND areas.id = areas_administrators.area_id
						AND areas.parent_id NOT IN (<cfqueryparam value="#allUserAreasAdminList#" list="true" cfsqltype="cf_sql_varchar">)
						ORDER BY areas.name ASC;
					</cfquery>

					<cfset userRootAreasAdmin = valueList(getUserRootAreasAdmin.id, ",")>

					<!---Este loop se hace sobre la lista porque daba problemas hacerlo sobre la consulta--->
					<cfloop list="#userRootAreasAdmin#" index="visibleRootAreaId">

						<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreaType" returnvariable="getAreaTypeResult">
							<cfinvokeargument name="area_id" value="#visibleRootAreaId#">

							<cfinvokeargument name="client_abb" value="#client_abb#">
							<cfinvokeargument name="client_dsn" value="#client_dsn#">
						</cfinvoke>

						<cfinvoke component="AreaManager" method="getAreaContent" returnvariable="areasResult">
							<cfinvokeargument name="area_id" value="#visibleRootAreaId#">
							<cfinvokeargument name="allowed" value="true">
							<cfinvokeargument name="whole_tree" value="false">
							<cfinvokeargument name="list_type" value="administrator">
							<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
							<cfinvokeargument name="areaType" value="#getAreaTypeResult.areaType#">
						</cfinvoke>

						<cfset areasContent = areasContent&areasResult>

					</cfloop>

				<cfelse>

					<cfinvoke component="AreaManager" method="getAreaContent" returnvariable="areasContent">
						<cfinvokeargument name="area_id" value="#rootAreaId#">
						<cfinvokeargument name="allowed" value="#userInRootAreaAdmin#">
						<cfinvokeargument name="whole_tree" value="#whole_tree#">
						<cfinvokeargument name="list_type" value="administrator">
						<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					</cfinvoke>

				</cfif><!--- whole_tree IS false AND userInRootArea IS false --->

				<cfif arguments.cached IS true>

					<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="saveCacheTree">
						<cfinvokeargument name="user_id" value="#arguments.get_user_id#">
						<cfinvokeargument name="area_id" value="#rootAreaId#">
						<cfinvokeargument name="version" value="#rootAreaVersion#">
						<cfinvokeargument name="tree_type" value="admin">
						<cfinvokeargument name="cache_content" value="#areasContent#">

						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

				</cfif>

				<cfset areasXml = '<areas cached="false">#areasContent#</areas>'>

			</cfif><!--- END len(areasXml) IS 0 --->

			<cfset response = {result=true, areasXml=#areasXml#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>

	<!--- --->


	<!--- ------------------------------------- getAreaContent ------------------------------------- --->
	<!---A esta función siempre la llama otra funcion de ColdFusion, por lo que no tiene que tener try catch, ya que la otra fucion que llame a esta lo tendrá.--->

	<cffunction name="getAreaContent" output="false" returntype="string" access="public">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="allowed" type="boolean" required="true">
		<cfargument name="whole_tree" type="boolean" required="false">
		<cfargument name="areaType" type="string" required="false" default="">

		<cfargument name="parent_image_id" type="string" required="false" default="">
		<cfargument name="parent_link" type="string" required="false" default="">

		<cfargument name="withSubAreas" type="boolean" required="false" default="true">
		<cfargument name="withSubSubAreas" type="boolean" required="false" default="true">

		<cfargument name="list_type" type="string" required="false" default="default">

		<cfargument name="get_user_id" type="numeric" required="false" default="#SESSION.user_id#">

		<cfset var method = "getAreaContent">

		<cfset var image_id = "">

		<cfset var with_link = "">

		<cfset var xmlPart = "">
		<cfset var xmlAreaResult = "">
		<cfset var isUserAreaResponsible = false>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---Este método no necesita chequeo de acceso al área porque si un usuario puede ver el árbol entero se tiene que acceder a este método para generarlo.--->

			<cfif NOT isDefined("arguments.whole_tree")>

				<cfinvoke component="AreaManager" method="userSeeTheWholeTree" returnvariable="whole_tree_visible">
					<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
				</cfinvoke>

				<cfset arguments.whole_tree = whole_tree_visible>

			</cfif>

			<cfquery name="areaAttsQuery" datasource="#client_dsn#">
				SELECT id, name, parent_id, creation_date, user_in_charge, image_id, link, type, read_only
				FROM #client_abb#_areas AS areas
				WHERE areas.id = #arguments.area_id#
				ORDER BY areas.name ASC;
			</cfquery>

			<cfif areaAttsQuery.RecordCount LT 1>

				<cfset error_code = 401>

				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfif areaAttsQuery.user_in_charge EQ arguments.get_user_id>
				<cfset isUserAreaResponsible = true>
			</cfif>

			<cfinvoke component="AreaManager" method="getAreaQueryContent" returnvariable="xmlAreaResult">
				<cfinvokeargument name="areaQuery" value="#areaAttsQuery#">
				<cfinvokeargument name="areaRow" value="1">

				<cfinvokeargument name="allowed" value="#arguments.allowed#">
				<cfinvokeargument name="responsible" value="#isUserAreaResponsible#">
				<cfinvokeargument name="whole_tree" value="#arguments.whole_tree#">
				<cfinvokeargument name="areaType" value="#arguments.areaType#">

				<cfinvokeargument name="parent_image_id" value="#arguments.parent_image_id#">
				<cfinvokeargument name="parent_link" value="#arguments.parent_link#">

				<cfinvokeargument name="withSubAreas" value="#arguments.withSubAreas#">
				<cfinvokeargument name="withSubSubAreas" value="#arguments.withSubSubAreas#">

				<cfinvokeargument name="list_type" value="#arguments.list_type#">

				<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
			</cfinvoke>

			<cfreturn #xmlAreaResult#>

	</cffunction>


	<!--- ------------------------------------- getAreaQueryContent ------------------------------------- --->
	<!---A esta función siempre la llama otra funcion de ColdFusion, por lo que no tiene que tener try catch, ya que la otra fucion que llame a esta lo tendrá.--->

	<cffunction name="getAreaQueryContent" output="false" returntype="string" access="public">
		<cfargument name="areaQuery" type="query" required="yes">
		<cfargument name="areaRow" type="numeric" required="yes">

		<!---<cfargument name="areasArray" type="Array" required="false">--->
		<cfargument name="allowed" type="boolean" required="true">
		<cfargument name="responsible" type="boolean" required="true">
		<cfargument name="whole_tree" type="Boolean" required="true">
		<cfargument name="areaType" type="string" required="false" default="">

		<cfargument name="parent_image_id" type="string" required="true">
		<cfargument name="parent_link" type="string" required="true">

		<cfargument name="withSubAreas" type="boolean" required="true">
		<cfargument name="withSubSubAreas" type="boolean" required="false" default="true">

		<cfargument name="list_type" type="string" required="true">

		<cfargument name="get_user_id" type="numeric" required="false" default="#SESSION.user_id#">

		<cfset var method = "getAreaQueryContent">

		<cfset var area_id = "">
		<cfset var image_id = "">

		<cfset var with_link = "">

		<cfset var xmlPart = "">
		<cfset var xmlAreasResult = "">

		<cfset var aRow = arguments.areaRow>
		<cfset var userBelongsToArea = false>
		<cfset var isUserAreaResponsible = false>
		<cfset var curAreaType = "">

			<cfinclude template="includes/functionStart.cfm">

			<cfset area_id = areaQuery.id[aRow]>

			<cfif arguments.allowed EQ true>
				<cfset userBelongsToArea = true>
			<cfelse>

				<cfif list_type NEQ "administrator">
					<!---<cfset list = ArrayToList(#arguments.areasArray#,",")>
					<cfset temp = ListFind(list, #areaId#)>
					<cfif temp GT 0>--->

					<cfquery datasource="#client_dsn#" name="isUserInArea">
						SELECT user_id
						FROM #client_abb#_areas_users AS areas_users
						WHERE area_id = <cfqueryparam value="#area_id#" cfsqltype="cf_sql_integer">
						AND user_id = <cfqueryparam value="#arguments.get_user_id#" cfsqltype="cf_sql_integer">;
					</cfquery>

					<cfif isUserInArea.recordCount GT 0>
						<cfset userBelongsToArea = true>
					<cfelse>
						<cfset userBelongsToArea = false>
					</cfif>

				<cfelse><!---LIST ADMINISTRATOR AREAS (to method getMainTreeAdministrator)--->

					<cfif whole_tree EQ true><!---Si es administrador general whole_tree IS true--->

						<cfset userBelongsToArea = true>

					<cfelse>
						<!---<cfset list = ArrayToList(#arguments.areasArray#,",")>
						<cfset temp = ListFind(list, #area_id#)>
						<cfif temp GT 0>--->

						<cfquery datasource="#client_dsn#" name="isUserAdministratorOfArea">
							SELECT areas_administrators.user_id
							FROM #client_abb#_areas_administrators AS areas_administrators
							WHERE areas_administrators.area_id = <cfqueryparam value="#area_id#" cfsqltype="cf_sql_integer">
							AND user_id = <cfqueryparam value="#arguments.get_user_id#" cfsqltype="cf_sql_integer">;
						</cfquery>

						<cfif isUserAdministratorOfArea.recordCount GT 0>
							<cfset userBelongsToArea = true>
						<cfelse>
							<cfset userBelongsToArea = false>
						</cfif>
					</cfif>

				</cfif>

			</cfif>

			<cfif arguments.responsible IS true>

				<cfset isUserAreaResponsible = true>

			<cfelseif userBelongsToArea IS true>

				<cfif arguments.get_user_id IS areaQuery.user_in_charge[aRow]>
					<cfset isUserAreaResponsible = true>
				</cfif>

			</cfif>

			<!---area_image--->
			<cfif len(areaQuery.image_id[aRow]) IS NOT 0 AND areaQuery.image_id[aRow] NEQ "NULL">

				<cfset image_id = areaQuery.image_id[aRow]>
				<!---<cfset image_background_color = areaQuery.image_background_color>--->
				<cfif len(areaQuery.link[aRow]) GT 0 AND areaQuery.link[aRow] NEQ "NULL">
					<cfset with_link = "true">
				</cfif>

			<cfelse>

				<cfset image_id = arguments.parent_image_id>
				<!---<cfset image_background_color = arguments.parent_image_background_color>--->
				<cfif len(arguments.parent_link) GT 0 AND arguments.parent_link EQ "true"><!---Si hereda la imagen tambien hereda la url--->
					<cfset with_link = "true">
				<cfelse>
					<cfset with_link = "false">
				</cfif>

			</cfif>

			<!---areaType--->
			<cfif len(arguments.areaType) GT 0>
				<cfset curAreaType = arguments.areaType>
			<cfelse>
				<cfset curAreaType = areaQuery.type[aRow]>
			</cfif>

			<cfset xmlPart = ''>


			<cfif whole_tree EQ true OR userBelongsToArea EQ true>

				<cfset xmlPart = '<area id="#area_id#" name="#xmlFormat(areaQuery.name[aRow])#" parent_id="#areaQuery.parent_id[aRow]#" allowed="#NumberFormat(userBelongsToArea)#" responsible="#NumberFormat(isUserAreaResponsible)#" read_only="#NumberFormat(areaQuery.read_only[aRow])#" with_link="#NumberFormat(with_link)#" type="#curAreaType#">'><!--- label="#xmlFormat(areaQuery.name[aRow])#" creation_date="#areaQuery.creation_date[aRow]#" image_id="#image_id#" user_in_charge="#areaQuery.user_in_charge[aRow]#" --->

			</cfif>

			<cfif arguments.withSubAreas EQ true><!---withSubAreas--->

				<cfinvoke component="AreaManager" method="getSubAreasContent" returnvariable="xmlAreasResult">
					<cfinvokeargument name="parent_id" value="#area_id#">
					<!---<cfif isDefined("arguments.areasArray")>
					<cfinvokeargument name="areasArray" value="#arguments.areasArray#">
					</cfif>--->
					<cfinvokeargument name="allowed" value="#userBelongsToArea#">
					<cfinvokeargument name="responsible" value="#isUserAreaResponsible#">
					<cfinvokeargument name="whole_tree" value="#whole_tree#">
					<cfinvokeargument name="areaType" value="#curAreaType#">

					<cfinvokeargument name="parent_image_id" value="#image_id#">
					<cfinvokeargument name="parent_link" value="#with_link#">

					<cfinvokeargument name="withSubSubAreas" value="#arguments.withSubSubAreas#">

					<cfinvokeargument name="list_type" value="#arguments.list_type#">

					<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
				</cfinvoke>

				<cfset xmlPart = xmlPart&xmlAreasResult>

			</cfif>

			<cfif whole_tree EQ true OR userBelongsToArea EQ true>
				<cfset xmlPart = xmlPart&'</area>'>
			</cfif>

			<cfreturn #xmlPart#>

	</cffunction>


	<!--- ------------------------------------- getSubAreasContent ------------------------------------- --->
	<!---A esta función siempre la llama otra funcion de ColdFusion, por lo que no tiene que tener try catch, ya que la otra fucion que llame a esta lo tendrá.--->

	<cffunction name="getSubAreasContent" output="false" returntype="string" access="public">
		<cfargument name="parent_id" type="numeric" required="true">
		<!---<cfargument name="areasArray" type="Array" required="false">--->
		<cfargument name="allowed" type="Boolean" required="true">
		<cfargument name="responsible" type="boolean" required="true">
		<cfargument name="whole_tree" type="Boolean" required="true">
		<cfargument name="areaType" type="string" required="true">

		<cfargument name="parent_image_id" type="string" required="false" default="">
		<cfargument name="parent_link" type="string" required="false" default="">

		<cfargument name="withSubSubAreas" type="boolean" required="true">

		<cfargument name="list_type" type="string" required="true">

		<cfargument name="get_user_id" type="numeric" required="false" default="#SESSION.user_id#">

		<cfset var method = "getSubAreasContent">

		<cfset var image_id = "">

		<cfset var with_link = "">

		<cfset var subAreasQuery = "">
		<cfset var xmlPart = "">
		<cfset var xmlAreaResult = "">

			<cfinclude template="includes/functionStart.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getSubAreas" returnvariable="subAreasQuery">
				<cfinvokeargument name="area_id" value="#arguments.parent_id#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif subAreasQuery.recordCount GT 0>

				<cfloop index="currentRow" from="1" to="#subAreasQuery.recordCount#">

					<cfinvoke component="AreaManager" method="getAreaQueryContent" returnvariable="xmlAreaResult">
						<cfinvokeargument name="areaQuery" value="#subAreasQuery#">
						<cfinvokeargument name="areaRow" value="#currentRow#">

						<!---<cfif isDefined("arguments.areasArray")>
						<cfinvokeargument name="areasArray" value="#arguments.areasArray#">
						</cfif>--->
						<cfinvokeargument name="allowed" value="#arguments.allowed#">
						<cfinvokeargument name="responsible" value="#arguments.responsible#">
						<cfinvokeargument name="whole_tree" value="#arguments.whole_tree#">
						<cfinvokeargument name="areaType" value="#arguments.areaType#">

						<cfinvokeargument name="parent_image_id" value="#arguments.parent_image_id#">
						<cfinvokeargument name="parent_link" value="#arguments.parent_link#">

						<cfinvokeargument name="withSubAreas" value="#arguments.withSubSubAreas#">

						<cfinvokeargument name="list_type" value="#arguments.list_type#">

						<cfinvokeargument name="get_user_id" value="#arguments.get_user_id#">
					</cfinvoke>

					<cfset xmlPart = xmlPart&xmlAreaResult>

				</cfloop>

			</cfif>

			<cfreturn #xmlPart#>

	</cffunction>


	<!--- ------------------------------------- getSubAreasIds ------------------------------------- --->

	<cffunction name="getSubAreasIds" output="false" access="public" returntype="struct">
		<cfargument name="area_id" type="numeric" required="true"/>

		<cfset var method = "getSubAreasIds">
		<cfset var subAreasIds = "">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getSubAreasIds" returnvariable="subAreasIds">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, areasIds=subAreasIds}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- createArea ------------------------------------- --->

	<cffunction name="createArea" output="false" access="public" returntype="struct">
		<cfargument name="parent_id" type="string" required="true"/>
		<cfargument name="user_in_charge" type="numeric" required="true"/>
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="description" type="string" required="true"/>
		<cfargument name="hide_in_menu" type="boolean" required="false" default="false"/>
		<cfargument name="menu_type_id" type="numeric" required="false"/>

		<cfargument name="item_type_1_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_2_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_3_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_4_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_5_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_6_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_7_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_8_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_9_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_10_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_11_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_12_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_13_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_14_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_15_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_16_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_20_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="items_enabled_subareas" type="boolean" required="false" default="false"/>
		<cfargument name="users_visible" type="boolean" required="false" default="false"/>
		<cfargument name="read_only" type="boolean" required="false" default="false"/>
		<cfargument name="list_mode" type="string" required="false" default=""/>
		<cfargument name="url_id" type="string" required="false">

		<cfargument name="no_notify" type="boolean" required="false" default="false">


		<cfset var method = "createArea">

		<cfset var response = structNew()>

		<cfset var area_id = "">
		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---<cfinclude template="includes/checkAreaAdminAccess.cfm">--->
			<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreaAdminAccess">
				<cfinvokeargument name="area_id" value="#arguments.parent_id#">
			</cfinvoke>

			<cfif isDefined("arguments.url_id")>

				<!--- Check url_id length --->
				<cfif len(arguments.url_id) GT 255>

					<cfset response = {result=false, message="URL de la página demasiado larga, introduzca una URL con menos de 200 caracteres", area_id=#arguments.parent_id#}>
					<cfreturn response>

				</cfif>

				<!--- Check if url_id exist --->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getArea" returnvariable="areaByUrlQuery">
					<cfinvokeargument name="url_id" value="#arguments.url_id#">
					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<cfif areaByUrlQuery.recordCount GT 0>
					<cfset response = {result=false, message="La URL de la página ya existe, debe usar otra distinta", area_id=#arguments.parent_id#}>
					<cfreturn response>
				</cfif>

			</cfif>

			<cftransaction>

				<cfinvoke component="AreaManager" method="createAreaInDatabase" argumentcollection="#arguments#" returnvariable="area_id">
				</cfinvoke>

				<cfinvoke component="AreaManager" method="setAreaEnabledItems" argumentcollection="#arguments#">
					<cfinvokeargument name="area_id" value="#area_id#">
					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

			</cftransaction>

      <!---Alerta a todos los usuarios que tienen acceso al área que se ha creado--->
			<!---<cfinvoke component="AreaManager" method="objectArea" returnvariable="objectArea">
				<cfinvokeargument name="id" value="#area_id#"/>
				<cfinvokeargument name="parent_id" value="#arguments.parent_id#"/>
				<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#"/>
				<cfinvokeargument name="name" value="#arguments.name#"/>
				<cfinvokeargument name="description" value="#arguments.description#"/>
				<cfinvokeargument name="creation_date" value="#stringCurrentDate#"/>
			</cfinvoke>--->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getArea" returnvariable="areaQuery">
				<cfinvokeargument name="area_id" value="#area_id#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif arguments.no_notify IS false>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/AlertManager" method="newArea">
					<cfinvokeargument name="objectArea" value="#areaQuery#">
					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<!---Alerta al usuario que que es responsable de la misma--->
				<cfinvoke component="UserManager" method="getUser" returnvariable="objectUser">
					<cfinvokeargument name="get_user_id" value="#arguments.user_in_charge#"/>
					<cfinvokeargument name="return_type" value="query"/>
				</cfinvoke>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/AlertManager" method="assignUserToArea">
					<cfinvokeargument name="objectUser" value="#objectUser#">
					<cfinvokeargument name="area_id" value="#area_id#">
					<cfinvokeargument name="new_area" value="true">

					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

			</cfif>

			<!--- updateRootAreaVersionTree --->
			<cfinclude template="includes/updateRootAreaVersionTree.cfm">

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, message="", area_id=#area_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>

	<!---  --->

	<!--- ------------------------------------ createAreaInDatabase -----------------------------------  --->

	<!--- Este método debe ser llamado dentro de una transaction --->

	<cffunction name="createAreaInDatabase" output="false" access="package" returntype="number">
		<cfargument name="parent_id" type="string" required="true"/>
		<cfargument name="user_in_charge" type="numeric" required="true"/>
		<cfargument name="name" type="string" required="true"/>
		<cfargument name="description" type="string" required="true"/>
		<cfargument name="hide_in_menu" type="boolean" required="false" default="false"/>
		<cfargument name="menu_type_id" type="numeric" required="false"/>
		<cfargument name="url_id" type="string" required="false"/>

		<cfset var method = "createAreaInDatabase">

		<cfset var area_id = "">

			<cfinclude template="includes/functionStartOnlySession.cfm">


			<cfquery name="insertAreaQuery" datasource="#client_dsn#" result="insertAreaResult">
				INSERT INTO #client_abb#_areas
				SET name = <cfqueryparam value="#arguments.name#" CFSQLType="CF_SQL_varchar">,
				parent_id = <cfqueryparam value="#arguments.parent_id#" CFSQLType="cf_sql_integer">,
				user_in_charge = <cfqueryparam value="#arguments.user_in_charge#" CFSQLType="cf_sql_integer">,
				creation_date = NOW(),
				description = <cfqueryparam value="#arguments.description#" CFSQLType="CF_SQL_varchar">,
				hide_in_menu = <cfqueryparam value="#arguments.hide_in_menu#" CFSQLType="CF_SQL_boolean">
				<!---item_type_1_enabled = <cfqueryparam value="#arguments.item_type_1_enabled#" cfsqltype="cf_sql_bit">,
				item_type_2_enabled = <cfqueryparam value="#arguments.item_type_2_enabled#" cfsqltype="cf_sql_bit">,
				item_type_3_enabled = <cfqueryparam value="#arguments.item_type_3_enabled#" cfsqltype="cf_sql_bit">,
				item_type_4_enabled = <cfqueryparam value="#arguments.item_type_4_enabled#" cfsqltype="cf_sql_bit">,
				item_type_5_enabled = <cfqueryparam value="#arguments.item_type_5_enabled#" cfsqltype="cf_sql_bit">,
				item_type_6_enabled = <cfqueryparam value="#arguments.item_type_6_enabled#" cfsqltype="cf_sql_bit">,
				item_type_7_enabled = <cfqueryparam value="#arguments.item_type_7_enabled#" cfsqltype="cf_sql_bit">,
				item_type_8_enabled = <cfqueryparam value="#arguments.item_type_8_enabled#" cfsqltype="cf_sql_bit">,
				item_type_9_enabled = <cfqueryparam value="#arguments.item_type_9_enabled#" cfsqltype="cf_sql_bit">,
				item_type_10_enabled = <cfqueryparam value="#arguments.item_type_10_enabled#" cfsqltype="cf_sql_bit">,
				item_type_11_enabled = <cfqueryparam value="#arguments.item_type_11_enabled#" cfsqltype="cf_sql_bit">,
				item_type_12_enabled = <cfqueryparam value="#arguments.item_type_12_enabled#" cfsqltype="cf_sql_bit">,
				item_type_13_enabled = <cfqueryparam value="#arguments.item_type_13_enabled#" cfsqltype="cf_sql_bit">,
				item_type_14_enabled = <cfqueryparam value="#arguments.item_type_14_enabled#" cfsqltype="cf_sql_bit">,
				item_type_15_enabled = <cfqueryparam value="#arguments.item_type_15_enabled#" cfsqltype="cf_sql_bit">,
				item_type_20_enabled = <cfqueryparam value="#arguments.item_type_20_enabled#" cfsqltype="cf_sql_bit">--->
				<cfif isDefined("arguments.menu_type_id") AND arguments.menu_type_id NEQ "">
					,menu_type_id = <cfqueryparam value = "#arguments.menu_type_id#" cfsqltype = "CF_SQL_integer">
				</cfif>
				<cfif isDefined("arguments.url_id")>
					,url_id = <cfqueryparam value="#arguments.url_id#" cfsqltype="CF_SQL_varchar">
				</cfif>
				;
			</cfquery>
			<cfquery name="getLastInsertId" datasource="#client_dsn#">
				SELECT LAST_INSERT_ID() AS last_insert_id FROM #client_abb#_areas;
			</cfquery>

			<cfset area_id = getLastInsertId.last_insert_id>

			<!---<cfquery name="insertUserQuery" datasource="#client_dsn#">
				INSERT INTO #client_abb#_areas_users (area_id, user_id, association_date)
				VALUES (<cfqueryparam value="#area_id#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#arguments.user_in_charge#" cfsqltype="cf_sql_integer">,
						NOW()
				);
			</cfquery>--->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/UserQuery" method="assignUserToArea">
				<cfinvokeargument name="area_id" value="#area_id#"/>
				<cfinvokeargument name="user_id" value="#arguments.user_in_charge#"/>

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfreturn area_id>

	</cffunction>


	<!--- setAreaEnabledItems --->

	<cffunction name="setAreaEnabledItems" returntype="void" output="false" access="private">
		<cfargument name="area_id" type="numeric" required="true"/>
		<cfargument name="item_type_1_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_2_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_3_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_4_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_5_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_6_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_7_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_8_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_9_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_10_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_11_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_12_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_13_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_14_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_15_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_16_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_17_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_20_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="items_enabled_subareas" type="boolean" required="false" default="false"/>
		<cfargument name="users_visible" type="boolean" required="false" default="false"/>
		<cfargument name="read_only" type="boolean" required="false" default="false"/>
		<cfargument name="list_mode" type="string" required="false" default=""/>

		<cfargument name="client_abb" type="string" required="true">
		<cfargument name="client_dsn" type="string" required="true">

		<cfif arguments.items_enabled_subareas IS true>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getSubAreasIds" returnvariable="subAreasIds">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

		</cfif>

		<cfquery name="itemsEnabledQuery" datasource="#client_dsn#">
			UPDATE #client_abb#_areas
			SET item_type_1_enabled = <cfqueryparam value="#arguments.item_type_1_enabled#" cfsqltype="cf_sql_bit">,
			item_type_2_enabled = <cfqueryparam value="#arguments.item_type_2_enabled#" cfsqltype="cf_sql_bit">,
			item_type_3_enabled = <cfqueryparam value="#arguments.item_type_3_enabled#" cfsqltype="cf_sql_bit">,
			item_type_4_enabled = <cfqueryparam value="#arguments.item_type_4_enabled#" cfsqltype="cf_sql_bit">,
			item_type_5_enabled = <cfqueryparam value="#arguments.item_type_5_enabled#" cfsqltype="cf_sql_bit">,
			item_type_6_enabled = <cfqueryparam value="#arguments.item_type_6_enabled#" cfsqltype="cf_sql_bit">,
			item_type_7_enabled = <cfqueryparam value="#arguments.item_type_7_enabled#" cfsqltype="cf_sql_bit">,
			item_type_8_enabled = <cfqueryparam value="#arguments.item_type_8_enabled#" cfsqltype="cf_sql_bit">,
			item_type_9_enabled = <cfqueryparam value="#arguments.item_type_9_enabled#" cfsqltype="cf_sql_bit">,
			item_type_10_enabled = <cfqueryparam value="#arguments.item_type_10_enabled#" cfsqltype="cf_sql_bit">,
			item_type_11_enabled = <cfqueryparam value="#arguments.item_type_11_enabled#" cfsqltype="cf_sql_bit">,
			item_type_12_enabled = <cfqueryparam value="#arguments.item_type_12_enabled#" cfsqltype="cf_sql_bit">,
			item_type_13_enabled = <cfqueryparam value="#arguments.item_type_13_enabled#" cfsqltype="cf_sql_bit">,
			item_type_14_enabled = <cfqueryparam value="#arguments.item_type_14_enabled#" cfsqltype="cf_sql_bit">,
			item_type_15_enabled = <cfqueryparam value="#arguments.item_type_15_enabled#" cfsqltype="cf_sql_bit">,
			item_type_16_enabled = <cfqueryparam value="#arguments.item_type_16_enabled#" cfsqltype="cf_sql_bit">,
			item_type_17_enabled = <cfqueryparam value="#arguments.item_type_17_enabled#" cfsqltype="cf_sql_bit">,
			item_type_20_enabled = <cfqueryparam value="#arguments.item_type_20_enabled#" cfsqltype="cf_sql_bit">,
			users_visible = <cfqueryparam value="#arguments.users_visible#" cfsqltype="cf_sql_bit">,
			read_only = <cfqueryparam value="#arguments.read_only#" cfsqltype="cf_sql_bit">,
			list_mode = <cfqueryparam value="#arguments.list_mode#" cfsqltype="cf_sql_varchar">
			WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
			<cfif arguments.items_enabled_subareas IS true AND len(subAreasIds) GT 0>
				OR id IN (<cfqueryparam value="#subAreasIds#" cfsqltype="cf_sql_longvarchar" list="true">)
			</cfif>;
		</cfquery>

	</cffunction>



	<!--- -------------------------------- updateArea ----------------------------------  --->

	<cffunction name="updateArea" returntype="struct" output="false" access="public">
		<cfargument name="area_id" type="numeric" required="true"/>
		<cfargument name="name" type="string" required="false"/>
		<cfargument name="description" type="string" required="false"/>
		<cfargument name="with_link" type="string" required="false"/>
		<cfargument name="link" type="string" required="false"/>
		<cfargument name="with_image" type="boolean" required="false"/>
		<cfargument name="user_in_charge" type="numeric" required="false"/>
		<cfargument name="image_file" type="string" required="false"/>
		<cfargument name="hide_in_menu" type="boolean" required="false" default="false"/>
		<cfargument name="menu_type_id" type="numeric" required="false"/>
		<cfargument name="files" type="array" required="false"/>

		<cfargument name="item_type_1_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_2_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_3_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_4_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_5_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_6_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_7_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_8_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_9_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_10_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_11_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_12_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_13_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_14_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_15_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_16_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_17_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="item_type_20_enabled" type="boolean" required="false" default="false"/>
		<cfargument name="items_enabled_subareas" type="boolean" required="false" default="false"/>
		<cfargument name="users_visible" type="boolean" required="false" default="false"/>
		<cfargument name="read_only" type="boolean" required="false" default="false"/>
		<cfargument name="list_mode" type="string" required="false" default=""/>
		<cfargument name="url_id" type="string" required="false">


		<cfset var method = "updateArea">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="includes/checkAreaAdminAccess.cfm">

			<!---<cfquery name="beginQuery" datasource="#client_dsn#">
				BEGIN;
			</cfquery>--->

			<cftry>

					<cfif isDefined("arguments.url_id")>

						<!--- Check url_id length --->
						<cfif len(arguments.url_id) GT 255>

							<cfset response = {result=false, message="URL de la página demasiado larga, introduzca una URL con menos de 200 caracteres", area_id=#arguments.area_id#}>
							<cfreturn response>

						</cfif>

						<!--- Check if url_id exist --->
						<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getArea" returnvariable="areaByUrlQuery">
							<cfinvokeargument name="url_id" value="#arguments.url_id#">
							<cfinvokeargument name="client_abb" value="#client_abb#">
							<cfinvokeargument name="client_dsn" value="#client_dsn#">
						</cfinvoke>

						<cfif areaByUrlQuery.recordCount GT 1 OR (areaByUrlQuery.recordCount IS 1 AND areaByUrlQuery.id NEQ arguments.area_id)>
							<cfset response = {result=false, message="La URL de la página ya existe, debe usar otra distinta", area_id=#arguments.area_id#}>
							<cfreturn response>
						</cfif>

					</cfif>

					<cftransaction>

					<cfif isDefined("arguments.name") AND arguments.name NEQ "">
						<cfquery name="nameQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET name = <cfqueryPARAM value = "#arguments.name#" CFSQLType = "CF_SQL_varchar">
							WHERE id = <cfqueryPARAM value = "#arguments.area_id#" CFSQLType = "CF_SQL_integer">;
						</cfquery>
					</cfif>
					<cfif isDefined("arguments.description")>
						<cfquery name="descriptionQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET description = <cfqueryPARAM value = "#arguments.description#" CFSQLType="cf_sql_longvarchar">
							WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
						</cfquery>
					</cfif>
					<!---
					<cfif isDefined("arguments.parent_id") AND arguments.parent_id NEQ "">
						<cfquery name="parentIdQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET parent_id = <cfqueryPARAM value = "#arguments.parent_id#" CFSQLType = "CF_SQL_integer">
							WHERE id = <cfqueryPARAM value = "#arguments.area_id#" CFSQLType = "CF_SQL_integer">;
						</cfquery>
					</cfif>
					--->
					<cfif isDefined("arguments.with_link") AND arguments.with_link NEQ "">
						<cfif arguments.with_link EQ "false">
							<cfquery name="withLinkQuery" datasource="#client_dsn#">
								UPDATE #client_abb#_areas SET link = <cfqueryPARAM null="yes" cfsqltype="cf_sql_varchar">
								WHERE id = <cfqueryPARAM value="#arguments.area_id#" CFSQLType="CF_SQL_integer">;
							</cfquery>
						<cfelse>
							<cfquery name="withLinkQuery" datasource="#client_dsn#">
								UPDATE #client_abb#_areas SET link = <cfqueryPARAM value="" cfsqltype="cf_sql_varchar">
								WHERE id = <cfqueryPARAM value="#arguments.area_id#" CFSQLType="CF_SQL_integer">;
							</cfquery>
						</cfif>
					</cfif>
					<cfif isDefined("arguments.link") AND arguments.link NEQ "">
						<cfquery name="parentIdQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET link = <cfqueryPARAM value="#arguments.link#" cfsqltype="cf_sql_varchar">
							WHERE id = <cfqueryPARAM value="#arguments.area_id#" CFSQLType="CF_SQL_integer">;
						</cfquery>
					</cfif>

					<cfif isDefined("arguments.hide_in_menu") AND arguments.hide_in_menu NEQ "" AND NOT isDefined("arguments.link")><!--- Si arguments.link está definido es porque se accede desde la página de modificar la imagen del área que no pasa este parámetro --->
						<cfquery name="hideMenuQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET hide_in_menu = <cfqueryparam value="#arguments.hide_in_menu#" cfsqltype="cf_sql_boolean">
							WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
						</cfquery>
					</cfif>

					<cfif isDefined("arguments.menu_type_id") AND arguments.menu_type_id NEQ "">
						<cfquery name="menuTypeIdQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET menu_type_id = <cfqueryPARAM value = "#arguments.menu_type_id#" cfsqltype = "CF_SQL_integer">
							WHERE id = <cfqueryPARAM value = "#arguments.area_id#" CFSQLType = "CF_SQL_integer">;
						</cfquery>
					</cfif>


					<cfif isDefined("arguments.url_id")>
						<cfquery name="urlIdQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET url_id = <cfqueryparam value="#arguments.url_id#" cfsqltype="cf_sql_varchar">
							WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype = "cf_sql_integer">;
						</cfquery>
					</cfif>

					<!--- +++++++++++++++++++++++++++++++++++USER IN CHARGE+++++++++++++++++++++++++++++++++++++ --->
					<cfif isDefined("arguments.user_in_charge") AND arguments.user_in_charge NEQ "">
						<cfquery name="userInChargeQuery" datasource="#client_dsn#">
							UPDATE #client_abb#_areas SET user_in_charge = <cfqueryPARAM value = "#arguments.user_in_charge#" cfsqltype="cf_sql_integer">
							WHERE id = <cfqueryPARAM value = "#arguments.area_id#" CFSQLType = "CF_SQL_integer">;
						</cfquery>

						<cfquery name="checkIsMember" datasource="#client_dsn#">
							SELECT user_id
							FROM #client_abb#_areas_users
							WHERE user_id = <cfqueryPARAM value = "#arguments.user_in_charge#" CFSQLType="cf_sql_integer">
								AND area_id = <cfqueryPARAM value = "#arguments.area_id#" CFSQLType = "CF_SQL_integer">;
						</cfquery>

						<cfif #checkIsMember.recordCount# LT 1>
							<!---<cfquery name="insertMember" datasource="#client_dsn#">
								INSERT
								INTO #client_abb#_areas_users (area_id, user_id, association_date)
								VALUES(<cfqueryPARAM value="#arguments.area_id#" CFSQLType="CF_SQL_integer">,
										<cfqueryPARAM value="#arguments.user_in_charge#" CFSQLType="cf_sql_integer">,
										NOW());
							</cfquery>--->

							<cfinvoke component="#APPLICATION.coreComponentsPath#/UserQuery" method="assignUserToArea">
								<cfinvokeargument name="area_id" value="#arguments.area_id#"/>
								<cfinvokeargument name="user_id" value="#arguments.user_in_charge#"/>

								<cfinvokeargument name="client_abb" value="#client_abb#">
								<cfinvokeargument name="client_dsn" value="#client_dsn#">
							</cfinvoke>

						</cfif>
					</cfif>

					<cfif NOT isDefined("arguments.link")><!--- Si arguments.link está definido es porque se accede desde la página de modificar la imagen del área que no pasa estos parámetros --->

						<cfinvoke component="AreaManager" method="setAreaEnabledItems" argumentcollection="#arguments#">
							<cfinvokeargument name="client_abb" value="#client_abb#"/>
							<cfinvokeargument name="client_dsn" value="#client_dsn#"/>
						</cfinvoke>

					</cfif>

					<!---<cfquery name="commitQuery" datasource="#client_dsn#">
						COMMIT;
					</cfquery>--->
					</cftransaction>

				<cfcatch>

					<!---<cfquery name="rollBackQuery" datasource="#client_dsn#">
						ROLLBACK;
					</cfquery>--->

					<cfinclude template="includes/errorHandlerStruct.cfm">

					<cfset response = {result=false, message=#cfcatch.message#, area_id=#arguments.area_id#}>
					<cfreturn response>
				</cfcatch>

			</cftry>

			<!---<cfif isDefined("arguments.image_file") AND len(arguments.image_file) GT 0>--->
			<cfif isDefined("arguments.files")>

				<cfset fileTypeId = 4>
				<cfinclude template="#APPLICATION.corePath#/includes/fileTypeSwitch.cfm">

				<cfquery name="getAreaFile" datasource="#client_dsn#">
					SELECT image_id
					FROM #client_abb#_areas
					WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

				<cfif getAreaFile.recordCount GT 0>

					<cfif NOT isNumeric(getAreaFile.image_id)><!---El area no tiene imagen--->

						<cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="createFile" returnvariable="createImageFileResponse">
							<cfinvokeargument name="file_name" value=" ">
							<cfinvokeargument name="file_type" value=" ">
							<cfinvokeargument name="file_size" value="0">
							<!---<cfinvokeargument name="description" value="">--->
							<cfinvokeargument name="fileTypeId" value="#fileTypeId#"><!---areas_images--->
						</cfinvoke>

						<cfif createImageFileResponse.result IS true>

							<cfset image_id = createImageFileResponse.objectFile.id>
							<cfset image_physical_name = createImageFileResponse.objectFile.physical_name>

						<cfelse>

							<cfset response_message = "Error al crear la imagen.">

							<cfset response = {result=false, message=#response_message#}>
							<cfreturn response>

						</cfif>


					<cfelse><!---El área ya tiene una imagen: se va a reemplazar--->

						<cfset image_id = getAreaFile.image_id>

						<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getFile" returnvariable="objectFile">
							<cfinvokeargument name="file_id" value="#image_id#">
							<cfinvokeargument name="fileTypeId" value="#fileTypeId#">

							<cfinvokeargument name="client_abb" value="#client_abb#"/>
							<cfinvokeargument name="client_dsn" value="#client_dsn#"/>
						</cfinvoke>

						<cfset image_physical_name = objectFile.physical_name>

						<!---<cfquery name="updateStateUploadingFile" datasource="#client_dsn#">
							UPDATE #client_abb#_#fileTypeTable#
							SET status_replacement = 'pending'
							WHERE id = <cfqueryparam value="#objectFile.id#" cfsqltype="cf_sql_integer">;
						</cfquery>--->

					</cfif>


				<cfelse><!---The area does not exist--->

					<cfset error_code = 301>

					<cfthrow errorcode="#error_code#">

				</cfif>


				<cftry>

					<!--- Upload Image File --->
					<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemFile" method="uploadItemFile">
						<cfinvokeargument name="type" value="area_image">
						<cfinvokeargument name="file_id" value="#image_id#">
						<cfinvokeargument name="file_physical_name" value="#image_physical_name#">
						<cfinvokeargument name="files" value="#arguments.files#">
						<cfinvokeargument name="area_id" value="#arguments.area_id#">
						<cfinvokeargument name="user_id" value="#user_id#">
						<cfinvokeargument name="client_abb" value="#client_abb#">
					</cfinvoke>

					<cfcatch>

						<cfinclude template="includes/errorHandlerStruct.cfm">

						<cfreturn response>

						<!---<cfset response = {result=false, message=#cfcatch.Message#}>
						<cfreturn response>--->

					</cfcatch>

				</cftry>

			</cfif>

			<!--- updateRootAreaVersionTree --->
			<cfinclude template="includes/updateRootAreaVersionTree.cfm">

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, area_id=#arguments.area_id#}><!---areaXml=#areaXml#--->

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>


	</cffunction>

	<!--- _____________________________________________________________________________  --->




	<!--- -------------------------------- moveArea ----------------------------------  --->

	<cffunction name="moveArea" returntype="struct" output="false" access="public">
		<cfargument name="area_id" type="string" required="true"/>
		<cfargument name="parent_id" type="numeric" required="true"/>

		<cfset var method = "moveArea">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="includes/checkAreaAdminAccess.cfm">

			<cfquery name="parentIdQuery" datasource="#client_dsn#">
				UPDATE #client_abb#_areas
				SET parent_id = <cfqueryparam value="#arguments.parent_id#" cfsqltype="cf_sql_integer">
				WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<!--- updateRootAreaVersionTree --->
			<cfinclude template="includes/updateRootAreaVersionTree.cfm">

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, area_id=#arguments.area_id#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>

	<!--- _____________________________________________________________________________  --->




	<!--- ------------------------------------- importAreas ------------------------------------- --->

	<cffunction name="importAreas" output="false" access="public" returntype="struct">
		<cfargument name="parent_id" type="numeric" required="true"/>
		<cfargument name="user_in_charge" type="numeric" required="true"/>
		<cfargument name="import_type" type="string" required="true"/>
		<cfargument name="hide_in_menu" type="boolean" required="false" default="false"/>
		<cfargument name="menu_type_id" type="numeric" required="false"/>
		<cfargument name="files" type="array" required="true"/>
		<cfargument name="delimiter" type="string" required="false">
		<cfargument name="start_row" type="numeric" required="false" default="2">

		<cfset var method = "importAreas">

		<cfset var response = structNew()>

		<cfset var filesData = arrayNew(1)>
		<cfset var fileData = "">
		<cfset var destination = "">
		<cfset var fileContent = "">
		<cfset var fileArray = arrayNew(1)>
		<cfset var areasCount = 0>
		<cfset var curArea = "">
		<cfset var createdAreaId = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!--- checkAreaAdminAccess --->
			<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreaAdminAccess">
				<cfinvokeargument name="area_id" value="#arguments.parent_id#">
			</cfinvoke>


			<cfset destination = GetTempDirectory()>

			<cfif arguments.import_type EQ "xml"><!--- XML file --->

				<cffile action="upload" fileField="files[]" destination="#destination#" nameConflict="makeunique"  result="fileResult" charset="utf-8" accept="text/plain,text/xml,application/xml">

			<cfelse>

		   		<cffile action="upload" fileField="files[]" destination="#destination#" nameConflict="makeunique"  result="fileResult" charset="iso-8859-1" accept="text/plain,text/csv,text/comma-separated-values,text/tab-separated-values,application/csv,application/vnd.ms-excel"><!--- application/vnd.ms-excel es necesario para IE --->

			</cfif>

			<cfset destinationFile = destination&fileResult.serverFile>

			<!--- MODULE ANTI VIRUS --->
			<cfif APPLICATION.moduleAntiVirus IS true>

				<cfinvoke component="#APPLICATION.coreComponentsPath#/AntiVirusManager" method="checkForVirus" returnvariable="checkForVirusResponse">
					<cfinvokeargument name="path" value="#destination#">
					<cfinvokeargument name="filename" value="#fileResult.serverFile#">
				</cfinvoke>

				<cfif checkForVirusResponse.result IS false><!--- Delete infected file --->

					<!--- delete image --->
					<cffile action="delete" file="#destinationFile#">

					<!---saveVirusLog--->
					<cfinvoke component="#APPLICATION.coreComponentsPath#/AntiVirusManager" method="saveVirusLog">
						<cfinvokeargument name="user_id" value="#user_id#">
						<cfinvokeargument name="file_name" value="#fileResult.clientFile#"/>
						<cfinvokeargument name="anti_virus_result" value="#checkForVirusResponse.message#">

						<cfinvokeargument name="client_abb" value="#client_abb#"/>
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

					<cfset anti_virus_check_message = trim(listlast(checkForVirusResponse.message, ":"))>

					<cfthrow type="virus" message="Archivo #fileResult.clientFile# no válido por ser identificado como virus: #anti_virus_check_message#">

				</cfif>

			</cfif>

			<cfset fileData = {
				    "name": fileResult.serverfile,
				    "size": fileResult.filesize,
				    "url": "",
				    "thumbnailUrl": "",
				    "deleteUrl": "",
				    "deleteType": "DELETE"
				  }>

			<cfset arrayAppend(filesData, fileData)>

			<cfif arguments.import_type EQ "xml"><!--- XML file --->
				<cffile action="read" file="#destinationFile#" variable="fileContent" charset="utf-8">
			<cfelse>
				<cffile action="read" file="#destinationFile#" variable="fileContent" charset="iso-8859-1">
			</cfif>

			<cffile action="delete" file="#destinationFile#">

			<cfif arguments.import_type EQ "xml"><!--- XML --->

				<cfset areasXml = xmlParse(fileContent)>

				<cfif isDefined("areasXml.area")>

					<cftransaction>
						<cfloop index="curArea" array="#areasXml.area#">

							<cfset areaName = curArea.name.xmlText>
							<cfset areaDescription = curArea.description.xmlText>

							<cfinvoke component="AreaManager" method="createAreaInDatabase" returnvariable="createdAreaId">
								<cfinvokeargument name="parent_id" value="#arguments.parent_id#"/>
								<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#"/>
								<cfinvokeargument name="name" value="#areaName#"/>
								<cfinvokeargument name="description" value="#areaDescription#"/>
								<cfinvokeargument name="hide_in_menu" value="#arguments.hide_in_menu#"/>
								<cfinvokeargument name="menu_type_id" value="#arguments.menu_type_id#"/>
							</cfinvoke>

							<cfinvoke component="AreaManager" method="importAreasXml" returnvariable="subAreasCount">
								<cfinvokeargument name="areasXml" value="#curArea#">

								<cfinvokeargument name="parent_id" value="#createdAreaId#"/>
								<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#"/>
								<cfinvokeargument name="hide_in_menu" value="#arguments.hide_in_menu#"/>
								<cfinvokeargument name="menu_type_id" value="#arguments.menu_type_id#"/>

								<cfinvokeargument name="client_dsn" value="#client_dsn#">
								<cfinvokeargument name="client_abb" value="#client_abb#">
							</cfinvoke>

							<cfset areasCount = areasCount+1+subAreasCount>

						</cfloop>
					</cftransaction>

				<cfelse>

					<cfset response = {result=false, files=fileData, message="Archivo vacío o con formato incorrecto"}>
					<cfreturn response>

				</cfif>


			<cfelse><!--- CSV --->


				<!--- CSV to array --->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/Utils" method="CSVToArray" returnvariable="fileArray">
					<cfinvokeargument name="CSV" value="#trim(#fileContent#)#">
					<cfif arguments.delimiter EQ "tab">
						<cfinvokeargument name="delimiter" value="#chr(9)#">
					<cfelse>
						<cfinvokeargument name="delimiter" value="#arguments.delimiter#">
					</cfif>
				</cfinvoke>

				<cfset numFileColumns = arrayLen(fileArray[1])>
				<cfset numFileRows = arrayLen(fileArray)>

				<!---<cfif numFileColumns IS 0 OR numFileRows IS 0> Esto hace nada usar porque nunca es 0
					<cfset response = {result=false, files=fileData, message="No hay contenidos en el archivo"}>
					<cfreturn response>
				</cfif>--->

				<cftransaction>

					<cfloop from="#arguments.start_row#" to="#numFileRows#" step="1" index="curRowIndex"><!--- loop Rows --->

						<!--- <cfset error = false> --->

						<cftry>

							<cfset curRow = fileArray[curRowIndex]>

							<cfset areaName = curRow[1]>

							<cfif len(areaName) GT 0>

								<cfif arrayLen(curRow) GT 1>
									<cfset areaDescription = curRow[2]>
								<cfelse>
									<cfset areaDescription = "">
								</cfif>

								<cfinvoke component="AreaManager" method="createAreaInDatabase" returnvariable="area_id">
									<cfinvokeargument name="parent_id" value="#arguments.parent_id#"/>
									<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#"/>
									<cfinvokeargument name="name" value="#areaName#"/>
									<cfinvokeargument name="description" value="#areaDescription#"/>
									<cfinvokeargument name="hide_in_menu" value="#arguments.hide_in_menu#"/>
									<cfinvokeargument name="menu_type_id" value="#arguments.menu_type_id#"/>
								</cfinvoke>

								<cfset areasCount = areasCount+1>

							</cfif>

							<cfcatch>

								<cfset errorMessagePrefix = "Error en fila #curRowIndex#: ">
								<cfset errorMessage = errorMessagePrefix&cfcatch.message>

								<cfthrow message="#errorMessage#">

							</cfcatch>

						</cftry>

					</cfloop>

				</cftransaction>

			</cfif><!--- END arguments.import_type EQ "xml" --->

			<!--- updateRootAreaVersionTree --->
			<cfinclude template="includes/updateRootAreaVersionTree.cfm">

			<cfinclude template="includes/logRecord.cfm">

			<cfif areasCount IS 0>
				<cfset response = {result=false, files=fileData, areasCount=areasCount, message="No se ha importado ningún área"}>
			<cfelse>
				<cfset response = {result=true, files=fileData, areasCount=areasCount, message="",}>
			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

				<cfset response = {result=false, files=fileData, areasCount=areasCount, message=cfcatch.message}>

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>

	<!---  --->


	<!--- ------------------------------------- importSubAreas ------------------------------------- --->

	<cffunction name="importAreasXml" output="false" access="package" returntype="numeric">
		<cfargument name="areasXml" type="xml" required="true"/>
		<cfargument name="parent_id" type="numeric" required="true"/>
		<cfargument name="user_in_charge" type="numeric" required="true"/>
		<cfargument name="hide_in_menu" type="boolean" required="false" default="false"/>
		<cfargument name="menu_type_id" type="numeric" required="false"/>

		<cfargument name="client_dsn" type="string" required="true"/>
		<cfargument name="client_abb" type="string" required="true"/>

		<cfset var areasCount = 0>
		<cfset var curArea = "">
		<cfset var createdAreaId = "">

		<cfif isDefined("areasXml.area")>

			<cfloop index="curArea" array="#areasXml.area#">

				<cfset areaName = curArea.name.xmlText>
				<cfset areaDescription = curArea.description.xmlText>

				<cfinvoke component="AreaManager" method="createAreaInDatabase" returnvariable="createdAreaId">
					<cfinvokeargument name="parent_id" value="#arguments.parent_id#"/>
					<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#"/>
					<cfinvokeargument name="name" value="#areaName#"/>
					<cfinvokeargument name="description" value="#areaDescription#"/>
					<cfinvokeargument name="hide_in_menu" value="#arguments.hide_in_menu#"/>
					<cfinvokeargument name="menu_type_id" value="#arguments.menu_type_id#"/>
				</cfinvoke>

				<cfinvoke component="AreaManager" method="importAreasXml" returnvariable="subAreasCount">
					<cfinvokeargument name="areasXml" value="#curArea#">

					<cfinvokeargument name="parent_id" value="#createdAreaId#"/>
					<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#"/>
					<cfinvokeargument name="hide_in_menu" value="#arguments.hide_in_menu#"/>
					<cfinvokeargument name="menu_type_id" value="#arguments.menu_type_id#"/>

					<cfinvokeargument name="client_dsn" value="#arguments.client_dsn#">
					<cfinvokeargument name="client_abb" value="#arguments.client_abb#">
				</cfinvoke>

				<cfset areasCount = areasCount+1+subAreasCount>

			</cfloop>

			<!--- updateRootAreaVersionTree --->
			<cfinclude template="includes/updateRootAreaVersionTree.cfm">

		</cfif>

		<cfreturn areasCount>

	</cffunction>


	<!--- ------------------------------------- exportAreasStructure ------------------------------------- --->

	<cffunction name="exportAreasStructure" output="false" access="public" returntype="struct">
		<cfargument name="area_id" type="numeric" required="true"/>

		<cfset var method = "importAreas">

		<cfset var response = structNew()>

		<cfset var fileContent = '<?xml version="1.0" encoding="UTF-8"?>'>
		<cfset var areaXmlContent = "">
		<cfset var subAreasXmlContent = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!--- checkAreaAdminAccess --->
			<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreaAdminAccess">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfquery name="getAreaQuery" datasource="#client_dsn#">
				SELECT areas.id, areas.name, areas.parent_id, areas.description
				FROM `#client_abb#_areas` AS areas
				WHERE areas.id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif getAreaQuery.recordCount GT 0>

				<cfinvoke component="AreaManager" method="exportSubAreasStructure" returnvariable="subAreasXmlContent">
					<cfinvokeargument name="parent_id" value="#arguments.area_id#">

					<cfinvokeargument name="client_dsn" value="#client_dsn#">
					<cfinvokeargument name="client_abb" value="#client_abb#">
				</cfinvoke>

				<cfset areaXmlContent = areaXmlContent&"<area><name><![CDATA[#getAreaQuery.name#]]></name>
<description><![CDATA[#getAreaQuery.description#]]></description>"&subAreasXmlContent&"</area>">

			</cfif>

			<cfset fileContent = fileContent&areaXmlContent>

			<cfinclude template="includes/logRecord.cfm">

			<cfset response = {result=true, fileContent=fileContent}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

				<cfset response = {result=false, fileContent=fileContent, message=cfcatch.message}>

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- ------------------------------------- exportSubAreasStructure ------------------------------------- --->

	<cffunction name="exportSubAreasStructure" output="false" access="package" returntype="string">
		<cfargument name="parent_id" type="numeric" required="true"/>

		<cfargument name="client_dsn" type="string" required="true"/>
		<cfargument name="client_abb" type="string" required="true"/>

		<cfset var areaXmlContent = "">
		<cfset var subAreasXmlContent = "">

		<cfquery name="getSubAreasQuery" datasource="#client_dsn#">
			SELECT areas.id, areas.name, areas.parent_id, areas.description
			FROM `#client_abb#_areas` AS areas
			WHERE areas.parent_id = <cfqueryparam value="#arguments.parent_id#" cfsqltype="cf_sql_integer">;
		</cfquery>

		<cfif getSubAreasQuery.recordCount GT 0>

			<cfloop query="#getSubAreasQuery#">

				<cfinvoke component="AreaManager" method="exportSubAreasStructure" returnvariable="subAreasXmlContent">
					<cfinvokeargument name="parent_id" value="#getSubAreasQuery.id#">

					<cfinvokeargument name="client_dsn" value="#arguments.client_dsn#">
					<cfinvokeargument name="client_abb" value="#arguments.client_abb#">
				</cfinvoke>

				<cfset areaXmlContent = areaXmlContent&"<area><name><![CDATA[#getSubAreasQuery.name#]]></name>
<description><![CDATA[#getSubAreasQuery.description#]]></description>"&subAreasXmlContent&"</area>">

			</cfloop>

		</cfif>

		<cfreturn areaXmlContent>


	</cffunction>




	<!--- ------------------------------------- selectArea -------------------------------------  --->

	<cffunction name="selectArea" output="false" access="public" returntype="string">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "selectArea">

		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">

		<cfset var xmlRequest = "">
		<cfset var xmlResponseContent = "">


		<cftry>

			<cfinclude template="includes/functionStart.cfm">

			<cfset select_area_id = xmlRequest.request.parameters.area.xmlAttributes.id>

			<cfinvoke component="AreaManager" method="getArea" returnvariable="xmlResponseContent">
				<cfinvokeargument name="get_area_id" value="#select_area_id#">
				<cfinvokeargument name="format_content" value="default">
			</cfinvoke>

			<cfinclude template="includes/functionEndNoLog.cfm">

			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>


		</cftry>

		<cfreturn xmlResponse>

	</cffunction>

	<!---  --->


	<!--- ------------------------------------- selectAreaAdmin -------------------------------------  --->

	<cffunction name="selectAreaAdmin" output="false" access="public" returntype="string">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "selectAreaAdmin">

		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">

		<cfset var xmlRequest = "">
		<cfset var xmlResponseContent = "">


		<cftry>

			<cfinclude template="includes/functionStart.cfm">

			<cfset select_area_id = xmlRequest.request.parameters.area.xmlAttributes.id>

			<cfinvoke component="AreaManager" method="getArea" returnvariable="xmlResponseContent">
				<cfinvokeargument name="get_area_id" value="#select_area_id#">
				<cfinvokeargument name="format_content" value="all">
			</cfinvoke>

			<cfinclude template="includes/functionEndNoLog.cfm">

			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>


		</cftry>

		<cfreturn xmlResponse>

	</cffunction>

	<!---   --->


	<!--- ------------------------------------- getArea ------------------------------------ --->

	<cffunction name="getArea" returntype="any" access="public">
		<cfargument name="get_area_id" type="numeric" required="yes">
		<cfargument name="format_content" type="string" required="no" default="default">
    <cfargument name="return_type" type="string" required="no" default="xml"><!---xml/object/query--->

		<cfset var method = "getArea">

		<cfset var user_id = "">
		<cfset var client_abb = "">
		<cfset var user_language = "">
		<cfset var internal_user = "">
		<cfset var access_result = "">

		<cfset var xmlResponseContent = "">
		<cfset var response = "">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="UserManager" method="isInternalUser" returnvariable="internal_user">
				<cfinvokeargument name="get_user_id" value="#SESSION.user_id#">
			</cfinvoke>
			<cfif internal_user IS false>

				<!--- checkAreaAccess --->
				<!---<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreaAccess">
					<cfinvokeargument name="area_id" value="#arguments.get_area_id#">
				</cfinvoke>---->

				<!--- checkAreaAccess --->
				<cfinvoke component="AreaManager" method="canUserAccessToArea" returnvariable="access_result">
					<cfinvokeargument name="area_id" value="#arguments.get_area_id#">
				</cfinvoke>

				<cfif access_result IS NOT true>

					<!--- checkAreaAdminAccess --->
					<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreaAdminAccess">
						<cfinvokeargument name="area_id" value="#arguments.get_area_id#">
					</cfinvoke>

				</cfif>

			</cfif>
			<!---Un usuario interno aunque no tenga permisos de área puede acceder a ver su nombre y descripción--->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getArea" returnvariable="selectAreaQuery">
				<cfinvokeargument name="area_id" value="#arguments.get_area_id#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfif selectAreaQuery.recordCount GT 0>

				<cfif arguments.return_type EQ "query">

        	<cfset response = selectAreaQuery>

        <cfelse>

					<cfinvoke component="AreaManager" method="objectArea" returnvariable="area">
						<cfinvokeargument name="id" value="#selectAreaQuery.id#">
						<cfinvokeargument name="name" value="#selectAreaQuery.name#">
						<cfinvokeargument name="creation_date" value="#selectAreaQuery.creation_date#">
						<cfinvokeargument name="parent_id" value="#selectAreaQuery.parent_id#">
						<cfinvokeargument name="user_in_charge" value="#selectAreaQuery.user_in_charge#">
						<cfinvokeargument name="description" value="#selectAreaQuery.description#">
						<cfinvokeargument name="user_full_name" value="#selectAreaQuery.user_full_name#">
						<cfinvokeargument name="image_id" value="#selectAreaQuery.image_id#">
						<cfif arguments.format_content EQ "all">
							<cfinvokeargument name="link" value="#selectAreaQuery.link#">
						</cfif>
						<cfinvokeargument name="type" value="#selectAreaQuery.type#">
						<cfinvokeargument name="default_typology_id" value="#selectAreaQuery.default_typology_id#">
						<cfinvokeargument name="hide_in_menu" value="#selectAreaQuery.hide_in_menu#">
						<cfinvokeargument name="menu_type_id" value="#selectAreaQuery.menu_type_id#">
					</cfinvoke>

          <cfif arguments.return_type EQ "object">

              <cfset response = area>

          <cfelse>

          	<cfinvoke component="AreaManager" method="xmlArea" returnvariable="xmlResponseContent">
                  <cfinvokeargument name="objectArea" value="#area#">
              </cfinvoke>

              <cfset response = xmlResponseContent>

          </cfif>

				</cfif>

			<cfelse><!---The area does not exist--->

				<cfset error_code = 401>

				<cfthrow errorcode="#error_code#">

			</cfif>

		<cfreturn response>

	</cffunction>

	<!--- _____________________________________________________________________________  --->



	<!--- ________________________________DELETE AREA__________________________________  --->

	<cffunction name="deleteArea" output="false" access="public" returntype="struct">
		<cfargument name="area_id" type="numeric" required="true">

		<cfset var method = "deleteArea">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="includes/checkAreaAdminAccess.cfm">

			<!---getRootAreaId--->
			<cfinvoke component="AreaManager" method="getRootAreaId" returnvariable="root_area_id">
			</cfinvoke>

			<cfif arguments.area_id IS root_area_id><!---No se puede eliminar el área Raiz--->
				<cfset error_code = 103><!---Access denied--->

				<cfthrow errorcode="#error_code#">
			</cfif>

			<cfinvoke component="AreaManager" method="getArea" returnvariable="area">
				<cfinvokeargument name="get_area_id" value="#arguments.area_id#">
				<cfinvokeargument name="format_content" value="all">
				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>

			<cfif len(area.type) GT 0><!---No se pueden borrar las áreas raices especiales--->
				<cfset error_code = 103><!---Access denied--->

				<cfthrow errorcode="#error_code#">
			</cfif>

			<cfquery name="beginQuery" datasource="#client_dsn#">
				BEGIN;
			</cfquery>

			<!--- -----------------DELETE AREA MESSAGES------------------------- --->
			<cfinvoke component="AreaItemManager" method="deleteAreaItems">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="itemTypeId" value="1">
			</cfinvoke>


			<cfif APPLICATION.moduleWeb EQ true>

				<!--- -----------------DELETE AREA ENTRIES------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="2">
				</cfinvoke>

				<cfif APPLICATION.identifier EQ "vpnet">

					<!--- -----------------DELETE AREA LINKS------------------------- --->
					<cfinvoke component="AreaItemManager" method="deleteAreaItems">
						<cfinvokeargument name="area_id" value="#arguments.area_id#">
						<cfinvokeargument name="itemTypeId" value="3">
					</cfinvoke>

				</cfif>

				<!--- -----------------DELETE AREA NEWS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="4">
				</cfinvoke>

				<!--- -----------------DELETE AREA IMAGES------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="9">
				</cfinvoke>

			</cfif>


			<cfif APPLICATION.moduleWeb EQ true OR APPLICATION.identifier NEQ "vpnet">

				<!--- -----------------DELETE AREA EVENTS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="5">
				</cfinvoke>

			</cfif>

			<cfif APPLICATION.identifier NEQ "vpnet">

				<!--- -----------------DELETE AREA TASKS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="6">
				</cfinvoke>

			</cfif>

			<cfif APPLICATION.moduleConsultations IS true>

				<!--- -----------------DELETE AREA CONSULTATIONS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="7">
				</cfinvoke>

			</cfif>

			<cfif APPLICATION.modulePubMedComments IS true>

				<!--- -----------------DELETE AREA PUBMEDS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="8">
				</cfinvoke>

			</cfif>

			<cfif APPLICATION.moduleLists IS true>

				<!--- -----------------DELETE AREA LISTS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="11">
				</cfinvoke>

				<!--- -----------------DELETE AREA LISTS VIEWS------------------------- --->
				<cfinvoke component="ViewManager" method="deleteAreaViews">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="14">
				</cfinvoke>

				<!--- GENERAL LISTS ROWS ---->
				<cfif len(area.type) IS 0>

					<cfinvoke component="#APPLICATION.coreComponentsPath#/RowQuery" method="deleteAreaGeneralTablesRows">
						<cfinvokeargument name="tableTypeId" value="1">
						<cfinvokeargument name="area_id" value="#arguments.area_id#">
						<cfinvokeargument name="user_id" value="#SESSION.user_id#">

						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

				</cfif>

			</cfif>

			<cfif APPLICATION.moduleForms IS true>

				<!--- -----------------DELETE AREA FORMS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="12">
				</cfinvoke>

				<!--- -----------------DELETE AREA FORMS VIEWS------------------------- --->
				<cfinvoke component="ViewManager" method="deleteAreaViews">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="15">
				</cfinvoke>

				<!--- GENERAL FORMS ROWS ---->
				<cfif len(area.type) IS 0>

					<cfinvoke component="#APPLICATION.coreComponentsPath#/RowQuery" method="deleteAreaGeneralTablesRows">
						<cfinvokeargument name="tableTypeId" value="2">
						<cfinvokeargument name="area_id" value="#arguments.area_id#">
						<cfinvokeargument name="user_id" value="#SESSION.user_id#">

						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>

				</cfif>

			</cfif>

			<cfif APPLICATION.moduleMailing IS true>

				<!--- ----------------- DELETE AREA MAILINGS ------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="17">
				</cfinvoke>

			</cfif>

			<cfif APPLICATION.moduleDPDocuments IS true>

				<!--- -----------------DELETE AREA DPDOCUMENTS------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="20">
				</cfinvoke>

			</cfif>

			<!--- -------------------DELETE AREAS_FILES------------------------ --->

			<cfinvoke component="FileManager" method="deleteAreaFiles" returnvariable="deleteAreaFilesResult">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>
			<cfif deleteAreaFilesResult.result IS false>
				<cfthrow message="#deleteAreaFilesResult.message#">
			</cfif>


			<cfif APPLICATION.modulefilesWithTables IS true>

				<!--- -----------------DELETE AREA TYPOLOGIES------------------------- --->
				<cfinvoke component="AreaItemManager" method="deleteAreaItems">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
					<cfinvokeargument name="itemTypeId" value="13">
				</cfinvoke>

			</cfif>

			<!--- --------------------DELETE AREAS USERS---------------------  --->
			<cfquery name="membersQuery" datasource="#client_dsn#">
				DELETE
				FROM #client_abb#_areas_users
				WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<!--- --------------------DELETE AREA IMAGE---------------------  --->
			<cfif len(area.image_id) GT 0 AND isNumeric(area.image_id)>

				<!---Delete area image--->
				<cfinvoke component="AreaManager" method="deleteAreaImage" returnvariable="deleteAreaImageResponse">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfinvoke>

				<cfif deleteAreaImageResponse.result NEQ true>

					<cfset error_code = 605>

					<cfthrow errorcode="#error_code#">

				</cfif>

			</cfif>

			<!--- -----------------DELETE SUB AREAS-------------------------- --->
			<cfquery name="subAreasQuery" datasource="#client_dsn#">
				SELECT id
				FROM #client_abb#_areas
				WHERE parent_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			<cfif subAreasQuery.recordCount GT 0>
				<cfloop query="subAreasQuery">
					<cfinvoke component="AreaManager" method="deleteArea" returnvariable="deleteSubAreaResult">
						<cfinvokeargument name="area_id" value="#subAreasQuery.id#">
					</cfinvoke>
					<cfif deleteSubAreaResult.result IS false>
						<cfthrow message="#deleteSubAreaResult.message#">
					</cfif>
				</cfloop>
			</cfif>


			<cfquery name="deleteAreaQuery" datasource="#client_dsn#">
				DELETE
				FROM #client_abb#_areas
				WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfquery name="commitQuery" datasource="#client_dsn#">
				COMMIT;
			</cfquery>

			<!--- updateRootAreaVersionTree --->
			<cfinclude template="includes/updateRootAreaVersionTree.cfm">

			<cfinclude template="includes/functionEndOnlyLog.cfm">

			<cfset response = {result=true, message="", area_id=#arguments.area_id#}>

			<cfcatch>
				<!--- RollBack the transaction --->
				<cfquery name="rollBackTransaction" datasource="#client_dsn#">
					ROLLBACK;
				</cfquery>

				<cfinclude template="includes/errorHandlerStruct.cfm">
			</cfcatch>

		</cftry>

		<cfreturn response>

	</cffunction>
	<!--- _____________________________________________________________________________  --->



	<!--- ----------------GET AREA MESSAGES LIST---------------------------------------   --->
	<!---Esta función hay que quitarla de este componente ya que se debe usar directamente la de MessageManager, se mantiene aquí para mantener compatibilidad con la versión de cliente de Flex--->
	<cffunction name="getAreaMessagesList" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

			<cfinvoke component="MessageManager" method="getAreaMessagesList" returnvariable="xmlResponse">
				<cfinvokeargument name="request" value="#arguments.request#">
			</cfinvoke>

		<cfreturn xmlResponse>

	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->


	<!--- ----------------GET AREA MESSAGES TREE---------------------------------------   --->
	<!---Esta función hay que quitarla de este componente ya que se debe usar directamente la de MessageManager, se mantiene aquí para mantener compatibilidad con la versión de cliente de Flex--->
	<cffunction name="getAreaMessagesTree" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

			<cfinvoke component="MessageManager" method="getAreaMessagesTree" returnvariable="xmlResponse">
				<cfinvokeargument name="request" value="#arguments.request#">
			</cfinvoke>

		<cfreturn xmlResponse>

	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->





	<!---    --------------------GET AREA MEMBERS-------------------------------------  --->
	<!---Obtiene los usuarios asociados a un área.
	Hay un método en el UserManager (getAreaUsers) que hace practicamente lo mismo--->
	<cffunction name="getAreaMembers" output="false" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="true"/>
		<cfargument name="order_by" type="string" required="false"/>
		<cfargument name="order_type" type="string" required="false"/>

		<cfset var method = "getAreaMembers">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!---checkAreaAccess--->
			<cfinclude template="includes/checkAreaAccess.cfm">

			<!--- ORDER --->
			<cfinclude template="includes/usersOrderParameters.cfm">


			<cfinvoke component="AreaManager" method="getAreaUsers" returnvariable="usersXml">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="order_by" value="#order_by#">
				<cfinvokeargument name="order_type" value="#order_type#">
			</cfinvoke>


			<cfset response = {result=true, message="", usersXml=#usersXml#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>
	<!--- -----------------------------------------------------------------------  --->


	<!---    --------------------GET AREA MEMBERS ADMIN-------------------------------------  --->

	<cffunction name="getAreaMembersAdmin" output="false" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "getAreaMembersAdmin">

		<cfset var area_id = "">

		<cftry>

			<cfinclude template="includes/functionStart.cfm">

			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>

			<cfinvoke component="AreaManager" method="getAreaUsers" returnvariable="xmlResponseContent">
				<cfinvokeargument name="area_id" value="#area_id#">
			</cfinvoke>


			<cfinclude template="includes/functionEndNoLog.cfm">

			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>

		</cftry>

		<cfreturn xmlResponse>

	</cffunction>
	<!--- -----------------------------------------------------------------------  --->


	<!---    --------------------GET AREA USERS-------------------------------------  --->
	<!---Hay un método en el UserManager que hace practicamente lo mismo, pero este es más simple, y por lo tanto más rápido, y es el que se debe usar en determinados casos--->
	<cffunction name="getAreaUsers" output="false" returntype="string" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="order_by" type="string" required="no" default="name">
		<cfargument name="order_type" type="string" required="no" default="asc">

		<cfset var method = "getAreaUsers">

		<cfset var access_result = false>
		<cfset var user_in_charge = "">

			<cfinclude template="includes/functionStart.cfm">

			<!--- checkAreaAccess --->
			<cfinvoke component="AreaManager" method="canUserAccessToArea" returnvariable="access_result">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
			</cfinvoke>

			<cfif access_result IS NOT true>

				<!--- checkAreaAdminAccess --->
				<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="checkAreaAdminAccess">
					<cfinvokeargument name="area_id" value="#arguments.area_id#">
				</cfinvoke>

			</cfif>

			<!---<cfquery name="membersQuery" datasource="#client_dsn#">
				SELECT users.id, users.email, users.name, users.telephone, users.family_name, users.mobile_phone, users.telephone_ccode, users.mobile_phone_ccode, users.image_type
				FROM #client_abb#_users AS users
				INNER JOIN #client_abb#_areas_users AS areas_users ON users.id = areas_users.user_id
				WHERE areas_users.area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				ORDER BY #arguments.order_by# #arguments.order_type#;
			</cfquery>--->

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreaUsers" returnvariable="membersQuery">
				<cfinvokeargument name="area_id" value="#arguments.area_id#"/>
				<cfinvokeargument name="order_by" value="#arguments.order_by#">
				<cfinvokeargument name="order_type" value="#arguments.order_type#">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset xmlResult = '<users>'>

			<cfif membersQuery.recordCount GT 0>

				<cfquery name="getAreaUserInCharge" datasource="#client_dsn#">
					SELECT user_in_charge
					FROM #client_abb#_areas AS areas
					WHERE areas.id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">
				</cfquery>

				<cfif getAreaUserInCharge.recordCount IS 0><!---The area does not exist--->

					<cfset error_code = 401>

					<cfthrow errorcode="#error_code#">

				</cfif>

				<cfset user_in_charge = getAreaUserInCharge.user_in_charge>

				<cfquery name="getUserInCharge" dbtype="query">
					SELECT id, email, telephone, family_name, name, mobile_phone, telephone_ccode, mobile_phone_ccode, image_type
					FROM membersQuery
					WHERE id = #user_in_charge#;
				</cfquery>

				<cfif getUserInCharge.recordCount GT 0>

					<cfloop query="getUserInCharge">
						<cfinvoke component="UserManager" method="objectUser" returnvariable="xmlUser">
							<cfinvokeargument name="id" value="#getUserInCharge.id#">
							<cfinvokeargument name="email" value="#getUserInCharge.email#">
							<cfinvokeargument name="telephone" value="#getUserInCharge.telephone#">
							<cfinvokeargument name="family_name" value="#getUserInCharge.family_name#">
							<cfinvokeargument name="name" value="#getUserInCharge.name#">
							<cfinvokeargument name="mobile_phone" value="#getUserInCharge.mobile_phone#">
							<cfinvokeargument name="telephone_ccode" value="#getUserInCharge.telephone_ccode#">
							<cfinvokeargument name="mobile_phone_ccode" value="#getUserInCharge.mobile_phone_ccode#">
							<cfinvokeargument name="image_type" value="#getUserInCharge.image_type#">
							<cfinvokeargument name="user_in_charge" value="true">

							<cfinvokeargument name="return_type" value="xml">
						</cfinvoke>
						<cfset xmlResult = xmlResult&xmlUser>
					</cfloop>

				</cfif>

				<cfloop query="membersQuery">
					<cfif membersQuery.id NEQ user_in_charge>
						<cfinvoke component="UserManager" method="objectUser" returnvariable="xmlUser">
							<cfinvokeargument name="id" value="#membersQuery.id#">
							<cfinvokeargument name="email" value="#membersQuery.email#">
							<cfinvokeargument name="telephone" value="#membersQuery.telephone#">
							<cfinvokeargument name="family_name" value="#membersQuery.family_name#">
							<cfinvokeargument name="name" value="#membersQuery.name#">
							<cfinvokeargument name="mobile_phone" value="#membersQuery.mobile_phone#">
							<cfinvokeargument name="telephone_ccode" value="#membersQuery.telephone_ccode#">
							<cfinvokeargument name="mobile_phone_ccode" value="#membersQuery.mobile_phone_ccode#">
							<cfinvokeargument name="image_type" value="#membersQuery.image_type#">

							<cfinvokeargument name="return_type" value="xml">
						</cfinvoke>
						<cfset xmlResult = xmlResult&xmlUser>
					</cfif>
				</cfloop>

			</cfif>

			<cfset xmlResponse = xmlResult&'</users>'>


		<cfreturn xmlResponse>

	</cffunction>
	<!--- -----------------------------------------------------------------------  --->


	<!---  --------------------GET AREA FILES-------------------------------------  --->
	<cffunction name="getAreaFiles" output="false" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="true">

		<cfset var method = "getAreaFiles">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!--- checkAreaAccess --->
			<cfinclude template="includes/checkAreaAccess.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/FileQuery" method="getAreaFiles" returnvariable="getAreaFilesResult">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="parse_dates" value="true">

				<cfinvokeargument name="with_user" value="true"/>

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, files=#getAreaFilesResult.query#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>
	<!--- -----------------------------------------------------------------------  --->


	<!---    --------------------GET ALL AREAS ADMINISTRATORS-------------------------------------  --->

	<cffunction name="getAllAreasAdministrators" output="false" returntype="struct" access="public">

		<cfset var method = "getAllAreasAdministrators">

		<cfset var response = structNew()>

		<cfset var usersArray = arrayNew(1)>

		<cfset var allUserAreasAdminList = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<!--- checkAreaAdministratorAdminAccess --->
			<cfif SESSION.area_admin_administrator IS false><!---user logged in is not an administrator --->

				<cfset error_code = 106>

				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfif SESSION.client_administrator NEQ SESSION.user_id><!---Is not general administrator user--->

				<cfinvoke component="AreaManager" method="getAllUserAreasAdminList" returnvariable="allUserAreasAdminList">
					<cfinvokeargument name="get_user_id" value="#SESSION.user_id#">
				</cfinvoke>

			</cfif>

			<cfquery name="getAreasAdministrators" datasource="#client_dsn#">
				SELECT areas_administrators.user_id, areas_administrators.area_id, areas.name AS area_name, users.family_name, users.name AS user_name,
				users.email, users.image_type, users.enabled
				FROM #client_abb#_areas_administrators AS areas_administrators
				INNER JOIN #client_abb#_areas AS areas ON areas_administrators.area_id = areas.id
				<cfif SESSION.client_administrator NEQ SESSION.user_id>
					AND areas_administrators.area_id IN (<cfqueryparam value="#allUserAreasAdminList#" cfsqltype="cf_sql_integer" list="true">)
				</cfif>
				INNER JOIN #client_abb#_users AS users ON areas_administrators.user_id = users.id
				ORDER BY users.family_name;
			</cfquery>

			<cfloop query="getAreasAdministrators">

				<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="objectUser" returnvariable="user">
					<cfinvokeargument name="id" value="#getAreasAdministrators.user_id#">
					<cfinvokeargument name="email" value="#getAreasAdministrators.email#">
					<cfinvokeargument name="family_name" value="#getAreasAdministrators.family_name#">
					<cfinvokeargument name="name" value="#getAreasAdministrators.user_name#">
					<cfinvokeargument name="image_type" value="#getAreasAdministrators.image_type#">
					<cfinvokeargument name="area_id" value="#getAreasAdministrators.area_id#">

					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>

				<cfset user.enabled = getAreasAdministrators.enabled>
				<cfset user.area_name = getAreasAdministrators.area_name>

				<cfset arrayAppend(usersArray,user)>

			</cfloop>

			<cfset response = {result=true, usersArray=usersArray}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!---  -------------------getAreaLink----------------------   --->

	<cffunction name="getAreaLink" returntype="string" access="public">
		<cfargument name="area_id" required="yes" type="numeric">

		<cfset var method = "getAreaLink">

		<cfset var area_link = "">

			<cfinclude template="includes/functionStart.cfm">

			<cfquery name="getAreaLink" datasource="#client_dsn#">
				SELECT link, parent_id
				FROM #client_abb#_areas AS areas
				WHERE areas.id = #arguments.area_id#;
			</cfquery>

			<cfif getAreaLink.recordCount GT 0>

				<cfif len(getAreaLink.link) IS 0 OR getAreaLink.link EQ "NULL">
					<cfif len(getAreaLink.parent_id) IS NOT 0 AND getAreaLink.parent_id IS NOT "NULL" AND getAreaLink.parent_id GT 0>
						<cfinvoke component="AreaManager" method="getAreaLink" returnvariable="area_link">
							<cfinvokeargument name="area_id" value="#getAreaLink.parent_id#">
						</cfinvoke>
					<cfelse><!---Area link not found--->

						<cfset error_code = 407>

						<cfthrow errorcode="#error_code#">
					</cfif>
				<cfelse>
					<cfset area_link = getAreaLink.link>
				</cfif>

				<cfreturn area_link>

			<cfelse><!---Area does not exist--->

				<cfset error_code = 401>

				<cfthrow errorcode="#error_code#">

			</cfif>

	</cffunction>


	<!---  -------------------getAreaImageId----------------------   --->

	<cffunction name="getAreaImageId" returntype="numeric" access="public">
		<cfargument name="area_id" required="yes" type="numeric">

		<cfset var method = "getAreaImageId">

		<cfset var area_image_id = "">

			<cfinclude template="includes/functionStart.cfm">

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreaImageId" returnvariable="area_image_id">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfreturn area_image_id>

	</cffunction>


	<!--- ----------------------- selectAreaImage -------------------------------- --->

	<cffunction name="selectAreaImage" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">

		<cfset var method = "selectAreaImage">

		<cfset var area_id = "">
		<cfset var with_image = "">
		<cfset var link = "">
		<cfset var with_link = "">
		<cfset var xmlFile = "">

		<!---<cfinclude template="includes/initVars.cfm">--->

		<cftry>

			<cfinclude template="includes/functionStart.cfm">

			<cfset area_id = xmlRequest.request.parameters.area.xmlAttributes.id>

			<cfinclude template="includes/checkAreaAdminAccess.cfm">

			<cfquery name="selectAreaImageQuery" datasource="#client_dsn#">
				SELECT image_id, file_name, link
				FROM #client_abb#_areas AS areas
				INNER JOIN #client_abb#_areas_images AS images ON areas.image_id = images.id
				WHERE areas.id = <cfqueryparam value="#area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif selectAreaImageQuery.recordCount GT 0>
				<cfset with_image = true>
				<cfset xmlFile = '<file id="#selectAreaImageQuery.image_id#"><file_name><![CDATA[#selectAreaImageQuery.file_name#]]></file_name></file>' >
				<!---check if link exist--->
				<cfif len(selectAreaImageQuery.link) GT 0 AND selectAreaImageQuery.link NEQ "NULL">
					<cfset with_link = true>
				<cfelse>
					<cfset with_link = false>
				</cfif>
				<cfset link = selectAreaImageQuery.link>
			<cfelse>
				<cfset with_image = false>
				<cfset with_link = false>
				<cfset link = "">
			</cfif>

			<cfset xmlResponseContent = '<area id="#area_id#" with_image="#with_image#" with_link="#with_link#" link="#link#" />'&xmlFile>

			<cfinclude template="includes/functionEnd.cfm">

			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>

		</cftry>

		<cfreturn xmlResponse>

	</cffunction>


	<!--- -------------------------- deleteAreaImage -------------------------------- --->

	<cffunction name="deleteAreaImage" returntype="struct" output="false" access="public">
		<cfargument name="area_id" type="numeric" required="yes">

		<cfset var method = "deleteAreaImage">

		<cfset var response = structNew()>

		<cfset var image_id = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinclude template="includes/checkAreaAdminAccess.cfm">

			<cfquery name="beginQuery" datasource="#client_dsn#">
				BEGIN;
			</cfquery>

			<!--- Query to get the physical name and file_size of the file --->
			<cfquery name="selectAreaImageQuery" datasource="#client_dsn#">
				SELECT image_id, physical_name, file_size
				FROM #client_abb#_areas AS areas INNER JOIN #client_abb#_areas_images AS images ON areas.image_id = images.id
				WHERE areas.id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
			</cfquery>

			<cfif selectAreaImageQuery.recordCount GT 0>

				<cfset image_id = selectAreaImageQuery.image_id>

				<!--- Change association --->
				<cfquery name="deleteAssociationFolderQuery" datasource="#client_dsn#">
					UPDATE #client_abb#_areas
					SET image_id = <cfqueryparam null="yes" cfsqltype="cf_sql_numeric">
					WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

				<!--- Deletion of the row representing the file --->
				<cfquery name="deleteFileQuery" datasource="#client_dsn#">
					DELETE
					FROM #client_abb#_areas_images
					WHERE id = <cfqueryparam value="#image_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

				<cfset path = APPLICATION.filesPath&'/#client_abb#/areas_images/'>
				<cfset filePath = path & "#selectAreaImageQuery.physical_name#">

				<!--- Now we delete physically the file on the server --->
				<cfif FileExists(filePath)><!---If the physical file exist--->
					<cffile action="delete" file="#filePath#">
				<cfelse><!---The physical file does not exist--->
					<cfset error_code = 608>

					<cfthrow errorcode="#error_code#">
				</cfif>

				<!---Update User Space Used--->
				<cfquery name="updateAreaSpaceUsed" datasource="#client_dsn#">
					UPDATE #client_abb#_areas
					SET space_used = space_used-#selectAreaImageQuery.file_size#
					WHERE id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
				</cfquery>

				<!--- End of the transaction --->
				<cfquery name="endTransaction" datasource="#client_dsn#">
					COMMIT;
				</cfquery>

				<cfinclude template="includes/functionEndOnlyLog.cfm">

				<cfset response = {result=true, message="", file_id=#image_id#}>

			<cfelse><!---The area has no image--->

				<!--- RollBack the transaction --->
				<cfquery name="rollBackTransaction" datasource="#client_dsn#">
					ROLLBACK;
				</cfquery>

				<cfset error_code = 406>

				<cfthrow errorcode="#error_code#">

			</cfif>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


	<!--- -------------------------- GET MENU TYPE LIST -------------------------------- --->

	<cffunction name="getMenuTypeList" returntype="struct" access="public">

		<cfset var method = "getMenuTypeList">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">


			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getMenuTypeList" returnvariable="menuTypeList">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, menuTypeList=#menuTypeList#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>


	</cffunction>


	<!--- -------------------------- updateRootAreaVersionTree -------------------------------- --->

	<cffunction name="updateRootAreaVersionTree" returntype="void" access="private">

		<cfset var method = "updateRootAreaVersionTree">

		<cfset var rootAreaId = "">

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="AreaManager" method="getRootAreaId" returnvariable="rootAreaId">
			</cfinvoke>

			<cftransaction>

				<!--- deleteAreaCacheTree --->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/CacheQuery" method="deleteAreaCacheTree">
					<cfinvokeargument name="area_id" value="#rootAreaId#">
					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

				<!--- updateAreaVersionTree --->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="updateAreaVersionTree">
					<cfinvokeargument name="area_id" value="#rootAreaId#">
					<cfinvokeargument name="client_abb" value="#client_abb#">
					<cfinvokeargument name="client_dsn" value="#client_dsn#">
				</cfinvoke>

			</cftransaction>


	</cffunction>


	<!--- -------------------------- GET LAST USED AREAS -------------------------------- --->

	<cffunction name="getLastUsedAreas" returntype="struct" access="public">
		<cfargument name="limit" type="numeric" required="false">

		<cfset var method = "getLastUsedAreas">

		<cfset var response = structNew()>

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="AreaManager" method="getAllUserAreasList" returnvariable="userAreasIds">
				<cfinvokeargument name="get_user_id" value="#SESSION.user_id#">
			</cfinvoke>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="listAllAreaItems" returnvariable="getAreaItemsResult">
				<cfinvokeargument name="areas_ids" value="#userAreasIds#">
				<cfinvokeargument name="limit" value="#arguments.limit#">

				<cfinvokeargument name="published" value="false">

				<cfinvokeargument name="withConsultations" value="#APPLICATION.moduleConsultations#">
				<cfinvokeargument name="withPubmedsComments" value="#APPLICATION.modulePubMedComments#">
				<cfinvokeargument name="withLists" value="#APPLICATION.moduleLists#">
				<cfinvokeargument name="withForms" value="#APPLICATION.moduleForms#">
				<cfinvokeargument name="withDPDocuments" value="#APPLICATION.moduleDPDocuments#">
				<cfinvokeargument name="withMailings" value="#APPLICATION.moduleMailing#">

				<cfinvokeargument name="onlyAreas" value="true">

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfset response = {result=true, query=#getAreaItemsResult.query#}>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>


	</cffunction>


	<!--- ---------------------------- GET AREAS -------------------------------- --->

	<cffunction name="getAreas" returntype="struct" output="false" access="public">
		<cfargument name="search_text" type="string" required="true">
		<!---<cfargument name="order_by" type="string" required="false" default="name">
		<cfargument name="order_type" type="string" required="false" default="asc">--->
		<cfargument name="limit" type="numeric" required="true">

		<cfset var method = "getAreas">

		<cfset var response = structNew()>

		<cfset var internal_user = "">
		<cfset var allUserAreasList = "">

		<cftry>

			<cfinclude template="includes/functionStartOnlySession.cfm">

			<cfinvoke component="UserManager" method="isInternalUser" returnvariable="internal_user">
				<cfinvokeargument name="get_user_id" value="#user_id#">
			</cfinvoke>

			<cfif internal_user IS false>
				<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="getAllUserAreasList" returnvariable="allUserAreasList">
					<cfinvokeargument name="get_user_id" value="#user_id#">
				</cfinvoke>
			</cfif>

			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaQuery" method="getAreas" returnvariable="response">
				<cfinvokeargument name="search_text" value="#arguments.search_text#"/>
				<!---<cfif len(arguments.order_by) GT 0>
					<cfinvokeargument name="order_by" value="#arguments.order_by#"/>
					<cfinvokeargument name="order_type" value="#arguments.order_type#"/>
				</cfif>--->
				<cfif internal_user IS false>
					<cfinvokeargument name="areas_ids" value="#allUserAreasList#"/>
				</cfif>
				<cfinvokeargument name="limit" value="#arguments.limit#"/>

				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>

			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>

	</cffunction>


</cfcomponent>
