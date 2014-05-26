<%@ page import="de.tp.Variant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'variant.label', default: 'Variant')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<r:require modules="jquery-ui, jquery, googleMaps, select2" />
	</head>
	<body>
		<a href="#create-variant" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-variant" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${variantInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${variantInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="form">
					<div class="fieldcontain ${hasErrors(bean: variantInstance, field: 'name', 'error')} ">
						<label for="copyFromVariant">
							<g:message code="copyFromVariant" default="Copy Stages, Days and Nights from Variant:" />
						</label>
						<g:select name="copyFromVariant" noSelection="[[id:null]:'-']" optionKey="id" from="${Variant.findAllByHoliday(session.holiday)}"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
