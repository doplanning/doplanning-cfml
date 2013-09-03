



<cfoutput>




<!---<link href="#APPLICATION.jqueryUICSSPath#" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="#APPLICATION.jqueryUIJSPath#"></script>
<script type="text/javascript" src="#APPLICATION.path#/jquery/jquery-ui/jquery.ui.datepicker-es.js"></script>--->


<script type="text/javascript" src="#APPLICATION.bootstrapDatepickerJSPath#"></script>
<link href="#APPLICATION.bootstrapDatepickerCSSPath#" rel="stylesheet" type="text/css" />
</cfoutput>


<cfif isDefined("URL.from_user") AND isNumeric(URL.from_user)>
	<cfset user_log = URL.from_user>
<cfelse>
	<cfset user_log = "">
</cfif>


<cfif isDefined("URL.action")>
	<cfset action = URL.action>
<cfelse>
	<cfset action = "">
</cfif>


<cfoutput>
<cfif isDefined("URL.from_date")>
	<cfset from_date = URL.from_date>
<cfelse>
	<cfset previousday = DateAdd("d",-1,now())>
	<cfset from_date = "#DateFormat(previousday, "DD-MM-YYYY")#">
</cfif>

<cfif isDefined("URL.end_date")>
	<cfset end_date = URL.end_date>
<cfelse>
	<cfset end_date = "#DateFormat(now(), "DD-MM-YYYY")#">
</cfif>

</cfoutput>


<cfif isDefined("URL.limit") AND isNumeric(URL.limit)>
	<cfset limit_to = URL.limit>
<cfelse>
	<cfset limit_to = 100>
</cfif>

<cfif NOT isDefined("curElement") OR curElement NEQ "users">

	<cfinvoke component="#APPLICATION.componentsPath#/LogManager" method="getLogActions" returnvariable="getLogActionsResponse">	
	</cfinvoke>
	
	<cfset logActions = getLogActionsResponse.query>
<!---	<cfset numLogActions = logActions.RecordCount>--->


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

<!---		$('.input_datepicker').datepicker({
		  format: 'dd-mm-yyyy', 
		  autoclose: true		  
		});--->
			

	
	
		$('#from_date').datepicker({
		  format: 'dd-mm-yyyy', 
		  autoclose: true,
		  endDate: $('#end_date').val()	  
		});
		
		
			
	
		$('#end_date').datepicker({
		  format: 'dd-mm-yyyy', 
		  autoclose: true
		});
			
	
<!---		$.datepicker.setDefaults($.datepicker.regional['es']);
		
		var dates = $( ".input_datepicker" ).datepicker({ dateFormat: 'dd-mm-yy', 
			changeMonth: true,
			changeYear: true
			, onSelect: function( selectedDate ) {
				var option = this.id == "date_from" ? "minDate" : "maxDate",
				instance = $( this ).data( "datepicker" ),
				date = $.datepicker.parseDate(
					instance.settings.dateFormat ||
					$.datepicker._defaults.dateFormat,
					selectedDate, instance.settings );
					//dates.not( this ).datepicker( "option", option, date );
					if(this.id == "date_from")
						$( "##date_end" ).datepicker( "option", option, date );
					else if(this.id == "date_end")
						$( "##date_from" ).datepicker( "option", option, date );
				}
			});--->
		
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
	

	<cfif NOT isDefined("curElement") OR curElement NEQ "users">
	
		&nbsp;<label for="from_user" lang="es">De</label> 
		<select name="from_user" id="from_user">
		<option value="" lang="es">Todos</option>
		<cfloop index="xmlIndex" from="1" to="#numUsers#" step="1">				
			<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="objectUser" returnvariable="objectUser">
				<cfinvokeargument name="xml" value="#xmlUsers.users.user[xmlIndex]#">
				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>	
			
			<option value="#objectUser.id#" <cfif objectUser.id EQ user_log>selected="selected"</cfif>>#objectUser.family_name# #objectUser.name#</option>
			
		</cfloop>
		</select>
		
		
		&nbsp;<label for="from_user" lang="es">Acción</label> 
		<select name="action" id="action" style="width:350px;">
		<option value="" lang="es">Todos</option>
		<cfloop query="logActions">	
			<option <cfif logActions.name EQ action>selected="selected"</cfif> value="#logActions.name#" >#logActions.action_es#</option>
		</cfloop>
		</select>		
		<br/><br/>
	
	
		&nbsp;<label for="from_user" lang="es">Fecha desde</label> 		
		<input type="text" name="from_date" id="from_date" class="input_datepicker" value="#from_date#" onchange="setFromDate()">

		&nbsp;<label for="end_user" lang="es">Fecha hasta</label> 
		<input type="text" name="end_date" id="end_date" value="#end_date#" class="input_datepicker" onchange="setEndDate()"/>
		
	</cfif>
	
	&nbsp;<label for="limit" lang="es">Nº resultados</label> <select name="limit" id="limit" class="input-small" >
	<!---<option value="1" <cfif limit_to IS 1>selected="selected"</cfif>>1</option>--->
	<option value="100" <cfif limit_to IS 100>selected="selected"</cfif>>100</option>
	<option value="500" <cfif limit_to IS 500>selected="selected"</cfif>>500</option>
	<option value="1000" <cfif limit_to IS 1000>selected="selected"</cfif>>1000</option>
	</select>
	<input type="submit" name="search" class="btn btn-primary" lang="es" value="Filtrar" /> <br/>
	
	&nbsp;<span style="font-size:10px" lang="es">Formato DD-MM-AAAA. Ejemplo:</span><span style="font-size:10px"> #DateFormat(now(), "DD-MM-YYYY")#</span>
</form>
</div>
</cfoutput>