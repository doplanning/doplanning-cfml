
<cfoutput>
	<script type="text/javascript" src="#APPLICATION.bootstrapDatepickerJSPath#"></script>
	<link href="#APPLICATION.bootstrapDatepickerCSSPath#" rel="stylesheet" type="text/css" />
</cfoutput>

<cfif NOT isDefined("itemTypeId")>
	<cfset itemTypeId = "">
</cfif>

<cfif isDefined("URL.text")>
	<cfset search_text = URL.text>
	<cfset search_text_highlight = replace(search_text,' ','","',"ALL")>
	<cfoutput>
		<script type="text/javascript">
			$(document).ready(function() {
			  <!---$(".text_item").highlight("#search_text#");--->
			  $(".text_item").highlight(["#search_text_highlight#"]);	
			});			
		</script>
	</cfoutput>
<cfelse>
	<cfset search_text = "">
</cfif>

<cfif isDefined("URL.from_user") AND isNumeric(URL.from_user)>
	<cfset user_in_charge = URL.from_user>
<cfelse>
	<cfset user_in_charge = "">
</cfif>

<cfif isDefined("URL.to_user") AND isNumeric(URL.to_user)>
	<cfset recipient_user = URL.to_user>
<cfelse>
	<cfif NOT isDefined("URL.to_user") AND isDefined("SESSION.user_id")>
		<cfset recipient_user = SESSION.user_id>
	<cfelse>
		<cfset recipient_user = "">
	</cfif>
</cfif>

<cfif isDefined("URL.done") AND isNumeric(URL.done)>
	<cfset is_done = URL.done>
<cfelse>
	<cfset is_done = 0>
</cfif>

<cfif isDefined("URL.state")>
	<cfset cur_state = URL.state>
<cfelse>
	<cfset cur_state = "">
</cfif>

<cfif isDefined("URL.limit") AND isNumeric(URL.limit)>
	<cfset limit_to = URL.limit>
<cfelse>
	<cfset limit_to = 100>
</cfif>


<cfif isDefined("URL.from_date")>
	<cfset from_date = URL.from_date>
<cfelse>
	<cfset from_date = "">
</cfif>

<cfif isDefined("URL.end_date")>
	<cfset end_date = URL.end_date>
<cfelse>
	<cfset end_date = "">
</cfif>


<cfif NOT isDefined("curElement") OR curElement NEQ "users">

	<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="getUsers" returnvariable="getUsersResponse">	
		<cfinvokeargument name="order_by" value="name">
		<cfinvokeargument name="order_type" value="asc">
	</cfinvoke>
	
	<cfxml variable="xmlUsers">
		<cfoutput>
		#getUsersResponse.usersXml#
		</cfoutput>
	</cfxml>
	<cfset numUsers = ArrayLen(xmlUsers.users.XmlChildren)>

</cfif>



<script type="text/javascript">
	
	$(function() {

		$('#from_date').datepicker({
		  format: 'dd-mm-yyyy', 
		  autoclose: true,
		  endDate: $('#end_date').val()	  
		});
	
		$('#end_date').datepicker({
		  format: 'dd-mm-yyyy', 
		  autoclose: true
		});

		
	});
	
	
	function setEndDate(){
		$('#from_date').datepicker('setEndDate', $('#end_date').val());
	}

	function setFromDate(){
		$('#end_date').datepicker('setStartDate', $('#from_date').val());
	}

	
</script>



<cfoutput>
<div style="clear:both; padding-left:2px;">
<form method="get" class="form-inline" action="#CGI.SCRIPT_NAME#">
	
	<div class="input-prepend">
	  <span class="add-on"><i class="icon-search"></i></span>
	  <input type="text" name="text" value="#HTMLEditFormat(search_text)#" class="input-medium"/>
	</div>

	<cfif NOT isDefined("curElement") OR curElement NEQ "users">
	
		&nbsp;<label for="from_user" lang="es">De</label> <select name="from_user" id="from_user">
		<option value="" lang="es">Todos</option>
		<cfloop index="xmlIndex" from="1" to="#numUsers#" step="1">				
			<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="objectUser" returnvariable="objectUser">
				<cfinvokeargument name="xml" value="#xmlUsers.users.user[xmlIndex]#">
				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>	
			
			<option value="#objectUser.id#" <cfif objectUser.id EQ user_in_charge>selected="selected"</cfif>>#objectUser.family_name# #objectUser.name#</option>
			
		</cfloop>
		</select>
		
		
		<br/>	
		&nbsp;<label for="from_user" lang="es">Fecha desde</label> 		
		<input type="text" name="from_date" id="from_date" class="input_datepicker" value="#from_date#" onchange="setFromDate()">

		&nbsp;<label for="end_user" lang="es">Fecha hasta</label> 
		<input type="text" name="end_date" id="end_date" value="#end_date#" class="input_datepicker" onchange="setEndDate()"/>
		
		
	
		<cfif itemTypeId IS 6><!---Tasks--->
			&nbsp;<label for="done" lang="es">Hecha</label> <select name="done" id="done" class="input-mini">
				<option value="1" <cfif is_done IS 1>selected="selected"</cfif> lang="es">Sí</option>
				<option value="0" <cfif is_done IS 0>selected="selected"</cfif> lang="es">No</option>
			</select><br/>
		
			<label for="to_user" lang="es">Para</label> <select name="to_user" lang="to_user">
				<option value="" lang="es">Todos</option>
				<cfloop index="xmlIndex" from="1" to="#numUsers#" step="1">				
					<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="objectUser" returnvariable="objectUser">
						<cfinvokeargument name="xml" value="#xmlUsers.users.user[xmlIndex]#">
						<cfinvokeargument name="return_type" value="object">
					</cfinvoke>	
					
					<option value="#objectUser.id#" <cfif objectUser.id EQ recipient_user>selected="selected"</cfif>>#objectUser.family_name# #objectUser.name#</option>
				</cfloop>
			</select>
		</cfif>
		
		<cfif itemTypeId IS 7><!---Consultations--->
			<br/>
			&nbsp;<label for="done" lang="es">Estado actual</label> <select name="state" id="state" class="input-medium">
				<option value="" lang="es">Todos</option>
				<option value="created" <cfif cur_state EQ "created">selected="selected"</cfif> lang="es">Enviada</option>
				<option value="read" <cfif cur_state EQ "read">selected="selected"</cfif> lang="es">Leída</option>
				<option value="answered" <cfif cur_state EQ "answered">selected="selected"</cfif> lang="es">Respondida</option>
				<option value="closed" <cfif cur_state EQ "closed">selected="selected"</cfif> lang="es">Cerrada</option>
			</select>	
		</cfif>
		
	</cfif>
	
	
	
	
	&nbsp;<label for="limit" lang="es">Nº resultados</label> <select name="limit" id="limit" class="input-small">
	<!---<option value="1" <cfif limit_to IS 1>selected="selected"</cfif>>1</option>--->
	<option value="100" <cfif limit_to IS 100>selected="selected"</cfif>>100</option>
	<option value="500" <cfif limit_to IS 500>selected="selected"</cfif>>500</option>
	<option value="1000" <cfif limit_to IS 1000>selected="selected"</cfif>>1000</option>
	</select>
	<input type="submit" name="search" class="btn btn-primary" lang="es" value="Buscar" />
	
	<br/>&nbsp;<span style="font-size:10px" lang="es">Formato DD-MM-AAAA. Ejemplo:</span><span style="font-size:10px"> #DateFormat(now(), "DD-MM-YYYY")#</span>
</form>
</div>
</cfoutput>