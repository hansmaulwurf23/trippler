
<r:require modules="jquery-ui-editable" />

<r:script disposition="head">
	$(document).ready(function() {
	
	
		$( 'td.weektd' ).click(function() {
			var dayid = $(this).parent().attr('data-dayid');
			
			$( 'tr.accorow[data-dayid=' + dayid + ']' ).toggleClass('hidden');
			$( 'tr.stagerow[data-dayid=' + dayid + ']' ).toggleClass('hidden');
		});	
		
		$.fn.editable.defaults.mode = 'inline';
		$.fn.editable.defaults.send = 'always';
		$.fn.editable.defaults.ajaxOptions = {dataType: 'json'};
		$.fn.editable.defaults.success = function(response, newValue) {
		        if(!response) {
		            return "Unknown error!";
		        }          
		        
		        if(response.success === false) {
		             return response.msg;
		        }
		    };
		
		
		$( '.dayDescription' ).editable({
			name	: 'dayDescription',
			url		: '${createLink(controller:"smartPlan", action:"remoteEditDay")}',
		});
	});
</r:script>

<style>
	.weektd:hover {
		cursor: pointer;
	}
	
	.editable-click {
		border-bottom: none!important;
	}
	form.editableform .control-group {
		margin-top: 3px;
	}
	form.editableform input[type="text"] {
    	width: 430px;
	}
	form.editableform .editable-input {
    	width: 500px;
	}
</style>



<g:each in="${entry.value}" status="i" var="dayInstance">
	
	<!-- Day entry -->
	<tr class="dayrow" id="week_${entry.key}_${i}" data-dayid="${dayInstance.id}">
		
		<td class="weektd weekcolor_${entry.key % 6}">
			<tp:weekdaybox date="${dayInstance.date}" />
		</td>
		
		<td style="text-align: center;">
			${dayInstance.date?.format('dd.MM.')}
		</td>
		
		<td class="dayDescription" data-pk="${dayInstance.id}">
			${fieldValue(bean: dayInstance, field: "description")}
		</td>

	</tr>
	
	
	<!-- Dawn night -->
	<tr class="hidden accorow dawn" data-dayid="${dayInstance.id}">
	
		<g:set var="night" value="${dayInstance.dawnNight}" />
		<td><g:img dir="/images/tango/22x22/" file="weather-few-clouds.png" /></td>
		<td style="text-align: center;">${dayInstance.date?.format('HH:mm')}</td>
		
		<g:if test="${night?.accomodation}">
			<td><g:link controller="night" action="show" id="${night?.id}">${night?.accomodation}</g:link></td>
		</g:if>
		<g:else>
			<td><g:link controller="night" action="show" id="${night?.id}">${night}</g:link></td>
		</g:else>
		
	</tr>
	
	
	<!-- Stages -->
	<g:render template="stages" model="${[dayInstance:dayInstance]}"/>
	
	
	<!-- Dusk night -->
	<tr class="hidden accorow dusk" data-dayid="${dayInstance.id}">
	
		<g:set var="night" value="${dayInstance.duskNight}" />
		<td><g:img dir="/images/tango/22x22/" file="weather-few-clouds-night.png" /></td>
		<td style="text-align: center;">${night?.arrivalTime?.format('HH:mm')}</td>
		<g:if test="${night?.accomodation}">
			<td><g:link controller="night" action="show" id="${night?.id}">${night?.accomodation}</g:link></td>
		</g:if>
		<g:else>
			<td><g:link controller="night" action="show" id="${night?.id}">${night}</g:link></td>
		</g:else>
		
	</tr>
	
</g:each>