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
				
				$('a.find').click(function() {
					if ($('tr.dayrow').eq(0).next().hasClass('hidden')) {
						$('tr.accorow,tr.stagerow').removeClass('hidden');
					} else {
						$('tr.accorow,tr.stagerow').addClass('hidden');
					}
				});
				
			});
		</r:script>
		
		
		
	</head>
	<body>
	
	
		<%-- 2nd LEVEL NAVIGATION --%>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				
				<g:each in="${weekMap.keySet()}" var="weekNo" status="i">
					<li><a class="weekcolor_${weekNo % 6}" href="#week_${weekNo}_0">${i + 1}</a></li>
				</g:each>
				
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
					</tr>
				</thead>
				<tbody>
				
				<g:each in="${weekMap}" status="i" var="weekMapEntry">
				
					<%-- Render each week in the map --%>
					<g:render template="week" model="${[entry:weekMapEntry]}" />
				
				</g:each>
				
				</tbody>
			</table>
		</div>
	</body>
</html>
