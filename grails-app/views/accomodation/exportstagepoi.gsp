
<%@ page import="de.mf.tp.Accomodation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'accomodation.label', default: 'Accomodation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<r:require modules="jquery-ui, jquery, googleMaps, select2" />
		
		<style type="text/css">
			textarea {
				width: 100%;
				font-size: 0.8em;
				padding: 0px;
				height: 400px;
			}
		</style>
	</head>
	<body>
		<a href="#show-accomodation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="exportpoi"><g:message code="default.exportpoi.label" /></g:link></li>
				<li><g:link class="create" action="exportstagepoi"><g:message code="default.exportstagepoi.label" /></g:link></li>
			</ul>
		</div>
		<div id="show-accomodation" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<p>
			<a href="http://garmin.gps-data-team.com/extra/">http://garmin.gps-data-team.com/extra/</a>
			</p>
			<g:textArea name="result" value="${result}"/>
		</div>
	</body>
</html>
