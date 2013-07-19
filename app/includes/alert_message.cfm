<cfif isDefined("URL.message") AND NOT isNumeric(URL.message)>

	<cfset message = URLDecode(URL.message)>
	<cfoutput>
		<div class="alert alert-block">
			<!---<button type="button" class="close" data-dismiss="alert">&times;</button>--->
			<span lang="es">#message#</span>
		</div>
	</cfoutput>

<cfelseif isDefined("URL.msg")>
	
	<cfset msg = URLDecode(URL.msg)>
	<cfoutput>
		<cfif NOT isDefined("URL.res") OR URL.res IS 1>
			<div class="alert alert-success">
				<!---<button type="button" class="close" data-dismiss="alert">&times;</button>--->
				<span lang="es">#msg#</span>
			</div>
		<cfelse>
			<div class="alert alert-error">
				<!---<button type="button" class="close" data-dismiss="alert">&times;</button>--->
				<i class="icon-warning-sign"></i> <span lang="es">#msg#</span>
			</div>
		</cfif>
	</cfoutput>
	
</cfif>