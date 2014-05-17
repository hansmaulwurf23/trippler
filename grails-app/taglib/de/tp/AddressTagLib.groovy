package de.tp

class AddressTagLib {
	
	static namespace = "tp"
	
	def address = { attrs, body ->
		//out<< render(template:'/shared/pickAddress', model:[addressInstance:attrs.value])
		out << "<input id='addressString' type='text' value='${attrs.value}' name='addressString' />"
		out << "${hiddenField(name:'address.id', value:attrs.addressid)}"
		out << '<a id="createNewAddressLink" style="cursor: pointer; display: none;">Anlegen...</a>'
		out << '<div id="newAddressDialog" style="display: none;">'
		// address input dialog
		out << '''
<input name="addressSearchString" size="75" style="width:auto" value="" id="addressSearchString" type="text">  <input name="validate" class="save" value="Validieren" id="validate" type="submit">

<div id="adressForm">

<input  name="addressValidated" value="false" id="addressValidated" type="hidden">

<div class="fieldcontain  ">
	<label for="street">
		Straße</label>
	<input  name="street" value="" id="street" type="text">
</div>

<div class="fieldcontain  ">
	<label for="zip">
		PLZ</label>
	<input  name="zip" value="" id="zip" type="text">
</div>

<div class="fieldcontain  ">
	<label for="city">
		Ort</label>
	<input  name="city" value="" id="city" type="text">
</div>

<div class="fieldcontain  ">
	<label for="county">
		Bezirk</label>
	<input  name="county" value="" id="county" type="text">
</div>

<div class="fieldcontain  ">
	<label for="state">
		Bundesland</label>
	<input  name="state" value="" id="state" type="text">
</div>

<div class="fieldcontain  ">
	<label for="country">
		Land</label>
	<input  name="country" value="" id="country" type="text">
</div>

<div class="fieldcontain  ">
	<label for="longitude">
		Längengrad</label>
	<input  name="longitude" step="any" value="" id="longitude" type="number">
</div>

<div class="fieldcontain  ">
	<label for="latitude">
		Breitengrad</label>
	<input  name="latitude" step="any" value="" id="latitude" type="number">
</div>

</div>
'''
		
		out << '</div>'
		out << "<script>"
		out << "var searchLink = '${createLink(controller:'address', action:'search')}';"
		out << "var ajaxSaveLink = '${g.createLink(controller:'address', action:'ajaxsave')}';"
		// necessary javascript
		out << '''
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
				$('#address\\\\.id').val(ui.item.id);
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
									$('#address\\\\.id').val(data.id);
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

		//$("#adressForm input").attr("readonly", "readonly");
		
		$("#validate").click(function() {
			geocode($('#addressSearchString').val(), function(result) {
				if (result.status == 'OK' || result.status == google.maps.GeocoderLocationType.APPROXIMATE) {
					$.each(result.addr, function(key, val) {
						$('#adressForm #' + key).val(val);
					});
					$('#addressValidated').val(true);
				} else {
					alert("Ein allgemeiner Fehler ist aufgetreten: " + result.status);
					$('#addressValidated').val(false);
				}
			});
			//$('#log').html(JSON.stringify());
			return false;
		});
'''
		
		out << "</script>"
	}

}
