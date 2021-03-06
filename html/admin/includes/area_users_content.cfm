<cfoutput>
<!--- <script src="#APPLICATION.htmlPath#/language/area_item_en.js" charset="utf-8"></script> --->

<cfinclude template="#APPLICATION.htmlPath#/includes/tablesorter_scripts.cfm">

<script src="#APPLICATION.path#/jquery/jquery-file-upload/js/vendor/jquery.ui.widget.js"></script>
<script src="#APPLICATION.path#/jquery/jquery-file-upload/js/jquery.iframe-transport.js"></script>
<script src="#APPLICATION.path#/jquery/jquery-file-upload/js/jquery.fileupload.js"></script>
</cfoutput>

<!--- <cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm"> --->

<cfinclude template="#APPLICATION.htmlPath#/includes/area_id.cfm">

<!---area_allowed--->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Area" method="checkAreaAdminAccess">
	<cfinvokeargument name="area_id" value="#area_id#">
</cfinvoke>
<cfset area_allowed = true>

<cfinclude template="#APPLICATION.htmlPath#/includes/area_checks.cfm">

<cfinvoke component="#APPLICATION.componentsPath#/AreaManager" method="getAreaPath" returnvariable="area_path">
	<cfinvokeargument name="area_id" value="#area_id#">
	<cfinvokeargument name="separator" value=" / ">
</cfinvoke>
<cfif SESSION.client_id NEQ "hcs">

	<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="isInternalUser" returnvariable="internal_user">
		<cfinvokeargument name="get_user_id" value="#SESSION.user_id#">
	</cfinvoke>

</cfif>
<cfoutput>
<div class="div_head_menu"><!---container--->
	<div class="navbar navbar-default navbar-static-top" style="margin-bottom:0">
		<div class="container-fluid">
			<a data-toggle="collapse" href="##areaInfo" aria-expanded="false" aria-controls="areaInfo" lang="es" title="Mostrar información del área" id="openAreaImg">
				<i class="icon-info-sign more_info_img"></i>
			</a>
			<a data-toggle="collapse" href="##areaInfo" aria-expanded="false" aria-controls="areaInfo" lang="es" title="Ocultar información del área" id="closeAreaImg" lang="es" style="display:none;">
				<i class="icon-info-sign more_info_img"></i>
			</a>
			<span class="navbar_brand">#area_name#</span>

			<p style="padding-top:0;margin-bottom:0;clear:left;font-size:12px;"><!--- class="navbar_brand" color:##737373 --->
				<cfif SESSION.client_id EQ "hcs" OR internal_user IS true><span lang="es">Ruta:</span> #area_path#<cfelse>&nbsp;</cfif>
			</p>
		</div>
	</div>
</div>
<div style="clear:both"><!-- --></div>

<cfinclude template="#APPLICATION.htmlPath#/includes/area_menu_info.cfm">

<!---<div>
	<img alt="Imagen del área" src="#APPLICATION.resourcesPath#/downloadAreaImage.cfm?id=#area_id#&no-cache=#RandRange(0,999)#" style="max-height:50px;">
</div>--->
</cfoutput>

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<cfoutput>
<div class="div_head_subtitle_area">

	<div class="btn-toolbar" style="padding-right:5px;" role="toolbar">

		<!---<div class="div_head_subtitle_area_text"><strong>USUARIOS</strong><br/> del área</div>--->

		<div class="btn-group">
			<a class="btn btn-info btn-sm" onclick="parent.loadModal('html_content/area_modify.cfm?area=#area_id#');"><i class="icon-edit icon-white"></i> <span lang="es">Modificar área</span></a>
		</div>


		<div class="btn-group">
			<a class="btn btn-default btn-sm" onclick="parent.loadModal('html_content/area_image_modify.cfm?area=#area_id#');"><i class="icon-picture icon-white"></i> <span lang="es">Cambiar imagen</span></a>
			<a class="btn btn-default btn-sm" data-toggle="collapse" href="##areaInfo" aria-expanded="false" aria-controls="areaInfo"> <span lang="es">Ver Imagen</span></a>
		</div>
		<div class="btn-group pull-right">
			<a href="area_users.cfm?area=#area_id#" class="btn btn-default btn-sm" title="Actualizar" lang="es"><i class="icon-refresh"></i></a>
		</div>

	</div>

</div>

</cfoutput>

