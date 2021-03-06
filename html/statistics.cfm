<cfprocessingdirective suppresswhitespace="true">
<!DOCTYPE html>
<html lang="es">
<head>
	<script src="http://d3js.org/d3.v3.min.js"></script>
  <script src="http://dimplejs.org/dist/dimple.v2.1.6.min.js"></script>
	<script src="./Scripts/areaBar.js"></script>
	<script src="./Scripts/mlineBrush.js"></script>
	<script src="./Scripts/areaTree.js"></script>

	<!-- stylesheet for visualization -->
	 <link rel="stylesheet" href="./styles/visualization.css">


<cfoutput>

<title>Estadísticas #APPLICATION.title#<cfif isDefined("SESSION.client_name")> - #SESSION.client_name#</cfif></title>

<cfinclude template="#APPLICATION.htmlPath#/includes/html_head.cfm">

<script src="#APPLICATION.path#/jquery/jquery.serializecfjson-0.2.min.js"></script>

</cfoutput>

<!--- isUserUserAdministrator --->
<cfinvoke component="#APPLICATION.componentsPath#/UserManager" method="isUserUserAdministrator" returnvariable="isUserUserAdministratorResponse">
	<cfinvokeargument name="check_user_id" value="#SESSION.user_id#">
</cfinvoke>

<cfif isUserUserAdministratorResponse.result IS false>
	<cfthrow message="#isUserUserAdministratorResponse.message#">
<cfelse>
	<cfset isUserAdministrator = isUserUserAdministratorResponse.isUserAdministrator>
</cfif>

<script>

	var totalItems;
	<cfoutput>

	function getTotalItemsByUser(areaId, areaType, includeSubareas) {

			return $.ajax({
					url: '#APPLICATION.htmlComponentsPath#/Statistic.cfc',
					data: {
							method: 'getTotalItemsByUser',
							area_id: areaId,
							area_type: areaType,
							include_subareas: includeSubareas
					},
					method:'POST',
					dataType:"json",
					success: function(data, textStatus){

						if( textStatus == "success"){

							if(data.result == true) {

								<!---console.log(data);--->

								<!--- Esto es necesario para que funcione bien serializeCFJSON, que falla y no realiza la conversión correctamente
								http://www.cutterscrossing.com/index.cfm/2012/5/2/JQuery-Plugin-serializeCFJSON
								En lugar de esto se puede llamar a standardiseCfQueryJSON que parece que funciona correctamente
								--->
								<!---var temp = new Object();
								temp.data = data.totalItems;

								var totalItems = $.serializeCFJSON(temp).data;--->


							}else{
								alert(data.message);
							}


						} else
							alert(textStatus);

					},
					error: function(jqXHR, textStatus, errorThrown){
						alert(textStatus+": "+errorThrown);
					}
			});

	}
	function getAllItemsArea(areaId, areaType, includeSubareas){

		return $.ajax({

				url: '#APPLICATION.htmlComponentsPath#/Statistic.cfc',
				data:{
					method: 'getTotalItemsByDay',
					area_id: areaId,
					area_type: areaType,
					include_subareas: includeSubareas
				},
				method: 'POST',
				dataType:'json',
				success: function(data, textStatus){

					if(textStatus == 'success'){

						if( data.result == true){

							mline(data.totalItems);

						}else{
							alert(data.message);
						}
					}else{
						alert(textStatus);
					}

				},
				error: function(jqXHR, textStatus, errorThrown){
					alert( textStatus + ':' + errorThrown);
				}
		});
	}

	function getMainTreeXml(areaId, areaType, includeSubareas) {

	    return $.ajax({
	        url: '#APPLICATION.htmlComponentsPath#/Area.cfc',
	        data: {
	            method: 'getMainTreeXml',
	            area_id: areaId,
	            area_type: areaType,
	            include_subareas: includeSubareas
	        },
	        method:'POST',
	        dataType: "xml",
	          success:function(xml){

								// Modify root node
								// Add name and id to root node
								xml.childNodes[0].setAttribute("name", "root");
								var rootId = xml.childNodes[0].attributes.item(1).nodeValue;
								xml.childNodes[0].setAttribute("id", rootId);

								areaTree(xml);

	          }
	    });

	}

	function resizeStackLegend() {

		$('##stackLegend').height($('##userLogArea').height());

	}

	</cfoutput>

	$(window).load( function() {

	});

	$(document).ready(function () {

		// Alert
		$('#alertContainer .close').click(function(e) {

			hideAlertMessage();

		});

	});

</script>
</head>

<body onBeforeUnload="onUnloadPage()" onLoad="onLoadPage()" class="body_global">

<!---divLoading--->
<cfinclude template="#APPLICATION.htmlPath#/includes/loading_page_div.cfm">

<!--- Alert --->
<cfinclude template="#APPLICATION.htmlPath#/includes/main_alert.cfm">

<div id="wrapper"><!--- wrapper --->

	<cfinclude template="#APPLICATION.htmlPath#/includes/app_head.cfm">

	<div id="page-content-wrapper"><!--- page-content-wrapper --->

		<div class="container app_main_container">

			<cfinclude template="#APPLICATION.htmlPath#/includes/area_head.cfm">

			<script>

				<cfoutput>

				$(document).ready(function () {

					var promise = getTotalItemsByUser(#URL.area#, '#area_type#', true);

						promise.success(function (data) {

						drawChart(data.totalItems);

						resizeStackLegend();

					});

					getAllItemsArea(#URL.area#, '#area_type#', true);

					getMainTreeXml(#URL.area#, '#area_type#', true);


			    $(window).resize(function() {

						resizeStackLegend();

			    }).trigger('resize');

				});

				</cfoutput>

			</script>


			<!--- PAGE CONTENT HERE --->


			<div class="row" >
			 	<div id="userLogArea" class="col-lg-9 col-md-9 col-sm-9"><h5>Per User Item Log </h5> </div>
				<div id="stackLegend" class="col-lg-3 col-md-3 col-sm-3"></div>
		 	</div>

			<div class="row">
			 <div id="mlineBrush" class="col-lg-9 col-md-9 col-sm-9"><h5>Per User Item Usage Over Time</h5></div>
			  <div id="mlineLegend" class="col-lg-3 col-md-3 col-sm-3"></div>
		 </div>

		 <div class="row">
			 <div id="treeContainer" class="col-lg-12 col-md-12 col-sm-12"><h5>Tree View </h5> <span>Hirarchial Representation Of User Area<span></div>
		 </div>


			<!--- END PAGE CONTENT --->

		</div>

	</div><!---END page-content-wrapper --->

</div>

</body>
</html>
</cfprocessingdirective>
cd
