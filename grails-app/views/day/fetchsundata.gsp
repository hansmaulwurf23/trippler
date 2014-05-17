<%@ page import="de.tp.Day" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title><g:message code="sundata.short.label" /></title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
		<r:require modules='sunriseset, moment'/>
		
		<script>
			$(document).ready(function() {
				$('#fetch').click(function() {
					fetchData();
				});
			
			});

			var timeZoneOffsets = new Object();
			timeZoneOffsets['Utah'] = -6;
			timeZoneOffsets['Arizona'] = -6;
			timeZoneOffsets['Colorado'] = -6;
			timeZoneOffsets['Nevada'] = -6;
			timeZoneOffsets['New Mexico'] = -6;
			timeZoneOffsets['Kalifornien'] = -7;
			
			
			var fetchData = function() {
				$('.weektd').each(function(idx, elem) {
					var dayid = $(elem).parent().attr('dayid');
					var sunriseSpan = $(elem).find('span.sunrise');
					var lat = $(sunriseSpan).attr('lat');
					var lon = $(sunriseSpan).attr('lon');
					var day = $(sunriseSpan).attr('day');
					var month = $(sunriseSpan).attr('month');
					var state = $(sunriseSpan).attr('state');
					
					if (day && month && lat && lon) {
						var suninfo = new SunriseSunset(2013, month, day, lat, lon);
						$('td.sunrise[dayid='+dayid+']').html(convertHoursToTime(24 + suninfo.sunriseUtcHours() + timeZoneOffsets[state]));
						$('td.sunset[dayid='+dayid+']').html(convertHoursToTime(48 + suninfo.sunsetUtcHours() + timeZoneOffsets[state]));
					}
				});
			};

			var convertHoursToTime = function(hours) {
				var h = Math.floor(hours);
				hours = hours - h;
				var m = Math.round(hours*60);
				if (m < 10) {
					return h + ":0" + m;
				} else {
					return h + ":" + m;
				}
			}
			
		
		</script>
		
	</head>
	<body>
		<a href="#create-day" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="['Tag']" /></g:link></li>
			</ul>
		</div>
		<div id="create-day" class="content scaffold-create" role="main">
			<h1><g:message code="sundata.long.label" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<fieldset class="buttons">
				<g:submitButton name="fetch" class="list" value="${message(code: 'default.button.fetch.data.label')}" />
				<g:submitButton name="save" class="save" value="${message(code: 'default.button.save.label')}" />
			</fieldset>
			
			<table>
				<thead>
					<tr>
						<th style="width:10px;"></th>
						<th style="width: 60px">${message(code: 'day.date.label')}</th>
						<th>${message(code: 'day.description.label', default: 'Description')}</th>
						<th style="width:60px;"><g:message code="sunrise.label" /></th>
						<th style="width:60px;"><g:message code="sunset.label" /></th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${days}" status="i" var="day">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'} dayrow" dayid="${day.id}">
						<td class="weektd weekcolor_${(day.date?.format('w') as Long) % 6}">
							<g:link class="nounderline" action="show" id="${day.id}">
								<tp:weekdaybox date="${day.date}" />
							</g:link>
							
							<span 	class="hidden sunrise" 
								dayid="${day.id}" 
								day="${day.date.date}" month="${day.date.month+1}"
								state="${day.dawnNight?.accomodation?.address?.state}"
								lat="${day.dawnNight?.accomodation?.address?.latitude}" 
								lon="${day.dawnNight?.accomodation?.address?.longitude}" ></span>
								
							<span 	class="hidden sunset" 
								dayid="${day.id}" 
								day="${day.date.date}" month="${day.date.month+1}"
								state="${day.dawnNight?.accomodation?.address?.state}" 
								lat="${day.duskNight?.accomodation?.address?.latitude}"
								lon="${day.duskNight?.accomodation?.address?.longitude}" ></span>
							
							
						</td>
						<td style="text-align: center;">${day.date?.format('dd.MM.')}</td>
						<td>${fieldValue(bean: day, field: "description")}</td>
						<td class="sunrise" dayid="${day.id}"><g:formatDate date="${day.sunrise}" format="HH:mm" /></td>
						<td class="sunset" dayid="${day.id}"><g:formatDate date="${day.sunset}" format="HH:mm" /></td>
						
					</tr>
				</g:each>
				</tbody>
			</table>
			
		</div>
	</body>
</html>
