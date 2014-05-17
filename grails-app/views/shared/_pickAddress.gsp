<r:require modules="jquery-ui, googleMaps"/>

<r:script>
	$(document).ready(function() {
		$('#addressString').autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: searchLink,
					dataType: "json",
					data: {
						term: request.term
					},
					success: function( data ) {
						if (data.length > 0) {
							response( $.map( data, function( item ) {
								return {
									id: item.id,
									label: item.value,
									value: item.value
								}
							}));
							$('#createNewAddressLink').hide();
						} else {
							$('#createNewAddressLink').show();
						}
					}
				});
			},
			minLength: 2,
			select: function( event, ui ) {
				$('#address\\.id').val(ui.item.id);
			}
		});
		
		$( "#newAddressDialog" ).dialog({
            autoOpen: false,
            width: 800,
            resizable: false,
            modal: true,
            closeOnEscape: true,
            title: "Addresse",
            buttons: {
				Ok: function() {
					var postdata = $('#newAddressDialog input').serialize();
					$.post(ajaxSaveLink,
						   postdata,
						   function(data) {
								if (data.status == 'OK') {
									$('#address\\.id').val(data.id);
									$('#addressString').val(data.label);
									$('#createNewAddressLink').hide();
									$("#newAddressDialog").dialog( "close" );
								} else {
									alert("Ein Fehler beim Verarbeiten der Adressinformationen ist aufgetreten!");
								}					   
						   }, 
						   "json");
					return false;
				}
			},
			close: function(event, ui) {
				
			}
        });
		
		$('#createNewAddressLink').click(function() {
			$('#addressSearchString').val($('#addressString').val());
			$("#newAddressDialog").dialog( "open" );
		});
	});
</r:script>


<g:textField name="addressString" value="${addressInstance}"/>
<g:hiddenField name="address.id" value="${addressInstance?.id}"/>

<a id="createNewAddressLink" style="cursor: pointer; display: none;"><g:message code="default.button.create.label"/></a>

<div id="newAddressDialog" style="display: none;">
	<g:render template="form" contextPath="/address/" />
</div>