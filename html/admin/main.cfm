<cfprocessingdirective suppresswhitespace="true">
<!DOCTYPE html>

<!---Obtiene el usuario logeado--->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="getUser" returnvariable="objectUser">
	<cfinvokeargument name="user_id" value="#SESSION.user_id#">
	<cfinvokeargument name="format_content" value="all">
</cfinvoke>

<html lang="es">
<head>
<!--Developed and copyright by Era7 Information Technologies 2007-2013 (www.era7.com)-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" /><!--- Fuerza a IE que renderize el contenido en la última versión (que no habilite el modo de compatibilidad) --->
<cfoutput>

<title>Administración #APPLICATION.title#<cfif isDefined("SESSION.client_name")> - #SESSION.client_name#</cfif></title>

<cfif APPLICATION.identifier EQ "dp">
<link href="#APPLICATION.htmlPath#/assets/favicon.ico" rel="shortcut icon" type="image/x-icon"> 
</cfif>

<link href="#APPLICATION.baseCSSPath#" rel="stylesheet">
<link href="#APPLICATION.baseCSSIconsPath#" rel="stylesheet">

<link href="#APPLICATION.htmlPath#/bootstrap/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet">

<cfif APPLICATION.identifier EQ "dp">
<link rel="stylesheet" type="text/css" media="all" href="#APPLICATION.htmlPath#/styles/styles_dp2.min.css"/>
<cfelse>
<link rel="stylesheet" type="text/css" media="all" href="#APPLICATION.htmlPath#/styles/styles_vpnet.css"/>
</cfif>
<!--- <link rel="stylesheet" type="text/css" href="../jquery/jstree/themes/dp/style.css"/> --->

<script type="text/javascript" src="#APPLICATION.jqueryJSPath#"></script>
<script type="text/javascript" src="#APPLICATION.path#/jquery/jstree/jquery.jstree.js"></script>

<script type="text/javascript" src="#APPLICATION.bootstrapJSPath#"></script>

<script type="text/javascript" src="#APPLICATION.htmlPath#/bootstrap/bootstrap-modal/js/bootstrap-modal.js"></script>
<script type="text/javascript" src="#APPLICATION.htmlPath#/bootstrap/bootstrap-modal/js/bootstrap-modalmanager.js"></script>

<script type="text/javascript" src="#APPLICATION.path#/jquery/jquery-lang/jquery-lang.js" charset="utf-8" ></script>
<script src="#APPLICATION.htmlPath#/language/main_en.js" charset="utf-8" type="text/javascript"></script>

</cfoutput>

<cfif isDefined("URL.area") AND isNumeric(URL.area)>
	<cfset area_id = URL.area>
	
	<cfinclude template="#APPLICATION.htmlPath#/includes/url_redirect.cfm">
	
	<cfif isDefined("redirect_page")>
		<cfset iframe_page = redirect_area_page>
	<cfelse>
		<cfset iframe_page = "">
	</cfif>
<cfelse>
	<cfset area_id = "null">
	
	<cfset iframe_page = "">
</cfif>

<script type="text/javascript">

	<cfoutput>
	<!--- var applicationPath = "#APPLICATION.path#"; --->
	var applicationId = "#APPLICATION.identifier#";
	var selectAreaId = "#area_id#";
	var iframePage = "#iframe_page#";
	var userLanguage = "#objectUser.language#";
	
	<!--- var areaImgHeight = 60; --->
	
	<!---Si se cambian estos valores, también hay que cambiarlos en los CSS--->
	var treeDefaultWidth = "99%";
	var areaDefaultWidth = "99%";
	
	// Language
	var selectedLanguage = 'es';
	jquery_lang_js.prototype.defaultLang = 'es';
	jquery_lang_js.prototype.currentLang = 'es';
	window.lang = new jquery_lang_js();
	</cfoutput>

	// Modal
	var $modal = null;
	
</script>

