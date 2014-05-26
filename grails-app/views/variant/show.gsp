
<%@ page import="de.tp.Variant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'variant.label', default: 'Variant')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<r:require modules="jquery-ui, jquery, googleMaps, select2" />
	</head>
	<body>
		<a href="#show-variant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="switchVariant"><g:message code="default.switch.variant" default="Switch Variant" /></g:link></li>
			</ul>
		</div>
		<div id="show-variant" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list variant">
			
				<g:if test="${variantInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="variant.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${variantInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${variantInstance?.holiday}">
				<li class="fieldcontain">
					<span id="holiday-label" class="property-label"><g:message code="variant.holiday.label" default="Holiday" /></span>
					
						<span class="property-value" aria-labelledby="holiday-label"><g:link controller="holiday" action="show" id="${variantInstance?.holiday?.id}">${variantInstance?.holiday?.encodeAsHTML()}</g:link></span>
					
					<!-- HANS -->
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${variantInstance?.id}" />
					<g:link class="edit" action="edit" id="${variantInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
