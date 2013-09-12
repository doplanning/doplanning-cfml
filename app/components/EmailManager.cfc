<!---Copyright Era7 Information Technologies 2007-2008

	Date of file creation: 27-10-2008
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 10-06-2013
	
	26-09-2012 alucena: añadido port="#APPLICATION.emailServerPort#"
	21-05-2013 alucena: modificado sendEmail para enviar a través de la API de Mandrill
	29-05-2013 alucena: quitado head_content, no se usa en esta versión	
--->
<cfcomponent output="false">

	<cfset component = "EmailManager">
	
	<!--- ----------------------- SEND EMAIL -------------------------------- --->
	
	<cffunction name="sendEmail" access="public" returntype="void">
		<cfargument name="from" type="string" required="yes">
		<cfargument name="from_name" type="string" required="false">
		<cfargument name="to" type="string" required="yes">
		<cfargument name="bcc" type="string" required="no" default="">
		<cfargument name="subject" type="string" required="yes">
		<cfargument name="content" type="string" required="yes">
		<!---<cfargument name="head_content" type="string" required="no">--->
		<cfargument name="foot_content" type="string" required="no">
		<cfargument name="styles" type="boolean" required="no" default="true">
		<cfargument name="file_source" type="string" required="no">
		
		<cfset var method = "sendEmail">
		
		<cfset var toEmails = "">
		<cfset var jsonFields = "">
		<cfset var fromName = "">
				
		<!--- <cfset head_content = '<p style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px;"><span style="color:##FF0000; font-size:12px;">No responda a este email.</span><br />Este email ha sido enviado mediante la aplicación #APPLICATION.title#.</p>'> --->

		<cfprocessingdirective suppresswhitespace="yes">
	<cfsavecontent variable="email_content">
	<!--Este mensaje está en formato HTML, si usted lee esto significa que su cliente de correo no le está mostrando el mensaje en dicho formato, por lo que no lo podrá ver correctamente--><!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<cfif styles EQ true><style type="text/css">
<!--
body {
	<cfif APPLICATION.identifier EQ "dp">
	background-color:#FFFFFF;
	color:#333333;
	<cfelse>
	background-color:#FFFFFF;
	color:#000000;
	</cfif>
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:12px;
}
-->
</style></cfif>
</head>
<body>
<cfoutput>
<!--- <cfif isDefined("head_content")>#head_content#<hr /><br /></cfif> --->
#arguments.content#
<cfif isDefined("arguments.foot_content")><br /><hr />#arguments.foot_content#</cfif>
</cfoutput>
</body>
</html>
	</cfsavecontent>
	
	<cfif APPLICATION.identifier EQ "dp">
		
		<cfif isDefined("arguments.from_name")>
			<cfset fromName = "#APPLICATION.title#-#arguments.from_name#">
		<cfelse>
			<cfset fromName = APPLICATION.title>			
		</cfif>

		<cfif APPLICATION.emailSendMode EQ "SMTP">
			
			<!---<cfif isDefined("SESSION.client_email_support")>
				<cfset email_failto = SESSION.client_email_support>
			<cfelse>
				<cfset email_failto = APPLICATION.emailFail>
			</cfif>--->

			<cfset fullFrom = '"#fromName#" <#APPLICATION.emailFrom#>'>
		
			<cfif len(APPLICATION.emailServerUserName) IS NOT 0><!---With authentication--->
				
				<cfmail server="#APPLICATION.emailServer#" username="#APPLICATION.emailServerUserName#" password="#APPLICATION.emailServerPassword#" type="html" from="#fullFrom#" to="cmartinez@era7.com" bcc="#arguments.bcc#" subject="#arguments.subject#" charset="utf-8" port="#APPLICATION.emailServerPort#">#email_content#</cfmail><!---from="#arguments.from#" failto="#email_failto#"--->

			<cfelse><!---Without authentication--->

				<cfmail server="#APPLICATION.emailServer#" type="html" from="#fullFrom#" to="#arguments.to#" bcc="#arguments.bcc#" subject="#arguments.subject#" charset="utf-8" port="#APPLICATION.emailServerPort#">#email_content#</cfmail><!---from="#arguments.from#" failto="#email_failto#"--->

			</cfif>


		<cfelse><!---Send emails by Mandrill API--->

			<cfset toEmails = arrayNew()>
		
			<cfif len(arguments.to) GT 0 AND arguments.to NEQ APPLICATION.emailFalseTo>
				
				<cfloop list="#arguments.to#" index="toEmail" delimiters=";">
				
					<cfset arrayAppend(toEmails, {"email":"#toEmail#"})>
				
				</cfloop>
				
			</cfif>
			
			<cfif len(arguments.bcc) GT 0>
				
				<cfloop list="#arguments.bcc#" index="bccEmail" delimiters=";">
				
					<cfset arrayAppend(toEmails, {"email":"#bccEmail#"})>
				
				</cfloop>
			
			</cfif>
			
			<cfif arrayLen(toEmails) IS 0><!---Unexpected error--->
				<cfthrow errorcode="10000">
			</cfif>
			
			<cfset jsonFields = {

				"key": "#APPLICATION.emailServerPassword#",
				"message": {
					"html": "#email_content#",
					"subject": "#arguments.subject#",
					"from_email": "#APPLICATION.emailFrom#",
					"from_name": "#fromName#",
					"to": #toEmails#,
					"important": false,
					"track_opens": false,
					"track_clicks": false,
					"auto_text": false,
					"auto_html": false,
					"inline_css": false,
					"url_strip_qs": false,
					"preserve_recipients": false,
				},
				"async": true
			}>
			
			<!---"to": [
				{
					"email": "alucena@era7.com"
				},
				{
					"email": "bugs@doplanning.net"
				}
			],
			
			"headers": {
				"Reply-To": "#APPLICATION.emailReply#"
			},--->
			
			<cfhttp method="post" url="https://mandrillapp.com/api/1.0/messages/send.json" result="responseResult">
				<cfhttpparam type="header" name="Content-Type" value="application/json" />
				<cfhttpparam type="body" value="#serializeJSON(jsonFields)#">
			</cfhttp>
					
			<cfset mandrillResponse = deserializeJSON(responseResult.filecontent)>
			
			<cfif responseResult.status_code NEQ 200>
				
				<cfthrow errorcode="1302" message="#mandrillResponse.message#">
				
			</cfif>
		

		</cfif>
		

	<cfelseif APPLICATION.identifier EQ "vpnet">

		<cfhttp url="#APPLICATION.mainUrl##APPLICATION.resourcesPath#/sendMail.jsp" method="post" result="pageResponse">				        
			<cfhttpparam name="email_from" type="formfield" value="#arguments.from#">
			<cfhttpparam name="email_to" type="formfield" value="#arguments.to#">
			<cfhttpparam name="email_bcc" type="formfield" value="#arguments.bcc#">
			<!---<cfhttpparam name="email_replyto" type="formfield" value="">--->
			<cfif isDefined("SESSION.client_email_support")>
				<cfhttpparam name="email_failto" type="formfield" value="#SESSION.client_email_support#">
			<cfelse>
				<cfhttpparam name="email_failto" type="formfield" value="#APPLICATION.emailFail#">
			</cfif>
			<cfhttpparam name="email_subject" type="formfield" value="#arguments.subject#">
			<cfhttpparam name="email_content" type="formfield" value="#email_content#">	
		</cfhttp>
		
		<cfset xmlResult = XmlParse(Trim(pageResponse.FileContent))>
		
		<cfif isDefined("xmlResult.response.xmlAttributes.status")>
			<cfif xmlResult.response.xmlAttributes.status NEQ "ok">
				<cfset error_code = 1302>
				<cfset error_message = xmlResult.response.error.title.xmlText>
				
				<cfthrow errorcode="#error_code#" message="#error_message# #xmlResult#">
			</cfif>
		<cfelse>
		
			<cfset error_code = 1302>
				
			<cfthrow errorcode="#error_code#" message="#xmlResult#">
		
		</cfif>
		
	</cfif>

	
