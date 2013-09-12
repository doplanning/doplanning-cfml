<!---Copyright Era7 Information Technologies 2007-2013

    File created by: alucena
    ColdFusion version required: 8
    Last file change by: alucena
    Date of last file change: 11-06-2013
	
	06-09-2012 alucena: añadido en objectItem parseo de fechas start_date y end_date
	26-09-2012 alucena: reemplazado "true" por true en comparaciones de booleanos
	28-09-2012 alucena: añadido iframe_url e iframe_display_type
	26-11-2012 alucena: añadido position a noticias
	27-11-2012 alucena: se puede modificar la fecha de creación de las noticias
	19-12-2012 alucena: comprueba APPLICATION.moduleWeb EQ "enabled" al definir iframe_display_type
	09-01-2013 alucena: añadido attached_image_id al contenido de los listados
	10-01-2013 alucena: los elementos web se pueden modificar por usuarios que no son los propietarios
	15-04-2013 alucena: añadido deleteUserItems
	11-06-2013 alucena: iframe_display_type_id se recibe y guarda aunque APPLICATION.moduleWeb sea falso
--->
<cfcomponent output="false">
	
	<cfset component = "AreaItemManager">
	
	<cfset messageTypeId = 1>
	<cfset entryTypeId = 2>
	<cfset linkTypeId = 3>
	<cfset newsTypeId = 4>
	<cfset eventTypeId = 5>
	<cfset taskTypeId = 6> 
	
	<!--- ----------------------- XML ITEM -------------------------------- --->
	
	<cffunction name="xmlItem" returntype="string" access="public">		
		<cfargument name="objectItem" type="struct" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfset var method = "xmlItem">
		
		<cfset var itemTypeName = "">
		
		<cftry>
		
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfprocessingdirective suppresswhitespace="true">
			<cfsavecontent variable="xmlResult">
				<cfoutput><#itemTypeName# 
					<cfif objectItem.tree_mode EQ "true">
						title="#xmlFormat(objectItem.title)#"
						<cfif objectItem.attached_file_name NEQ "NULL">
						attached_file_name="#xmlFormat(objectItem.attached_file_name)#"
						<cfelse>attached_file_name="-"</cfif>						
						user_full_name="#xmlFormat(objectItem.user_full_name)#"
					</cfif>
					<cfif len(objectItem.id) GT 0>
						id="#objectItem.id#"
					</cfif>
					<cfif len(objectItem.parent_id) GT 0>
						parent_id="#objectItem.parent_id#"
					</cfif>
					<cfif len(objectItem.parent_kind) GT 0>
						parent_kind="#objectItem.parent_kind#"
					</cfif>
					<cfif len(objectItem.area_id) GT 0>
						area_id="#objectItem.area_id#"
					</cfif>
					<cfif len(objectItem.area_name) GT 0>
						area_name="#xmlFormat(objectItem.area_name)#"
					</cfif>
					<cfif len(objectItem.user_in_charge) GT 0>
						user_in_charge="#objectItem.user_in_charge#"
					</cfif>
					<cfif len(objectItem.creation_date) GT 0>
						creation_date="#objectItem.creation_date#"
					</cfif>
					<cfif len(objectItem.attached_file_id) GT 0>
						attached_file_id="#objectItem.attached_file_id#"
					</cfif>
					<cfif len(objectItem.attached_image_id) GT 0>
						attached_image_id="#objectItem.attached_image_id#"
					</cfif>
					<cfif len(objectItem.attached_file_type) GT 0> 
						attached_file_type="#objectItem.attached_file_type#"
					</cfif>
					<!---<cfif len(objectItem.attached_image_type) GT 0> 
						attached_image_type="#objectItem.attached_image_type#"
					</cfif>--->
					<cfif len(objectItem.notify_by_sms) GT 0> 
						notify_by_sms="#objectItem.notify_by_sms#"
					</cfif>
					<cfif len(objectItem.post_to_twitter) GT 0> 
						post_to_twitter="#objectItem.post_to_twitter#"
					</cfif>
					<cfif len(objectItem.start_date) GT 0> 
						start_date="#objectItem.start_date#"
					</cfif>
					<cfif len(objectItem.end_date) GT 0> 
						end_date="#objectItem.end_date#"
					</cfif>
					<cfif len(objectItem.place) GT 0> 
						place="#objectItem.place#"
					</cfif>
					<cfif len(objectItem.recipient_user) GT 0>
						recipient_user="#objectItem.recipient_user#"
					</cfif>
					<cfif len(objectItem.done) GT 0>
						done="#objectItem.done#"
					</cfif>
					<cfif len(objectItem.estimated_value) GT 0>
						estimated_value="#objectItem.estimated_value#"
					</cfif>
					<cfif len(objectItem.real_value) GT 0>
						real_value="#objectItem.real_value#"
					</cfif>
					<cfif len(objectItem.start_time) GT 0>
						start_time="#objectItem.start_time#"
					</cfif>
					<cfif len(objectItem.end_time) GT 0>
						end_time="#objectItem.end_time#"
					</cfif>
					<cfif len(objectItem.last_update_date) GT 0>
						last_update_date="#objectItem.last_update_date#"
					</cfif>
					<cfif len(objectItem.position) GT 0>
						position="#objectItem.position#"
					</cfif>
					<cfif len(objectItem.display_type_id) GT 0>
						display_type_id="#objectItem.display_type_id#"
					</cfif>
					<cfif len(objectItem.iframe_display_type_id) GT 0>
						iframe_display_type_id="#objectItem.iframe_display_type_id#"
					</cfif>
					<cfif len(objectItem.user_image_type) GT 0>
						user_image_type="#objectItem.user_image_type#"
					</cfif>
					<cfif len(objectItem.state) GT 0>
						state="#objectItem.state#"
					</cfif>
					<cfif len(objectItem.identifier) GT 0>
						identifier="#objectItem.identifier#"
					</cfif>
					<cfif len(objectItem.link_target) GT 0>
						link_target="#objectItem.link_target#"
					</cfif>
					>
					<cfif objectItem.tree_mode NEQ "true">
						<cfif len(objectItem.attached_file_name) NEQ 0 AND objectItem.attached_file_name NEQ "NULL">
							<attached_file_name><![CDATA[#objectItem.attached_file_name#]]></attached_file_name>
						<cfelse>
							<attached_file_name><![CDATA[-]]></attached_file_name>
						</cfif>
						<cfif len(objectItem.attached_image_name) NEQ 0 AND objectItem.attached_image_name NEQ "NULL">
							<attached_image_name><![CDATA[#objectItem.attached_image_name#]]></attached_image_name>
						<cfelse>
							<attached_image_name><![CDATA[-]]></attached_image_name>
						</cfif>
						<cfif len(objectItem.title) NEQ 0>
							<title><![CDATA[#objectItem.title#]]></title>
						</cfif>
						<cfif len(objectItem.link) NEQ 0>
							<link><![CDATA[#objectItem.link#]]></link>
						</cfif>
						<cfif len(objectItem.description) NEQ 0>
							<description><![CDATA[#objectItem.description#]]></description>
						</cfif>
						<cfif len(objectItem.user_full_name) NEQ 0>
							<user_full_name><![CDATA[#objectItem.user_full_name#]]></user_full_name>
						</cfif>
						<cfif len(objectItem.iframe_url) NEQ 0>
							<iframe_url><![CDATA[#objectItem.iframe_url#]]></iframe_url>
						</cfif>
					</cfif>
					<cfif len(objectItem.recipient_user_full_name) NEQ 0>
						<recipient_user_full_name><![CDATA[#objectItem.recipient_user_full_name#]]></recipient_user_full_name>
					</cfif>
					
					
					<cfif len(objectItem.sub_items) NEQ 0>
						#objectItem.sub_items#
					</cfif>
				</#itemTypeName#></cfoutput>
			</cfsavecontent>
			</cfprocessingdirective>
	

			
			<cfreturn xmlResult>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>
		
	</cffunction>
	
	
	<!--- ----------------------- ITEM OBJECT -------------------------------- --->
	
	<cffunction name="objectItem" returntype="any" output="false" access="public">	
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfargument name="xml" type="string" required="no">
		
		<cfargument name="id" type="string" required="no" default="">
		<cfargument name="parent_id" type="string" required="no" default="">
		<cfargument name="parent_kind" type="string" required="no" default="">
		<cfargument name="area_id" type="string" required="no" default="">
		<cfargument name="user_in_charge" type="string" required="no" default="">
		<cfargument name="creation_date" type="string" required="no" default="">
		<cfargument name="attached_file_id" type="string" required="no" default="">
		<cfargument name="attached_image_id" type="string" required="no" default="">
		<cfargument name="area_name" type="string" required="no" default="">
		<cfargument name="attached_file_name" type="string" required="no" default="">
		<cfargument name="attached_image_name" type="string" required="no" default="">
		<cfargument name="title" type="string" required="no" default="">
		<cfargument name="link" type="string" required="no" default="">
		<cfargument name="description" type="string" required="no" default="">
		<cfargument name="user_full_name" type="string" required="no" default="">
		<cfargument name="sub_items" type="string" required="no" default="">
		<cfargument name="attached_file_type" type="string" required="no" default="">
		<cfargument name="notify_by_sms" type="string" required="no" default="">
		<cfargument name="post_to_twitter" type="string" required="no" default="">
		<cfargument name="start_date" type="string" required="no" default="">
		<cfargument name="end_date" type="string" required="no" default="">
		<cfargument name="place" type="string" required="no" default="">
		<cfargument name="recipient_user" type="string" required="no" default="">
		<cfargument name="recipient_user_full_name" type="string" required="no" default="">
		<cfargument name="done" type="string" required="no" default="">
		<cfargument name="estimated_value" type="string" required="no" default="">
		<cfargument name="real_value" type="string" required="no" default="">
		<cfargument name="start_time" type="string" required="no" default="">
		<cfargument name="end_time" type="string" required="no" default="">
		<cfargument name="last_update_date" type="string" required="no" default="">
		<cfargument name="position" type="string" required="no" default="">
		<cfargument name="display_type_id" type="string" required="no" default="">
		<cfargument name="iframe_url" type="string" required="no" default="">
		<cfargument name="iframe_display_type_id" type="string" required="no" default="">
		<cfargument name="user_image_type" type="string" required="no" default="">
		<cfargument name="state" type="string" required="no" default="">
		<cfargument name="identifier" type="string" required="no" default="">
		<cfargument name="link_target" type="string" required="no" default="">
		
		<cfargument name="tree_mode" type="boolean" required="no" default="false"><!---Con esto a true se pasan los elementos como atributos--->
		
		<cfargument name="return_type" type="string" required="no">
		
		<cfset var method = "objectItem"> 
		
		<cfset var itemTypeName = "">
		
		<cftry>
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfif isDefined("arguments.xml")>
			
				<cfxml variable="xmlItem">
				<cfoutput>
				#xml#
				</cfoutput>
				</cfxml>
			
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.id")>
					<cfset id=xmlItem.xmlChildren[1].XmlAttributes.id>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.parent_id")>
					<cfset parent_id=xmlItem.xmlChildren[1].XmlAttributes.parent_id>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.XmlAttributes.parent_kind")>
					<cfset parent_kind=xmlItem.xmlChildren[1].XmlAttributes.parent_kind>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.XmlAttributes.area_id")>
					<cfset area_id=xmlItem.xmlChildren[1].XmlAttributes.area_id>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.XmlAttributes.user_in_charge")>
					<cfset user_in_charge=xmlItem.xmlChildren[1].XmlAttributes.user_in_charge>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.creation_date")>
					<cfset creation_date=xmlItem.xmlChildren[1].XmlAttributes.creation_date>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.XmlAttributes.attached_file_id")>
					<cfset attached_file_id="#xmlItem.xmlChildren[1].XmlAttributes.attached_file_id#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.XmlAttributes.attached_image_id")>
					<cfset attached_image_id="#xmlItem.xmlChildren[1].XmlAttributes.attached_image_id#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.XmlAttributes.area_name")>
					<cfset area_name="#xmlItem.xmlChildren[1].XmlAttributes.area_name#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.attached_file_name.xmlText")>
					<cfset attached_file_name="#xmlItem.xmlChildren[1].attached_file_name.xmlText#">
				<cfelseif isDefined("xmlItem.#itemTypeName#.xmlAttributes.attached_file_name")>
					<cfset attached_file_name=xmlItem.xmlChildren[1].xmlAttributes.attached_file_name>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.attached_image_name.xmlText")>
					<cfset attached_image_name="#xmlItem.xmlChildren[1].attached_image_name.xmlText#">
				<cfelseif isDefined("xmlItem.#itemTypeName#.xmlAttributes.attached_image_name")>
					<cfset attached_image_name=xmlItem.xmlChildren[1].xmlAttributes.attached_image_name>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.title")>
					<cfset title=xmlItem.xmlChildren[1].title.xmlText>
				<cfelseif isDefined("xmlItem.#itemTypeName#.XmlAttributes.title")>
					<cfset title = xmlItem.xmlChildren[1].XmlAttributes.title>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.link")>
					<cfset link=xmlItem.xmlChildren[1].link.xmlText>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.description")>
					<cfset description=xmlItem.xmlChildren[1].description.xmlText>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.user_full_name")>
					<cfset user_full_name=xmlItem.xmlChildren[1].user_full_name.xmlText>
				<cfelseif isDefined("xmlItem.#itemTypeName#.xmlAttributes.user_full_name")>
					<cfset user_full_name=xmlItem.xmlChildren[1].xmlAttributes.user_full_name>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.iframe_url")>
					<cfset iframe_url=xmlItem.xmlChildren[1].iframe_url.xmlText>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.recipient_user_full_name")>
					<cfset recipient_user_full_name=xmlItem.xmlChildren[1].recipient_user_full_name.xmlText>
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.attached_file_type")>
					<cfset attached_file_type="#xmlItem.xmlChildren[1].XmlAttributes.attached_file_type#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.notify_by_sms")>
					<cfset notify_by_sms="#xmlItem.xmlChildren[1].XmlAttributes.notify_by_sms#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.post_to_twitter")>
					<cfset post_to_twitter="#xmlItem.xmlChildren[1].XmlAttributes.post_to_twitter#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.start_date")>
					<cfset start_date="#xmlItem.xmlChildren[1].XmlAttributes.start_date#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.end_date")>
					<cfset end_date="#xmlItem.xmlChildren[1].XmlAttributes.end_date#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.place")>
					<cfset place="#xmlItem.xmlChildren[1].XmlAttributes.place#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.recipient_user")>
					<cfset recipient_user="#xmlItem.xmlChildren[1].XmlAttributes.recipient_user#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.done")>
					<cfset done="#xmlItem.xmlChildren[1].XmlAttributes.done#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.estimated_value")>
					<cfset estimated_value="#xmlItem.xmlChildren[1].XmlAttributes.estimated_value#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.real_value")>
					<cfset real_value="#xmlItem.xmlChildren[1].XmlAttributes.real_value#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.start_time")>
					<cfset start_time="#xmlItem.xmlChildren[1].XmlAttributes.start_time#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.end_time")>
					<cfset end_time="#xmlItem.xmlChildren[1].XmlAttributes.end_time#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.last_update_date")>
					<cfset last_update_date="#xmlItem.xmlChildren[1].XmlAttributes.last_update_date#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.position")>
					<cfset position="#xmlItem.xmlChildren[1].XmlAttributes.position#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.display_type_id")>
					<cfset display_type_id="#xmlItem.xmlChildren[1].XmlAttributes.display_type_id#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.iframe_display_type_id")>
					<cfset iframe_display_type_id="#xmlItem.xmlChildren[1].XmlAttributes.iframe_display_type_id#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.user_image_type")>
					<cfset user_image_type="#xmlItem.xmlChildren[1].XmlAttributes.user_image_type#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.state")>
					<cfset state="#xmlItem.xmlChildren[1].XmlAttributes.state#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.identifier")>
					<cfset identifier="#xmlItem.xmlChildren[1].XmlAttributes.identifier#">
				</cfif>
				<cfif isDefined("xmlItem.#itemTypeName#.xmlAttributes.link_target")>
					<cfset link_target="#xmlItem.xmlChildren[1].XmlAttributes.link_target#">
				</cfif>
				
			</cfif>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringDate">
				<cfinvokeargument name="timestamp_date" value="#creation_date#">
			</cfinvoke>
			<cfset creation_date = stringDate>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringUpdateDate">
				<cfinvokeargument name="timestamp_date" value="#last_update_date#">
			</cfinvoke>
			<cfset last_update_date = stringUpdateDate>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringStartDate">
				<cfinvokeargument name="timestamp_date" value="#start_date#">
				<cfinvokeargument name="with_time" value="false">
			</cfinvoke>
			<cfset start_date = stringStartDate>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringStartDate">
				<cfinvokeargument name="timestamp_date" value="#end_date#">
				<cfinvokeargument name="with_time" value="false">
			</cfinvoke>
			<cfset end_date = stringStartDate>
			
			<!---<cfif len(description) GT 0>
				<cfset description = Replace(description,'SIZE="','style="font-size:',"ALL")>
			</cfif>---> 
			
			<cfset object = {
				id="#id#",
				parent_id="#parent_id#",
				parent_kind="#parent_kind#",
				area_id="#area_id#",
				user_in_charge="#user_in_charge#",
				creation_date="#creation_date#",
				attached_file_id="#attached_file_id#",
				attached_image_id="#attached_image_id#",
				area_name="#area_name#",
				attached_file_name="#attached_file_name#",
				attached_image_name="#attached_image_name#",
				title="#title#",
				link="#link#",
				description="#description#",
				sub_items="#sub_items#",
				user_full_name="#user_full_name#",
				tree_mode="#tree_mode#",
				attached_file_type="#attached_file_type#",
				notify_by_sms="#notify_by_sms#",
				post_to_twitter="#post_to_twitter#",
				start_date="#start_date#",
				end_date="#end_date#",
				place="#place#",
				recipient_user="#recipient_user#",
				recipient_user_full_name="#recipient_user_full_name#",
				done="#done#",
				estimated_value="#estimated_value#",
				real_value="#real_value#",
				start_time="#start_time#",
				end_time="#end_time#",
				last_update_date="#last_update_date#",
				position="#position#",
				display_type_id="#display_type_id#",
				iframe_url="#iframe_url#",
				iframe_display_type_id="#iframe_display_type_id#",
				user_image_type="#user_image_type#",
				state="#state#",
				identifier="#identifier#",
				link_target="#link_target#"
				}>


			<cfif isDefined("arguments.return_type")>
			
				<cfif arguments.return_type EQ "object">
				
					<cfreturn object>
					
				<cfelseif arguments.return_type EQ "xml">
				
					<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResult">
						<cfinvokeargument name="objectItem" value="#object#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
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
			</cfcatch>
		</cftry>
		
	</cffunction>

	
	<cffunction name="createDateFromString" returntype="date" output="false" access="public">
		<cfargument name="strDate" type="string" required="yes">
		
		<cfset date = createDate(listGetAt(strDate,3,'-'), listGetAt(strDate,2,"-"), listGetAt(strDate,1,"-"))>
		<cfreturn date>
		
	</cffunction>
	
	
	
	<!--- ----------------------- CREATE ITEM -------------------------------- --->
	
	<cffunction name="createItem" returntype="struct" output="false" access="public">		
		<cfargument name="xmlItem" type="xml" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">

		<cfset var method = "createItem">
				
		<cfset var parent_kind = "">
		<cfset var parent_id = "">
		<cfset var area_id = "">
		
			
		<cfinclude template="includes/functionStartOnlySession.cfm">
		
		<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
				
		<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="objectItem">
			<cfinvokeargument name="xml" value="#xmlItem#">
			<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
		</cfinvoke>
		
		<!---checkAreaAccess--->
		<cfif objectItem.parent_kind EQ "area">
		
			<cfset area_id = objectItem.parent_id>	

		<cfelse>
		
			<!---GET ITEM PARENT--->
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getItemParent" returnvariable="getItemParentResult">
				<cfinvokeargument name="item_id" value="#objectItem.parent_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfset area_id = getItemParentResult.parent_area_id>
			
		</cfif>
		
		<cfinclude template="includes/checkAreaAccess.cfm">
		
		<cfset objectItem.area_id = area_id><!---Esta variable se utiliza despues para enviar las ALERTAS--->
		
		<cfif itemTypeId IS 7 AND objectItem.parent_kind NEQ "area"><!---Consultations--->
			
			<cfset parent_state = getItemParentResult.state>
			
			<cfif parent_state EQ "closed">
			
				<cfthrow message="La consulta está cerrada, no puede responderla.">
				
			</cfif>
		
		</cfif>
		
		
		<cfif itemTypeId IS 5><!---Events--->
			
			<cfif len(objectItem.start_date) GT 0 AND len(objectItem.end_date) GT 0>
				<cfset start_date = createDateFromString(objectItem.start_date)>
				<cfset end_date = createDateFromString(objectItem.end_date)>
				
				<!---end_date check--->
				<cfif DateCompare(start_date,end_date,"d") IS 1>
					<cfset response_message = 'Fechas incorrectas: la fecha de fin del evento debe ser posterior a la de inicio.'>
				
					<cfthrow message="#response_message#">
				</cfif>	
			</cfif>
			
		</cfif>
		
		<cfquery datasource="#client_dsn#" name="getUserData">
			SELECT family_name, name
			FROM #client_abb#_users
			WHERE id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		
		<cfif getUserData.recordCount LT 1><!---the user does not exist--->
			
			<cfset error_code = 204>
			
			<cfthrow errorcode="#error_code#"> 
			
		</cfif>
	
		<cfset objectItem.user_full_name = "#getUserData.family_name# #getUserData.name#">
		
		
		<cfif itemTypeId IS 6><!---Tasks--->
			
			<cfquery datasource="#client_dsn#" name="getRecipientUserData">
				SELECT family_name, name
				FROM #client_abb#_users
				WHERE id = <cfqueryparam value="#objectItem.recipient_user#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getRecipientUserData.recordCount LT 1><!---the user does not exist--->
				
				<cfset error_code = 204>
				
				<cfthrow errorcode="#error_code#"> 
				
			</cfif>
		
			<cfset objectItem.recipient_user_full_name = "#getRecipientUserData.family_name# #getRecipientUserData.name#">
		
		</cfif>
		
		
		
		<cfinvoke component="DateManager" method="getCurrentDateTime" returnvariable="current_date">
		</cfinvoke>
		
		<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringCurrentDate">
			<cfinvokeargument name="timestamp_date" value="#current_date#">
		</cfinvoke>
		
		<!---Status of item--->
		<!---<cfif NOT isDefined("xmlItem.item.attached_file_name.xmlText") OR len(xmlItem.item.attached_file_name.xmlText) IS 0 OR xmlItem.item.xmlAttributes.attached_file_id EQ "NULL">--->
		<cfif len(objectItem.attached_file_name) IS 0 OR objectItem.attached_file_id IS "NULL"
			OR objectItem.attached_image_id IS "NULL">
			<cfset status = "pending">
		<cfelse>
			<cfset status = "ok">
		</cfif>

		
		<cftransaction>
		
			<cfquery name="insertItemQuery" datasource="#client_dsn#" result="insertItemResult">		
				INSERT INTO #client_abb#_#itemTypeTable#
				SET title = <cfqueryparam value="#objectItem.title#" cfsqltype="CF_SQL_varchar">,
				description = <cfqueryparam value="#objectItem.description#" cfsqltype="CF_SQL_varchar">,
				parent_id = <cfqueryparam value="#objectItem.parent_id#" cfsqltype="CF_SQL_integer">,
				parent_kind = <cfqueryparam value="#objectItem.parent_kind#" cfsqltype="CF_SQL_varchar">,
				user_in_charge = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">,
				attached_file_name = <cfqueryparam value="#objectItem.attached_file_name#" cfsqltype="cf_sql_varchar">,
				attached_file_id = <cfif objectItem.attached_file_id EQ "NULL" OR objectItem.attached_file_id EQ "-1">
						<cfqueryparam null="yes" cfsqltype="cf_sql_numeric">
					<cfelse>
						<cfqueryparam value="#objectItem.attached_file_id#" cfsqltype="cf_sql_integer">
					</cfif>,
				<cfif itemTypeId IS 4><!---News--->
					creation_date = STR_TO_DATE(<cfqueryparam value="#objectItem.creation_date#" cfsqltype="cf_sql_varchar">,'%d-%m-%Y'),
				<cfelse>
					creation_date = <cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">,
				</cfif>
				status = '#status#',
				area_id = <cfqueryparam value="#objectItem.area_id#" cfsqltype="cf_sql_integer">,
				link = <cfqueryparam value="#objectItem.link#" cfsqltype="cf_sql_varchar">
				<cfif itemTypeId IS NOT 1>
				, last_update_date = <cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">
				</cfif>
				<cfif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News--->
				, position = <cfqueryparam value="#objectItem.position#" cfsqltype="cf_sql_integer">
					<cfif itemTypeId IS 2><!---Entries--->
					, display_type_id = <cfqueryparam value="#objectItem.display_type_id#" cfsqltype="cf_sql_integer">
					</cfif>
				</cfif>
				<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 4 OR arguments.itemTypeId IS 5><!---Entries, News, Events--->	
					, iframe_url = <cfqueryparam value="#objectItem.iframe_url#" cfsqltype="cf_sql_varchar">
					, iframe_display_type_id = <cfqueryparam value="#objectItem.iframe_display_type_id#" cfsqltype="cf_sql_integer">
				</cfif>	 
				<cfif itemTypeId IS 5 OR itemTypeId IS 6><!---Events, Tasks--->
				, start_date = STR_TO_DATE(<cfqueryparam value="#objectItem.start_date#" cfsqltype="cf_sql_varchar">,'%d-%m-%Y')
				, end_date = STR_TO_DATE(<cfqueryparam value="#objectItem.end_date#" cfsqltype="cf_sql_varchar">,'%d-%m-%Y')
				</cfif>
				<cfif itemTypeId IS 5><!---Events--->
				, start_time = <cfqueryparam value="#objectItem.start_time#" cfsqltype="cf_sql_time">
				, end_time = <cfqueryparam value="#objectItem.end_time#" cfsqltype="cf_sql_time">
				, place = <cfqueryparam value="#objectItem.place#" cfsqltype="cf_sql_varchar">
				</cfif>
				<cfif itemTypeId IS 6><!---Tasks--->
				, recipient_user = <cfqueryparam value="#objectItem.recipient_user#" cfsqltype="cf_sql_varchar">
				, done = <cfqueryparam value="#objectItem.done#" cfsqltype="cf_sql_bit">
				, estimated_value = <cfqueryparam value="#objectItem.estimated_value#" cfsqltype="cf_sql_float">
				, real_value = <cfqueryparam value="#objectItem.real_value#" cfsqltype="cf_sql_float">
				</cfif>
				<cfif itemTypeId IS 7><!---Consultation--->
				, identifier = <cfqueryparam value="#objectItem.identifier#" cfsqltype="cf_sql_varchar"
