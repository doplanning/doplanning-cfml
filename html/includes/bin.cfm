
<!--- getClient --->
<cfinvoke component="#APPLICATION.htmlPath#/components/Client" method="getClient" returnvariable="clientQuery">
	<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
</cfinvoke>

<cfif clientQuery.bin_enabled IS false><!--- BIN NOT Enabled --->

	<div class="row">
		<div class="col-sm-12">

			<div class="alert alert-info" role="alert"><i class="icon-info-sign"></i> <span lang="es">La papelera no está habilitada en su organización, debe ser habilitada por el administrador general de la misma.</span></div>

		</div>
	</div>

<cfelse>

	<cfset url_return_page = "&return_page="&URLEncodedFormat("#APPLICATION.htmlPath#/bin.cfm")>

	<div><!--- class="contenedor_fondo_blanco"--->

		<div class="container-fluid">

			<div class="row">
				<div class="col-sm-12">
					<cfinclude template="alert_message.cfm">
				</div>
			</div>

		</div>

		<cfif SESSION.user_id EQ SESSION.client_administrator>

		<script>

			$(window).load( function() {

				$('#binTab a').click( function (e) {
					if(e.preventDefault)
				  		e.preventDefault();

				  	$(this).tab('show');
				});

			} );

		</script>


		<div class="tabbable" role="tabpanel">


			<ul class="nav nav-tabs" role="tablist" id="binTab">
			  <li class="active"><a href="#tab1" lang="es">Eliminados por mi</a></li>
			  <li><a href="#tab2" lang="es">Todos los de la organización</a></li>
			</ul>


			<div class="tab-content">

				<div class="tab-pane active" id="tab1"><!--- My items --->

		</cfif>

					<!--- All deleted items --->
					<cfinvoke component="#APPLICATION.htmlComponentsPath#/Bin" method="getAllBinItems" returnvariable="getMyItemsResult">
						<!---<cfif isDefined("limit_to") AND isNumeric(limit_to)>
						<cfinvokeargument name="limit" value="#limit_to#">
						</cfif>--->
						<cfinvokeargument name="delete_user_id" value="#SESSION.user_id#">
						<cfinvokeargument name="full_content" value="true">
					</cfinvoke>

					<cfset myItemsQuery = getMyItemsResult.query>

					<div class="navbar navbar-default"><!---navbar-static-top--->
						<div class="container-fluid">

							<cfoutput>

							<cfif myItemsQuery.recordCount GT 0>
								<div class="btn-toolbar navbar-left" role="toolbar">
									<div class="btn-group">
										<a href="#APPLICATION.htmlComponentsPath#/Bin.cfc?method=restoreBinItems&delete_user_id=#SESSION.user_id##url_return_page#" onclick="return confirmReversibleAction('restaurar');" class="btn btn-primary btn-sm navbar-btn"><i class="icon-undo icon-white"></i> <span lang="es">Restaurar todo</span></a>
									</div>

									<div class="btn-group">
										<a href="#APPLICATION.htmlComponentsPath#/Bin.cfc?method=deleteBinItems&delete_user_id=#SESSION.user_id##url_return_page#" onclick="return confirmAction('eliminar');" class="btn btn-danger btn-sm navbar-btn"><i class="icon-remove icon-white"></i> <span lang="es">Eliminar todo definitivamente</span></a>
									</div>
								</div>
							</cfif>

							<!---<cfif app_version NEQ "mobile">
								<a href="#CGI.SCRIPT_NAME#" class="btn btn-default btn-sm navbar-btn navbar-right" style="margin-left:8px;margin-right:5px;"><i class="icon-refresh icon-white"></i></a>
							</cfif>--->

							<p class="navbar-text navbar-right">#myItemsQuery.recordCount# <cfif myItemsQuery.recordCount IS 1><span lang="es">Elemento</span><cfelse><span lang="es">Elementos</span></cfif>&nbsp;&nbsp;&nbsp;</p>

							</cfoutput>

						</div>
					</div>

					<div class="container-fluid">

						<div class="row">
							<div class="col-sm-12" id="lastItemsContainer">

							<cfif myItemsQuery.recordCount GT 0>

								<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="outputAllItemsFullList">
									<cfinvokeargument name="itemsQuery" value="#myItemsQuery#">
									<cfinvokeargument name="return_path" value="#APPLICATION.htmlPath#/">
									<cfinvokeargument name="showLastUpdate" value="false">
									<cfinvokeargument name="deletedItems" value="true">
								</cfinvoke>

							<cfelse>

								<cfoutput>
								<p lang="es">No hay elementos</p>
								</cfoutput>

							</cfif>

							</div>
						</div>

					</div><!--- END container-fluid --->


		<cfif SESSION.user_id EQ SESSION.client_administrator>


				</div><!--- END tab1--->

				<!--- All deleted items --->
				<cfinvoke component="#APPLICATION.htmlComponentsPath#/Bin" method="getAllBinItems" returnvariable="getAllItemsResult">
					<cfinvokeargument name="full_content" value="true">
				</cfinvoke>

				<cfset itemsQuery = getAllItemsResult.query>

				<div class="tab-pane" id="tab2">


					<div class="navbar navbar-default"><!---navbar-static-top--->
						<div class="container-fluid">

							<cfoutput>

							<cfif itemsQuery.recordCount GT 0>
								<div class="btn-toolbar navbar-left" role="toolbar">
									<div class="btn-group">
										<a href="#APPLICATION.htmlComponentsPath#/Bin.cfc?method=restoreBinItems#url_return_page#" onclick="return confirmReversibleAction('restaurar');" class="btn btn-primary btn-sm navbar-btn"><i class="icon-undo icon-white"></i> <span lang="es">Restaurar todo</span></a>
									</div>

									<div class="btn-group">
										<a href="#APPLICATION.htmlComponentsPath#/Bin.cfc?method=deleteBinItems#url_return_page#" onclick="return confirmAction('eliminar');" class="btn btn-danger btn-sm navbar-btn"><i class="icon-remove icon-white"></i> <span lang="es">Eliminar todo definitivamente</span></a>
									</div>
								</div>
							</cfif>

							<!---<cfif app_version NEQ "mobile">
								<a href="#CGI.SCRIPT_NAME#" class="btn btn-default btn-sm navbar-btn navbar-right" style="margin-left:8px;margin-right:5px;"><i class="icon-refresh icon-white"></i></a>
							</cfif>--->

							<p class="navbar-text navbar-right">#itemsQuery.recordCount# <cfif itemsQuery.recordCount IS 1><span lang="es">Elemento</span><cfelse><span lang="es">Elementos</span></cfif>&nbsp;&nbsp;&nbsp;</p>

							</cfoutput>

						</div>
					</div>

					<div class="container-fluid">

						<div class="row">
							<div class="col-sm-12" id="lastItemsContainer">

							<cfif itemsQuery.recordCount GT 0>

								<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="outputAllItemsFullList">
									<cfinvokeargument name="itemsQuery" value="#itemsQuery#">
									<cfinvokeargument name="return_path" value="#APPLICATION.htmlPath#/">
									<cfinvokeargument name="showLastUpdate" value="false">
									<cfinvokeargument name="deletedItems" value="true">
								</cfinvoke>

							<cfelse>

								<cfoutput>
								<p lang="es">No hay elementos</p>
								</cfoutput>

							</cfif>

							</div>
						</div>

					</div><!--- END container-fluid --->


				</div><!--- END tab-pane tab2--->



			</div><!--- END tab-content --->

		</div><!--- END tabbable --->


		</cfif>


	</div><!--- END contenedor_fondo_blanco --->


</cfif>
