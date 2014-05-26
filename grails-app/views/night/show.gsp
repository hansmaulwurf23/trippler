
<%@ page import="de.tp.Night" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'night.label', default: 'Night')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<r:require modules="jquery-ui, jquery, googleMaps, select2" />
	</head>
	<body>
		<a href="#show-night" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-night" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list night">
			
				<g:if test="${nightInstance?.midnight}">
				<li class="fieldcontain">
					<span id="midnight-label" class="property-label"><g:message code="night.midnight.label" default="Midnight" /></span>
					
						<span class="property-value" aria-labelledby="midnight-label"><g:formatDate date="${nightInstance?.midnight}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.accomodation}">
				<li class="fieldcontain">
					<span id="accomodation-label" class="property-label"><g:message code="night.accomodation.label" default="Accomodation" /></span>
					
						<span class="property-value" aria-labelledby="accomodation-label"><g:link controller="accomodation" action="show" id="${nightInstance?.accomodation?.id}">${nightInstance?.accomodation?.encodeAsHTML()}</g:link></span>
					
					<!-- HANS -->
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.arrivalTime}">
				<li class="fieldcontain">
					<span id="arrivalTime-label" class="property-label"><g:message code="night.arrivalTime.label" default="Arrival Time" /></span>
					
						<span class="property-value" aria-labelledby="arrivalTime-label"><g:formatDate date="${nightInstance?.arrivalTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.booked}">
				<li class="fieldcontain">
					<span id="booked-label" class="property-label"><g:message code="night.booked.label" default="Booked" /></span>
					
						<span class="property-value" aria-labelledby="booked-label"><g:formatBoolean boolean="${nightInstance?.booked}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.discount}">
				<li class="fieldcontain">
					<span id="discount-label" class="property-label"><g:message code="night.discount.label" default="Discount" /></span>
					
						<span class="property-value" aria-labelledby="discount-label"><g:fieldValue bean="${nightInstance}" field="discount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.distanceFromLastStage}">
				<li class="fieldcontain">
					<span id="distanceFromLastStage-label" class="property-label"><g:message code="night.distanceFromLastStage.label" default="Distance From Last Stage" /></span>
					
						<span class="property-value" aria-labelledby="distanceFromLastStage-label"><g:fieldValue bean="${nightInstance}" field="distanceFromLastStage"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.durationFromLastStage}">
				<li class="fieldcontain">
					<span id="durationFromLastStage-label" class="property-label"><g:message code="night.durationFromLastStage.label" default="Duration From Last Stage" /></span>
					
						<span class="property-value" aria-labelledby="durationFromLastStage-label"><g:fieldValue bean="${nightInstance}" field="durationFromLastStage"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.paid}">
				<li class="fieldcontain">
					<span id="paid-label" class="property-label"><g:message code="night.paid.label" default="Paid" /></span>
					
						<span class="property-value" aria-labelledby="paid-label"><g:formatBoolean boolean="${nightInstance?.paid}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${nightInstance?.variant}">
				<li class="fieldcontain">
					<span id="variant-label" class="property-label"><g:message code="night.variant.label" default="Variant" /></span>
					
						<span class="property-value" aria-labelledby="variant-label"><g:link controller="variant" action="show" id="${nightInstance?.variant?.id}">${nightInstance?.variant?.encodeAsHTML()}</g:link></span>
					
					<!-- HANS -->
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${nightInstance?.id}" />
					<g:link class="edit" action="edit" id="${nightInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
