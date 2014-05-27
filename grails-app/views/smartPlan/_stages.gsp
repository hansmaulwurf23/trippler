<g:each in="${dayInstance.stages.sort { it.time }}" status="j" var="s">
	
	<tr class="hidden stagerow" data-dayid="${dayInstance.id}">
		<td></td>
		<td style="text-align: center;">${s.time?.format("HH:mm")}</td>
		<td colspan="1"><g:link controller="stage" action="edit" id="${s.id}">${s}</g:link></td>
	</tr>
	
</g:each>