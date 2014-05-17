
<%@ page import="de.tp.Accomodation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'accomodation.label', default: 'Accomodation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<r:require modules="jquery-ui, jquery, googleMaps, select2" />
	</head>
	<body>
		<a href="#show-accomodation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-accomodation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list accomodation">
			
				<g:if test="${accomodationInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="accomodation.name.label" default="Name" /></span>
					<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${accomodationInstance}" field="name"/></span>
				</li>
				</g:if>
			
				<g:if test="${accomodationInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="accomodation.price.label" default="Price" /></span>
					<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${accomodationInstance}" field="price"/></span>
				</li>
				</g:if>
			
				<g:if test="${accomodationInstance?.link}">
				<li class="fieldcontain">
					<span id="link-label" class="property-label"><g:message code="accomodation.link.label" default="Link" /></span>
					<span class="property-value" aria-labelledby="link-label"><a href="http://${accomodationInstance?.link}">LINK</a></span>
				</li>
				</g:if>
			
				<g:if test="${accomodationInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="accomodation.description.label" default="Description" /></span>
					<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${accomodationInstance}" field="description"/></span>
				</li>
				</g:if>
			
				<g:if test="${accomodationInstance?.notes}">
				<li class="fieldcontain">
					<span id="notes-label" class="property-label"><g:message code="accomodation.notes.label" default="Notes" /></span>
					<span class="property-value" aria-labelledby="notes-label"><g:fieldValue bean="${accomodationInstance}" field="notes"/></span>
				</li>
				</g:if>
			
				<g:if test="${accomodationInstance?.roominfo}">
				<li class="fieldcontain">
					<span id="roominfo-label" class="property-label"><g:message code="accomodation.roominfo.label" default="Roominfo" /></span>
					<span class="property-value" aria-labelledby="roominfo-label"><g:fieldValue bean="${accomodationInstance}" field="roominfo"/></span>
				</li>
				</g:if>
			
				<g:if test="${accomodationInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="accomodation.address.label" default="Address" /></span>
					<span class="property-value" aria-labelledby="address-label"><g:link controller="address" action="show" id="${accomodationInstance?.address?.id}">${accomodationInstance?.address?.encodeAsHTML()}</g:link></span>
					<!-- HANS -->
				</li>
				</g:if>
			
				<li class="fieldcontain">
					<span id="breakfast-label" class="property-label"><g:message code="accomodation.breakfast.label" default="Breakfast" /></span>
					<span class="property-value" aria-labelledby="breakfast-label"><tp:yesno value="${accomodationInstance?.breakfast}" /></span>
				</li>
				
				<li class="fieldcontain">
					<span id="wifi-label" class="property-label"><g:message code="accomodation.wifi.label" /></span>
					<span class="property-value" aria-labelledby="wifi-label"><tp:yesno value="${accomodationInstance?.wifi}" /></span>
				</li>
				
				<li class="fieldcontain">
					<span id="parking-label" class="property-label"><g:message code="accomodation.parking.label" /></span>
					<span class="property-value" aria-labelledby="parking-label"><tp:yesno value="${accomodationInstance?.parking}" /></span>
				</li>
			
				<g:if test="${accomodationInstance?.cancellationContact}">
				<li class="fieldcontain">
					<span id="cancellationContact-label" class="property-label"><g:message code="accomodation.cancellationContact.label" default="Cancellation Contact" /></span>
					<span class="property-value" aria-labelledby="cancellationContact-label"><g:fieldValue bean="${accomodationInstance}" field="cancellationContact"/></span>
				</li>
				</g:if>
			
				<g:if test="${accomodationInstance?.latestCancellation}">
				<li class="fieldcontain">
					<span id="latestCancellation-label" class="property-label"><g:message code="accomodation.latestCancellation.label" default="Latest Cancellation" /></span>
					<span class="property-value" aria-labelledby="latestCancellation-label"><g:formatDate date="${accomodationInstance?.latestCancellation}" /></span>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${accomodationInstance?.id}" />
					<g:link class="edit" action="edit" id="${accomodationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
