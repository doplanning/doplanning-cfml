<cfoutput>
<!---
<script src="#APPLICATION.htmlPath#/language/area_item_en.js" charset="utf-8"></script>
 --->
<cfif itemTypeId IS 17>
	<script src="#APPLICATION.ckeditorJSPath#"></script>
</cfif>
</cfoutput>

<!--- https://github.com/twitter/twemoji --->
<!---<script src="//cdnjs.cloudflare.com/ajax/libs/twemoji/1.3.2/twemoji.min.js"></script>--->

<!---
<cfif itemTypeId EQ 1>
	<!--- http://emojione.com/ --->
	<script src="//cdn.jsdelivr.net/emojione/1.3.0/lib/js/emojione.min.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/emojione/1.3.0/assets/css/emojione.min.css" />
</cfif>
--->

<cfinclude template="#APPLICATION.htmlPath#/includes/item_type_switch.cfm">

<cfif isDefined("URL.#itemTypeName#") AND isNumeric(URL[itemTypeName])>
	<cfset item_id = URL[#itemTypeName#]>
<cfelse>
	<cflocation url="empty.cfm" addtoken="no">
</cfif>

<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="getItem" returnvariable="getItemResponse">
	<cfinvokeargument name="item_id" value="#item_id#">
	<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
	<cfif itemTypeId IS 20>
		<cfinvokeargument name="with_lock" value="true">
	</cfif>
	<cfinvokeargument name="with_categories" value="true"/>
</cfinvoke>

<cfset objectItem = getItemResponse.item>
<cfset itemCategories = getItemResponse.categories>
<cfset area_id = objectItem.area_id>

<cfif APPLICATION.dpUrlRewrite IS true>
	<cfset rewriteCurUrlPage = "#APPLICATION.htmlPath#/?abb=#SESSION.client_abb#&area=#area_id#&#itemTypeName#=#item_id#">
</cfif>

<!---
<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">
--->
<cfinclude template="#APPLICATION.htmlPath#/includes/area_id.cfm">
<cfinclude template="#APPLICATION.htmlPath#/includes/area_checks.cfm">

<cfinclude template="#APPLICATION.htmlPath#/includes/app_page_head.cfm">

<cfinclude template="#APPLICATION.htmlPath#/includes/area_path.cfm">

<cfinclude template="#APPLICATION.htmlPath#/includes/alert_message.cfm">

<!---<cfif app_version EQ "mobile">
	<cfinclude template="#APPLICATION.htmlPath#/includes/area_items_menu.cfm">
</cfif>--->

<script>

	$(document).ready( function(){

		$('.dropdown-toggle').dropdown();
		<!---Esto es para evitar que se abran enlaces en el iframe--->
		$(".div_message_page_description a").attr('target','_blank');

		<!---
		<cfif itemTypeId EQ 1>
   		 $(".div_message_page_description").html(emojione.shortnameToImage($(".div_message_page_description").html()));
		</cfif>
		--->

	});

	<cfif itemTypeId IS 20>
	function confirmLockDocument(value) {

		var messageLock = "";

		if(value)
			messageLock = "¿Seguro que desea bloquear el documento?. No podrá ser modificado por otros usuarios.";
		else
			messageLock = "¿Seguro que desea desbloquear el documento?.";

		return confirm(messageLock);
	}
	</cfif>

	<cfif itemTypeId IS 17>
	<cfoutput>
	function confirmSendMailing(itemId, itemTypeId, areaId) {


		bootbox.dialog({
                title: "¿Seguro que deseas enviar el boletín a todos los usuarios del área?",
                message: '<div class="row">  ' +
                    '<div class="col-md-12"> ' +
                    	'<form class="form-group"> ' +
                    		'<div class="checkbox"> ' +
													'<label for="send_to_test_users">' +
                    				'<input type="checkbox" name="send_to_test_users" id="send_to_test_users" value="true"> Incluir destinatarios introducidos para pruebas' +
                    			'</label>' +
                    		'</div>' +
                    	'</form> </div> </div>',
                buttons: {
                    success: {
                        label: "Enviar boletín a usuarios",
                        className: "btn-primary",
                        callback: function () {

                            var send_to_test_users = $("input[name='send_to_test_users']:checked").val();

                            //alert("Enviar a destinatarios para pruebas"+send_to_test_users);

														var requestUrl = "#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=sendAreaItem";
														var requestData = { item_id : itemId, itemTypeId : itemTypeId, area_id : areaId, send_to_test_users: send_to_test_users};

														showLoadingPage(true);

														$.ajax({
															  type: "POST",
															  url: requestUrl,
															  data: requestData,
															  success: function(data, status) {

																	showLoadingPage(false);

															  	if(status == "success"){

															  		var message = data.message;
																		var result = data.result;

																		goToUrl("#CGI.SCRIPT_NAME#?#itemTypeName#=#item_id#&area=#area_id#&res="+result+"&msg="+message);
																		/*showAlertMessage(message, data.result);

																		if(data.result == true)
																			$("##attachedFile"+fieldId).hide();*/

															  	}else
																		showAlertMessage(status, 0);

															  },
															  dataType: "json"
														});

                        }
                    }
                }
            }
        );



	}
	</cfoutput>
	</cfif>

</script>

<!---<cfif app_version NEQ "html2">
	<div class="div_head_subtitle">
	<cfoutput>
	<span lang="es">#itemTypeNameEs#</span>
	</cfoutput>
	</div>
</cfif>--->

<cfoutput>

<div class="div_elements_menu"><!---div_elements_menu--->
<div class="btn-toolbar" role="toolbar">

	<cfif APPLICATION.identifier NEQ "vpnet"><!---DP--->

		<cfif isDefined("URL.return_page") AND len(URL.return_page) GT 0>
			<cfset url_return_page = "&return_page="&URLEncodedFormat(return_path&URL.return_page)>
			<!--- <cfset url_return_path = "&return_path="&URLEncodedFormat(return_path&URL.return_page)> --->
		<cfelse>
			<cfset url_return_page = "&return_page="&URLEncodedFormat("#return_path#area_items.cfm?area=#area_id#&#itemTypeName#=#item_id#")>
		</cfif>

		<cfset url_return_path = "&return_path="&URLEncodedFormat("#return_path#area_items.cfm?area=#area_id#&#itemTypeName#=#item_id#")>

		<cfif itemTypeId IS 1 OR itemTypeId IS 7><!---Solo para mensajes y consultas--->
			<cfif itemTypeId IS 1 OR objectItem.state NEQ "closed">
				<cfif objectArea["item_type_#itemTypeId#_enabled"] IS true AND objectArea.read_only IS false>
					<div class="btn-group">
						<a href="#itemTypeName#_new.cfm?#itemTypeName#=#objectItem.id#" class="btn btn-sm btn-primary"><i class="icon-reply"></i> <span lang="es">Responder</span></a>
					</div>
				<cfelse>
					<div><button class="btn btn-link disabled" lang="es">Está deshabilitada la creación de <cfif itemTypeGender EQ "male">nuevos<cfelse>nuevas</cfif> #itemTypeNameEsP# en esta área</button></div>
				</cfif>

			</cfif>

		<cfelse><!---Si no es mensaje o consulta--->

			<cfif objectArea.read_only IS false>

				<cfif itemTypeId IS NOT 17 AND itemTypeId IS NOT 20>

					<!---En las áreas web o intranet se pueden modificar los elementos--->
					<cfif len(area_type) GT 0 OR objectItem.user_in_charge EQ SESSION.user_id OR (itemTypeId IS 6 AND objectItem.recipient_user EQ SESSION.user_id)><!---Si es el propietario o es tarea y es el destinatario de la misma--->

						<div class="btn-group">
							<a href="#itemTypeName#_modify.cfm?#itemTypeName#=#item_id#" class="btn btn-sm btn-primary"><i class="icon-edit icon-white"></i> <span lang="es">Modificar</span></a>
						</div>

					</cfif>

				<cfelseif itemTypeId IS 17 AND is_user_area_responsible AND objectItem.state NEQ "sent">

					<div class="btn-group">
						<a href="#itemTypeName#_modify.cfm?#itemTypeName#=#item_id#" class="btn btn-sm btn-default"><i class="icon-edit icon-white"></i> <span lang="es">Modificar</span></a>
					</div>

				<cfelseif  itemTypeId IS 20 AND ( ( objectItem.area_editable IS false AND objectItem.user_in_charge EQ SESSION.user_id ) OR ( objectItem.area_editable IS true AND (objectItem.locked IS false OR objectItem.lock_user_id IS SESSION.user_id) ) )>

					<div class="btn-group">
						<a href="#itemTypeName#_modify.cfm?#itemTypeName#=#item_id#" class="btn btn-sm btn-primary"><i class="icon-edit icon-white"></i> <span lang="es">Modificar</span></a>
					</div>

				</cfif>

			</cfif>




			<cfif APPLICATION.moduleWeb IS true AND len(area_type) GT 0>

				<cfif APPLICATION.publicationValidation IS true AND is_user_area_responsible IS true AND objectArea.read_only IS false>

					<!--- publication validation --->
					<cfif objectItem.publication_validated IS false>

						<cfif SESSION.client_abb NEQ "hcs" OR NOT isDefined("objectItem.publication_scope_id") OR objectItem.publication_scope_id NEQ 1><!---En el DP HCS el ámbito de publicación 1 es DoPlanning, que NO necesita aprobación de publicación--->
							<div class="btn-group">
								<a href="#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=changeItemPublicationValidation&item_id=#item_id#&itemTypeId=#itemTypeId#&validate=true#url_return_path#" onclick="return confirmReversibleAction('Permitir la publicación en web');" title="Permitir la publicación en web" class="btn btn-success btn-sm"><i class="icon-check"></i> <span lang="es">Aprobar publicación</span></a>
							</div>
						</cfif>

					<cfelse>
						<div class="btn-group">
							<a href="#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=changeItemPublicationValidation&item_id=#item_id#&itemTypeId=#itemTypeId#&validate=false#url_return_path#" onclick="return confirmReversibleAction('Impedir la publicación en web');" title="Permitir la publicación en web" class="btn btn-warning btn-sm"><i class="icon-remove-sign"></i> <span lang="es">Desaprobar publicación</span></a>
						</div>

						<!---<cfif SESSION.client_abb EQ "hcs">

							<a href="" target="_blank" title="Ver en web" class="btn btn-default btn-sm"><i class="icon-remove-sign"></i> <span lang="es">Ver en web</span></a>

						</cfif>--->

					</cfif>

				</cfif>

			</cfif>

		</cfif>


		<cfif itemTypeId IS 7><!---Consultations--->

			<cfif objectItem.state NEQ "closed" AND objectArea.read_only IS false>

				<cfif objectItem.parent_kind EQ "area">

					<cfset close_item_id = item_id>
					<cfset close_user_in_charge = objectItem.user_in_charge>

				<cfelse>

					<cfinvoke component="#APPLICATION.componentsPath#/AreaItemManager" method="getItemRoot" returnvariable="getItemRootResult">
						<cfinvokeargument name="item_id" value="#objectItem.parent_id#">
						<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
					</cfinvoke>

					<cfset close_item_id = getItemRootResult.id>
					<cfset close_user_in_charge = getItemRootResult.user_in_charge>

				</cfif>

				<cfif close_user_in_charge EQ SESSION.user_id>
					<div class="btn-group">
						<a href="area_item_close.cfm?item=#close_item_id#&type=#itemTypeId#&area=#area_id##url_return_page#" onclick="return confirmAction('cerrar la #itemTypeNameEs#');" title="Cerrar #itemTypeNameEs#" class="btn btn-warning btn-sm" lang="es"><i class="icon-lock"></i> <span lang="es">Cerrar</span></a>
					</div>

				</cfif>

			</cfif>

		</cfif>


		<cfif itemTypeId IS 6><!---Tasks--->

			<cfif objectItem.done IS 0 AND objectArea.read_only IS false>

				<cfif objectItem.user_in_charge EQ SESSION.user_id OR objectItem.recipient_user EQ SESSION.user_id>

					<!--- <a href="area_item_done.cfm?item=#objectItem.id#&type=#itemTypeId#&area=#area_id#&done=1#url_return_page#" title="Marcar la #itemTypeNameEs# como realizada" class="btn btn-info btn-sm" lang="es"><i class="icon-ok"></i> <span lang="es">Realizada</span></a> --->

					<div class="btn-group">
						<a href="#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=changeAreaItemDone&item_id=#item_id#&itemTypeId=#itemTypeId#&done=true#url_return_path#" title="Marcar la #itemTypeNameEs# como realizada" onclick="return confirmReversibleAction('Marcar la #itemTypeNameEs# como realizada');" class="btn btn-default btn-sm" lang="es"><i class="icon-ok"></i> <span lang="es">Realizada</span></a>
					</div>

				</cfif>

			</cfif>

		</cfif>

		<cfif itemTypeId IS 5 OR itemTypeId IS 6><!--- Event OR Task --->

			<div class="btn-group">
				<a href="item_icalendar_download.cfm?item=#item_id#&itemTypeId=#itemTypeId#" title="Eportar en formato iCalendar (.ics)" class="btn btn-default btn-sm" onclick="return downloadFileLinked(this,event)" lang="es"><i class="fa fa-arrow-down"></i> <span lang="es">Exportar para calendario externo</span></a>
			</div>

		</cfif>

		<cfif isNumeric(objectItem.attached_file_id) AND objectItem.attached_file_id GT 0>

			<div class="btn-group">

				<a href="#APPLICATION.htmlPath#/file_download.cfm?id=#objectItem.attached_file_id#&#itemTypeName#=#objectItem.id#" onclick="return downloadFileLinked(this,event)" class="btn btn-default btn-sm"><i class="icon-download-alt"></i> <span lang="es">Adjunto</span></a>

				<!--- Convert files --->
				<cfif APPLICATION.moduleConvertFiles EQ true>

					<cfinvoke component="#APPLICATION.htmlComponentsPath#/File" method="outputConvertFileMenu">
						<cfinvokeargument name="file_type" value=".#listLast(objectItem.attached_file_name,'.')#">
						<cfinvokeargument name="file_id" value="#objectItem.attached_file_id#">
						<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
						<cfinvokeargument name="item_id" value="#item_id#">
					</cfinvoke>

				</cfif>

			</div>

		</cfif>

		<cfif itemTypeId IS 20><!--- DoPlanning document--->

			<div class="btn-group">
				<a href="#APPLICATION.htmlPath#/dp_document_generate_pdf.cfm?#itemTypeName#=#objectItem.id#" target="_blank" class="btn btn-default btn-sm"><i class="icon-file-text"></i> <span lang="es">PDF</span></a>
			</div>

			<cfif objectItem.area_editable IS true AND objectArea.read_only IS false><!--- Area editable --->

				<cfif objectItem.locked IS true>

					<cfif objectItem.lock_user_id IS SESSION.user_id OR is_user_area_responsible>
						<div class="btn-group">
							<a href="#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=lockAreaItem&item_id=#item_id#&itemTypeId=#itemTypeId#&area_id=#area_id#&lock=false&return_path=#return_path#" class="btn btn-warning btn-sm" onclick="return confirmLockDocument(false);"><i class="icon-unlock"></i> <span lang="es">Desbloquear</span></a>
						</div>
					</cfif>

				<cfelse>
					<div class="btn-group">
						<a href="#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=lockAreaItem&item_id=#item_id#&itemTypeId=#itemTypeId#&area_id=#area_id#&lock=true&return_path=#return_path#" class="btn btn-warning btn-sm" onclick="return confirmLockDocument(true);"><i class="icon-lock"></i> <span lang="es">Bloquear</span></a>
					</div>
				</cfif>

			</cfif>


		</cfif>

		<cfif itemTypeId IS 17 AND is_user_area_responsible AND objectItem.state NEQ "sent"><!--- Mailing --->

			<div class="btn-group">
				<button type="button" class="btn btn-primary btn-sm" onclick="confirmSendMailing(#item_id#, #itemTypeId#, #area_id#);"><i class="fa fa-paper-plane"></i> <span lang="es">Enviar boletín</span></a>
			</div>

		</cfif>

		<cfif ( itemTypeId IS NOT 7 OR objectItem.state EQ "created" ) AND objectArea.read_only IS false><!---Is not consultation or is not created--->

			<cfif objectItem.user_in_charge EQ SESSION.user_id OR (itemTypeId IS 1 AND SESSION.user_id IS SESSION.client_administrator)>

				<!--- getClient --->
				<cfinvoke component="#APPLICATION.htmlPath#/components/Client" method="getClient" returnvariable="clientQuery">
					<cfinvokeargument name="client_abb" value="#SESSION.client_abb#">
				</cfinvoke>

				<cfif clientQuery.bin_enabled IS true><!--- BIN Enabled --->
					<div class="btn-group">
						<a href="#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=deleteItem&item_id=#item_id#&area_id=#area_id#&itemTypeId=#itemTypeId##url_return_page#" onclick="return confirmReversibleAction('eliminar');" title="Eliminar #itemTypeNameEs#" class="btn btn-danger btn-sm"><i class="icon-trash"></i> <span lang="es">Eliminar</span></a>
					</div>
				<cfelse>
					<div class="btn-group">
						<a href="#APPLICATION.htmlComponentsPath#/AreaItem.cfc?method=deleteItem&item_id=#item_id#&area_id=#area_id#&itemTypeId=#itemTypeId##url_return_page#" onclick="return confirmAction('eliminar');" title="Eliminar #itemTypeNameEs#" class="btn btn-danger btn-sm"><i class="icon-remove"></i> <span lang="es">Eliminar</span></a>
					</div>
				</cfif>

				<!---
				Esto no se puede usar porque la alerta de confirmación se tiene que mostrar en la ventana padre, y al responder no se puede acceder a este frame para ejecutar el método correspondiente a la respuesta
				<script>
					function eliminarElemento(){

						confirmAction('eliminar');
					}
				</script>
				<a onclick="return parent.showConfirmModal('¿Seguro que desea eliminar?',function(){ confirmAction('eliminar'); })" title="Eliminar #itemTypeNameEs#" class="btn btn-danger btn-sm"><i class="icon-remove"></i> <span lang="es">Eliminar</span></a>--->

			</cfif>

		</cfif>

		<cfif ( objectItem.user_in_charge EQ SESSION.user_id OR is_user_area_responsible ) AND objectArea.read_only IS false>

			<div class="btn-group">
			<cfif itemTypeId IS NOT 1>
				<a href="item_change_user.cfm?item=#item_id#&itemTypeId=#itemTypeId#&area=#area_id#" class="btn btn-default btn-sm"><i class="icon-user"></i> <span lang="es">Cambiar propietario</span></a>
			</cfif>
			</div>

			<div class="btn-group">
			<cfif APPLICATION.changeElementsArea IS true>
				<a href="item_change_area.cfm?item=#item_id#&itemTypeId=#itemTypeId#&area=#area_id#" class="btn btn-default btn-sm"><i class="icon-cut"></i> <span lang="es">Mover a otra área</span></a>
			</cfif>
			</div>

		</cfif>


		<cfif itemTypeId LT 10 OR itemTypeId IS 17>

			<cfset copy_query_string = "sourceItemTypeId=#itemTypeId#&#itemTypeName#=#objectItem.id#">
			<div class="btn-group">
				<a href="##" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" title="Copiar a otras áreas">
				<i class="icon-copy"></i> <span lang="es">Copiar como</span> <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="message_copy.cfm?#copy_query_string#" lang="es">Mensaje</a></li>

					<cfif APPLICATION.moduleWeb EQ true>
						<li><a href="entry_copy.cfm?#copy_query_string#" lang="es">Elemento web</a></li>
						<cfif APPLICATION.identifier EQ "vpnet">
						<li><a href="link_copy.cfm?#copy_query_string#" lang="es">Enlace</a></li>
						</cfif>
						<li><a href="news_copy.cfm?#copy_query_string#" lang="es">Noticia</a></li>
					</cfif>

						<li><a href="event_copy.cfm?#copy_query_string#" lang="es">Evento</a></li>
					<cfif APPLICATION.identifier EQ "dp">
					<li><a href="task_copy.cfm?#copy_query_string#" lang="es">Tarea</a></li>
					</cfif>
					<li><a href="dp_document_copy.cfm?#copy_query_string#" lang="es">Documento DoPlanning</a></li>
					<cfif APPLICATION.moduleMailing IS true>
						<li><a href="mailing_copy.cfm?#copy_query_string#" lang="es">Boletín</a></li>
					</cfif>
					<cfif APPLICATION.moduleConsultations IS true>
					<li><a href="consultation_copy.cfm?#copy_query_string#" lang="es">Consulta</a></li>
					</cfif>
					<cfif APPLICATION.modulePubMedComments IS true>
						<li><a href="publication_copy.cfm?#copy_query_string#" lang="es">Publicación</a></li>
					</cfif>
				</ul>
			</div>

		</cfif>


		<cfif app_version NEQ "mobile">
			<div class="btn-group">
				<a href="#APPLICATION.htmlPath#/#itemTypeName#.cfm?#itemTypeName#=#item_id#" title="Abrir en nueva ventana" target="_blank" class="btn btn-default btn-sm" lang="es"><i class="icon-external-link"></i> <span lang="es">Ampliar</span></a>
			</div>
		</cfif>


		<cfif APPLICATION.moduleWeb EQ true AND ( area_type EQ "web" OR area_type EQ "intranet" ) AND objectItem.publication_validated IS NOT false>

			<cfif APPLICATION.moduleTwitter IS true AND area_type EQ "web">
				<div class="btn-group">
					<a href="#itemTypeName#_twitter.cfm?#itemTypeName#=#item_id#" class="btn btn-default btn-sm"><i class="icon-twitter"></i> Publicar en Twitter</a>
				</div>
			</cfif>

			<cfif (itemTypeId IS 4 OR itemTypeId IS 5) AND isDefined("webPath")>

				<!---areaWebUrl--->
				<cfinvoke component="#APPLICATION.coreComponentsPath#/UrlManager" method="getItemWebPageFullUrl" returnvariable="itemPageFullUrl">
					<cfinvokeargument name="item_id" value="#objectItem.id#">
					<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
					<cfinvokeargument name="title" value="#objectItem.title#">
					<cfinvokeargument name="path_url" value="#webPathUrl#">
					<cfinvokeargument name="path" value="#webPath#">
				</cfinvoke>

				<span class="divider">&nbsp;</span>

				<div class="btn-group">
					<a href="#itemPageFullUrl#" class="btn btn-default btn-sm" title="Ver en #area_type#" lang="es" target="_blank"><i class="icon-globe"></i> <span lang="es">Ver en #area_type#</span></a>
				</div>

			</cfif>

		</cfif>



	<cfelse><!---VPNET--->

		<cfinclude template="#APPLICATION.htmlPath#/includes/area_items_menu_vpnet.cfm">

	</cfif>

</div><!--- END btn-toolbar --->
</div><!---END div_elements_menu--->

<cfif itemTypeId IS 20 AND objectItem.area_editable IS true><!--- DoPlanning Document area editable--->


	<cfif objectItem.locked IS true>
		<div class="alert alert-warning">
			<span>Archivo bloqueado por</span> <a href="area_user.cfm?area=#objectItem.area_id#&user=#objectItem.lock_user_id#">#objectItem.lock_user_full_name#</a> (#objectItem.lock_date#)<br/>
			<span>Sólo este usuario puede editar el documento.</span>
			<!---<span lang="es">Fecha de bloqueo:</span> <span>#objectItem.lock_date#</span><br/>--->

		</div>

		<!---<div class="div_file_page_label">
			<span lang="es">Fecha de bloqueo:</span> <span class="text_file_page">#objectItem.lock_date#</span>
		</div>--->
	</cfif>


</cfif>

</cfoutput>
<cfinvoke component="#APPLICATION.htmlComponentsPath#/AreaItem" method="outputItem">
	<cfinvokeargument name="objectItem" value="#objectItem#">
	<cfinvokeargument name="itemTypeId" value="#itemTypeId#">
	<cfinvokeargument name="area_type" value="#area_type#">
	<cfif isDefined("webPath")>
		<cfinvokeargument name="webPath" value="#webPath#">
	</cfif>
	<cfinvokeargument name="categories" value="#itemCategories#"/>
	<cfinvokeargument name="internal_user" value="#loggedUser.internal_user#">
</cfinvoke>
