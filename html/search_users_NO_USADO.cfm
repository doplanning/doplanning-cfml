<cfprocessingdirective suppresswhitespace="true">
<!DOCTYPE html>
<html lang="es"><!-- InstanceBegin template="/Templates/plantilla_app_doplanning.dwt.cfm" codeOutsideHTMLIsLocked="true" -->
<head>
<!--Developed and copyright by Era7 Information Technologies 2007-2013 (www.era7.com)-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" /><!--- Fuerza a IE que renderize el contenido en la última versión (que no habilite el modo de compatibilidad) --->
<!---<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />--->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<cfoutput>
<!-- InstanceBeginEditable name="doctitle" -->
<title>#APPLICATION.title#</title>
<!-- InstanceEndEditable -->
<link href="assets/favicon.ico" rel="shortcut icon" type="image/x-icon">
<link href="#APPLICATION.baseCSSPath#" rel="stylesheet">
<link href="#APPLICATION.baseCSSIconsPath#" rel="stylesheet">

<link href="styles/styles.min.css" rel="stylesheet" type="text/css" media="all" />
<cfif APPLICATION.identifier EQ "vpnet">
<link href="styles/styles_vpnet.css" rel="stylesheet" type="text/css" media="all" />
<cfelse>
<link href="styles/styles_dp.css" rel="stylesheet" type="text/css" media="all" />
</cfif>
<!--using caps S (Screen), Pocket IE ignores it. Windows Mobile 6.1 ignores media="handled"-->  
<link href="styles/styles_screen.css" rel="stylesheet" type="text/css" media="Screen" />
<link href="styles/styles_mobiles.css" rel="stylesheet" type="text/css" media="only screen and (max-device-width: 800px)" />
<!---<link href="../html/styles_mobiles.css" rel="stylesheet" type="text/css" media="handheld" />
<link href="../html/styles_iphone.css" rel="stylesheet" type="text/css" media="only screen and (max-device-width: 480px)" />--->
</cfoutput>

<cfif APPLICATION.identifier EQ "vpnet">
	<!---Esto solo debe mantenerse para la versión vpnet (por el Messenger)--->
	<script type="text/javascript" src="../SpryAssets/includes/xpath.js"></script>
	<script type="text/javascript" src="../SpryAssets/includes/SpryData.js"></script>
	<script type="text/javascript" src="../SpryAssets/includes/SpryXML.js"></script>
	<script type="text/javascript" src="../SpryAssets/includes/SpryDOMUtils.js"></script>
	<cfif APPLICATION.moduleMessenger EQ true>
		<script type="text/javascript" src="../app/scripts/App.js"></script>
		<script type="text/javascript" src="scripts/MessengerControl.js"></script>
		<cfif isDefined("SESSION.user_id")>
		<script type="text/javascript">
		window.onload = function (){
			Messenger.Private.initGetNewConversations();
		}
		</script>
		</cfif>
	</cfif>
</cfif>

<cfoutput>
<script type="text/javascript" src="#APPLICATION.jqueryJSPath#"></script>
<script type="text/javascript" src="#APPLICATION.path#/jquery/jquery-lang/jquery-lang.js" charset="utf-8" ></script>
<script src="#APPLICATION.htmlPath#/language/base_en.js" charset="utf-8" type="text/javascript"></script>
<script type="text/javascript" src="scripts/functions.min.js?v=2.1"></script>
</cfoutput>

<script type="text/javascript">
	//Language
	jquery_lang_js.prototype.defaultLang = 'es';
	jquery_lang_js.prototype.currentLang = 'es';
	window.lang = new jquery_lang_js();
	
	$().ready(function () {
		window.lang.run();
	});
</script>


<cfoutput>
<script type="text/javascript" src="#APPLICATION.bootstrapJSPath#"></script>
</cfoutput>
<script type="text/javascript">
	function openUrlLite(url,target){
		window.location.href = url;
	}
	function openUrl(url,target,event){
		window.location.href = url;
	}
	function openUrlHtml2(url,target){
		//En esta versión no se hace nada con las peticiones a este método
	}
</script>
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
</head>

