
<%@ page import="de.tp.Day" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'day.label', default: 'Day')}" />
		<title>SmartPlan</title>
		
		<r:require modules="jquery"/>
		
		<r:script>
			$(document).ready(function() {
				$('td.dayDescription').click(function() {
					var dayid = $(this).parent().attr('dayid');
					$('tr.accorow[dayid='+dayid+']').toggleClass('hidden');
					$('tr.stagerow[dayid='+dayid+']').toggleClass('hidden');
				});	
				
				$('a.find').click(function() {
					if ($('tr.dayrow').eq(0).next().hasClass('hidden')) {
						$('tr.accorow,tr.stagerow').removeClass('hidden');
					} else {
						$('tr.accorow,tr.stagerow').addClass('hidden');
					}
				});
			});
		</r:script>
		
		<style>
			.dayDescription:hover {
				cursor: pointer;
			}
		</style>
		
	</head>
	<body>
	
	
		<%-- 2nd LEVEL NAVIGATION --%>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				
				<g:if test="${dayInstanceList}">
					<g:set var="firstWeekNo" value="${dayInstanceList[0].date?.format('w') as Long}" />
					<g:each in="${dayInstanceList*.date*.format('w').unique()}" status="weekNo" var="w">
						<g:set var="currentWeek" value="${(w.toLong() - firstWeekNo + 1)}" />
<%--						<li ><a class="weekcolor_${w.toLong() % 6}" href="#week${currentWeek}">${currentWeek}</a></li>--%>
						<li ><g:link class="weekcolor_${w.toLong() % 6}" params="${[week:(currentWeek-1)]}">${currentWeek}</g:link></li>
					</g:each>
				</g:if>
				<li><a style="cursor: pointer;" class="find"><g:message code="toggle.allrows" /></a></li>
 			</ul>
		</div>
		
		
		<%-- DAY LIST --%>
		<div id="list-day" class="content scaffold-list" role="main">
		
			<table>
				<thead>
					<tr>
						<th style="width:10px;"></th>
						<th style="width: 60px">${message(code: 'day.date.label')}</th>
						<th>${message(code: 'day.description.label', default: 'Description')}</th>
<%--						<th style="width:60px;"><g:message code="night.booked.short.label" /></th>--%>
<%--						<th style="width:60px;"><g:message code="night.paid.short.label" /></th>--%>
					</tr>
				</thead>
				<tbody>
				<g:each in="${displayInstanceList}" status="i" var="dayInstance">
					
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'} dayrow" 
						id="${dayInstance.date.day == 1 ? 'week' + (dayInstance.date.format('w').toLong() - firstWeekNo + 1) :''}"
						dayid="${dayInstance.id}">
						
						<td class="weektd weekcolor_${(dayInstance.date?.format('w') as Long) % 6}">
							<g:link class="nounderline" action="show" id="${dayInstance.id}">
								<tp:weekdaybox date="${dayInstance.date}" />
							</g:link>
						</td>
						<td style="text-align: center;">${dayInstance.date?.format('dd.MM.')}</td>
						<td class="dayDescription">${fieldValue(bean: dayInstance, field: "description")}</td>
<%--						<td><g:link class="edit" action="edit" id="${dayInstance.id}" >${message(code: 'default.button.edit.label')}</g:link></td>--%>
<%--						<td><g:link class="managestages" action="manageStages" id="${dayInstance.id}" >${message(code: 'manage.stages.label')}</g:link></td>--%>

					</tr>
					
					<!-- Dawn Night -->
					<tr class="hidden accorow dawn ${(i % 2) == 0 ? 'even' : 'odd'}" dayid="${dayInstance.id}">
						<g:set var="night" value="${dayInstance.dawnNight}" />
						<td><g:img dir="/images/tango/22x22/" file="weather-few-clouds.png" /></td>
						<td style="text-align: center;">${dayInstance.date?.format('HH:mm')}</td>
						
						<g:if test="${night?.accomodation}">
							<td><g:link controller="night" action="show" id="${night?.id}">${night?.accomodation}</g:link></td>
						</g:if>
						<g:else>
							<td><g:link controller="night" action="show" id="${night?.id}">${night}</g:link></td>
						</g:else>
						
<%--						<td><tp:yesno value="${night?.booked}" /></td>--%>
<%--						<td><tp:yesno value="${night?.paid}" /></td>--%>
					</tr>
					
					<g:each in="${dayInstance.stages.sort { it.time }}" status="j" var="s">
					<tr class="hidden stagerow ${(i % 2) == 0 ? 'even' : 'odd'}" dayid="${dayInstance.id}">
						<td></td>
						<td style="text-align: center;">${s.time?.format("HH:mm")}</td>
						<td colspan="1"><g:link controller="stage" action="edit" id="${s.id}">${s}</g:link></td>
<%--						<td><tp:formatDistance value="${s.distance}" /></td>--%>
<%--						<td><tp:formatDuration value="${s.staySeconds}" /></td>--%>
					</tr>
					</g:each>
					
					<!-- Dusk Night -->
					<tr class="hidden accorow dusk ${(i % 2) == 0 ? 'even' : 'odd'}" dayid="${dayInstance.id}">
						<g:set var="night" value="${dayInstance.duskNight}" />
						<td><g:img dir="/images/tango/22x22/" file="weather-few-clouds-night.png" /></td>
						<td style="text-align: center;">${night?.arrivalTime?.format('HH:mm')}</td>
						<g:if test="${night?.accomodation}">
							<td><g:link controller="night" action="show" id="${night?.id}">${night?.accomodation}</g:link></td>
						</g:if>
						<g:else>
							<td><g:link controller="night" action="show" id="${night?.id}">${night}</g:link></td>
						</g:else>
<%--						<td><tp:yesno value="${night?.booked}" /></td>--%>
<%--						<td><tp:yesno value="${night?.paid}" /></td>--%>
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
