<%@ page import="de.tp.Variant" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'variant.label', default: 'Variant')}" />
		<title><g:message code="default.switch.variant" default="Switch Variant" /></title>
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
			<h1><g:message code="default.switch.variant" default="Switch Variant" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:form action="doSwitchVariant" >
				<fieldset class="form">
					<div class="fieldcontain">
						<label for="newVariant">
							<g:message code="newVariant" default="Variant:" />
						</label>
						<g:select style="width:35%" name="newVariant" optionKey="id" from="${Variant.findAllByHoliday(session.holiday)}"/>
					</div>
					<div class="fieldcontain">
						<label for="newDefault">
							<g:message code="newDefault" default="New Default" />
						</label>
						<g:checkBox name="newDefault" />
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="save" class="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