<cfoutput>
<script type="text/javascript" src="#APPLICATION.htmlPath#/scripts/functions.min.js"></script>
<script type="text/javascript" src="#APPLICATION.htmlPath#/scripts/tree.min.js?v=2.1"></script>
<script type="text/javascript" src="#APPLICATION.htmlPath#/scripts/main.min.js?v=2.2"></script>
</cfoutput>

<script type="text/javascript">
	
	function resizeIframe() {
		var newHeight = windowHeight()-56;
		$(".iframes").height(newHeight);
		
		var userIframeHeight = 300;

		$("#areaIframe").height(newHeight-userIframeHeight-5)
		$("#allUsersIframe").height(newHeight-userIframeHeight-5);
		$("#logItemIframe").height(newHeight);
		$("#treeContainer").height(newHeight-73);
	}

	function changeLanguage() {
		
		if(selectedLanguage == 'en')
			newLanguage = 'es';
		else
			newLanguage = 'en';
			
		window.lang.change(newLanguage);
			
		location.href = "language_selection.cfm?lan="+newLanguage;
	
	}

	function treeLoaded() {

		if ( !isNaN(selectAreaId) ) { //Hay área para seleccionar

			selectTreeNode(selectAreaId);
			
		}else if( isNaN(selectAreaId) ) { //No hay area para seleccionar

			emptyIframes();
		}

		$("#loadingContainer").hide();
		$("#treeContainer").css('visibility', 'visible');

		if($("#mainContainer").is(":hidden"))
			$("#mainContainer").show();
	}

	function logIframeLoaded() {

		if($("#logIframe").attr('src') != "about:blank" && $("#loadingContainer").css('display') == "block"){
			$("#loadingContainer").hide();
		}
			
	}

	function loadAreaImage(areaId) {

		<!--- Aquí no se carga la imagen del área en la administración
		if(applicationId != "vpnet") { //Esto solo está habilitado para DP ya que en la otra versión no se utiliza y carga la aplicación
					$("#areaImage").attr('src', "../../app/downloadAreaImage.cfm?id="+areaId);
		} --->

	}

	<!---
	Esto no se usa en la administración
	function goToAreaLink() {
		
		if(areaWithLink == true) {
			window.open("../../app/goToAreaLink.cfm?id="+curAreaId, "_blank");
		}
		
	}--->

	function openAreaNewModal(){

		if($.isNumeric(curAreaId))
			loadModal('html_content/area_new.cfm?parent='+curAreaId);
		else
			alert("Debe seleccionar un área en la que crear la nueva");
	}

	function openAreaMoveModal(){

		if($.isNumeric(curAreaId))
			loadModal('html_content/area_cut.cfm?area='+curAreaId);
		else
			alert("Debe seleccionar un área para mover");
	}

	function openAreaAssociateModal(userId){

		if($.isNumeric(curAreaId))
			loadModal('html_content/area_user_associate.cfm?area='+curAreaId+'&user='+userId);
		else
			alert("Debe seleccionar un área para asociar el usuario");
	}
	
	function emptyIframes(){

		$("#areaIframe").attr('src', 'about:blank');
		$("#userAreaIframe").attr('src', 'about:blank');
		
	}

	$(window).resize( function() {
		resizeIframe();
	});
	
	$(window).load( function() {		
		resizeIframe();
		loadTree();
		
		<cfif APPLICATION.moduleMessenger EQ true AND isDefined("SESSION.user_id")>
		Messenger.Private.initGetNewConversations();
		</cfif>
		
		<!---/*$("#maximizeTree").click( function() {
			maximizeTree();
		} );
		
		$("#restoreTree").click( function() {
			restoreTree();
		} );
		
		$("#maximizeArea").click( function() {
			maximizeArea();
		} );
		
		$("#restoreArea").click( function() {
			restoreArea();
		} );*/--->
				
		<!---$("#areaImage").load( function () {
			areaImgHeight = $("#areaImage").height();			
			resizeIframe();	
		});--->

		$('#dpTab a').click( function (e) {
			if(e.preventDefault)
		  		e.preventDefault();
			
		  	$(this).tab('show');
			
		});
		
		$('a[data-toggle="tab"]').on('shown', function (e) { //On show tab
			
			var pattern=/#.+/gi //use regex to get anchor(==selector)
			currentTab = e.target.toString().match(pattern)[0];

			if(currentTab == "#tab3" && $("#logIframe").attr('src') == "about:blank") { //Load logs page
				$("#logIframe").attr('src', 'iframes/logs.cfm');
				$("#loadingContainer").show();
			}

		})
		
		$("#searchText").on("keydown", function(e) { 
		
			if(e.which == 13) //Enter key
				searchTextInTree();
			
		});
		
	});
	
	$(document).ready(function () {
		// Language
   		window.lang.run();
		
		selectedLanguage = localStorage.getItem('langJs_currentLang');

		if(userLanguage != selectedLanguage)
			window.lang.change(userLanguage);
		
		if(selectedLanguage == 'en')
			$('#languageSelector').text('Español');
		else
			$('#languageSelector').text('English');

		// Modal
		$modal = $('#ajax-modal');

		// Alert
		$('#alertContainer .close').click(function(e) {

			hideAlertMessage();

    		$("#alertContainer span").remove();

		});
				
	});
	
