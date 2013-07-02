<cfset curElement = "">

<cfset curPage = getFileFromPath(CGI.SCRIPT_NAME)>

<cfswitch expression="#curPage#">
	<cfcase value="messages_search.cfm">
		<cfset curElement = "messages">
		<cfset curTitle = "Mensajes">
	</cfcase>
	
	<cfcase value="entries_search.cfm">
		<cfset curElement = "entries">
		<cfset curTitle = "Elementos de contenido web">
	</cfcase>
	
	<cfcase value="links_search.cfm">
		<cfset curElement = "links">
		<cfset curTitle = "Enlaces">
	</cfcase>
	
	<cfcase value="newss_search.cfm">
		<cfset curElement = "news">
		<cfset curTitle = "Noticias">
	</cfcase>
	
	<cfcase value="events_search.cfm">
		<cfset curElement = "events">
		<cfset curTitle = "Eventos">
	</cfcase>
	
	<cfcase value="tasks_search.cfm">
		<cfset curElement = "tasks">
		<cfset curTitle = "Tareas">
	</cfcase>
	
	<cfcase value="files_search.cfm">
		<cfset curElement = "files">
		<cfset curTitle = "Archivos">
	</cfcase>
	
	<cfcase value="users_search.cfm">
		<cfset curElement = "users">
		<cfset curTitle = "Usuarios">
	</cfcase>
	
	<cfcase value="consultations_search.cfm">
		<cfset curElement = "consultations">
		<cfset curTitle = "Interconsultas">
	</cfcase>
	
</cfswitch>

<cfoutput>
<div class="navbar navbar-static-top">
  <div class="navbar-inner">
	<!---<a class="brand" href="##">Mensajes</a>--->
	
	<span class="navbar_brand" lang="es">#curTitle#</span>
	
	<ul class="nav pull-right">	
		
		<li <cfif curElement EQ "messages">class="active"</cfif>><a href="messages_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons/message.png" title="Mensajes" alt="Mensajes" lang="es"/></a></li>
		
		<li <cfif curElement EQ "files">class="active"</cfif>><a href="files_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons/file.png" title="Archivos" alt="Archivos" lang="es"/></a></li>
		
		<li <cfif curElement EQ "events">class="active"</cfif>><a href="events_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons/event.png" title="Eventos" alt="Eventos" lang="es"/></a></li>
			
		<li <cfif curElement EQ "tasks">class="active"</cfif>><a href="tasks_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons/task.png" title="Tareas" alt="Tareas" lang="es"/></a></li>			
	
		<cfif APPLICATION.moduleConsultations IS true>
			<li <cfif curElement EQ "consultations">class="active"</cfif>><a href="consultations_search.cfm" title="Interconsultas" lang="es"><i class="icon-exchange" style="font-size:25px; color:##0088CC"></i></a></li>			
		</cfif>
		
		<cfif APPLICATION.moduleWeb EQ true>
			<li <cfif curElement EQ "entries">class="active"</cfif>><a href="entries_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons/entry.png" title="Elementos de contenido web" alt="Elementos de contenidos web" lang="es"/></a></li>
			
			<li <cfif curElement EQ "news">class="active"</cfif>><a href="newss_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons/news.png" title="Noticias" alt="Noticias" lang="es"/></a></li>
			
			<!---<cfif APPLICATION.identifier EQ "vpnet">
			<li <cfif curElement EQ "links">class="active"</cfif>><a href="links_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons/links.png" title="Enlaces" alt="Enlaces" /></a></li>
			</cfif>--->
		</cfif>
	
		<li <cfif curElement EQ "users">class="active"</cfif>><a href="users_search.cfm"><img src="#APPLICATION.htmlPath#/assets/icons_#APPLICATION.identifier#/users.png" title="Usuarios" alt="Usuarios" lang="es"/></a></li>			

	</ul>
  </div>
</div>
<div style="height:4px; clear:both;"><!-- --></div>
</cfoutput>