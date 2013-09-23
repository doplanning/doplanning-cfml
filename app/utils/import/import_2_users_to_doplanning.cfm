<cfprocessingdirective suppresswhitespace="true">
<!DOCTYPE html>
<html lang="es"><!-- InstanceBegin template="/Templates/plantilla_basica_general_doplanning.dwt.cfm" codeOutsideHTMLIsLocked="true" -->
<head>
<!--Developed and copyright by Era7 Information Technologies 2007-2013 (www.era7.com)-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" /><!--- Fuerza a IE que renderize el contenido en la última versión (que no habilite el modo de compatibilidad) --->
<!---<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />--->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<cfoutput>
<!-- InstanceBeginEditable name="doctitle" -->
<title>#APPLICATION.title# - Crear los usuarios cargados en DoPlanning</title>
<!-- InstanceEndEditable -->
<link href="../../../html/assets/favicon.ico" rel="shortcut icon" type="image/x-icon">
<link href="#APPLICATION.baseCSSPath#" rel="stylesheet">
<link href="#APPLICATION.baseCSSIconsPath#" rel="stylesheet">

<link href="../../../html/styles/styles.min.css" rel="stylesheet" type="text/css" media="all" />
<cfif APPLICATION.identifier EQ "vpnet">
<link href="../../../html/styles/styles_vpnet.css" rel="stylesheet" type="text/css" media="all" />
<cfelse>
<link href="../../../html/styles/styles_dp.css" rel="stylesheet" type="text/css" media="all" />
</cfif>
<!--using caps S (Screen), Pocket IE ignores it. Windows Mobile 6.1 ignores media="handled"-->  
<link href="../../../html/styles/styles_screen.css" rel="stylesheet" type="text/css" media="Screen" />
<link href="../../../html/styles/styles_mobiles.css" rel="stylesheet" type="text/css" media="only screen and (max-device-width: 800px)" />
<!---<link href="../html/styles_mobiles.css" rel="stylesheet" type="text/css" media="handheld" />
<link href="../html/styles_iphone.css" rel="stylesheet" type="text/css" media="only screen and (max-device-width: 480px)" />--->
</cfoutput>

<cfif APPLICATION.identifier EQ "vpnet">
	<!---Esto solo debe mantenerse para la versión vpnet (por el Messenger)--->
	<script type="text/javascript" src="../../../SpryAssets/includes/xpath.js"></script>
	<script type="text/javascript" src="../../../SpryAssets/includes/SpryData.js"></script>
	<script type="text/javascript" src="../../../SpryAssets/includes/SpryXML.js"></script>
	<script type="text/javascript" src="../../../SpryAssets/includes/SpryDOMUtils.js"></script>
	<cfif APPLICATION.moduleMessenger EQ true>
		<script type="text/javascript" src="../../scripts/App.js"></script>
		<script type="text/javascript" src="../../../html/scripts/MessengerControl.js"></script>
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
<script type="text/javascript" src="../../../html/scripts/functions.min.js"></script>
</cfoutput>

<script type="text/javascript">
	//Language
	jquery_lang_js.prototype.defaultLang = 'es';
	jquery_lang_js.prototype.currentLang = 'es';
	window.lang = new jquery_lang_js();
	
	$().ready(function () {
		//Language
		window.lang.run();
	});
</script>

<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
</head>

<body class="body_global">
<cfif APPLICATION.identifier NEQ "dp">
	<div class="div_header">
		<a href="../../../html/"><div class="div_header_content"><!-- --></div></a>
		<div class="div_separador_header"><!-- --></div>
	</div>
</cfif>
<!-- InstanceBeginEditable name="header" -->

<!-- InstanceEndEditable -->
<div class="div_contenedor_contenido">
<!-- InstanceBeginEditable name="contenido" -->

<h2>2º Crear los usuarios cargados en DoPlanning</h1>

<br/>

<cfset client_abb = SESSION.client_abb>
<cfset client_dsn = APPLICATION.identifier&"_"&client_abb>