<body onBeforeUnload="onUnloadPage()" onLoad="onLoadPage()" class="body_global">
<!---divLoading--->
<cfinclude template="#APPLICATION.htmlPath#/includes/loading_page_div.cfm">
<cfif APPLICATION.identifier NEQ "dp">
	<div class="div_header">
		<a href="../html/"><div class="div_header_content"><!-- --></div></a>
		<div class="div_separador_header"><!-- --></div>
	</div>
</cfif>

 
<cfoutput>
<cfif APPLICATION.identifier EQ "dp">
<div style="float:left; padding-top:2px;"><a href="index.cfm"><img src="assets/logo_app.gif" alt="Inicio" title="Inicio"/></a></div>
</cfif>
<div style="float:right">
	<div style="float:right; margin-right:5px; padding-top:2px;" class="div_text_user_logged">
		<a href="preferences.cfm" class="link_user_logged" title="Preferencias del usuario" lang="es">#getAuthUser()#</a>&nbsp;&nbsp;&nbsp;<a href="logout.cfm" class="text_user_logged" title="Cerrar sesión" lang="es"><i class="icon-signout"></i> <span lang="es">Salir</span></a>
	</div>
</div>
</cfoutput>

<div class="div_contenedor_contenido">
<!-- InstanceBeginEditable name="contenido" -->
<cfinclude template="includes/search_head.cfm">

<div class="div_head_subtitle">
Buscar usuarios
</div>

<cfset return_page = "search.cfm">

<cfinclude template="includes/search_bar.cfm">

<cfif isDefined("search_text")>


	<cfinvoke component="#APPLICATION.htmlComponentsPath#/Search" method="searchUsers" returnvariable="xmlResponse">
		<cfinvokeargument name="text" value="#search_text#">
		<cfinvokeargument name="page" value="#search_page#">
	</cfinvoke>
	
	<!---PROVISIONAL--->
	<cfset area_id = 0>
	<cfset URL.area= 0>
	
	<cfxml variable="xmlUsers">
		<cfoutput>
		#xmlResponse.response.result.search.users#
		</cfoutput>
	</cfxml>
	
	<cfset page = xmlUsers.users.xmlAttributes.page>
	<cfset pages = xmlUsers.users.xmlAttributes.pages>
	<cfset total = xmlUsers.users.xmlAttributes.total>
	
	<cfinclude template="includes/search_result_text.cfm">
	
	<cfinclude template="includes/search_pages.cfm">
	
	<cfset numUsers = ArrayLen(xmlUsers.users.XmlChildren)>
	
	<cfoutput>

		<form action="users.cfm?area=#area_id#" method="post" style="padding:0; margin:0; clear:none;">
		<cfif APPLICATION.identifier EQ "vpnet">
		<div class="div_element_menu">
			<div class="div_icon_menus"><input type="image" name="notification" src="assets/icons/notifications.gif" title="Enviar notificación a usuarios seleccionados" /></div>
			<div class="div_text_menus"><span class="span_text_menus">Enviar <br /> notificación</span></div>	
		</div>
		<div class="div_element_menu">
			<div class="div_icon_menus"><input type="image" name="sms" src="assets/icons/sms.png" title="Enviar SMS a usuarios seleccionados" /></div>
			<div class="div_text_menus"><span class="span_text_menus">Enviar<br />SMS</span></div>
		</div>
		</cfif>
	<!--- </div> --->
	</cfoutput>
	<div class="div_items">
	<div class="div_separator"><!-- --></div>
	<cfif numUsers GT 0>
	
		<cfloop index="xmlIndex" from="1" to="#numUsers#" step="1">

			<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUserList">
				<cfinvokeargument name="xmlUser" value="#xmlUsers.users.user[xmlIndex]#">
				<cfinvokeargument name="page_type" value="6">
			</cfinvoke>
			
		</cfloop>
	
	</div>
	<cfinclude template="includes/search_pages.cfm">
	<cfelse>
		No hay usuarios con el texto buscado.
	</div>
	</cfif>
	
	
	</form>

</cfif>

<cfinvoke component="#APPLICATION.htmlComponentsPath#/Interface" method="returnElement">
	<cfinvokeargument name="return_page" value="#return_page#">
</cfinvoke>
<!-- InstanceEndEditable -->
</div>
</body>
<!-- InstanceEnd --></html>
</cfprocessingdirective>