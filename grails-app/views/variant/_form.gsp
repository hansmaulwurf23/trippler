<%@ page import="de.tp.Variant" %>



<div class="fieldcontain ${hasErrors(bean: variantInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="variant.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${variantInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: variantInstance, field: 'holiday', 'error')} required">
	<label for="holiday">
		<g:message code="variant.holiday.label" default="Holiday" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="holiday" name="holiday.id" from="${de.tp.Holiday.list()}" optionKey="id" required="" value="${variantInstance?.holiday?.id}" class="many-to-one"/>
</div>