<cfif isDefined("FORM.area_id")>
		
	<cfset add_to_area_id = FORM.area_id>

	<cfquery datasource="#APPLICATION.dsn#" name="getClient">
		SELECT *
		FROM APP_clients
		WHERE abbreviation = <cfqueryparam value="#client_abb#" cfsqltype="cf_sql_varchar">;
	</cfquery>

	<cfif getClient.recordCount IS 0>
		<cfthrow message="Error al obtener el cliente: #client_abb#">
	</cfif>
	
	<cfoutput>
	Inicio de importación.<br/>
	CLIENTE: #getClient.name#<br/>
	ÁREA por defecto: #add_to_area_id#<br/><br/>
	</cfoutput>
	

	<cfquery datasource="#client_dsn#" name="getUsersToImport">
		SELECT *
		FROM #client_abb#_users_to_import;
	</cfquery>

	<cfloop query="getUsersToImport">
		
		<cfinvoke component="#APPLICATION.componentsPath#/LoginManager" method="generatePassword" returnvariable="newPassword">
			<cfinvokeargument name="numberofCharacters" value="5">
		</cfinvoke>

		<!--- <cfoutput>#newPassword#<br/></cfoutput> --->

		<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="objectUser" returnvariable="xmlUser">
			<cfinvokeargument name="name" value="#getUsersToImport.family_name_1# #getUsersToImport.family_name_2#">
			<cfinvokeargument name="family_name" value="#getUsersToImport.name#">
			<cfinvokeargument name="email" value="#Trim(getUsersToImport.email_login)#">
			<!---<cfinvokeargument name="telephone" value="">
			<cfinvokeargument name="telephone_ccode" value="">
			<cfinvokeargument name="mobile_phone" value="">
			<cfinvokeargument name="mobile_phone_ccode" value="">--->
			<cfinvokeargument name="password" value="#hash(newPassword)#"/>
			<cfinvokeargument name="password_temp" value="#newPassword#"/>
			<!---<cfif APPLICATION.moduleLdapUsers IS true>--->
			<cfinvokeargument name="login_ldap" value="#Trim(getUsersToImport.login_dmsas)#"/>
			<cfinvokeargument name="login_diraya" value="#Trim(getUsersToImport.login_diraya)#"/>
			<!---</cfif>--->
			<cfinvokeargument name="dni" value="#getUsersToImport.nif#"/>
			<cfinvokeargument name="address" value="#getUsersToImport.address#"/>
			<cfinvokeargument name="sms_allowed" value="false">
			<!---<cfinvokeargument name="whole_tree_visible" value="true">--->
			<cfinvokeargument name="whole_tree_visible" value="false">
			
			<cfinvokeargument name="return_type" value="xml">
		</cfinvoke>

		<cfinvoke component="#APPLICATION.componentsPath#/RequestManager" method="createRequest" returnvariable="createUserRequest">
			<cfinvokeargument name="request_parameters" value='#xmlUser#'>
		</cfinvoke>

		<cfdump var="#createUserRequest#"/>
		
		<!---createUser--->
		<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="createUser" returnvariable="createUserResponse">
			<cfinvokeargument name="request" value="#createUserRequest#">
		</cfinvoke>

		<cfxml variable="userResponseXml">
			<cfoutput>
			#createUserResponse#
			</cfoutput>
		</cfxml>

		<!---Si la respuesta es un error--->
		<cfif isDefined("userResponseXml.response.error.xmlAttributes.code") AND isValid("integer",userResponseXml.response.error.xmlAttributes.code)>
			
			<cfoutput>
			<strong>Error al crear el usuario con email #getUsersToImport.email_login#: #userResponseXml.response.error.xmlAttributes.code#</strong><br/>
			</cfoutput>

		<cfelse>

			<cfset created_user_id = userResponseXml.response.result.user.xmlAttributes.id>

			<cfoutput>
			Usuario con email #getUsersToImport.email_login# creado correctamente con ID: #created_user_id#<br/>
			</cfoutput>


			<!---assign User To Root Area--->
			<cfinvoke component="#APPLICATION.componentsPath#/RequestManager" method="createRequest" returnvariable="assignUserToAreaRequest">
				<cfinvokeargument name="request_parameters" value='<user id="#created_user_id#"/><area id="#add_to_area_id#"/>'>
			</cfinvoke>
		
			<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="assignUserToArea" returnvariable="assignToAreaResponse">
				<cfinvokeargument name="request" value="#assignUserToAreaRequest#">
			</cfinvoke>

			<cfxml variable="assignToAreaResponseXml">
				<cfoutput>
				#assignToAreaResponse#
				</cfoutput>
			</cfxml>

			<!---Si la respuesta es un error--->
			<cfif isDefined("assignToAreaResponseXml.response.error.xmlAttributes.code") AND isValid("integer",assignToAreaResponseXml.response.error.xmlAttributes.code)>

				<cfoutput>
				<strong>Error al añadir el usuario al área: #assignToAreaResponseXml.response.error.xmlAttributes.code#</strong><br/>
				</cfoutput>

			<cfelse>

				<cfoutput>
					Añadido al área #add_to_area_id#.<br/>
				</cfoutput>

			</cfif>


		</cfif>		
		

		<br/><br/>

	</cfloop>

	Importación terminada.<br/>

