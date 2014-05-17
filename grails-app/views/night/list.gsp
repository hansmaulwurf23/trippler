
<%@ page import="de.tp.Night" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'night.label', default: 'Night')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="export"/>
	</head>
	<body>
		<a href="#list-night" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-night" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table style="font-size: 0.9em;">
				<thead>
					<tr>
						<g:sortableColumn style="width:200px;" property="midnight" title="${message(code: 'night.midnight.label', default: 'Midnight')}" />
						<th><g:message code="night.accomodation.label" default="Accomodation" /></th>
						<th style="width:60px;"><g:message code="night.booked.short.label" /></th>
						<th style="width:60px;"><g:message code="night.paid.short.label" /></th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${nightInstanceList}" status="i" var="nightInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${nightInstance.id}">
								<g:formatDate date="${nightInstance.midnight?.minus(1)}" format="dd." />&rarr;
								<g:formatDate date="${nightInstance.midnight}" format="dd.MM." />
								<g:formatDate date="${nightInstance.midnight?.minus(1)}" format="(E)" />&rarr;
								<g:formatDate date="${nightInstance.midnight}" format="(E)" />
							</g:link></td>
						<td>${nightInstance.accomodation}</td>
						<td><tp:yesno value="${nightInstance?.booked}" /></td>
						<td><tp:yesno value="${nightInstance?.paid}" /></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${nightInstanceTotal}" />
			</div>
			
			<export:formats formats="['csv', 'excel', 'pdf']" />
		</div>
	</body>
</html>