</cfprocessingdirective>
	</cffunction>
	
	
	<!--- ----------------------- SEND NOTIFICATION -------------------------------- --->
	
	<cffunction name="sendNotification" returntype="String" output="false" access="public">		
		<cfargument name="request" type="string" required="yes">
		<!---<cfargument name="from" type="string" required="yes">
		<cfargument name="to" type="string" required="yes">	
		<cfargument name="subject" type="string" required="yes">	
		<cfargument name="text" type="string" required="yes">
		<cfargument name="html" type="string" required="yes">--->
		
		<cfset var method = "sendNotification">
		
		<cfset var from = "">
		<cfset var to = "">
		<cfset var subject = "">
		<cfset var text = "">
		<cfset var html = "">
						
		<cftry>
		
			<cfinclude template="includes/functionStart.cfm">
			
			<!---check if the user logged in already exist--->
			<cfquery name="checkUser" datasource="#client_dsn#">
				SELECT * FROM #client_abb#_users
				WHERE id = <cfqueryparam value="#user_id#" cfsqltype="cf_sql_integer">;
			</cfquery>
			<cfif checkUser.recordCount IS 0><!---The user does not exist--->
				<cfset error_code = 204>
				
				<cfthrow errorcode="#error_code#"> 
			</cfif>
			
			<!---<cfset from = xmlRequest.request.parameters.notification.xmlAttributes.from>--->
			<!---Obtener el nombre del usuario que lo envia y ponerlo en el from--->
			<!---<cfset from = user_id>--->
			<cfset from = checkUser.family_name&" "&checkUser.name>
			<cfset to = xmlRequest.request.parameters.notification.xmlAttributes.recipients>
			<cfset subject = xmlRequest.request.parameters.notification.subject.xmlText>
			<cfset html_text = xmlRequest.request.parameters.notification.html_text.xmlText>
			
			<cfif len(html_text) GT 0>
		
				<cfset html_text = REReplace(html_text,'[[:space:]]SIZE="',' style="font-size:',"ALL")>

			</cfif>
			
			<cfset email_type = "html">	
			<cfset foot_content = '<p style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:9px;">No responda a este email.<br />Este email ha sido enviado mediante la aplicación #APPLICATION.title#.</p>'>			
			
			<cfinvoke component="EmailManager" method="sendEmail">
				<cfinvokeargument name="from" value="#SESSION.client_email_from#">
				<cfinvokeargument name="to" value="#to#">
				<cfinvokeargument name="subject" value="<#from#> #subject#">
				<cfinvokeargument name="content" value="#html_text#">
				<cfinvokeargument name="foot_content" value="#foot_content#">
				<cfinvokeargument name="styles" value="false">
			</cfinvoke>			 
			
			<cfset xmlResponseContent = '<notification from="#from#" recipients="#to#"/>'>
		
			<cfinclude template="includes/functionEnd.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
		
	</cffunction>
	
	
</cfcomponent>