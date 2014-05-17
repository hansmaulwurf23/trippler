
<%@ page import="de.mf.tp.Day" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'day.label', default: 'Day')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<r:require modules="jquery-ui, jquery, googleMaps, select2" />
	</head>
	<body>
		<a href="#show-day" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-day" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list day">
			
				<g:if test="${dayInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="day.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${dayInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dayInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="day.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${dayInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dayInstance?.stages}">
				<li class="fieldcontain">
					<span id="stages-label" class="property-label"><g:message code="day.stages.label" default="Stages" /></span>
					
						<g:each in="${dayInstance.stages}" var="s">
						<span class="property-value" aria-labelledby="stages-label"><g:link controller="stage" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${dayInstance?.id}" />
					<g:link class="edit" action="edit" id="${dayInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
