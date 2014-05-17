
<%@ page import="de.mf.tp.Accomodation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'accomodation.label', default: 'Accomodation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-accomodation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="exportpoi"><g:message code="default.exportpoi.label" /></g:link></li>
				<li><g:link class="create" action="exportstagepoi"><g:message code="default.exportstagepoi.label" /></g:link></li>
			</ul>
		</div>
		<div id="list-accomodation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'accomodation.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="price" title="${message(code: 'accomodation.price.label', default: 'Price')}" />
					
						<g:sortableColumn property="link" title="${message(code: 'accomodation.link.label', default: 'Link')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'accomodation.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="notes" title="${message(code: 'accomodation.notes.label', default: 'Notes')}" />
					
						<g:sortableColumn property="roominfo" title="${message(code: 'accomodation.roominfo.label', default: 'Roominfo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${accomodationInstanceList}" status="i" var="accomodationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${accomodationInstance.id}">${fieldValue(bean: accomodationInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: accomodationInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: accomodationInstance, field: "link")}</td>
					
						<td>${fieldValue(bean: accomodationInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: accomodationInstance, field: "notes")}</td>
					
						<td>${fieldValue(bean: accomodationInstance, field: "roominfo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${accomodationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
