<%@ page import="de.tp.Accomodation" %>

<r:require modules="jquery-ui, datePickers" />

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="accomodation.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${accomodationInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'price', 'error')} ">
	<label for="price"><g:message code="accomodation.price.label" />€</label>
	<g:field name="price" value="${fieldValue(bean: accomodationInstance, field: 'price')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'priceusd', 'error')} ">
	<label for="price"><g:message code="accomodation.price.label" />US$</label>
	<g:field name="priceusd" value="${fieldValue(bean: accomodationInstance, field: 'priceusd')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'link', 'error')} ">
	<label for="link">
		<g:message code="accomodation.link.label" default="Link" />
		
	</label>
	<g:textField name="link" value="${accomodationInstance?.link}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="accomodation.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${accomodationInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'notes', 'error')} ">
	<label for="notes">
		<g:message code="accomodation.notes.label" default="Notes" />
		
	</label>
	<g:textArea name="notes" value="${accomodationInstance?.notes}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'roominfo', 'error')} ">
	<label for="roominfo">
		<g:message code="accomodation.roominfo.label" default="Roominfo" />
		
	</label>
	<g:textArea name="roominfo" value="${accomodationInstance?.roominfo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="accomodation.address.label" default="Address" />
		
	</label>
	<tp:address name="address" addressid="${accomodationInstance?.address?.id}" value="${accomodationInstance?.address}" />
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'breakfast', 'error')} ">
	<label for="breakfast"><g:message code="accomodation.breakfast.label" /></label>
	<g:checkBox name="breakfast" value="${accomodationInstance?.breakfast}" />
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'wifi', 'error')} ">
	<label for="wifi"><g:message code="accomodation.wifi.label" /></label>
	<g:checkBox name="wifi" value="${accomodationInstance?.wifi}" />
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'parking', 'error')} ">
	<label for="parking"><g:message code="accomodation.parking.label" /></label>
	<g:checkBox name="parking" value="${accomodationInstance?.parking}" />
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'cancellationContact', 'error')} ">
	<label for="cancellationContact">
		<g:message code="accomodation.cancellationContact.label" default="Cancellation Contact" />
		
	</label>
	<g:textField name="cancellationContact" value="${accomodationInstance?.cancellationContact}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: accomodationInstance, field: 'latestCancellation', 'error')} ">
	<label for="latestCancellation">
		<g:message code="accomodation.latestCancellation.label" default="Latest Cancellation" />
	</label>
	<tp:datePicker name="latestCancellation" value="${accomodationInstance?.latestCancellation}" />
	<tp:timePicker name="latestCancellation" value="${accomodationInstance?.latestCancellation}"/>
</div>

