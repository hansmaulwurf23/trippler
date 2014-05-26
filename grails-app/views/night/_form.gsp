<%@ page import="de.tp.Night" %>

<r:require modules="datePickers" />

<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'midnight', 'error')} ">
	<label for="midnight">
		<g:message code="night.midnight.label" default="Midnight" />
		
	</label>
	<tp:datePicker name="midnight" precision="minute"  value="${nightInstance?.midnight}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'accomodation', 'error')} ">
	<label for="accomodation">
		<g:message code="night.accomodation.label" default="Accomodation" />
		
	</label>
	<g:select id="accomodation" name="accomodation.id" from="${de.tp.Accomodation.list()}" optionKey="id" value="${nightInstance?.accomodation?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'arrivalTime', 'error')} ">--%>
<%--	<label for="arrivalTime">--%>
<%--		<g:message code="night.arrivalTime.label" default="Arrival Time" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<tp:datePicker name="arrivalTime" precision="minute"  value="${nightInstance?.arrivalTime}" default="none" noSelection="['': '']" />--%>
<%--</div>--%>

<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'booked', 'error')} ">
	<label for="booked">
		<g:message code="night.booked.label" default="Booked" />
		
	</label>
	<g:checkBox name="booked" value="${nightInstance?.booked}" />
</div>

<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'discount', 'error')} ">
	<label for="discount">
		<g:message code="night.discount.label" default="Discount" />
		
	</label>
	<g:textField name="discount" value="${nightInstance?.discount}"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'distanceFromLastStage', 'error')} ">--%>
<%--	<label for="distanceFromLastStage">--%>
<%--		<g:message code="night.distanceFromLastStage.label" default="Distance From Last Stage" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<g:field name="distanceFromLastStage" type="number" value="${nightInstance.distanceFromLastStage}"/>--%>
<%--</div>--%>
<%----%>
<%--<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'durationFromLastStage', 'error')} ">--%>
<%--	<label for="durationFromLastStage">--%>
<%--		<g:message code="night.durationFromLastStage.label" default="Duration From Last Stage" />--%>
<%--		--%>
<%--	</label>--%>
<%--	<g:field name="durationFromLastStage" type="number" value="${nightInstance.durationFromLastStage}"/>--%>
<%--</div>--%>

<div class="fieldcontain ${hasErrors(bean: nightInstance, field: 'paid', 'error')} ">
	<label for="paid">
		<g:message code="night.paid.label" default="Paid" />
		
	</label>
	<g:checkBox name="paid" value="${nightInstance?.paid}" />
</div>

