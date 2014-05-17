
<%@ page import="de.mf.tp.Address"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'address.label', default: 'Address')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>

<r:require modules="jquery, googleMaps"/>

<!-- MAPSTUFF -->
<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.4.5/leaflet.css" />
<!--[if lte IE 8]>
    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.4.5/leaflet.ie.css" />
<![endif]-->
<script src="http://cdn.leafletjs.com/leaflet-0.4.5/leaflet.js"></script>

<style>
	#map { 
		height: 550px;
		margin-top: 10px; 
	}
</style>
<r:script>
	$(document).ready(function() {
			initGoogleMapsMap();
	});
	
	function initGoogleMapsMap() {
		var mapOptions = {
	      center: new google.maps.LatLng(${center.lat}, ${center.lon}),
	      zoom: 6,
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    };
	    var map = new google.maps.Map(document.getElementById("map"), mapOptions);
	    
	    //var iconBase = 'http://www.google.com/mapfiles/';
	    var iconBase = 'http://maps.google.com/mapfiles/kml/shapes/';
	    <g:each in="${stages}" var="a" status="i">
		var marker = new google.maps.Marker({
		      position: new google.maps.LatLng(${a.address.latitude}, ${a.address.longitude}),
		      map: map,
		      animation: google.maps.Animation.DROP,
		      title:"${a.toString()}: ${a.name}",
		      icon: iconBase + 'placemark_circle.png'
		      //shadow: iconBase + 'arrowshadow.png'
		  });
		 </g:each>
	    
	    <g:each in="${accoAddresses}" var="a" status="i">
		var marker = new google.maps.Marker({
		      position: new google.maps.LatLng(${a.accomodation.address.latitude}, ${a.accomodation.address.longitude}),
		      map: map,
		      animation: google.maps.Animation.DROP,
		      title:"${a.toString()}: ${a.accomodation.name} (${a.accomodation.price})",
		      icon: pinImages[${(a.midnight.format('w') as Long) % 6}],
		      shadow: pinShadow
		  });
		 </g:each>
	}
</r:script>

</head>
<body>
	<a href="#show-address" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label" /></a></li>
			<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			<li><g:link class="list" action="acco"><g:message code="address.acco.view.label" /></g:link></li>
			<li><g:link class="list" action="stages"><g:message code="address.stages.view.label" /></g:link></li>
		</ul>
	</div>
	<div id="show-address" class="content" role="main">
		<div id="map"></div>
	</div>
</body>
</html>
