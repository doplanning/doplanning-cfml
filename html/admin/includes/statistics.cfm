<cfif isDefined("URL.from_date")>
	<cfset from_date = URL.from_date>
<cfelse>
	<cfset from_date = "">
</cfif>

<cfif isDefined("URL.end_date")>
	<cfset end_date = URL.end_date>
<cfelse>
	<cfset end_date = "">
</cfif>

<!--- getGeneralStatistics --->
<cfinvoke component="#APPLICATION.htmlComponentsPath#/Statistic" method="getGeneralStatistics" returnvariable="getStatisticsResponse">
	<cfif len(from_date) GT 0>
		<cfinvokeargument name="from_date" value="#from_date#"/>
	</cfif>
	<cfif len(end_date) GT 0>
		<cfinvokeargument name="end_date" value="#end_date#"/>
	</cfif>
</cfinvoke>

<cfset statisticsQuery = getStatisticsResponse.query>

<cfoutput>
<cfinclude template="#APPLICATION.htmlPath#/includes/tablesorter_scripts.cfm">
<link href="#APPLICATION.bootstrapDatepickerCSSPath#" rel="stylesheet" type="text/css" />
<script src="#APPLICATION.bootstrapDatepickerJSPath#"></script>
<script src="#APPLICATION.htmlPath#/bootstrap/bootstrap-datepicker/js/locales/bootstrap-datepicker.es.js" charset="UTF-8"></script>
</cfoutput>

<script>
	
	$(function() {

		$('#from_date').datepicker({
		  format: 'dd-mm-yyyy', 
		  autoclose: true,
		  weekStart: 1,
		  language: 'es',
		  todayBtn: 'linked',
		  endDate: $('#end_date').val()  
		});
	
		$('#end_date').datepicker({
		  format: 'dd-mm-yyyy',
		  weekStart: 1,
		  language: 'es',
		  todayBtn: 'linked', 
		  autoclose: true
		});

	});
	
	
	function setEndDate(){
		$('#from_date').datepicker('setEndDate', $('#end_date').val());
	}

	function setFromDate(){
		$('#end_date').datepicker('setStartDate', $('#from_date').val());
	}

</script>

<div class="container">

	<div class="row">
		<div class="col-sm-12">
			<div class="div_message_page_title" lang="es">Estadísticas generales</div>
		</div>
	</div>

	<cfoutput>

	<div class="row">
		<div class="col-sm-12">

			<div class="div_search_bar">

				<form method="get" name="statistics_form" action="#CGI.SCRIPT_NAME#" class="form-horizontal">

					<div class="row">

						<label for="from_date" class="col-xs-5 col-sm-3 control-label" lang="es"><i class="icon-calendar"></i>&nbsp;&nbsp;<span lang="es">Fecha desde</span></label> 

						<div class="col-xs-7 col-sm-9">
							<input type="text" name="from_date" id="from_date" class="form-control input_datepicker" value="#from_date#" onchange="setFromDate()">
						</div>

					</div>

					<div class="row">

						<label for="end_date" class="col-xs-5 col-sm-3 control-label"><i class="icon-calendar"></i>&nbsp;&nbsp;<span lang="es">Fecha hasta</span></label> 

						<div class="col-xs-7 col-sm-9">
							<input type="text" name="end_date" id="end_date" value="#end_date#" class="form-control input_datepicker" onchange="setEndDate()"/>
						</div>

					</div>

					<div class="row">

						<div class="col-sm-offset-3 col-sm-10"> 
							<input type="submit" name="search" class="btn btn-primary" style="margin-top:30px;" lang="es" value="Filtrar" />
						</div>

					</div>

				</form>

			</div>

		</div>
	</div>

	<cfinvoke component="#APPLICATION.coreComponentsPath#/AreaItemManager" method="getAreaItemTypesStruct" returnvariable="itemTypesStruct">
	</cfinvoke>

	<cfset itemTypesArray = structSort(itemTypesStruct, "numeric", "ASC", "position")>

	<script>

		$(document).ready(function() { 
			

			$("##statisticsTable").tablesorter({ 

				widgets: ['zebra','uitheme','filter','stickyHeaders','math'],<!---'select',--->
				theme : "bootstrap",
				headerTemplate : '{content} {icon}',<!---new in v2.7. Needed to add the bootstrap icon!--->
				headers: { 
					0: {
						sorter: "text"
					}
				}
				, widgetOptions : {
					filter_childRows : false,
					filter_columnFilters : true,
					filter_cssFilter : 'tablesorter-filter',
					filter_filteredRow   : 'filtered',
					filter_formatter : null,
					filter_functions : null,
					filter_hideFilters : false,
					filter_ignoreCase : true,
					filter_liveSearch : true,
					//filter_reset : 'button.reset',
					filter_searchDelay : 300,
					filter_serversideFiltering: false,
					filter_startsWith : false,
					filter_useParsedData : false

						, math_data     : 'math' // data-math attribute
					    , math_ignore   : [0,1,2,3,4,7,8,9]
					    , math_mask     : '##000,##'
					    <!---. math_mask     : '##,####0.00'--->
					    <!---, math_complete : function($cell, wo, result, value, arry) {
					        var txt = '<span class="align-decimal"> ' + result + '</span>';
					        if ($cell.attr('data-math') === 'all-sum') {
					          // when the "all-sum" is processed, add a count to the end
					          return txt + ' (Sum of ' + arry.length + ' cells)';
					        }
					        return txt;
					    } --->

			    }
			});

		}); 
	</script>
	
	<div class="row">
		<div class="col-sm-12">

			<table id="statisticsTable" class="tablesorter" style="margin-top:20px;">

				<thead>
					<tr>
						<th><span lang="es">Elemento</span></th>
						<th><span lang="es">Registros</span></th>	
					</tr>
				</thead>

				<tfoot>
				   	<tr>
				   		<th></th>
				   		<th data-math="col-sum"></th>
					</tr>
				</tfoot>

				
				<tbody>

					<cfloop array="#itemTypesArray#" index="curItemTypeId">
					<tr>
						<td><span lang="es">#itemTypesStruct[curItemTypeId].labelPlural#</span></td>			
						<td>#statisticsQuery['#itemTypesStruct[curItemTypeId].table#_count']#</td>
					</tr>
					</cfloop>

				</tbody>

				<tbody class="tablesorter-infoOnly">
				    <tr>
				      <th><span lang="es">Total elementos de área</span></th>
				      <th data-math="above-sum">above-sum</th>
				    </tr>
				</tbody>

				<tbody>

					<tr>
						<td><span lang="es">Áreas</span></td>			
						<td>#statisticsQuery.areas_count#</td>
					</tr>

					<tr>
						<td><span lang="es">Usuarios</span></td>			
						<td>#statisticsQuery.users_count#</td>
					</tr>				  

					<tr>
						<td><span lang="es">Accesos a la aplicación</span></td>			
						<td>#statisticsQuery.users_login_success_count#</td>
					</tr>

					<tr>
						<td><span lang="es">Login fallidos</span></td>			
						<td>#statisticsQuery.users_login_failed_count#</td>
					</tr>

				</tbody>

			</table>

		</div>
	</div>

	</cfoutput>

</div>