<cfelse>

	-Cada usuario creado en DoPlanning recibirá un correo electrónico con su cuenta y contraseña.<br/>
	<!--- -Los usuarios no podrán ver todo el árbol de la organización (se crearán como usuarios externos).<br/> ---->
	-A los usuarios se les añadirá por defecto al área indicada a continuación.<br/>
	-Este proceso no es reversible.<br/>
	-Los usuarios ya existentes en DoPlanning no se podrán crear de nuevo y darán un error 205.<br/>
	-Una vez pulsado el botón "Importar usuarios" <strong>debe esperar unos minutos hasta que se complete la operación</strong>.<br/><br/>

	<cftry>
		
		<cfquery datasource="#client_dsn#" name="getImportedUsersQuery">
			SELECT *
			FROM #SESSION.client_abb#_users_to_import;
		</cfquery>

		<cfif getImportedUsersQuery.recordCount GT 0>

			<script type="text/javascript">

				function onSubmitForm(){
					document.getElementById("submitDiv1").innerHTML = window.lang.convert('Importando...');
				}

			</script>

			<cfoutput>
			<cfform method="post" action="#CGI.SCRIPT_NAME#" onsubmit="onSubmitForm();">
				<!---<label>Client Abb</label>
				<cfinput type="text" name="abb" value="" required="true" message="Client abb requerido">--->
				<label for="client_dsn">Identificador de aplicación DoPlanning en la que se crearán los usuarios:</label>
				<input name="client_dsn" id="client_dsn" type="text" value="#client_dsn#" readonly="true" />
				<label for="area_id">ID de área a la que añadir los usuarios importados</label>
				<cfinput type="text" name="area_id" id="area_id" value="5" class="input-mini" validate="integer" required="true" message="Area a la que añadir los usuarios requerida (valor numérico)"/>
				<div style="margin-top:5px" id="submitDiv1">
				<cfinput type="submit" name="import" class="btn btn-primary" value="Importar usuarios">
				</div>
			</cfform>
			</cfoutput>

			<strong>Usuarios a importar:</strong>				
			<cfdump var="#getImportedUsersQuery#" label="#SESSION.client_abb#_users_to_import" metainfo="no">

		<cfelse>

			<strong>No se puede realizar la importación, no hay usuarios para importar.</strong>	

		</cfif>

		<cfcatch>
			<strong>ERROR, no se puede realizar la importación. Antes debe cargar usuarios mediante <a href="import_1_users_from_csv.cfm">1º Cargar desde un CSV los usuarios</a>.</strong>
		</cfcatch>		
	</cftry>
	
</cfif>

<!-- InstanceEndEditable -->
</div>
</body>
<!-- InstanceEnd --></html>
</cfprocessingdirective>