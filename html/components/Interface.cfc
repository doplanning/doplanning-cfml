<!---Copyright Era7 Information Technologies 2007-2013

	Date of file creation: 07-10-2008
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 23-04-2013
	
--->
<cfcomponent output="true">

	<cfset component = "Interface">
	
	
	<cffunction name="returnElement" returntype="void" access="public">
		<cfargument name="return_page" type="string" required="true">
		
		<cfset var method = "returnElement">
		
		<cfoutput>
			<!---<div class="div_return">
				<a href="#arguments.return_page#" class="a_return"><img src="#APPLICATION.htmlPath#/assets/icons/return.gif" title="Volver" alt="Volver" />
				Volver</a>
			</div>--->
			<a href="#arguments.return_page#" class="btn btn-default btn-sm" style="margin-left:5px; margin-bottom:5px;"><i class="icon-arrow-left"></i> <span lang="es">Volver</span></a>
		</cfoutput>
		
		<cftry>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		

	</cffunction>
	
	<cffunction name="goUpElement" returntype="void" access="public">
		<cfargument name="return_page" type="string" required="true">
		
		<cfset var method = "goUpElement">
		
		<cfoutput>
			<div class="div_return">
				<a href="#arguments.return_page#" class="btn btn-default btn-sm" lang="es">Ir a nivel superior</a>
			</div>
		</cfoutput>
		
		<cftry>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		

	</cffunction>
	
	
	<cffunction name="userListHeader" returntype="void" access="public">
		<cfargument name="current_page" type="string" required="true">
		<cfargument name="order_by" type="string" required="true">
		<cfargument name="order_type" type="string" required="true">
		
		<cfset var method = "userListHeader">
		
		<cfset family_name_order_type = "asc">
		<cfset name_order_type = "desc">

		<cfif order_by EQ "family_name">
			<cfset name_order_type = "asc">
			<cfif order_type EQ "asc">
				<cfset family_name_order_type = "desc">
			<cfelse>
				<cfset family_name_order_type = "asc">
			</cfif>
		<cfelseif order_by EQ "name">
			<cfif order_type EQ "asc">
				<cfset name_order_type = "desc">
			<cfelse>
				<cfset name_order_type = "asc">
			</cfif>
		</cfif>
		<!---<cfif order_type EQ "asc">
			<cfset new_order_type = "desc">
		<cfelse>
			<cfset new_order_type = "asc">
		</cfif>--->
		
		<cfoutput>
			<div class="div_separator"><!-- --></div>
			<div class="div_users_header">
<!--				<div class="div_checkbox_users_header"><!---<input type="checkbox" class="checkbox_users_header"/>---></div>	-->
				<div class="div_user_right">		
					<div class="div_text_user_name"><span class="texto_normal" style="font-weight:bold;">Ordenar por:</span> <a href="#arguments.current_page#&order_by=family_name&order_type=#family_name_order_type#" class="texto_normal">Nombre</a> <a href="#arguments.current_page#&order_by=name&order_type=#name_order_type#" class="texto_normal">Apellido</a></div>
					<div class="div_text_user_email"></div><div class="div_text_user_mobile"></div>
				</div>
			</div>		
			<div class="div_separator"><!-- --></div>
		</cfoutput>
		
		<cftry>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		

	</cffunction>


	<!--- isMobileBrowser --->

	<cffunction name="isMobileBrowser" returntype="boolean" access="public">

		<!--- http://detectmobilebrowsers.com/ --->
		
		<cfif reFindNoCase("(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino",CGI.HTTP_USER_AGENT) GT 0 OR reFindNoCase("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-",Left(CGI.HTTP_USER_AGENT,4)) GT 0>

			<cfreturn true>

		<cfelse>

			<cfreturn false>

		</cfif>


	</cffunction>


	<!--- insertBR --->

	<cffunction name="insertBR" returntype="string" access="public">
		<cfargument name="string" type="string" required="true">

		<cfset string = replace(string,chr(13),"<br />","ALL")>

		<cfreturn string>

	</cffunction>


	<!--- replaceBR --->

	<!---<cffunction name="replaceBR" returntype="string" access="public">
		<cfargument name="string" type="string" required="true">

		<cfset string = replace(string,"<br />",chr(13),"ALL")>

		<cfreturn string>

	</cffunction>--->

	<!--- replaceP --->

	<cffunction name="replaceP" returntype="string" access="public">
		<cfargument name="string" type="string" required="true">

		<cfset string = replace(string,"<p>","","ALL")>
		<cfset string = replace(string,"</p>",chr(13),"ALL")>

		<cfreturn string>

	</cffunction>


	<!--- removeHTML --->

	<cffunction name="removeHTML" returntype="string" access="public">
		<cfargument name="string" type="string" required="true">

		<cfset string = REReplace(string,"<[^>]*>","","ALL")>>

		<cfreturn string>

	</cffunction>


</cfcomponent>