</script>
</head>

<body class="body_tree">			

<!--- Alert --->
<cfinclude template="#APPLICATION.htmlPath#/includes/main_alert.cfm">

<!--- Loading --->
<cfinclude template="#APPLICATION.htmlPath#/includes/loading_div.cfm">

<div class="div_contenedor_contenido">

	<!---<cfset current_page = "main.cfm">--->
	
	<div id="mainContainer">
	
		
		<div class="tabbable"><!---Tab Panel--->
	
		  <ul class="nav nav-pills" id="dpTab" style="margin-bottom:0px; clear:none;">
			<li class="active"><a href="#tab1" data-toggle="tab" lang="es">Árbol</a></li>
			<li><a href="#tab2" data-toggle="tab" lang="es">Área</a></li>
			<cfif SESSION.client_administrator IS SESSION.user_id>
			<li><a href="#tab3" data-toggle="tab" lang="es">Logs</a></li>
			</cfif>
		  </ul>
		  
		  <cfoutput>
		  <div style="float:right; clear:none;">
		  
		  	<div style="float:right; text-align:right; clear:none;">
				<a href="../preferences.cfm" title="Preferencias del usuario" class="link_user_logged" lang="es">#objectUser.family_name# #objectUser.name# (#getAuthUser()#)</a><br/>
				
				<a href="../logout.cfm" title="Cerrar sesión" class="link_user_logout" lang="es"><i class="icon-signout"></i> <span lang="es">Salir</span></a>

			</div>
			
			<cfif APPLICATION.identifier NEQ "vpnet">
				<div style="float:right; padding-top:1px; padding-right:6px; width:80px; text-align:right;">
					
					<!--- 
					<cfif objectUser.general_administrator EQ true>
											<a href="#APPLICATION.path#/#SESSION.client_id#/index.cfm?app=generalAdmin"><img src="assets/icons_#APPLICATION.identifier#/administration.png" alt="Administración general" title="Administración general" style="margin-right:3px;" lang="es"/></a>
										<cfelse>
											<cfxml variable="areasAdminXml">
												#objectUser.areas_administration#
											</cfxml>
											<cfif isDefined("areasAdminXml.areas_administration.area")>
												<cfset nAreasAdmin = arrayLen(areasAdminXml.areas_administration.area)>
											<cfelse>
												<cfset nAreasAdmin = 0>
											</cfif>
											<cfif nAreasAdmin GT 0>
												<a href="#APPLICATION.path#/#SESSION.client_id#/index.cfm?app=areaAdmin"><img src="assets/icons_#APPLICATION.identifier#/administration.png" alt="Administración de áreas" title="Administración de áreas" style="margin-right:3px;" lang="es"/></a>
											</cfif>
										</cfif> --->
					
				
					<a href="preferences.cfm" title="Preferencias del usuario" lang="es">
					<cfif len(objectUser.image_file) GT 0>
						<img src="#APPLICATION.htmlPath#/download_user_image.cfm?id=#objectUser.image_file#&type=#objectUser.image_type#&small=" alt="#objectUser.family_name# #objectUser.name#" />
					<cfelse>
						<img src="#APPLICATION.htmlPath#/assets/icons/user_default.png" alt="#objectUser.family_name# #objectUser.name#" />
					</cfif>
					</a>
				</div>
			</cfif>
		  
		  </div>
		  </cfoutput>
		  
		  <div class="tab-content" style="clear:both;">
		  
		  
			<div class="tab-pane active" id="tab1"><!---Tab Tree--->
				
				<div class="form-inline" style="padding-bottom:5px;">
										
					<div class="input-append">
						<input type="text" name="text" id="searchText" value="" class="input-medium" on/>
						<button onClick="searchTextInTree()" class="btn" type="button" title="Buscar área en el árbol" lang="es"><i class="icon-search"></i> <span lang="es">Buscar</span></button>
					</div>					
					
					<a onClick="updateTree();" class="btn" title="Actualizar" lang="es"><i class="icon-refresh"></i> <span lang="es">Actualizar</span></a>
					<a onClick="expandTree();" class="btn" title="Expandir todo el árbol" lang="es"><i class="icon-plus"></i> <span lang="es">Expandir</span></a>
					<a onClick="collapseTree();" class="btn" title="Colapsar todo el árbol" lang="es"><i class="icon-minus"></i> <span lang="es">Colapsar</span></a>
					
					<a onClick="openAreaNewModal()" class="btn btn-info" title="Nueva área" lang="es"><i class="icon-plus icon-white"></i> <span lang="es">Nueva área</span></a>

					<a onClick="openAreaMoveModal()" class="btn btn-info" title="Mover área" lang="es"><i class="icon-cut icon-white"></i> <span lang="es">Mover área</span></a>

					<a onClick="loadModal('html_content/area_delete.cfm?area='+curAreaId);" class="btn btn-danger" title="Eliminar área" lang="es"><i class="icon-remove"></i> <span lang="es">Eliminar área</span></a>

					<a href="../main.cfm" class="btn btn-info" style="float:right"><i class="icon-arrow-left"></i> <span>Volver</span></a>
				</div>

				<div class="form-inline" style="padding-bottom:5px; padding-left:5px;">
					<label class="checkbox">
						<input type="checkbox" id="changeTabDisabled" value="true"/> <span>No cambiar de pestaña al seleccionar área</span>
					</label>
				</div>
				
				<!---treeContainer--->
				<div id="treeWrapper">
					<!---<cfoutput>
					<div style="cursor:pointer;float:right;clear:both;">
					<img src="#APPLICATION.htmlPath#/assets/icons/maximize.png" title="Maximizar Árbol" id="maximizeTree" />
					<img src="#APPLICATION.htmlPath#/assets/icons/restore.png" title="Restaurar Árbol" id="restoreTree" style="display:none;"/>
					</div>
					</cfoutput>--->
					
					<div id="treeContainer" style="overflow:auto;clear:both;"></div>			
				</div>
				
				<!---foot--->
				<div>				
					
					<div style="float:right; padding:0; margin:0;">
						
						<a onClick="changeLanguage()" id="languageSelector" style="font-size:12px;cursor:pointer;">Inglés</a>
						
						<!--- <span style="font-size:12px;">&nbsp;|&nbsp;</span>
						
						<a href="mobile.cfm" style="font-size:12px" lang="es">Versión móvil</a> --->
						
					</div>
					
				</div>
				
			</div><!---END Tab Tree--->
			
			
			<div class="tab-pane" id="tab2"><!---Tab Area--->
				
				<!---areaContainer--->
				<div id="areaContainer">
									
					<!---<cfoutput>
					<div style="cursor:pointer;float:right;">
					<img src="#APPLICATION.htmlPath#/assets/icons/maximize.png" title="Maximizar" id="maximizeArea" />
					<img src="#APPLICATION.htmlPath#/assets/icons/restore.png" title="Restaurar" id="restoreArea" style="display:none;"/>
					</div>
					</cfoutput>--->
					
					<div id="areaUsersContainer"><!---Area Users--->

						<!--- 
						<a id="areaImageAnchor" onClick="goToAreaLink()"><!---Banner--->
						<cfoutput>
							<cfif isNumeric(area_id)>
								<img src="#APPLICATION.resourcesPath#/downloadAreaImage.cfm?id=#area_id#" id="areaImage" alt="Imagen del área" />
							<cfelse>
								<img src="#APPLICATION.resourcesPath#/#APPLICATION.identifier#_banner.png" id="areaImage" alt="Imagen del área" />
							</cfif>
						</cfoutput>
						</a> --->
						
					
						<iframe marginheight="0" marginwidth="0" scrolling="auto" width="100%" frameborder="0" class="iframes" src="about:blank" style="height:100%;background-color:#FFFFFF;" id="areaIframe" onload="areaIframeLoaded()"></iframe><!---iframes/area.cfm--->

						<iframe marginheight="0" marginwidth="0" scrolling="auto" width="100%" frameborder="0" class="iframeItem" src="iframes/area_user.cfm" style="height:300px;background-color:#FFFFFF; border-top: 1px solid #CCCCCC;" id="userAreaIframe"></iframe>
					
					</div>
					
					<div id="usersContainer"><!---Users--->
						
						<!---All users--->
						<iframe marginheight="0" marginwidth="0" scrolling="auto" width="100%" frameborder="0" class="iframeItem" src="iframes/all_users.cfm" style="height:100%;background-color:#FFFFFF;" id="allUsersIframe"></iframe>

						<iframe marginheight="0" marginwidth="0" scrolling="auto" width="100%" frameborder="0" class="iframeItem" src="iframes/user.cfm" style="height:300px;background-color:#FFFFFF; border-top: 1px solid #CCCCCC;" id="userAdminIframe"></iframe>
						
					</div>
					
					
				</div>
				
			</div><!---END Tab Area--->
			
			
			<cfif SESSION.client_administrator IS SESSION.user_id>

			<div class="tab-pane" id="tab3"><!---Tab Logs--->
				
				<!---logContainer--->
				<div id="logContainer">
					
					
					<div id="logItemsContainer"><!---Items Log--->
						
						<iframe marginheight="0" marginwidth="0" scrolling="auto" width="100%" frameborder="0" class="iframes" src="about:blank" style="height:100%;background-color:#FFFFFF;" id="logIframe" onload="logIframeLoaded()"></iframe>
					
					</div>
					
					<div id="logItemContainer"><!---Item Log--->
					
						<iframe marginheight="0" marginwidth="0" scrolling="auto" width="100%" frameborder="0" class="logItem" src="about:blank" style="height:100%;background-color:#FFFFFF;" id="logItemIframe"></iframe>
						
					</div>
					
				
				</div>
				
			</div><!---END Tab Logs--->

			</cfif>
						
		  </div>
		  
		</div><!---END TabPanel--->
	
		
		<div style="clear:both"><!-- --></div>
		
	</div>

	<!--- Modal Window --->
	<div id="ajax-modal" class="modal hide fade" tabindex="-1"></div>

	<div style="clear:both"><!-- --></div>
	<div class="msg_div_error" id="errorMessage"></div>

</div>

<!---Download File--->
<!--- <cfinclude template="#APPLICATION.htmlPath#/includes/open_download_file.cfm"> --->

</body>
</html>
</cfprocessingdirective>
	