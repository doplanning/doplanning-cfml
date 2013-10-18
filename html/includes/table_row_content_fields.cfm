<!---Table fields--->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Table" method="getTableFields" returnvariable="fieldsResult">
	<cfinvokeargument name="table_id" value="#table_id#">
	<cfinvokeargument name="tableTypeId" value="#tableTypeId#">
	<cfinvokeargument name="with_types" value="true"/>
</cfinvoke>
<cfset fields = fieldsResult.tableFields>

<cfoutput>
<cfloop query="fields">

	<cfset field_label = fields.label&":">
	<cfset field_name = "field_#fields.field_id#">
	<cfset field_value = row[field_name]>



	<cfif fields.input_type IS "textarea">

		<div class="div_message_page_label">#field_label#</div>
		<cfif len(field_value) GT 0>
			<div class="div_message_page_description">#field_value#</div>
		</cfif> 

	<cfelseif fields.field_type_id IS 8><!---URL--->

		<div class="div_message_page_label">#field_label#<br/> <a href="#field_value#" target="_blank">#field_value#</a></div>

	<cfelse>

		<cfif fields.field_type_id IS 6><!--- DATE --->

			<cfif isDate(field_value)>
				<cfset field_value = DateFormat(field_value, APPLICATION.dateFormat)>
			</cfif>		
		
		<cfelseif fields.field_type_id IS 7><!--- BOOLEAN --->
			
			<cfif field_value IS true>
				<cfset field_value = "Sí">
			<cfelseif field_Value IS false>
				<cfset field_value = "No">
			</cfif>

		</cfif>

		<div class="div_message_page_label">#field_label# <span class="text_message_page">#field_value#</span></div>

	</cfif>		

</cfloop>
</cfoutput>
