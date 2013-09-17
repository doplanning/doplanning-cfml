<cfinclude template="#APPLICATION.corePath#/includes/tableTypeSwitch.cfm">

<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

<cfif isDefined("URL.#itemTypeName#")>
	<cfset item_id = URL[#itemTypeName#]>
<cfelse>
	<cflocation url="area.cfm" addtoken="no">
</cfif>

<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="getItem" returnvariable="objectItem">
	<cfinvokeargument name="item_id" value="#item_id#">
	<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
</cfinvoke>

<!---Table data--->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="getTableData" returnvariable="tableDataResult">
	<cfinvokeargument name="table_id" value="#item_id#">
	<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
</cfinvoke>
<cfset tableData = tableDataResult.tableData>

<!---Table fields--->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="getTableFields" returnvariable="fieldsResult">
	<cfinvokeargument name="table_id" value="#item_id#">
	<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
</cfinvoke>
<cfset fields = fieldsResult.tableFields>

<cfset area_id = objectItem.area_id>

<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">

<cfoutput>

<div class="div_message_page_title">#objectItem.title#</div>
<div class="div_separator"><!-- --></div>

<div class="div_elements_menu">

	<a href="#itemTypeName#_data_new.cfm?#itemTypeName#=#item_id#" onclick="openUrl('#itemTypeName#_data_new.cfm?#itemTypeName#=#item_id#', 'itemIframe', event)" class="btn btn-small" title="Nueva entrada" lang="es"><i class="icon-plus icon-white" style="color:##5BB75B;font-size:15px;line-height:20px;"></i> <span>Nueva entrada</span></a>

	<span class="divider">&nbsp;</span>

	<cfif app_version NEQ "mobile">
		<a href="#APPLICATION.htmlPath#/area_#itemTypeName#_data.cfm?#itemTypeName#=#item_id#" class="btn btn-small" title="Abrir en nueva ventana" lang="es" target="_blank"><i class="icon-external-link" style="font-size:14px; line-height:23px;"></i></a>
	</cfif>

	<a href="area_#itemTypeName#_data.cfm?#itemTypeName#=#item_id#" class="btn btn-small" title="Actualizar" lang="es"><i class="icon-refresh" style="font-size:14px; line-height:23px;"></i></a>

</div>

<cfinclude template="#APPLICATION.htmlPath#/includes/tablesorter_scripts.cfm">

<script type="text/javascript">
	$(document).ready(function() { 
		
		$("##dataTable").tablesorter({ 
			widgets: ['zebra','filter','select'],
			sortList: [[1,1]] ,
			headers: { 
				1: { 
					sorter: "datetime" 
				},
				2: { 
					sorter: "datetime" 
				}
			},

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
				filter_useParsedData : false,
		    }
		});
		
	}); 
</script>

<table id="dataTable" class="table table-condensed table-hover" style="width:100%;margin-top:5px;margin-bottom:0px;">
	<thead>
		<tr>
			<th style="width:25px;">##</th>
			<th>Fecha de inserción</th>
			<th>Fecha de última modificación</th>
			<cfloop query="#fields#">
				<cfif fields.field_type_id IS NOT 3><!--- IS NOT long text --->	
					<th>#fields.label#</th>
				</cfif>
			</cfloop>
			<!---<th class="filter-false">Acciones</th>--->
		</tr>
	</thead>
	<tbody>
	<cfloop query="tableData">

		<!---<cfif isDefined("arguments.return_page")>
			<cfset rpage = arguments.return_page>
		<cfelse>--->
			<cfset rpage = "area_#itemTypeName#_data.cfm?area=#item_id#">
		<!---</cfif>--->
		<cfset data_page_url = "#tableTypeName#_data.cfm?#tableTypeName#=#item_id#&data=#tableData.data_id#&return_page=#URLEncodedFormat(rpage)#">

		<tr onclick="openUrl('#data_page_url#','itemIframe',event)">
			<td>#tableData.currentRow#</td>
			<td>#DateFormat(tableData.insert_date, "dd/mm/yyyy")# #TimeFormat(tableData.insert_date, "HH:mm")#</td>
			<td><cfif len(tableData.last_update_date) GT 0>#DateFormat(tableData.last_update_date, "dd/mm/yyyy")# #TimeFormat(tableData.last_update_date, "HH:mm")#<cfelse>-</cfif></td>
			<cfloop query="fields">
				<cfif fields.field_type_id IS NOT 3><!--- IS NOT long text --->	
					<cfset field_value = tableData['field_#fields.field_id#']>
					<cfif fields.field_type_id IS 6 AND len(field_value) GT 0>
						<cfset field_value = DateFormat(dateConvert("local2Utc",field_value), "dd/mm/yyyy")>
					</cfif>
					<td>#field_value#</td>
				</cfif>
			</cfloop>
			<!---<td>
				<a href="#itemTypeName#_data_edit.cfm?#itemTypeName#=#item_id#data=#tableData.data_id#" class="btn btn-info btn-small"><i class="icon-pencil"></i></a>
				<a href="#itemTypeName#_data_edit.cfm?#itemTypeName#=#item_id#data=#tableData.data_id#" class="btn btn-danger btn-small"><i class="icon-remove"></i></a>
			</td>--->
		</tr>
	</cfloop>
	</tbody>
</table>
</cfoutput>