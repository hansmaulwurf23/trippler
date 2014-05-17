var nameMapping = {
	'postal_code' : 'zip',
	'administrative_area_level_1' : 'state',
	'administrative_area_level_2' : 'county',
	'country' : 'country',
	'locality' : 'city',
	'route' : 'route',
	'street_number' : 'street_number'
};


var pinColors = ['ABBF78', '996633', 'FFFFCC', 'FF9933', '6699FF', 'FF3300'];

var pinImages = new Array();
for (var i = 0; i < 6; i++) {
	pinImages[i] =  new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColors[i],
	        new google.maps.Size(21, 34),
	        new google.maps.Point(0,0),
	        new google.maps.Point(10, 34));
}

var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
        new google.maps.Size(40, 37),
        new google.maps.Point(0, 0),
        new google.maps.Point(12, 35));


var geocode = function(addressString, callback) {
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({
		'address' : addressString
	}, function(results, status) {
		var resultAddr = new Object();
		if (status == google.maps.GeocoderStatus.OK) {
			
			if (google.maps.GeocoderLocationType.APPROXIMATE == results[0].location_type) {
				resultAddr.status = google.maps.GeocoderLocationType.APPROXIMATE;
			} else {
				var exact = false;
				
				for (var i = 0; i < results[0].types.length; i++) {
					if (results[0].types[i] == 'street_address') {
						exact = true;
						break;
					}
				}
				
				if (exact) {
					resultAddr.status = "OK";
				} else {
					resultAddr.status = google.maps.GeocoderLocationType.APPROXIMATE;
				}
				
				resultAddr.addr = new Object();
				
				for ( var i = 0; i < results[0]['address_components'].length; i++) {
					var geocodedElement = results[0]['address_components'][i];
					
					for ( var j = 0; j < geocodedElement.types.length; j++) {
						if (nameMapping[geocodedElement.types[j]] !== undefined) {
							resultAddr.addr[nameMapping[geocodedElement.types[j]]] = geocodedElement.long_name;
							break;
						}
					}
				}
				
				if (resultAddr.addr.street_number) {
					resultAddr.addr.street = resultAddr.addr.route + " " + resultAddr.addr.street_number; 
				} else {
					resultAddr.addr.street = resultAddr.addr.route;
				}
				
				resultAddr.addr.longitude = results[0].geometry.location.lng();
				resultAddr.addr.latitude = results[0].geometry.location.lat();
				
			}
			
		} else {
			//alert("Geocode was not successful for the following reason: " + status);
			resultAddr.status = status;
		}
		callback(resultAddr);
	});
}

var getdistance = function(backendUrl, sourceString, sourceId, destinationString, destinationId, callback) {
	$.getJSON(backendUrl + '/getDistance', {sourceId: sourceId, destinationId : destinationId}, function(data) {
		if (data.status == 'ERROR') {
			// Programming error: missing arguments in call to (controller) backend
			alert('Ein Fehler beim Abrufen der Entfernungsinformationen ist aufgetreten: fehlender Parameter!');
			callback(null);
		} else if (data.status == 'OK') {
			// distance was found in backend -> returning immediately
			callback(data);
		} else if (data.status == 'NOTFOUND') {
			// distance not found, call googleMapsService, store distance in backend and return with a recursive call
			fetchAndStoreDistance(backendUrl, sourceString, sourceId, destinationString, destinationId, function(data) {
				if (data.status == 'OK') {
					getdistance(backendUrl, sourceString, sourceId, destinationString, destinationId, callback);
				} else {
					alert('Ein Fehler beim Abrufen der Entfernungsinformationen ist aufgetreten: ' + data.status);
					callback(null);
				}
			})
		} else {
			alert('Schwerwiegender Fehler in GoogleMaps Modul!');
			callback(null);
		}
	});
}

var fetchAndStoreDistance = function(backendUrl, sourceString, sourceId, destinationString, destinationId, callback) {
	var service = new google.maps.DistanceMatrixService();
	service.getDistanceMatrix({
		origins : [ eval(sourceString) ],
		destinations : [ eval(destinationString) ],
		travelMode : google.maps.TravelMode.DRIVING,
		avoidHighways : false,
		avoidTolls : false
	}, function(response, status) {
		var resultMap = new Object();
		
		if (status != google.maps.DistanceMatrixStatus.OK) {
			alert('Error was: ' + status);
			resultMap.status = status;
			callback(resultMap);
		} else {
			resultMap.status = "OK";
			resultMap.sourceAddr = response.originAddresses[0];
			resultMap.sourceId = sourceId;
			resultMap.destAddr = response.destinationAddresses[0];
			resultMap.destinationId = destinationId;
			resultMap.distance = response.rows[0].elements[0].distance.value;
			resultMap.duration = response.rows[0].elements[0].duration.value;
			
			$.post(backendUrl + '/storeDistance', resultMap, function(data) {
				if (data.status != 'OK') {
					resultMap.status = data.status;
				}
				callback(resultMap);
			});
		}
	});
}
