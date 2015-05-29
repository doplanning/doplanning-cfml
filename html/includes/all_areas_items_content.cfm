<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

<cfoutput>
<!--- 
<script src="#APPLICATION.htmlPath#/language/area_item_en.js" charset="utf-8"></script>
 --->

<cfinclude template="#APPLICATION.htmlPath#/includes/tablesorter_scripts.cfm">

</cfoutput>


<!---<div class="div_head_title">
<cfoutput>
<div class="icon_title">
<a href="all_#lCase(itemTypeNameP)#.cfm"><img src="assets/icons/#lCase(itemTypeNameP)#.png" alt="#itemTypeNameEsP#"/></a>
</div>
<div class="head_title" style="padding-top:4px;"><a href="all_#itemTypeNameP#.cfm"><cfif itemTypeGender EQ "male">Todos los<cfelse>Todas las</cfif> #itemTypeNameEsP#</a></div>
</cfoutput>
</div>--->


<cfinclude template="#APPLICATION.htmlPath#/includes/search_2_bar.cfm">

<cfif isDefined("URL.search")>

	<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="getAllAreasItems" returnvariable="getAllAreasItemsResponse">
		<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
		<cfif len(search_text) GT 0>
		<cfinvokeargument name="search_text" value="#search_text#">	
		</cfif>
		<cfif isNumeric(user_in_charge)>
		<cfinvokeargument name="user_in_charge" value="#user_in_charge#">
		</cfif>
		<cfif itemTypeId IS 6><!---Tasks--->
			<cfif isNumeric(recipient_user)>
				<cfinvokeargument name="recipient_user" value="#recipient_user#">
			</cfif>
			<cfif isNumeric(is_done)>
				<cfinvokeargument name="done" value="#is_done#">
			</cfif>
		</cfif>
		<cfif itemTypeId IS 7><!---Consultations--->
			<cfif len(cur_state) GT 0>
				<cfinvokeargument name="state" value="#cur_state#">
			</cfif>
		</cfif>
		<cfif isNumeric(limit_to)>
		<cfinvokeargument name="limit" value="#limit_to#">
		</cfif>
		
		<cfif len(from_date) GT 0>
			<cfinvokeargument name="from_date" value="#from_date#">
		</cfif>		
		
		<cfif len(end_date) GT 0>
			<cfinvokeargument name="end_date" value="#end_date#">
		</cfif>

		<cfif len(identifier) GT 0>
			<cfinvokeargument name="identifier" value="#identifier#">
		</cfif>

		
	</cfinvoke>
	
	<cfset areaItemsQuery = getAllAreasItemsResponse.query>

	<cfset numItems = areaItemsQuery.recordCount>
	<cfif numItems GT 0>
		<cfoutput>
		<div class="div_search_results_text" style="margin-bottom:5px; margin-top:5px;"><span lang="es">Resultado:</span> #numItems# <span lang="es"><cfif numItems GT 1>#itemTypeNameEsP#<cfelse>#itemTypeNameEs#</cfif></span></div>
		</cfoutput>
		<div class="div_items">
		
		<!---<cfif itemTypeId IS NOT 6>
			<cfset current_url = "#lCase(itemTypeNameP)#_search.cfm?from_user=#user_in_charge#&limit=#limit_to#">
		<cfelse>
			<cfset current_url = "#lCase(itemTypeNameP)#_search.cfm?from_user=#user_in_charge#&to_user=#recipient_user#&limit=#limit_to#">
		</cfif>--->
		
		<cfif itemTypeId IS 7><!---Consultations--->

			<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="outputConsultationsList">
				<cfinvokeargument name="itemsQuery" value="#areaItemsQuery#">
				<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
				<cfinvokeargument name="full_content" value="true">
				<cfinvokeargument name="app_version" value="html2">
			</cfinvoke>

		<cfelseif itemTypeId IS 11 OR itemTypeId IS 12><!--- List AND Forms --->

			<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="outputTablesList">
				<cfinvokeargument name="itemsQuery" value="#areaItemsQuery#">
				<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
				<cfinvokeargument name="full_content" value="true">
				<cfinvokeargument name="app_version" value="html2">
			</cfinvoke>
	
		<cfelse>
		
			<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="outputItemsList">
				<cfinvokeargument name="itemsQuery" value="#areaItemsQuery#">
				<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
				<cfinvokeargument name="full_content" value="true">
				<cfinvokeargument name="app_version" value="html2">
			</cfinvoke>
		
		</cfif>
		
		</div>
	<cfelse>
		
		<script>
			openUrlHtml2('empty.cfm','itemIframe');
		</script>			
	
		<div class="div_items">
		<cfoutput>
		<div class="div_text_result"><span lang="es">No se han encontrado #lCase(itemTypeNameEsP)#.</span></div>
		</cfoutput>
		</div>
	</cfif>

<cfelse>

	<script type="text/javascript">
		openUrlHtml2('empty.cfm','itemIframe');
	</script>
	
	<div class="alert" style="margin:10px;margin-top:30px;background-color:#65C5BD"><i class="icon-info-sign"></i>&nbsp;<span lang="es">Rellene el formulario y haga click en BUSCAR</span></div>

</cfif>

<!---<cfset return_page = "index.cfm">
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Interface" method="returnElement">
	<cfinvokeargument name="return_page" value="#return_page#">
</cfinvoke>--->