<script>

	<cfoutput>
	var areaId = #area_id#;
	var userId = "";
	<cfif isDefined("URL.user")>
		userId = #URL.user#;
	</cfif>
	</cfoutput>

	$(window).load( function() {

		<!---$('#dpTab a').click( function (e) {
			if(e.preventDefault)
		  		e.preventDefault();

		  	$(this).tab('show');

		});--->


		$('a[data-toggle="tab"]').on('show.bs.tab', function (e) { //On show tab


			var pattern=/#.+/gi; //use regex to get anchor(==selector)
			var currentTab = e.target.toString().match(pattern)[0];

			if(currentTab == "#administrators" && $('#administrators').is(':empty') ) {

				loadAdministrators();
				showLoadingPage(true);
				<!---$("#mainContainer").hide();--->
			}

		});

		<!--- Select the active tab from URL --->
		var activeTab = $('[href="' + location.hash + '"]');
		activeTab && activeTab.tab('show');

	});


	function loadAdministrators() {

		$("#loadingContainer").show();

		var noCacheNumber = Math.floor(Math.random()*1001);
		var loadPage = "../html_content/area_administrators.cfm?area="+areaId+"&n="+noCacheNumber;
		if($.isNumeric(userId))
			loadPage = loadPage+"&user="+userId;

		$("#administrators").load(loadPage, function() {
			showLoadingPage(false);
		});
	}
</script>

<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="getAllAreaUsers" returnvariable="usersResponse">
	<cfinvokeargument name="area_id" value="#area_id#">
</cfinvoke>

<cfset users = usersResponse.users>
<cfset numUsers = ArrayLen(users)>


<!--- Nav tabs --->
<cfif SESSION.area_admin_administrator IS true>

	<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="getAllAreaAdministrators" returnvariable="administratorsResponse">
		<cfinvokeargument name="area_id" value="#area_id#">
	</cfinvoke>

	<cfset administrators = administratorsResponse.users>
	<cfset numAdministrators = ArrayLen(administrators)>

	<cfoutput>
		<ul class="nav nav-pills" role="tablist">
		  <li role="presentation" class="active"><a href="##users" role="tab" data-toggle="tab"><span lang="es">Usuarios</span> (#numUsers#)</a></li>
		  <li role="presentation"><a href="##administrators" role="tab" data-toggle="tab"><span lang="es">Administradores</span> (#numAdministrators#)</a></li>
		</ul>
	</cfoutput>

	<!--- Tab panes --->
	<div class="tab-content">
	  <div class="tab-pane active" role="tabpanel" id="users">

<cfelse>

	<cfoutput>
		<span class="label label-primary">#numUsers# <span lang="es">Usuarios</span></span>
	</cfoutput>

</cfif>

	<div>

		<cfif numUsers GT 0>

			<cfinvoke component="#APPLICATION.htmlComponentsPath#/User" method="outputUsersList">
				<cfinvokeargument name="users" value="#users#">
				<cfinvokeargument name="area_id" value="#area_id#">
				<cfinvokeargument name="user_in_charge" value="#objectArea.user_in_charge#">
				<cfinvokeargument name="show_area_members" value="true">
				<cfinvokeargument name="open_url_target" value="userAreaIframe">
				<cfinvokeargument name="filter_enabled" value="false">
				<cfinvokeargument name="openRowOnSelect" value="true">
			</cfinvoke>

			<cfif objectArea.users_visible IS false>
				<div><small class="help-block" lang="es">Estos usuarios no se muestran visibles en esta área</small></div>
			</cfif>

			<div style="height:40px;"></div>

			<cfoutput>

				<nav class="navbar navbar-default navbar-fixed-bottom navbar_admin">
				  	<div class="container-fluid">

						<!---<a class="btn btn-info btn-sm navbar-btn" onclick="openAreaAssociateUsers()"><i class="icon-plus icon-white"></i> Asociar usuarios seleccionados al área</a>--->

						<a class="btn btn-default btn-sm navbar-btn" onclick="parent.loadModal('html_content/area_users_associate_select.cfm?area=#area_id#');"><i class="icon-plus icon-white"></i> <span lang="es">Asociar estos usuarios a otra área</span></a>

				  	</div>
				</nav>

			</cfoutput>

		<cfelse>
			<span lang="es">No hay usuarios.</span>
		</cfif>

	</div>

<cfif SESSION.area_admin_administrator IS true>

	  </div>
	  <div class="tab-pane" role="tabpanel" id="administrators"></div>
	</div>

</cfif>
