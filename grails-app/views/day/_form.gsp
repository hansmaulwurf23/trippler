<%@ page import="de.tp.Day" %>

<r:require modules="datePickers" />

<div class="fieldcontain ${hasErrors(bean: dayInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="day.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<tp:datePicker name="date" precision="minute"  value="${dayInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: dayInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="day.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${dayInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dayInstance, field: 'stages', 'error')} ">
	<label for="stages">
		<g:message code="day.stages.label" default="Stages" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${dayInstance?.stages?}" var="s">
    <li><g:link controller="stage" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="stage" action="create" params="['day.id': dayInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'stage.label', default: 'Stage')])}</g:link>
</li>
</ul>

</div>