>				, state = <cfqueryparam value="created" cfsqltype="cf_sql_varchar">
				</cfif>
				;			
			</cfquery>
			
			<cfquery name="getLastInsertId" datasource="#client_dsn#">
				SELECT LAST_INSERT_ID() AS last_insert_id FROM #client_abb#_#itemTypeTable#;
			</cfquery>
		
		</cftransaction>
		
		<cfset objectItem.id = getLastInsertId.last_insert_id>
		
		<cfif itemTypeId IS NOT 4>
			<cfset objectItem.creation_date = stringCurrentDate>
		</cfif>
		
		<cfif arguments.itemTypeId IS 7 AND objectItem.parent_kind NEQ "area" AND parent_state NEQ "answered"><!---Consultations--->
	
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="updateItemState">
				<cfinvokeargument name="item_id" value="#objectItem.parent_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="state" value="answered">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>					
		
		</cfif>
		
		<cfif status EQ "ok">
			<cfinvoke component="AlertManager" method="newAreaItem">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="action" value="new">
				<cfif objectItem.notify_by_sms EQ "true">
					<cfinvokeargument name="send_sms" value="true">
				</cfif>
			</cfinvoke>
		</cfif>
		
		
		<cfif objectItem.post_to_twitter IS true>
			<!---postItemToTwitter--->
			<cfinvoke component="AreaItemManager" method="postItemToTwitter">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="item_id" value="#objectItem.id#">
				<cfinvokeargument name="area_id" value="#area_id#">
			</cfinvoke>		
		</cfif>
		
		
		<cfreturn objectItem>
		
	</cffunction>
	
	
	
	<!--- ----------------------- CREATE ITEM WITH ATTACHED -------------------------------- --->
	
	<cffunction name="createItemWithAttachedFile" returntype="struct" output="false" access="public">		
		<cfargument name="xmlItem" type="xml" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<!---Este parámetro debe quitarse cuando se modifiquen los métodos de FileManager y ya no sea requerido--->
		<!---<cfargument name="request" type="string" required="yes">--->
		<cfargument name="file_name" type="string" required="true"/>
		<cfargument name="file_file_name" type="string" required="true"/>
		<cfargument name="file_size" type="numeric" required="true"/>
		<cfargument name="file_type" type="string" required="true"/>
		<cfargument name="file_description" type="string" required="true"/>
		
		<cfset var method = "createItemWithAttachedFile">

		<cfset var response = structNew()>

		<cftry>
							
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">

			<cfinvoke component="AreaItemManager" method="createItem" returnvariable="objectItem">
				<cfinvokeargument name="xmlItem" value="#xmlItem#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
			</cfinvoke>
			
			<!---<cfinvoke component="FileManager" method="createFile" returnvariable="resultFile">
				<cfinvokeargument name="request" value="#xmlRequest#">
				<cfinvokeargument name="status" value="pending">
			</cfinvoke>
				
			<cfxml variable="xmlResultFile">
				<cfoutput>
					#resultFile#
				</cfoutput>					
			</cfxml>--->

			<cfinvoke component="FileManager" method="createFile" returnvariable="createFileResponse">
				<cfinvokeargument name="name" value="#arguments.file_name#">		
				<cfinvokeargument name="file_name" value="#arguments.file_file_name#">
				<cfinvokeargument name="file_type" value="#arguments.file_type#">
				<cfinvokeargument name="file_size" value="#arguments.file_size#">
				<cfinvokeargument name="description" value="#arguments.file_description#">
			</cfinvoke>			
			
			<cfif createFileResponse.result IS true>
				
				<cfset objectItem.attached_file_id = createFileResponse.objectFile.id>
				<cfset objectItem.attached_file_name = createFileResponse.objectFile.file_name>
				
				<!---<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlItem">
					<cfinvokeargument name="objectItem" value="#objectItem#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				</cfinvoke>
				
				<cfinvoke component="FileManager" method="objectFile" returnvariable="xmlFile">
					<cfinvokeargument name="xml" value="#xmlResultFile.response.result.file#">
					
					<cfinvokeargument name="return_type" value="xml">
				</cfinvoke>
				
				<cfsavecontent variable="xmlResult">
					<cfoutput>
					#xmlItem#
					#xmlFile#
					</cfoutput>				
				</cfsavecontent>

				<cfset xmlResponseContent = xmlResult>

				<cfreturn xmlResponseContent>--->

				<cfset response = {result=true, message="", objectItem=#objectItem#, objectFile=#createFileResponse.objectFile#}>						
			
			<cfelse><!---File insert failed--->
			
				<!---Delete the inserted item--->
				<!---
				No se elimina porque se envía la notificación de eliminar un mensaje que no se ha enviado
				<cfinvoke component="AreaItemManager" method="deleteItem" returnvariable="resultDeleteItem">
					<cfinvokeargument name="item_id" value="#objectItem.id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#"/>
				</cfinvoke>--->
		
				<cfset error_code = 602>
				
				<cfthrow errorcode="#error_code#">
			
			</cfif>


			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
	
	</cffunction>
	
	
	
	<!--- ----------------------- UPDATE ITEM -------------------------------- --->
	
	<cffunction name="updateItem" returntype="struct" output="false" access="public">		
		<cfargument name="xmlItem" type="xml" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">

		<cfset var method = "updateItem">
				
			
		<cfinclude template="includes/functionStartOnlySession.cfm">
		
		<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
		
		<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="objectItem">
			<cfinvokeargument name="xml" value="#xmlItem#">
			<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
		</cfinvoke>
		
		<cfinvoke component="AreaItemManager" method="getItem" returnvariable="getItemObject">
			<cfinvokeargument name="item_id" value="#objectItem.id#">
			<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
			
			<cfinvokeargument name="return_type" value="object">
		</cfinvoke>
		
		<cfset objectItem.area_id = getItemObject.area_id><!---Esta variable se utiliza despues para enviar las alertas--->	
		<cfset objectItem.user_in_charge = getItemObject.user_in_charge>
		<cfset objectItem.user_full_name = getItemObject.user_full_name><!---Para las alertas--->
		
		<!---checkAreaAccess--->
		<!---Esto se hace en getItem--->
		<!---<cfinclude template="includes/checkAreaAccess.cfm">--->
		
		<cfif itemTypeId IS 5 OR itemTypeId IS 6><!---Events, Tasks--->
			
			<cfif len(objectItem.start_date) GT 0 AND len(objectItem.end_date) GT 0>
				<cfset start_date = createDateFromString(objectItem.start_date)>
				<cfset end_date = createDateFromString(objectItem.end_date)>
				
				<!---end_date check--->
				<cfif DateCompare(start_date,end_date,"d") IS 1>
					<cfset response_message = 'Fechas incorrectas: la fecha de fin del evento debe ser posterior a la de inicio.'>
				
					<cfthrow message="#response_message#">
				</cfif>	
			</cfif>
			
		</cfif>
		
		
		<cfif itemTypeId IS 1 OR itemTypeId IS 7><!---Messages, Consultations--->
			
			<cfset error_code = 103><!---Access denied--->
					
			<cfthrow errorcode="#error_code#">
		
		<cfelseif itemTypeId IS 6><!---Tasks--->
			
			<!---Si es una tarea, puede modificarla el usuario que la creó y el usuario asignado.--->
			
			<cfif getItemObject.user_in_charge NEQ user_id AND getItemObject.recipient_user NEQ user_id><!---El usuario que accede no tiene permiso--->
				<cfset error_code = 103><!---Access denied--->
					
				<cfthrow errorcode="#error_code#">
			</cfif>
			
		<cfelse>
		
			<cfif getItemObject.user_in_charge NEQ user_id><!---El usuario del item no es el mismo que intenta modificar--->
					
				<cfinvoke component="AreaManager" method="getAreaType" returnvariable="areaTypeResult">				
					<cfinvokeargument name="area_id" value="#objectItem.area_id#">
				</cfinvoke>
			
				<cfset area_type = areaTypeResult.areaType>
				
				<!---Si el área es web o intranet, los items pueden modificarlos todos los que tengan acceso a ese área--->
				<cfif area_type NEQ "web" AND area_type NEQ "intranet">
				
					<cfset error_code = 103><!---Access denied--->
					
					<cfthrow errorcode="#error_code#">
					
				<cfelse>
				
					<cfinvoke component="UserManager" method="getUser" returnvariable="objectUser">
						<cfinvokeargument name="get_user_id" value="#user_id#">
						<cfinvokeargument name="format_content" value="default">
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>
					
					<!---Asigna el nombre del nuevo usuario para las alertas--->
					<cfset objectItem.user_in_charge = user_id>
					<cfset objectItem.user_full_name = objectUser.family_name&" "&objectUser.name>
					
				</cfif>
					
			</cfif>
			
		</cfif>
		
		
		<cfif itemTypeId IS 6><!---Tasks--->
			
			<cfquery datasource="#client_dsn#" name="getRecipientUserData">
				SELECT family_name, name
				FROM #client_abb#_users
				WHERE id = <cfqueryparam value="#objectItem.recipient_user#" cfsqltype="cf_sql_integer">;
			</cfquery>
			
			<cfif getRecipientUserData.recordCount LT 1><!---the user does not exist--->
				
				<cfset error_code = 204>
				
				<cfthrow errorcode="#error_code#"> 
				
			</cfif>
		
			<cfset objectItem.recipient_user_full_name = "#getRecipientUserData.family_name# #getRecipientUserData.name#">
		
		</cfif>
		
		
		<cfif itemTypeId IS NOT 1>
			<cfinvoke component="DateManager" method="getCurrentDateTime" returnvariable="current_date">
			</cfinvoke>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringCurrentDate">
				<cfinvokeargument name="timestamp_date" value="#current_date#">
			</cfinvoke>
		</cfif>
		
	
		<!---Status of item--->
		<!---<cfif NOT isDefined("xmlItem.item.attached_file_name.xmlText") OR len(xmlItem.item.attached_file_name.xmlText) IS 0 OR xmlItem.item.xmlAttributes.attached_file_id EQ "NULL">--->
		<cfif len(objectItem.attached_file_name) IS 0 OR objectItem.attached_file_id IS "NULL"
			OR objectItem.attached_image_id IS "NULL">
			<cfset status = "pending">
		<cfelse>
			<cfset status = "ok">
		</cfif>
		
		<cftransaction>
		
			<cfquery name="updateItemQuery" datasource="#client_dsn#">		
				UPDATE #client_abb#_#itemTypeTable#
				SET title = <cfqueryparam value="#objectItem.title#" cfsqltype="cf_sql_varchar">,
				description = <cfqueryparam value="#objectItem.description#" cfsqltype="cf_sql_longvarchar">,
				link = <cfqueryparam value="#objectItem.link#" cfsqltype="cf_sql_varchar">
				<cfif itemTypeId IS 4><!---News--->
				, creation_date = STR_TO_DATE(<cfqueryparam value="#objectItem.creation_date#" cfsqltype="cf_sql_varchar">,'%d-%m-%Y')
				</cfif>
				, last_update_date = <cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">
				<cfif itemTypeId IS 2 OR itemTypeId IS 3 OR itemTypeId IS 4><!---Entries, Links, News--->
				, position = <cfqueryparam value="#objectItem.position#" cfsqltype="cf_sql_integer">
					<cfif itemTypeId IS 2><!---Entries--->
					, display_type_id = <cfqueryparam value="#objectItem.display_type_id#" cfsqltype="cf_sql_integer">
					</cfif>
				</cfif>
				<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 4 OR arguments.itemTypeId IS 5><!---Entries, News, Events--->	
					, iframe_url = <cfqueryparam value="#objectItem.iframe_url#" cfsqltype="cf_sql_varchar">
					, iframe_display_type_id = <cfqueryparam value="#objectItem.iframe_display_type_id#" cfsqltype="cf_sql_integer">
				</cfif>	 
				<cfif itemTypeId IS 5 OR itemTypeId IS 6><!---Events, Tasks--->
				, start_date = STR_TO_DATE(<cfqueryparam value="#objectItem.start_date#" cfsqltype="cf_sql_varchar">,'%d-%m-%Y')
				, end_date = STR_TO_DATE(<cfqueryparam value="#objectItem.end_date#" cfsqltype="cf_sql_varchar">,'%d-%m-%Y')
				</cfif>
				<cfif itemTypeId IS 5><!---Events--->
				, start_time = <cfqueryparam value="#objectItem.start_time#" cfsqltype="cf_sql_time">
				, end_time = <cfqueryparam value="#objectItem.end_time#" cfsqltype="cf_sql_time">
				, place = <cfqueryparam value="#objectItem.place#" cfsqltype="cf_sql_varchar">
				</cfif>
				<cfif itemTypeId IS 6><!---Tasks--->
				, recipient_user = <cfqueryparam value="#objectItem.recipient_user#" cfsqltype="cf_sql_varchar">
				, done = <cfqueryparam value="#objectItem.done#" cfsqltype="cf_sql_bit">
				, estimated_value = <cfqueryparam value="#objectItem.estimated_value#" cfsqltype="cf_sql_float">
				, real_value = <cfqueryparam value="#objectItem.real_value#" cfsqltype="cf_sql_float">
				<cfelse><!---Is not tasks--->
				, user_in_charge = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">
				</cfif>
				WHERE id = <cfqueryparam value="#objectItem.id#" cfsqltype="cf_sql_integer">;			
			</cfquery>
			
		</cftransaction>
		
		<cfif itemTypeId IS NOT 4>
			<cfset objectItem.creation_date = getItemObject.creation_date><!---Para las alertas--->
		</cfif>
		
		<cfset objectItem.last_update_date = stringCurrentDate>
		
		
		<cfif status EQ "ok">
			<cfinvoke component="AlertManager" method="newAreaItem">
				<cfinvokeargument name="objectItem" value="#objectItem#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="action" value="update">
				<cfif objectItem.notify_by_sms EQ "true">
					<cfinvokeargument name="send_sms" value="true">
				</cfif>
			</cfinvoke>
		</cfif>
		
		
		<cfreturn objectItem>
		
	</cffunction>
	
	
	
	<!--- ----------------------- UPDATE ITEM WITH ATTACHED -------------------------------- --->
	
	<cffunction name="updateItemWithAttachedFile" returntype="struct" output="false" access="public">		
		<cfargument name="xmlItem" type="xml" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<!---Este parámetro debe quitarse cuando se modifiquen los métodos de FileManager y ya no sea requerido--->
<!---		<cfargument name="request" type="string" required="yes">--->
		<cfargument name="file_name" type="string" required="true"/>
		<cfargument name="file_file_name" type="string" required="true"/>
		<cfargument name="file_size" type="numeric" required="true"/>
		<cfargument name="file_type" type="string" required="true"/>
		<cfargument name="file_description" type="string" required="true"/>
		
		
		<cfset var method = "updateItemWithAttachedFile">
		
		<cfset var response = structNew()>
		
			<cftry>
							
				<cfinclude template="includes/functionStart.cfm">
				
				<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
	
				<cfinvoke component="AreaItemManager" method="updateItem" returnvariable="objectItem">
					<cfinvokeargument name="xmlItem" value="#xmlItem#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				</cfinvoke>
				
	<!---			<cfinvoke component="FileManager" method="createFile" returnvariable="resultFile">
					<cfinvokeargument name="request" value="#xmlRequest#">
					<cfinvokeargument name="status" value="pending">
				</cfinvoke>
					
				<cfxml variable="xmlResultFile">
					<cfoutput>
						#resultFile#
					</cfoutput>					
				</cfxml>--->
				
				
				<cfinvoke component="FileManager" method="createFile" returnvariable="createFileResponse">
					<cfinvokeargument name="name" value="#arguments.file_name#">		
					<cfinvokeargument name="file_name" value="#arguments.file_file_name#">
					<cfinvokeargument name="file_type" value="#arguments.file_type#">
					<cfinvokeargument name="file_size" value="#arguments.file_size#">
					<cfinvokeargument name="description" value="#arguments.file_description#">
				</cfinvoke>				
				
				
				
				<cfif createFileResponse.result IS true>
					
					<cfset objectItem.attached_file_id = createFileResponse.objectFile.id>
					<cfset objectItem.attached_file_name = createFileResponse.objectFile.file_name>
					
	<!---				<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlItem">
						<cfinvokeargument name="objectItem" value="#objectItem#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					</cfinvoke>
					
					<cfinvoke component="FileManager" method="objectFile" returnvariable="xmlFile">
						<cfinvokeargument name="xml" value="#xmlResultFile.response.result.file#">
						
						<cfinvokeargument name="return_type" value="xml">
					</cfinvoke>
					
					<cfsavecontent variable="xmlResult">
						<cfoutput>
						#xmlItem#
						#xmlFile#
						</cfoutput>				
					</cfsavecontent>
					
	
					<cfset xmlResponseContent = xmlResult>
					
					<cfreturn xmlResponseContent>--->
					
					<cfset response = {result=true, message="", objectItem=#objectItem#, objectFile=#createFileResponse.objectFile#}>			
							
				
				<cfelse><!---File insert failed--->
				
					<!---Delete the inserted item--->
	<!---				<cfinvoke component="AreaItemManager" method="deleteItem" returnvariable="resultDeleteItem">
						<cfinvokeargument name="item_id" value="#objectItem.id#">
					</cfinvoke>--->
			
					<cfset error_code = 602>
					
					<cfthrow errorcode="#error_code#">
				
				</cfif>
			
				<cfcatch>
	
					<cfinclude template="includes/errorHandlerStruct.cfm">
	
				</cfcatch>
			</cftry>
			
			
		<cfreturn response>
	
	</cffunction>
	
	
	
	
	<!--- ----------------------- ADD FILE TO ITEM -------------------------------- --->
	
	<!---Añade un archivo existente (duplicándolo y creando uno nuevo) a un mensaje, noticia, entrada etc.--->
	
	<cffunction name="addFileToItem" output="false" returntype="struct" access="public">		
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="file_id" type="numeric" required="yes">
		<cfargument name="file_type" type="string" required="no" default="file"><!---file/image--->
		
		<cfset var method = "associateFileToItem">
							
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<!---Se duplica el archivo--->
			<cfinvoke component="FileManager" method="duplicateFile" returnvariable="objectFile">
				<cfinvokeargument name="file_id" value="#arguments.file_id#">
			</cfinvoke>	
			
			<cfif arguments.file_type NEQ "file">
				<cfset arguments.file_type = "image">
			</cfif>
			
			<!---Se añade la referencia al mensaje--->
			<cfquery datasource="#client_dsn#" name="addFileToItem">
				UPDATE #client_abb#_#itemTypeTable#
				SET attached_#arguments.file_type#_id = <cfqueryparam value="#objectFile.id#" cfsqltype="cf_sql_integer">,
				attached_#arguments.file_type#_name = <cfqueryparam value="#objectFile.file_name#" cfsqltype="cf_sql_varchar">,						
				status = 'ok'
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">
			</cfquery>
			
			
		<cfreturn objectFile>		
		
	</cffunction>
	
	
	
	<!---  ---------------------- getWebItemUrl -------------------------------- --->
	
	<cffunction name="getWebItemUrl" returntype="string" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="item_id" type="numeric" required="true">
		
		<cfset var method = "getWebItemUrl">
		<cfset var item_url = "">
				
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfset item_url = "#APPLICATION.webUrl##lCase(itemTypeNameEs)#.cfm?iid=#arguments.item_id#">
		
		<cfreturn item_url>
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!---  ---------------------- postItemToTwitter -------------------------------- --->
	
	<cffunction name="postItemToTwitter" returntype="void" access="public">
		<cfargument name="itemTypeId" type="numeric" required="true">
		<cfargument name="item_id" type="numeric" required="true">
		<cfargument name="area_id" type="numeric" required="true">
		<cfargument name="content" type="string" required="no">
		
		<cfset var method = "postItemToTwitter">
		<cfset var tweet_content = "">
		<cfset var tweet_url = "">			
			
			<cfinvoke component="AreaItemManager" method="getWebItemUrl" returnvariable="tweet_url">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
			</cfinvoke>
			
			<cfif NOT isDefined("arguments.content") OR len(arguments.content) IS 0>
				<cfinvoke component="AreaItemManager" method="getItem" returnvariable="objectItem">
					<cfinvokeargument name="item_id" value="#arguments.item_id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					
					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>
				
				<cfif len(objectItem.title) GT 119><!---Se deben reservar 20 caracteres + 1 espacio para la URL (la URL abreviada ocupa 20 caracteres)--->
					<cfset tweet_content = left(objectItem.title,116)&"...">
				<cfelse>
					<cfset tweet_content = objectItem.title>
				</cfif>
				
				<cfset tweet_content = tweet_content&" "&tweet_url>
			<cfelse>
				<cfset tweet_content = arguments.content&" "&tweet_url>
			</cfif>
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/TwitterManager" method="sendTweet">
				<cfinvokeargument name="content" value="#tweet_content#">
			</cfinvoke>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	<!---  -------------------GET ITEM PARENT----------------------   --->
	<!---<cffunction name="getItemParent" returntype="struct" output="false" access="public">
		<cfargument name="item_id" required="yes" type="numeric">
		<cfargument name="itemTypeId" required="yes" type="numeric">
		
		<cfset var method = "getItemParent">
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getItemParent" returnvariable="getItemParentResult">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfreturn getItemParentResult>

	</cffunction>--->
	
	
	<!---  -------------------GET ITEM ROOT----------------------   --->
	<cffunction name="getItemRoot" returntype="query" output="false" access="public">
		<cfargument name="item_id" required="yes" type="numeric">
		<cfargument name="itemTypeId" required="yes" type="numeric">
		
		<cfset var method = "getItemRoot">
			
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getItemRoot" returnvariable="getItemRootResult">
				<cfinvokeargument name="item_id" value="#arguments.item_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfreturn getItemRootResult>

	</cffunction>
	
	
	
	<!---  ---------------------- getItem -------------------------------- --->
	
	<cffunction name="getItem" returntype="any" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="return_type" type="string" required="no" default="xml">
		
		<cfset var method = "getItem">
		
		<cfset var id = arguments.item_id>
		<cfset var area_id = "">
		<cfset var recipient_user_full_name = "">
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getItem" returnvariable="selectItemQuery">
				<cfinvokeargument name="item_id" value="#id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfif selectItemQuery.recordCount GT 0>
			
				<cfif arguments.itemTypeId IS 6><!---Tasks--->
				
					<cfquery datasource="#client_dsn#" name="getRecipientUserData">
						SELECT family_name, name
						FROM #client_abb#_users
						WHERE id = <cfqueryparam value="#selectItemQuery.recipient_user#" cfsqltype="cf_sql_integer">;
					</cfquery>
					
					<cfif getRecipientUserData.recordCount LT 1><!---the user does not exist--->
						
						<cfset error_code = 204>
						
						<cfthrow errorcode="#error_code#"> 
						
					</cfif>
					
					<cfset recipient_user_full_name = "#getRecipientUserData.family_name# #getRecipientUserData.name#">
				
				</cfif>
				

				<cfset area_id = selectItemQuery.area_id>
			
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">
				
				<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="result">
					<cfinvokeargument name="id" value="#selectItemQuery.item_id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					<cfinvokeargument name="parent_id" value="#selectItemQuery.parent_id#">
					<cfinvokeargument name="parent_kind" value="#selectItemQuery.parent_kind#">
					<cfinvokeargument name="area_id" value="#area_id#">
					<cfinvokeargument name="user_in_charge" value="#selectItemQuery.user_in_charge#">
					<cfinvokeargument name="creation_date" value="#selectItemQuery.creation_date#">
					<cfinvokeargument name="attached_file_id" value="#selectItemQuery.attached_file_id#">
					<cfif selectItemQuery.attached_file_name EQ "NULL">
						<cfinvokeargument name="attached_file_name" value="-">
					<cfelse>
						<cfinvokeargument name="attached_file_name" value="#selectItemQuery.attached_file_name#">
					</cfif>
					<cfinvokeargument name="link" value="#selectItemQuery.link#">

					<cfif arguments.itemTypeId NEQ messageTypeId>
						<cfinvokeargument name="last_update_date" value="#selectItemQuery.last_update_date#">
						<cfinvokeargument name="attached_image_id" value="#selectItemQuery.attached_image_id#">
						<cfif selectItemQuery.attached_image_name EQ "NULL">
							<cfinvokeargument name="attached_image_name" value="-">
						<cfelse>
							<cfinvokeargument name="attached_image_name" value="#selectItemQuery.attached_image_name#">
						</cfif>
						
						<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 3 OR arguments.itemTypeId IS 4><!---Entries, Links, News--->
							<cfinvokeargument name="position" value="#selectItemQuery.position#">
						</cfif>
						
						<cfif arguments.itemTypeId EQ 5 OR arguments.itemTypeId EQ 6><!---Events, Tasks--->
							<cfinvokeargument name="start_date" value="#selectItemQuery.start_date#">
							<cfinvokeargument name="end_date" value="#selectItemQuery.end_date#">
							<cfif arguments.itemTypeId EQ 5>
								<cfinvokeargument name="start_time" value="#selectItemQuery.start_time#">
								<cfinvokeargument name="end_time" value="#selectItemQuery.end_time#">
								<cfinvokeargument name="place" value="#selectItemQuery.place#">
							<cfelse>
								<cfinvokeargument name="recipient_user" value="#selectItemQuery.recipient_user#">
								<cfinvokeargument name="recipient_user_full_name" value="#recipient_user_full_name#">
								<cfinvokeargument name="done" value="#selectItemQuery.done#">
								<cfinvokeargument name="estimated_value" value="#selectItemQuery.estimated_value#">
								<cfinvokeargument name="real_value" value="#selectItemQuery.real_value#">
							</cfif>
						</cfif>
					</cfif>
					<cfif arguments.itemTypeId IS 2>
					<cfinvokeargument name="display_type_id" value="#selectItemQuery.display_type_id#">
					</cfif>
					<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 4 OR arguments.itemTypeId IS 5>
					<cfinvokeargument name="iframe_url" value="#selectItemQuery.iframe_url#">
					<cfinvokeargument name="iframe_display_type_id" value="#selectItemQuery.iframe_display_type_id#">
					</cfif>
					<cfinvokeargument name="attached_file_type" value="#selectItemQuery.file_type#">
					<cfinvokeargument name="title" value="#selectItemQuery.title#">
					<cfinvokeargument name="description" value="#selectItemQuery.description#">
					<cfinvokeargument name="user_full_name" value="#selectItemQuery.family_name# #selectItemQuery.user_name#">
					<cfinvokeargument name="user_image_type" value="#selectItemQuery.user_image_type#">
					<cfif arguments.itemTypeId IS 7><!---Consultations--->
					<cfinvokeargument name="state" value="#selectItemQuery.state#">
					<cfinvokeargument name="identifier" value="#selectItemQuery.identifier#">
					</cfif>
					
					<cfinvokeargument name="return_type" value="#return_type#">
				</cfinvoke>
				
				
				<cfif itemTypeId IS 7><!---Consultations--->
					
					<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="addReadToItem">
						<cfinvokeargument name="item_id" value="#id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="user_id" value="#user_id#">
						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>
					
					<cfif selectItemQuery.user_in_charge NEQ user_id>
						
						<cfif selectItemQuery.state EQ "created">
						
							<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="updateItemState">
								<cfinvokeargument name="item_id" value="#id#">
								<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
								<cfinvokeargument name="state" value="read">
								<cfinvokeargument name="client_abb" value="#client_abb#">
								<cfinvokeargument name="client_dsn" value="#client_dsn#">
							</cfinvoke>	
							
						<cfelseif NOT isDate(selectItemQuery.read_date)>
							
							<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="setItemReadDate">
								<cfinvokeargument name="item_id" value="#id#">
								<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
								<cfinvokeargument name="client_abb" value="#client_abb#">
								<cfinvokeargument name="client_dsn" value="#client_dsn#">
							</cfinvoke>				
						
						</cfif>						
					
					</cfif>
					
				</cfif>
				
				<cfset xmlResponse = result>
				
				
			<cfelse><!---Item does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#">
					
			</cfif>		
		
			
		<cfreturn xmlResponse>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!---  ---------------------- getAreaItemsLastPosition -------------------------------- --->
	
	<cffunction name="getAreaItemsLastPosition" returntype="numeric" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfset var method = "getAreaItemsLastPosition">
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getAreaItemsLastPosition" returnvariable="getLastPositionResult">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
		
		<cfif isNumeric(getLastPositionResult.position)>
			<cfreturn getLastPositionResult.position>
		<cfelse>
			<cfreturn 0>
		</cfif>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!---  ---------------------- changeAreaItemPosition -------------------------------- --->
	
	<cffunction name="changeAreaItemPosition" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="action" type="string" required="yes"><!---increase/decrease--->
		
		<cfset var method = "changeAreaItemPosition">
		<cfset var response = structNew()>
		
		<cfset var area_id = "">
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfquery name="getItem" datasource="#client_dsn#">		
				SELECT position, area_id
				FROM #client_abb#_#itemTypeTable# 
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;			
			</cfquery>
			
			<cfif getItem.recordCount GT 0>
				
				<cfset area_id = getItem.area_id>
			
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">
				
				<cfquery name="getOtherItem" datasource="#client_dsn#">		
					SELECT id, position 
					FROM #client_abb#_#itemTypeTable# 
					WHERE
					area_id = <cfqueryparam value="#getItem.area_id#" cfsqltype="cf_sql_integer">
					AND 
					<cfif arguments.action IS "increase">
					position < <cfqueryparam value="#getItem.position#" cfsqltype="cf_sql_integer"> 
					ORDER BY position DESC
					<cfelse>
					position > <cfqueryparam value="#getItem.position#" cfsqltype="cf_sql_integer"> 
					ORDER BY position ASC
					</cfif>
					LIMIT 1;			
				</cfquery>
			
					
				<cfif getOtherItem.recordCount GT 0>
					
					<cftransaction>
					
						<cfquery name="updateOtherItemQuery" datasource="#client_dsn#">		
							UPDATE #client_abb#_#itemTypeTable#
							SET position = <cfqueryparam value="#getItem.position#" cfsqltype="cf_sql_integer">
							WHERE id = <cfqueryparam value="#getOtherItem.id#" cfsqltype="cf_sql_integer">;			
						</cfquery>
						
						<cfquery name="updateItemQuery" datasource="#client_dsn#">		
							UPDATE #client_abb#_#itemTypeTable#
							SET position = <cfqueryparam value="#getOtherItem.position#" cfsqltype="cf_sql_integer">
							WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;			
						</cfquery>
					
					</cftransaction>
					
				<cfelse>
				
					<cfset response = {result="false", message="Error, no se ha encontrado el elemento por el que hay que cambiar el orden"}>
					
					<cfreturn response>
					
				</cfif>
				
				<cfset response = {result="true", area_id=getItem.area_id}>
			
			<cfelse>
			
				<cfset response = {result="false", message="Error, no se ha encontrado el elemento"}>
			
			</cfif>
			
			<cfreturn response>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!---  ---------------------- changeAreaItemState -------------------------------- --->
	
	<cffunction name="changeAreaItemState" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="state" type="string" required="yes"><!---closed--->
		
		<cfset var method = "changeAreaItemState">
		<cfset var response = structNew()>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfquery name="getItem" datasource="#client_dsn#">		
				SELECT area_id, state, parent_kind, parent_id, user_in_charge
				FROM #client_abb#_#itemTypeTable# 
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;			
			</cfquery>
			
			<cfif getItem.recordCount GT 0 AND arguments.itemTypeId IS 7>
				
				<cfset area_id = getItem.area_id>
			
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">
			
				<cfif getItem.user_in_charge EQ user_id AND getItem.parent_kind EQ "area" AND getItem.state NEQ "closed" AND arguments.state EQ "closed"><!---Solo se pueden cerrar las consultas por el creador--->
				
					<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="changeItemsState">
						<cfinvokeargument name="item_id" value="#arguments.item_id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="state" value="#arguments.state#">
						<cfinvokeargument name="client_abb" value="#client_abb#">
						<cfinvokeargument name="client_dsn" value="#client_dsn#">
					</cfinvoke>	
								
					<cfinvoke component="AreaItemManager" method="getItem" returnvariable="objectItem">
						<cfinvokeargument name="item_id" value="#arguments.item_id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>
					
					<!---Alert--->
					<cfinvoke component="AlertManager" method="newAreaItem">
						<cfinvokeargument name="objectItem" value="#objectItem#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="action" value="close">
					</cfinvoke>
									
					<cfset response = {result="true", area_id=getItem.area_id, message="#itemTypeNameEs# cerrada"}>
										
				<cfelse>
				
					<cfset response = {result="false", message="Error: estado de #itemTypeNameEs# incorrecto"}>
					
					<cfreturn response>
					
				</cfif>
			
			<cfelse>
			
				<cfset response = {result="false", message="Error: no se ha encontrado la #itemTypeNameEs#"}>
			
			</cfif>
			
			<cfreturn response>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!---  ---------------------- changeAreaItemDone -------------------------------- --->
	
	<cffunction name="changeAreaItemDone" returntype="struct" access="public">
		<cfargument name="item_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="done" type="boolean" required="yes"><!---1--->
		
		<cfset var method = "changeAreaItemDone">
		<cfset var response = structNew()>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfquery name="getItem" datasource="#client_dsn#">		
				SELECT area_id, done, user_in_charge, recipient_user
				FROM #client_abb#_#itemTypeTable# 
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;			
			</cfquery>
			
			<cfif getItem.recordCount GT 0 AND arguments.itemTypeId IS 6>
				
				<cfset area_id = getItem.area_id>
			
				<!---checkAreaAccess--->
				<cfinclude template="includes/checkAreaAccess.cfm">
			
				<cfif getItem.user_in_charge EQ user_id OR getItem.recipient_user EQ user_id AND getItem.done NEQ arguments.done AND getItem.done IS 0 AND arguments.done IS 1><!---Solo se pueden marcar como hechas--->
				
					<cfquery name="addReadToItem" datasource="#client_dsn#">		
						UPDATE #client_abb#_#itemTypeTable#
						SET	done = <cfqueryparam value="#arguments.done#" cfsqltype="cf_sql_bit">,
						last_update_date = NOW()
						WHERE
						id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;			
					</cfquery>
					
					<cfinvoke component="AreaItemManager" method="getItem" returnvariable="objectItem">
						<cfinvokeargument name="item_id" value="#arguments.item_id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>
					
					<!---Alert--->
					<cfinvoke component="AlertManager" method="newAreaItem">
						<cfinvokeargument name="objectItem" value="#objectItem#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="action" value="done">
					</cfinvoke>
									
					<cfset response = {result="true", area_id=getItem.area_id, message="#itemTypeNameEs# marcada como realizada"}>
										
				<cfelse>
				
					<cfset response = {result="false", message="Error, estado de #itemTypeNameEs# incorrecto"}>
					
					<cfreturn response>
					
				</cfif>
			
			<cfelse>
			
				<cfset response = {result="false", message="Error, no se ha encontrado la #itemTypeNameEs#"}>
			
			</cfif>
			
			<cfreturn response>
		
	</cffunction>
	<!---  ------------------------------------------------------------------------ --->
	
	
	
	<!--- ----------------------- DELETE AREA ITEMS -------------------------------- --->
	
	<cffunction name="deleteAreaItems" returntype="string" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfinclude template="includes/functionStart.cfm">
		
		<cfinclude template="includes/checkAreaAdminAccess.cfm">
		
		<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
		
		<!--- --------------DELETE AREA ITEMS------------------------- --->
		<cfquery name="itemsQuery" datasource="#client_dsn#">
			SELECT id 
			FROM #client_abb#_#itemTypeTable# 
			WHERE area_id = <cfqueryparam value="#arguments.area_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		
		<cfif itemsQuery.recordCount GT 0>
		
			<cfloop query="itemsQuery">
			
				<cfinvoke component="AreaItemManager" method="deleteItem">
					<cfinvokeargument name="item_id" value="#itemsQuery.id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				</cfinvoke>
				
			</cfloop>
			
		</cfif>
		
	</cffunction>
	
	
	
	<!--- ----------------------- DELETE USER ITEMS -------------------------------- --->
	
	<cffunction name="deleteUserItems" returntype="string" access="public">
		<cfargument name="delete_user_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfinclude template="includes/functionStart.cfm">
				
		<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
		
		<!---checkAdminUser--->
		<cfif SESSION.client_administrator NEQ user_id><!---The user is not the organization administrator--->
			<cfset error_code = 206>
		
			<cfthrow errorcode="#error_code#">
		</cfif>
		
		<!--- --------------DELETE USER ITEMS------------------------- --->
		<cfquery name="userItemsQuery" datasource="#client_dsn#">
			SELECT id
			FROM #client_abb#_#itemTypeTable# 
			WHERE user_in_charge = <cfqueryparam value="#arguments.delete_user_id#" cfsqltype="cf_sql_integer">;
		</cfquery>
		
		<cfif userItemsQuery.recordCount GT 0>
		
			<cfloop query="userItemsQuery">
			
				<cfinvoke component="AreaItemManager" method="deleteItem">
					<cfinvokeargument name="item_id" value="#userItemsQuery.id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				</cfinvoke>
				
			</cfloop>
			
		</cfif>
		
	</cffunction>
	
	
	
	<!--- ----------------------- DELETE ITEM -------------------------------- --->
	
	<cffunction name="deleteItem" returntype="string" access="public">
		<cfargument name="item_id" type="string" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfset var method = "deleteItem">
		
		<cfset var area_id = "">
						
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
		
			<cfquery name="getItemQuery" datasource="#client_dsn#">		
				SELECT id,parent_kind,parent_id,attached_file_id,area_id,user_in_charge
				<cfif arguments.itemTypeId IS NOT 1>,attached_image_id</cfif>
				<cfif arguments.itemTypeId IS 7>,state</cfif>
				FROM #client_abb#_#itemTypeTable#
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;		
			</cfquery>
			
			
			<cfif getItemQuery.recordCount GT 0>
				
				<!---checkAreaAccess--->
				<cfset area_id = getItemQuery.area_id>
				
				<cfinclude template="includes/checkAreaAccess.cfm">
				
				<cfif getItemQuery.user_in_charge NEQ user_id><!---El usuario del item no es el mismo que el que intenta eliminar--->
					<!---<cfset error_code = 103><!---Access denied--->
					<cfthrow errorcode="#error_code#">--->
					<cfinclude template="includes/checkAreaAdminAccess.cfm">
				</cfif>
				
				<cfif arguments.itemTypeId IS 7 AND getItemQuery.state NEQ "created"><!---Consultations--->
					<!---Las interconsultas solo se pueden eliminar si están en estado creadas (enviadas)--->
					<!---<cfset error_code = 103><!---Access denied--->
					<cfthrow errorcode="#error_code#">--->
					<!---Los administradores sí pueden borrar las interconsultas cuando borran un área--->
					<cfinclude template="includes/checkAreaAdminAccess.cfm">
				</cfif>
				
					
				<cfinvoke component="AreaItemManager" method="getItem" returnvariable="objectItem">
					<cfinvokeargument name="item_id" value="#arguments.item_id#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					<cfinvokeargument name="return_type" value="object">
				</cfinvoke>
				
				<!---Alert--->
				<cfinvoke component="AlertManager" method="newAreaItem">
					<cfinvokeargument name="objectItem" value="#objectItem#">
					<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					<cfinvokeargument name="action" value="delete">
				</cfinvoke>
					
							
				<cftransaction>
					
					<!--- CHANGE SUB ITEMS  --->
					<cfquery name="changeSubItemsQuery" datasource="#client_dsn#">
						UPDATE #client_abb#_#itemTypeTable#
						SET parent_id = #getItemQuery.parent_id#, 
						parent_kind = <cfqueryparam value="#getItemQuery.parent_kind#" cfsqltype="cf_sql_varchar">			
						WHERE parent_id = <cfqueryparam value="#getItemQuery.id#" cfsqltype="cf_sql_integer"> 
						AND parent_kind = <cfqueryparam value="item" cfsqltype="cf_sql_varchar">;
					</cfquery>
				
					<cfquery name="deleteItemQuery" datasource="#client_dsn#">	
						DELETE FROM #client_abb#_#itemTypeTable#
						WHERE id = <cfqueryparam value="#getItemQuery.id#" cfsqltype="cf_sql_integer">;
					</cfquery>
					
					<!--- DELETE SUB ITEMS  --->
					<!---Ya no se borran los submensajes de un mensaje, lo que se hace es que se ponen como hijos del nivel superior--->					
					
				
				</cftransaction>
				
					
				<!---DELETE ATTACHED_FILE FILE--->
				<cfif getItemQuery.attached_file_id NEQ "NULL" AND getItemQuery.attached_file_id NEQ "" AND getItemQuery.attached_file_id NEQ "-1">
				
					<cfinvoke component="FileManager" method="deleteFile" returnvariable="resultDeleteFile">
						<cfinvokeargument name="request" value='<request><parameters><file id="#getItemQuery.attached_file_id#"/></parameters></request>'>
					</cfinvoke>
					
					<cfxml variable="xmlResultDeleteFile">
						<cfoutput>
							#resultDeleteFile#
						</cfoutput>
					</cfxml>
					
					<cfif xmlResultDeleteFile.response.xmlAttributes.status NEQ "ok"><!---File delete failed--->
						<!--- RollBack the transaction --->
						<!---<cfquery name="rollBackTransaction" datasource="#client_dsn#">
							ROLLBACK;
						</cfquery>--->
						
						<cfset error_code = 605>
	
						<cfthrow errorcode="#error_code#">
					
					</cfif>
					
				</cfif>
				
				<cfif arguments.itemTypeId IS NOT 1>
				
					<!---DELETE ATTACHED_IMAGE FILE--->
					<cfif getItemQuery.attached_image_id NEQ "NULL" AND getItemQuery.attached_image_id NEQ "" AND getItemQuery.attached_image_id NEQ "-1">
					
						<cfinvoke component="FileManager" method="deleteFile" returnvariable="resultDeleteFile">
							<cfinvokeargument name="request" value='<request><parameters><file id="#getItemQuery.attached_image_id#"/></parameters></request>'>
						</cfinvoke>
						
						<cfxml variable="xmlResultDeleteFile">
							<cfoutput>
								#resultDeleteFile#
							</cfoutput>
						</cfxml>
						
						<cfif xmlResultDeleteFile.response.xmlAttributes.status NEQ "ok"><!---File delete failed--->
							<!--- RollBack the transaction --->
							<!---<cfquery name="rollBackTransaction" datasource="#client_dsn#">
								ROLLBACK;
							</cfquery>--->
							
							<cfset error_code = 605>
		
							<cfthrow errorcode="#error_code#">
						
						</cfif>
						
					</cfif>
					
				</cfif>

				
				<cfset xmlResponseContent = '<#itemTypeName# id="#arguments.item_id#"/>'>
				
			<cfelse><!---Item does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#">
					
			</cfif>	
			
						
		<cfreturn xmlResponseContent>
				
	</cffunction>
	<!--- ----------------------------------------------------------------------- --->
	
	
	
	<!--- ----------------------- DELETE ITEM ATTACHED FILE -------------------------------- --->
	
	<cffunction name="deleteItemAttachedFile" returntype="string" access="public">
		<cfargument name="item_id" type="string" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfset var method = "deleteItemAttachedFile">
		
		<cfset var area_id = "">
		<cfset var area_type = "">
						
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
					
			<cfquery name="getItemQuery" datasource="#client_dsn#">		
				SELECT id,parent_kind,parent_id,attached_file_id,area_id,user_in_charge
				FROM #client_abb#_#itemTypeTable#
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;		
			</cfquery>
			
			
			<cfif getItemQuery.recordCount GT 0>
				
				<!---checkAreaAccess--->
				<cfset area_id = getItemQuery.area_id>
				
				<cfinclude template="includes/checkAreaAccess.cfm">
				
				<cfif getItemQuery.user_in_charge NEQ user_id><!---El usuario del item no es el mismo que intenta modificar--->
					
					<cfinvoke component="AreaManager" method="getAreaType" returnvariable="areaTypeResult">				
						<cfinvokeargument name="area_id" value="#area_id#">
					</cfinvoke>
				
					<cfset area_type = areaTypeResult.areaType>
					
					<!---Si el área es web o intranet, los items pueden modificarlos todos los que tengan acceso a ese área--->
					<cfif area_type NEQ "web" AND area_type NEQ "intranet">
					
						<cfset error_code = 103><!---Access denied--->
							
						<cfthrow errorcode="#error_code#">
						
					</cfif>
				</cfif>					
				
				
				<!--- DELETE IN DB  --->
				<cfquery name="deleteAttachedFile" datasource="#client_dsn#">
					UPDATE #client_abb#_#itemTypeTable#
					SET	attached_file_name = <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
					attached_file_id = <cfqueryparam cfsqltype="cf_sql_integer" null="yes">
					WHERE id = <cfqueryparam value="#getItemQuery.id#" cfsqltype="cf_sql_integer">;
				</cfquery>
				
					
				<!---DELETE ATTACHED_FILE FILE--->
				<cfif getItemQuery.attached_file_id NEQ "NULL" AND getItemQuery.attached_file_id NEQ "" AND getItemQuery.attached_file_id NEQ "-1">
				
					<cfinvoke component="FileManager" method="deleteFile" returnvariable="resultDeleteFile">
						<cfinvokeargument name="request" value='<request><parameters><file id="#getItemQuery.attached_file_id#"/></parameters></request>'>
					</cfinvoke>
					
					<cfxml variable="xmlResultDeleteFile">
						<cfoutput>
							#resultDeleteFile#
						</cfoutput>
					</cfxml>
					
					<cfif xmlResultDeleteFile.response.xmlAttributes.status NEQ "ok"><!---File delete failed--->
						<cfset error_code = 605>
	
						<cfthrow errorcode="#error_code#">
					
					</cfif>
					
				<cfelse>
				
					<cfset error_code = 601>
	
					<cfthrow errorcode="#error_code#">
					
				</cfif>
				
				<cfset xmlResponseContent = '<#itemTypeName# id="#arguments.item_id#"/>'>
				
			<cfelse><!---Item does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#">
					
			</cfif>	
			
						
		<cfreturn xmlResponseContent>
				
	</cffunction>
	<!--- ---------------------------------------------------------------------------------- --->
	
	
	
	
	<!--- ----------------------- DELETE ITEM ATTACHED IMAGE -------------------------------- --->
	
	<cffunction name="deleteItemAttachedImage" returntype="string" access="public">
		<cfargument name="item_id" type="string" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		
		<cfset var method = "deleteItemAttachedImage">
		
		<cfset var area_id = "">
		<cfset var area_type = "">
						
			<cfinclude template="includes/functionStart.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
		
			<cfquery name="getItemQuery" datasource="#client_dsn#">		
				SELECT id,parent_kind,parent_id,attached_image_id,area_id,user_in_charge
				FROM #client_abb#_#itemTypeTable#
				WHERE id = <cfqueryparam value="#arguments.item_id#" cfsqltype="cf_sql_integer">;		
			</cfquery>
			
			
			<cfif getItemQuery.recordCount GT 0>
				
				<!---checkAreaAccess--->
				<cfset area_id = getItemQuery.area_id>
				
				<cfinclude template="includes/checkAreaAccess.cfm">
				
				<cfif getItemQuery.user_in_charge NEQ user_id><!---El usuario del item no es el mismo que intenta modificar--->
					
					<cfinvoke component="AreaManager" method="getAreaType" returnvariable="areaTypeResult">				
						<cfinvokeargument name="area_id" value="#area_id#">
					</cfinvoke>
				
					<cfset area_type = areaTypeResult.areaType>
					
					<!---Si el área es web o intranet, los items pueden modificarlos todos los que tengan acceso a ese área--->
					<cfif area_type NEQ "web" AND area_type NEQ "intranet">
					
						<cfset error_code = 103><!---Access denied--->
							
						<cfthrow errorcode="#error_code#">
						
					</cfif>
				</cfif>		
				
				
				<!--- DELETE IN DB  --->
				<cfquery name="deleteAttachedFile" datasource="#client_dsn#">
					UPDATE #client_abb#_#itemTypeTable#
					SET	attached_image_name = <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
					attached_image_id = <cfqueryparam cfsqltype="cf_sql_integer" null="yes">
					WHERE id = <cfqueryparam value="#getItemQuery.id#" cfsqltype="cf_sql_integer">;
				</cfquery>
				
					
				<!---DELETE ATTACHED_IMAGE FILE--->
				<cfif getItemQuery.attached_image_id NEQ "NULL" AND getItemQuery.attached_image_id NEQ "" AND getItemQuery.attached_image_id NEQ "-1">
				
					<cfinvoke component="FileManager" method="deleteFile" returnvariable="resultDeleteFile">
						<cfinvokeargument name="request" value='<request><parameters><file id="#getItemQuery.attached_image_id#"/></parameters></request>'>
					</cfinvoke>
					
					<cfxml variable="xmlResultDeleteFile">
						<cfoutput>
							#resultDeleteFile#
						</cfoutput>
					</cfxml>
					
					<cfif xmlResultDeleteFile.response.xmlAttributes.status NEQ "ok"><!---File delete failed--->
						<cfset error_code = 605>
	
						<cfthrow errorcode="#error_code#">
					
					</cfif>
					
				<cfelse>
				
					<cfset error_code = 601>
	
					<cfthrow errorcode="#error_code#">
					
				</cfif>
				
				<cfset xmlResponseContent = '<#itemTypeName# id="#arguments.item_id#"/>'>
				
			<cfelse><!---Item does not exist--->
			
				<cfset error_code = 501>
			
				<cfthrow errorcode="#error_code#">
					
			</cfif>	
			
						
		<cfreturn xmlResponseContent>
				
	</cffunction>
	<!--- ---------------------------------------------------------------------------------- --->
	
	
	
	
	<!--- ------------------------- GET SUB ITEMS ------------------------------------------ --->
	<cffunction name="getSubItems" returntype="string" access="public">
		<cfargument name="item_id" type="String" required="yes">	
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="listFormat" type="boolean" required="yes">
		<cfargument name="format_content" type="string" required="no" default="default"><!---default/all--->
		
		<cfset var method = "getSubItems">
		
		
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			
			<cfquery name="getSubItemsQuery" datasource="#client_dsn#" result="result">
				SELECT items.id, title, user_in_charge, attached_file_name, attached_file_id, family_name, items.creation_date AS item_creation_date, users.name AS user_name, users.image_type AS user_image_type
				<cfif arguments.itemTypeId NEQ 1>
				, attached_image_id
				</cfif>
				<cfif arguments.itemTypeId IS 7><!---Consultations--->
				, state, identifier
				</cfif>
				<cfif arguments.format_content EQ "ALL">
				, parent_id, parent_kind, description
				</cfif>
				FROM #client_abb#_#itemTypeTable# AS items, #client_abb#_users AS users
				WHERE parent_id=<cfqueryparam value = "#item_id#" CFSQLType = "CF_SQL_Integer">  
				AND items.user_in_charge = users.id
				AND items.parent_kind='#itemTypeName#' 
				AND items.status='ok'
				ORDER BY items.creation_date DESC;
			</cfquery>			
			
			<cfif getSubItemsQuery.recordCount GT 0>
				<cfset xmlObject=''>
						
						<cfloop query="getSubItemsQuery">	
					
							
							<!--- TREE FORMAT --->
							<cfif listFormat NEQ true>							
								<cfinvoke component="AreaItemManager" method="getSubItems" returnvariable="resultSubItems">
									<cfinvokeargument name="item_id" value="#getSubItemsQuery.id#">
									<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
									<cfinvokeargument name="listFormat" value="#listFormat#">
									<cfinvokeargument name="format_content" value="#format_content#">
								</cfinvoke>
								
							<cfelse>
							
								<cfset resultSubItems = "">
	
							</cfif>	
							
							<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="xmlResultItem">
								<cfinvokeargument name="id" value="#getSubItemsQuery.id#">
								<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
								<cfinvokeargument name="title" value="#getSubItemsQuery.title#">
								<cfinvokeargument name="user_in_charge" value="#getSubItemsQuery.user_in_charge#">
								<cfinvokeargument name="creation_date" value="#getSubItemsQuery.item_creation_date#">
								<cfinvokeargument name="attached_file_name" value="#getSubItemsQuery.attached_file_name#">
								<cfinvokeargument name="attached_file_id" value="#getSubItemsQuery.attached_file_id#">
								<cfif arguments.itemTypeId NEQ 1>
									<cfinvokeargument name="attached_image_id" value="#getSubItemsQuery.attached_image_id#">
								</cfif>
								<cfinvokeargument name="user_full_name" value="#getSubItemsQuery.family_name# #getSubItemsQuery.user_name#">
								<cfinvokeargument name="user_image_type" value="#getSubItemsQuery.user_image_type#">
								
								<cfif arguments.itemTypeId IS 7><!---Consultations--->
									<cfinvokeargument name="state" value="#getSubItemsQuery.state#">
									<cfinvokeargument name="identifier" value="#getSubItemsQuery.identifier#">
								</cfif>
												
								<cfif format_content EQ "all">
									<!---<cfinvokeargument name="area_name" value="#getSubItemsQuery.area_name#">--->
									<cfinvokeargument name="parent_id" value="#getSubItemsQuery.parent_id#">
									<cfinvokeargument name="parent_kind" value="#getSubItemsQuery.parent_kind#">
									<cfinvokeargument name="description" value="#getSubItemsQuery.description#">
								</cfif> 
								
								<cfif listFormat NEQ true>
									<cfinvokeargument name="sub_items" value="#resultSubItems#">
								</cfif>
								
								<cfinvokeargument name="tree_mode" value="true"><!---Esto hace que se pasen los elementos del mensaje como atributos--->
																
								<cfinvokeargument name="return_type" value="xml">
							</cfinvoke>
							
							<cfset xmlObject = xmlObject&xmlResultItem>
							
							<cfif listFormat EQ true>
								<cfinvoke component="AreaItemManager" method="getSubItems" returnvariable="resultSubItems">
									<cfinvokeargument name="item_id" value="#getSubItemsQuery.id#">
									<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
									<cfinvokeargument name="listFormat" value="#listFormat#">
									<cfinvokeargument name="format_content" value="#format_content#">
								</cfinvoke>

								<cfset xmlObject = xmlObject&resultSubItems>
							</cfif>				
							
						</cfloop>
										
				<cfelse>
					<cfset xmlObject=''>
			</cfif>
								
			<cfreturn "#xmlObject#">
	
	</cffunction>
	<!--- -----------------------------------------------------------------------------------------  --->
	
	
	
	<!--- ------------------------- GET SUB ITEMS ARRAY ------------------------------------------ --->
	<cffunction name="getSubItemsArray" returntype="array" access="public">
		<cfargument name="item_id" type="String" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">	
		<cfargument name="format_content" type="string" required="no" default="default">
		<cfargument name="arrayItems" type="array" required="yes">
		<cfargument name="order_by" type="string" required="yes">
		<cfargument name="order_type" type="string" required="yes"> 
		
		<cfset var method = "getSubItemsArray">
		
		<cfset var arrayItemsUpdated = arrayNew(1)>
		
		
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfquery name="getSubItemsQuery" datasource="#client_dsn#" result="result">
				SELECT items.id, title, user_in_charge, attached_file_name, family_name, users.name AS user_name, items.creation_date AS item_creation_date, UNIX_TIMESTAMP(items.creation_date) AS creation_date_epoch
				<cfif arguments.format_content EQ "ALL">
				attached_file_id, parent_id, parent_kind, description
				</cfif>
				FROM #client_abb#_#itemTypeTable# AS items, #client_abb#_users AS users
				WHERE parent_id=<cfqueryPARAM value = "#item_id#" CFSQLType = "CF_SQL_Integer">  
				AND items.user_in_charge = users.id
				AND items.parent_kind='item' 
				AND items.status='ok'
				ORDER BY #arguments.order_by# #arguments.order_type#;
			</cfquery>			
			
			<cfif getSubItemsQuery.recordCount GT 0>

						<cfloop query="getSubItemsQuery">	
				
							<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="objectResultItem">
								<cfinvokeargument name="id" value="#getSubItemsQuery.id#">
								<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
								<cfinvokeargument name="title" value="#getSubItemsQuery.title#">
								<cfinvokeargument name="user_in_charge" value="#getSubItemsQuery.user_in_charge#">
								<cfinvokeargument name="creation_date" value="#getSubItemsQuery.item_creation_date#">
								<cfinvokeargument name="attached_file_name" value="#getSubItemsQuery.attached_file_name#">
								<cfinvokeargument name="user_full_name" value="#getSubItemsQuery.family_name# #getSubItemsQuery.user_name#">
												
								<cfif format_content EQ "all">
									<cfinvokeargument name="attached_file_id" value="#getSubItemsQuery.attached_file_id#">
									<!---<cfinvokeargument name="item_read" value="#getSubItemsQuery.item_read#">--->
									<!---<cfinvokeargument name="area_name" value="#getSubItemsQuery.area_name#">--->
									<cfinvokeargument name="parent_id" value="#getSubItemsQuery.parent_id#">
									<cfinvokeargument name="parent_kind" value="#getSubItemsQuery.parent_kind#">
									<cfinvokeargument name="description" value="#getSubItemsQuery.description#">
								</cfif> 
								
								<cfinvokeargument name="tree_mode" value="true"><!---Esto hace que se pasen los elementos del mensaje como atributos--->
								<cfinvokeargument name="return_type" value="object">
							</cfinvoke>
							
							<cfset objectResultItem.creation_date_epoch = getSubItemsQuery.creation_date_epoch>
							
							<cfset ArrayAppend(arguments.arrayItems, objectResultItem)>
							
							
							<cfinvoke component="AreaItemManager" method="getSubItemsArray" returnvariable="arrayItemsUpdated">
								<cfinvokeargument name="item_id" value="#getSubItemsQuery.id#">
								<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
								<cfinvokeargument name="format_content" value="#format_content#">
								<cfinvokeargument name="arrayItems" value="#arguments.arrayItems#">
								<cfinvokeargument name="order_by" value="#arguments.order_by#">
								<cfinvokeargument name="order_type" value="#arguments.order_type#">
							</cfinvoke>
							
							<cfset arguments.arrayItems = arrayItemsUpdated>
							
						</cfloop>
						
				

			</cfif>
								
			<cfreturn arguments.arrayItems>		
	
	</cffunction>
	<!--- -----------------------------------------------------------------------------------------  --->
	
	
	
	<!--- ----------------GET AREA ITEMS--------------------------------------------   --->
	<!---A esta función siempre la llama otra funcion de ColdFusion, por lo que no tiene que tener try catch, ya que la otra fucion que llame a esta lo tendrá.--->
	
	<cffunction name="getAreaItems" output="false" returntype="string" access="public">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="recipient_user" type="numeric" required="no">
		<cfargument name="listFormat" type="boolean" required="yes">
		<cfargument name="format_content" type="string" required="no" default="default"><!---default/all--->
		<cfargument name="limit" type="numeric" required="no">
		<cfargument name="done" type="boolean" required="no">
		
		<cfset var method = "getAreaItems">
		<cfset var areaItemsQuery = "">
				
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
						
			<!---checkAreaAccess--->
			<cfinclude template="includes/checkAreaAccess.cfm">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getAreaItems" returnvariable="getAreaItemsResult">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfif isDefined("arguments.user_in_charge")>
					<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
				</cfif>
				<cfif isDefined("arguments.recipient_user")>
					<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
				</cfif>
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="listFormat" value="#arguments.listFormat#">
				<cfinvokeargument name="format_content" value="#arguments.format_content#">
				<cfinvokeargument name="with_user" value="true">
				<cfif isDefined("arguments.limit")>
					<cfinvokeargument name="limit" value="#arguments.limit#">
				</cfif>
				<cfif isDefined("arguments.done")>
				<cfinvokeargument name="done" value="#arguments.done#">
				</cfif>				
				
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfset areaItemsQuery = getAreaItemsResult.query>
			
			<cfset xmlItems=''>
			<cfif areaItemsQuery.recordCount GT 0>
					
					<cfset xmlItems = '<#itemTypeNameP#>'>
						
						<cfloop query="areaItemsQuery">																		
							
							<!--- TREE FORMAT --->
							<cfif arguments.listFormat NEQ true>							
								<cfinvoke component="AreaItemManager" method="getSubItems" returnvariable="resultSubItems">
									<cfinvokeargument name="item_id" value="#areaItemsQuery.id#">
									<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
									<cfinvokeargument name="listFormat" value="#listFormat#">
									<cfinvokeargument name="format_content" value="#format_content#">
								</cfinvoke>
							</cfif>	
							
							<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="xmlResultItem">
								<cfinvokeargument name="id" value="#areaItemsQuery.id#">
								<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
								<cfinvokeargument name="title" value="#areaItemsQuery.title#">
								<cfinvokeargument name="user_in_charge" value="#areaItemsQuery.user_in_charge#">
								<cfinvokeargument name="creation_date" value="#areaItemsQuery.creation_date#">
								<cfinvokeargument name="attached_file_name" value="#areaItemsQuery.attached_file_name#">
								<cfinvokeargument name="attached_file_id" value="#areaItemsQuery.attached_file_id#">
								<cfif arguments.itemTypeId IS NOT 1>
									<cfinvokeargument name="attached_image_id" value="#areaItemsQuery.attached_image_id#">
								</cfif>
								<cfinvokeargument name="user_full_name" value="#areaItemsQuery.family_name# #areaItemsQuery.user_name#">
								<cfinvokeargument name="user_image_type" value="#areaItemsQuery.user_image_type#">
								<cfif arguments.itemTypeId IS 5 OR arguments.itemTypeId IS 6><!---Events OR Tasks--->
									<cfinvokeargument name="start_date" value="#areaItemsQuery.start_date#">
									<cfinvokeargument name="end_date" value="#areaItemsQuery.end_date#">
								</cfif>
								<cfif arguments.itemTypeId IS 6><!---Tasks--->
									<cfinvokeargument name="recipient_user_full_name" value="#areaItemsQuery.recipient_user_family_name# #areaItemsQuery.recipient_user_name#">
									<cfinvokeargument name="done" value="#areaItemsQuery.done#">
									<cfinvokeargument name="estimated_value" value="#areaItemsQuery.estimated_value#">
									<cfinvokeargument name="real_value" value="#areaItemsQuery.real_value#">
								</cfif>
								<cfif arguments.itemTypeId IS 2 OR arguments.itemTypeId IS 3 OR arguments.itemTypeId IS 4>
									<cfinvokeargument name="position" value="#areaItemsQuery.position#">
								</cfif>
								<cfif arguments.itemTypeId IS 7><!---Consultations--->	
									<cfinvokeargument name="state" value="#areaItemsQuery.state#">
									<cfinvokeargument name="identifier" value="#areaItemsQuery.identifier#">
								</cfif>
								<cfif format_content EQ "all">
									<cfinvokeargument name="parent_id" value="#areaItemsQuery.parent_id#">
									<cfinvokeargument name="parent_kind" value="#areaItemsQuery.parent_kind#">
									<cfinvokeargument name="description" value="#areaItemsQuery.description#">						
								</cfif> 

								<cfif listFormat NEQ true>
									<cfinvokeargument name="sub_items" value="#resultSubItems#">
								</cfif>
								
								<cfinvokeargument name="tree_mode" value="true"><!---Esto hace que se pasen los elementos del mensaje como atributos--->
								<cfinvokeargument name="return_type" value="xml">
							</cfinvoke>
							
							<cfset xmlItems = xmlItems&xmlResultItem>
							
						</cfloop>
						

				<cfset xmlItems = xmlItems&'</#itemTypeNameP#>'>

			<cfelse>	
				<cfset xmlItems='<#itemTypeNameP#/>'>	
			</cfif>			
						
			<cfset xmlResponseContent = xmlItems>
		
			<!---<cfinclude template="includes/functionEndNoLog.cfm">--->
			
			<cfset xmlResponse = xmlResponseContent>
		
		<cfreturn xmlResponse>
			
	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->
	
	
	
	
	<!--- ------------------------GET ALL AREAS ITEMS-----------------------------------   --->
	
	<cffunction name="getAllAreasItems" output="false" returntype="struct" access="public">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="search_text" type="string" required="no">
		<cfargument name="user_in_charge" type="numeric" required="no">
		<cfargument name="recipient_user" type="numeric" required="no">
		<cfargument name="format_content" type="string" required="no" default="default">
		<cfargument name="with_area" type="boolean" required="no" default="false">
		<cfargument name="limit" type="numeric" required="no">
		<cfargument name="done" type="numeric" required="no">
		<cfargument name="state" type="string" required="no">
		<cfargument name="from_date" type="string" required="no">
		<cfargument name="end_date" type="string" required="no">
		
		<cfset var method = "getAllAreasItems">

		<cfset var response = structNew()>
		<cfset var areaItemsQuery = "">

		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">
			
			<cfinvoke component="AreaManager" method="getAllUserAreasList" returnvariable="user_areas_ids">
				<cfinvokeargument name="get_user_id" value="#user_id#">
			</cfinvoke>
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="getAreaItems" returnvariable="getAreaItemsResult">
				<cfinvokeargument name="areas_ids" value="#user_areas_ids#">
				<cfif isDefined("arguments.search_text")>
					<cfinvokeargument name="search_text" value="#arguments.search_text#">
				</cfif>
				<cfif isDefined("arguments.user_in_charge")>
					<cfinvokeargument name="user_in_charge" value="#arguments.user_in_charge#">
				</cfif>
				<cfif isDefined("arguments.recipient_user")>
					<cfinvokeargument name="recipient_user" value="#arguments.recipient_user#">
				</cfif>
				<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
				<cfinvokeargument name="listFormat" value="true">
				<cfinvokeargument name="format_content" value="#arguments.format_content#">
				<cfinvokeargument name="with_user" value="true">
				<cfinvokeargument name="with_area" value="#arguments.with_area#">
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
				
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>
			
			<cfset areaItemsQuery = getAreaItemsResult.query>
			
			<cfset xmlItems=''>
			<cfif areaItemsQuery.recordCount GT 0>
					
					<cfset xmlItems = '<#itemTypeNameP#>'>
						
						<cfloop query="areaItemsQuery">																		
							
							<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="xmlResultItem">
								<cfinvokeargument name="id" value="#areaItemsQuery.id#">
								<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
								<cfinvokeargument name="title" value="#areaItemsQuery.title#">
								<cfinvokeargument name="user_in_charge" value="#areaItemsQuery.user_in_charge#">
								<cfinvokeargument name="creation_date" value="#areaItemsQuery.creation_date#">
								<cfinvokeargument name="attached_file_name" value="#areaItemsQuery.attached_file_name#">
								<cfinvokeargument name="attached_file_id" value="#areaItemsQuery.attached_file_id#">
								<cfif arguments.itemTypeId IS NOT 1>
									<cfinvokeargument name="attached_image_id" value="#areaItemsQuery.attached_image_id#">
								</cfif>
								<cfinvokeargument name="user_full_name" value="#areaItemsQuery.family_name# #areaItemsQuery.user_name#">
								<cfinvokeargument name="user_image_type" value="#areaItemsQuery.user_image_type#">
								<cfif arguments.itemTypeId IS 5 OR arguments.itemTypeId IS 6><!---Events OR Tasks--->
									<cfinvokeargument name="start_date" value="#areaItemsQuery.start_date#">
									<cfinvokeargument name="end_date" value="#areaItemsQuery.end_date#">
								</cfif>
								<cfif arguments.itemTypeId IS 6><!---Tasks--->
									<cfinvokeargument name="recipient_user_full_name" value="#areaItemsQuery.recipient_user_family_name# #areaItemsQuery.recipient_user_name#">
									<cfinvokeargument name="done" value="#areaItemsQuery.done#">
									<cfinvokeargument name="estimated_value" value="#areaItemsQuery.estimated_value#">
									<cfinvokeargument name="real_value" value="#areaItemsQuery.real_value#">
									<cfinvokeargument name="end_date" value="#areaItemsQuery.end_date#">
								</cfif>
								<cfif arguments.itemTypeId IS 7><!---Consultations--->
									<cfinvokeargument name="state" value="#areaItemsQuery.state#">
									<cfinvokeargument name="identifier" value="#areaItemsQuery.identifier#">
								</cfif>
												
								<cfif format_content EQ "all">
									<!---<cfinvokeargument name="area_name" value="#areaItemsQuery.area_name#">--->
									<cfinvokeargument name="parent_id" value="#areaItemsQuery.parent_id#">
									<cfinvokeargument name="parent_kind" value="#areaItemsQuery.parent_kind#">
									<cfinvokeargument name="description" value="#areaItemsQuery.description#">	
								</cfif> 
								
								<cfif arguments.with_area IS true>
									<cfinvokeargument name="area_name" value="#areaItemsQuery.area_name#">
									<cfinvokeargument name="area_id" value="#areaItemsQuery.area_id#">	
								</cfif>

								<cfinvokeargument name="tree_mode" value="true"><!---Esto hace que se pasen los elementos del mensaje como atributos--->
								<cfinvokeargument name="return_type" value="xml">
							</cfinvoke>
							
							<cfset xmlItems = xmlItems&xmlResultItem>
							
						</cfloop>
						

				<cfset xmlItems = xmlItems&'</#itemTypeNameP#>'>

			<cfelse>	
				<cfset xmlItems='<#itemTypeNameP#/>'>	
			</cfif>			
						
			<cfset response = {result="true", message="", itemsXml=#xmlItems#}>
		
			<cfcatch>

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>

		<cfreturn response>
			
	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->
	
	
	
	
	<!--- ----------------GET ALL AREA ITEMS--------------------------------------------   --->
	<!---A esta función siempre la llama otra funcion de ColdFusion, por lo que no tiene que tener try catch, ya que la otra fucion que llame a esta lo tendrá.--->
	
	<cffunction name="getAllAreaItems" output="false" returntype="struct" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="area_type" type="string" required="yes">
		<cfargument name="limit" type="numeric" required="no">
		
		<cfset var method = "getAllAreaItems">

		<cfset var response = structNew()>

		<cftry>
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<!---checkAreaAccess--->
			<cfinclude template="includes/checkAreaAccess.cfm">
			
			<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemQuery" method="listAllAreaItems" returnvariable="getAreaItemsResult">
				<cfinvokeargument name="area_id" value="#arguments.area_id#">
				<cfinvokeargument name="area_type" value="#arguments.area_type#">
				<cfif isDefined("arguments.limit")>
				<cfinvokeargument name="limit" value="#arguments.limit#">
				</cfif>
				
				<cfinvokeargument name="client_abb" value="#client_abb#">
				<cfinvokeargument name="client_dsn" value="#client_dsn#">
			</cfinvoke>	

			<cfset response = {result="true", message="", query=#getAreaItemsResult.query#}>

			<cfcatch>
				<!--- <cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn xmlResponse> --->

				<cfinclude template="includes/errorHandlerStruct.cfm">

			</cfcatch>
		</cftry>
			
		<cfreturn response>
			
	</cffunction>
	<!--- ------------------------------------------------------------------------------  --->
	
	
	
	
	
	<!--- ----------------GET AREA ITEMS ORDERLY--------------------------------------------   --->
	<!---A esta función siempre la llama otra funcion de ColdFusion, por lo que no tiene que tener try catch, ya que la otra fucion que llame a esta lo tendrá.--->
	
	<!---<cffunction name="getAreaItemsListOrderly" output="false" returntype="string" access="public">
		<cfargument name="area_id" type="numeric" required="yes">
		<cfargument name="itemTypeId" type="numeric" required="yes">
		<cfargument name="format_content" type="string" default="default">
		
		<cfset var method = "getAreaItemsListOrderly">
		
		<cfset var arrayItems = arrayNew(1)>
		<cfset var arrayItemsUpdated = arrayNew(1)>
		
		<cfset order_by = "creation_date_epoch">
		<cfset order_type = "desc">
		<cfset order_data = "numeric">
		
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<cfinclude template="#APPLICATION.corePath#/includes/areaItemTypeSwitch.cfm">	
			
			<!---checkAreaAccess--->
			<cfinclude template="includes/checkAreaAccess.cfm">
		
		
			<cfquery name="areaItemsQuery" datasource="#client_dsn#" result="queryResult">
				SELECT items.id, items.title, items.user_in_charge, users.family_name, items.attached_file_name, items.attached_file_id, users.family_name, users.name AS user_name, items.creation_date AS item_creation_date, UNIX_TIMESTAMP(items.creation_date) AS creation_date_epoch
				<cfif format_content EQ "all">
				<!---, items.item_read--->, items.parent_id, items.parent_kind, items.description
				</cfif>
				FROM #client_abb#_#itemTypeTable# AS items, #client_abb#_users AS users 
				WHERE parent_id=<cfqueryPARAM value = "#arguments.area_id#" CFSQLType = "CF_SQL_Integer"> 
				AND items.user_in_charge = users.id 
				AND parent_kind='area' AND status='ok'
				ORDER BY #order_by# #order_type#;
			</cfquery>	
			
			<cfif areaItemsQuery.recordCount GT 0>
						
				<cfloop query="areaItemsQuery">																		
					
					<cfinvoke component="AreaItemManager" method="objectItem" returnvariable="objectResultItem">
						<cfinvokeargument name="id" value="#areaItemsQuery.id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="title" value="#areaItemsQuery.title#">
						<cfinvokeargument name="user_in_charge" value="#areaItemsQuery.user_in_charge#">
						<cfinvokeargument name="creation_date" value="#areaItemsQuery.item_creation_date#">
						<cfinvokeargument name="attached_file_name" value="#areaItemsQuery.attached_file_name#">
						<cfinvokeargument name="attached_file_id" value="#areaItemsQuery.attached_file_id#">
						<cfinvokeargument name="user_full_name" value="#areaItemsQuery.family_name# #areaItemsQuery.user_name#">
										
						<cfif format_content EQ "all">
							<cfinvokeargument name="attached_file_id" value="#areaItemsQuery.attached_file_id#">
							<!---<cfinvokeargument name="area_name" value="#areaItemsQuery.area_name#">--->
							<cfinvokeargument name="parent_id" value="#areaItemsQuery.parent_id#">
							<cfinvokeargument name="parent_kind" value="#areaItemsQuery.parent_kind#">
							<cfinvokeargument name="description" value="#areaItemsQuery.description#">
						</cfif> 
						
						<cfinvokeargument name="tree_mode" value="true"><!---Esto hace que se pasen los elementos del mensaje como atributos--->
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>
					
					<cfset objectResultItem.creation_date_epoch = areaItemsQuery.creation_date_epoch>
					
					<cfset arrayAppend(arrayItems, objectResultItem)>
					
					<cfinvoke component="AreaItemManager" method="getSubItemsArray" returnvariable="arrayItemsUpdated">
						<cfinvokeargument name="item_id" value="#areaItemsQuery.id#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
						<cfinvokeargument name="format_content" value="#format_content#">
						<cfinvokeargument name="arrayItems" value="#arrayItems#">
						<cfinvokeargument name="order_by" value="#order_by#">
						<cfinvokeargument name="order_type" value="#order_type#">
					</cfinvoke>
					
					<cfset arrayItems = arrayItemsUpdated>
					
				</cfloop>
						
			</cfif>			
			
			<cfset xmlItems = '<#itemTypeNameP# title="#itemTypeNameP#">'>
			
			<cfif arrayLen(arrayItems) GT 0>
				
				<cfset arrayItems = arrayOfStructsSort(arrayItems, "#order_by#", "#order_type#", "#order_data#")>
				
				<cfloop index="arrItem" array="#arrayItems#">
					
					<cfinvoke component="AreaItemManager" method="xmlItem" returnvariable="xmlResultItem">
						<cfinvokeargument name="objectItem" value="#arrItem#">
						<cfinvokeargument name="itemTypeId" value="#arguments.itemTypeId#">
					</cfinvoke>
					
					<cfset xmlItems = xmlItems&xmlResultItem>
					
				</cfloop>
			</cfif>		
			
			<cfset xmlItems = xmlItems&'</#itemTypeNameP#>'>
			
			<!---<cfinclude template="includes/functionEndNoLog.cfm">--->
			
			<cfset xmlResponse = xmlItems>
		
		<cfreturn xmlResponse>
			
	</cffunction>--->
	<!--- ------------------------------------------------------------------------------  --->
	

</cfcomponent>