
<%@ page import="de.tp.Day" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'day.label', default: 'Job')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		
		<!-- TODO include JQuery and JQuery-UI via plugins (resources) as soon as JQuery-UI 1.9 is available -->
<%--		<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />--%>
<%--		<script src="http://code.jquery.com/jquery-1.8.2.js"></script>--%>
<%--		<script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>--%>
		
		<r:require modules="jquery-ui, googleMaps, datePickers, moment, stageManagement"/>
		
		<tooltip:resources/>
		
		<r:script>
			var jobStartMillies = ${day.date.getTime()};
			var activeRequests = 0;
			var totalStages = 0;
			
			$(document).ready(function() {
			
				var toggleWaitingTimes = function() {
					$('.waitingtime').toggleClass('hidden');
				};
				
				// handle switching waiting times
				$('#waitingTimes').click(function() {
					toggleWaitingTimes();
				}); 
			
				// initialize pre-existing stages
				var data;
				
				// dawn night
				<g:if test="${dawn?.accomodation}">
					data = new Object();
					data.id = "dawn";
					data.time = "${day.date.format('HH:mm')}";
					data.addressid = ${dawn.accomodation.address.id};
					data.address = "${dawn.accomodation.address.toSearchableString()}";
					data.lat = "${dawn.accomodation.address.latitude}";
					data.long = "${dawn.accomodation.address.longitude}";
					data.label = "${dawn.accomodation.name.toString() + (dawn.accomodation.address ? " (" + dawn.accomodation.address + ")" : "") }";
					$('#stages').append(createNightRow(data));
					$('#dawn').find('input.timepicker').val(data.time);
				</g:if>
				
				<g:if test="${dayStages}">
					var waitingTimeStagesFound = false;
					<g:each in="${dayStages}" status="i" var="ds">
						data = new Object();
						data.id = ${ds.id};
						data.addressid = ${ds.address.id};
						data.address = "${ds.address.toSearchableString()}";
						data.label = "${ds.name.toString() + (ds.address ? " (" + ds.address + ")" : "") }";
					
						// init time pickers
						$('#stages').append(createStageRow(data, totalStages));
						var timePicker = $('li#' + totalStages).find('input.timepicker'); 
						createTimePickers(timePicker);
						$(timePicker).datepicker('setTime', new Date(${ds.time?.time}));
						
						// init waiting times
						<g:if test="${ds.staySeconds}">
							$('li#' + totalStages).find('input.waitingtime').val(${ds.staySeconds?.div(60)});
							waitingTimeStagesFound = true;
						</g:if>
						
						totalStages++;
					</g:each>
					
					if (waitingTimeStagesFound) {
						toggleWaitingTimes();
						$('#waitingTimes').prop('checked', waitingTimeStagesFound);
					}
				</g:if>
				
				// dusk night
				<g:if test="${dusk?.accomodation}">
					data = new Object();
					data.id = "dusk";
					data.addressid = ${dusk.accomodation.address.id};
					data.address = "${dusk.accomodation.address.toSearchableString()}";
					data.label = "${dusk.accomodation.name.toString() + (dusk.accomodation.address ? " (" + dusk.accomodation.address + ")" : "") }";
					$('#stages').append(createNightRow(data));
					createTimePickers($('#dusk').find('input.timepicker'));
					<g:if test="${dusk?.arrivalTime}">
					$('#dusk').find('input.timepicker').datepicker('setTime', new Date(${dusk?.arrivalTime?.time}));
					</g:if>
				</g:if>
				
				// handle removing a stage
				$('span.removestage').live('click', function() {
					$(this).closest('li').remove();
				});
			
			
				// add a new stage (search and autocomplete a client)
				$('#stageString').autocomplete({
					source: "${g.createLink(controller:'stage', action:'search')}",
					minLength: 2,
					select: function( event, ui ) {
						$('#stage\\.id').val(ui.item.id);
						var duskNight = $('#dusk'); 
						
						if ($(duskNight).length > 0) {
							$(duskNight).before(createStageRow(ui.item, totalStages));
						} else {
							$('#stages').append(createStageRow(ui.item, totalStages));
						}
						
						$('li#' + totalStages).find('.waitingtime').toggleClass('hidden', !$('#waitingTimes').prop('checked'));
						
						createTimePickers($('li#' + totalStages).find('input.timepicker'));						
						totalStages++;
						
						$('#stageString').val( '' ).focus();
						
						return false;
					}
				});
				
				
				// create time pickers 
				function createTimePickers(domElem) {
					var config = {
						timeFormat: 'h:mm',
						ampm: false,
						stepMinute: 5
					};
					
					// FIXME						
					// TO BE REPLACED by jquery-ui timespinner
					if (domElem !== 'undefined') {
						$(domElem).timepicker(config); 
					} else {
						$('.timepicker').timepicker(config);
					}
					
					//$(domElem).timespinner();
				}
				
				// calculate distances and durations
				$('#fetchDistances').click(function() {
					if ($('#stages .stage').length < 2) {
						alert("Es sind zu wenig Stationen vorhanden, um Entfernungen zu berchnen!");
						return;
					}
					
					var prevDomElem;
					
					activeRequests = $('#stages .stage').length - 1; 
					
					$('#stages .stage').each(function(index, domElem) {
						if (index > 0) {
							var sourceAddr = $(prevDomElem).attr('address');
							var sourceId = $(prevDomElem).attr('addressid');
							var destAddr = $(domElem).attr('address');
							var destId = $(domElem).attr('addressid');
							getdistance("${g.createLink(controller:'distanceapi')}", sourceAddr, sourceId, destAddr, destId, function(data) {
								console.log(activeRequests);
								activeRequests--;
								if (data.status == 'OK') { 
									if ($(domElem).find('.distanceinfo').length < 1) {
										$(domElem).append('<span class="distanceinfo"></span>');
									}
									$(domElem).find('span.distanceinfo').html(transformDistance(data.distance.distance) + ' ' + transformDuration(data.distance.duration));
									$(domElem).find('span.distanceinfo').attr('duration', data.distance.duration);
									$(domElem).find('span.distanceinfo').attr('distance', data.distance.distance);
								} else {
									$('#log').append(JSON.stringify(data));
								}
							});
						} 
						
						prevDomElem = domElem;
					});
					
					
					setTimeout("updateStageTimeOffsets()", 50);
				});
				
				
				// store stages to the backend
				$('#storeStages').click(function() {
					var requestParams = new Object();
					requestParams.dayid = ${day.id};
				
					var stageData = new Array();
					var waitingTime = 0;
					$('#stages .stage').not('#dusk').not('#dawn').each(function(index, domElem) {
						if ($('#waitingTimes').attr('checked')) {
							waitingTime = Number($(domElem).find('input.waitingtime').val()) * 60;					
						}
					
						stageData[index] = { 
							addressid	: $(this).attr('addressid'), 
							stageid	: $(this).attr('stageid'), 
							time		: $(this).find('.timepicker').datetimepicker('getDate').getTime(),
							distance	: $(this).find('.distanceinfo').attr('distance'),
							staySeconds : waitingTime
						};
					});
					
					var dusk = $('#stages .stage#dusk');
					var duskData = {
						time		: $(dusk).find('.timepicker').datetimepicker('getDate').getTime(),
						distance	: $(dusk).find('.distanceinfo').attr('distance'),
						duration	: $(dusk).find('.distanceinfo').attr('duration')
					};
					
					requestParams.duskData = duskData;
					requestParams.stages = stageData;
					
					$.post("${g.createLink(controller:'day', action:'updateStages')}", { data : JSON.stringify(requestParams) }, function(data) {
						console.log(data);
						if (data.status == 'OK') {
							window.location.href = window.location.href; 
						}
					});
				});
				
				$('#stages').sortable({
					items: "li:not(.night)",
					change: function(event, ui) { 
						$('#stages span.distanceinfo').remove();
						$('#stages input.timepicker').val('');
					}
				});
				
				$('#clearAllTimes').click(function() {
					$('.timepicker').val('').change();
				});
				
				$('.fixedStage').mouseover(function() { tooltip.show('Feste Stationszeit'); });
				$('.fixedStage').mouseout(function() { tooltip.hide(); });
				$('.waitingtime').mouseover(function() { tooltip.show('Wartezeit in Minuten'); });
				$('.waitingtime').mouseout(function() { tooltip.hide(); });
			});
			
			// deferred updating the durations timepickers, because of the unknown callback order (this may need fixing later on)
			var updateStageTimeOffsets = function() {
				if (activeRequests > 0) {
					setTimeout("updateStageTimeOffsets()", 50);
					return;
				}
				
				var currentStart = jobStartMillies;
				var stageTimes = new Array();
				var waitingTime = 0;
				
				// then calculate the stage times as if there was nothing preset
				$('#stages .stage').each(function(index, domElem) {
					if (index > 0) {
						currentStart = currentStart + (Number($(domElem).find('span.distanceinfo').attr('duration')) * 1000) + waitingTime;					
					}
					var stageTime = roundTime(currentStart);
					currentStart = stageTime.valueOf();
					stageTimes[index] = stageTime;
					
					// store waiting time of this stage, so it can be added on the next stage's time
					if ($('#waitingTimes').attr('checked')) {
						if ($(domElem).find('input.waitingtime').length > 0) {
							waitingTime = Number($(domElem).find('input.waitingtime').val()) * 60 * 1000;
						} else {
							waitingTime = 0;
						}
					}
				});
				
				// set the stage times finally 
				$('#stages .stage').each(function(index, domElem) {
					$(domElem).find('input.timepicker').datepicker('setTime', stageTimes[index].toDate());
				});
			};
		</r:script>
		
	</head>
	<body>
		<a href="#show-day" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="list" action="dayview"><g:message code="dayview" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-day" class="content scaffold-show" role="main">

			<h1><g:message code="manage.stages" /></h1>
			<g:if test="${flash.message}">
			<div id="log" class="message" role="status">${flash.message}</div>
			</g:if>
			
			<tp:dayinfo day="${day}" />

			<div class="fieldcontain">
				<label for="stage"><g:message code="add.stage" /></label>:
				<g:textField name="stageString" />
				<g:hiddenField name="stage.id" />
			</div>

			<h1>Stationen</h1>
			
			<ul class="sortable" id="stages">
			</ul>
			
			<g:checkBox name="waitingTimes" style="margin-right: 4px; margin-left: 80px; margin-bottom: 15px;"/><g:message code="plan.stay.in.stage" />
			
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField id="jobid" name="id" value="${jobInstance?.id}" />
					<a class="edit" id="clearAllTimes"><g:message code="default.button.clearAllTimes.label" /></a>
					<a class="edit" id="fetchDistances"><g:message code="default.button.fetchDistance.label" /></a>
					<a class="save" id="storeStages"><g:message code="default.button.save.label" /></a>
				</fieldset>
			</g:form>
		</div>
		
	</body>
</html>
