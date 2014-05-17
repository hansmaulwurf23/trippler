
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
		height: 350px;
		margin-top: 10px; 
	}
</style>
<r:script>
	$(document).ready(function() {
		<g:if test="${params.othermap}">
			initLeafletjsMap();
		</g:if>
		<g:else>
			initGoogleMapsMap();
		</g:else>	
	});
	
	function initLeafletjsMap() {
		var map = L.map('map');
		
		L.tileLayer('http://{s}.tile.cloudmade.com/3a9720940b70412c8617fbeb859598cb/997/256/{z}/{x}/{y}.png', {
			maxZoom: 18,
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
		}).addTo(map);
		var point = new L.LatLng(${addressInstance?.latitude}, ${addressInstance?.longitude});
	    var marker = new L.Marker(point);
	    map.setView(point, 15).addLayer(marker);
	}
	
	function initGoogleMapsMap() {
		var mapOptions = {
	      center: new google.maps.LatLng(${addressInstance?.latitude}, ${addressInstance?.longitude}),
	      zoom: 15,
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    };
	    var map = new google.maps.Map(document.getElementById("map"), mapOptions);
		var marker = new google.maps.Marker({
		      position: mapOptions.center,
		      map: map,
		      animation: google.maps.Animation.DROP,
		      title:"${addressInstance.toString()}"
		  });
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
	<div id="show-address" class="content scaffold-show" role="main">
		<h1>
			<g:message code="default.show.label" args="[entityName]" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<ol class="property-list address">

			<g:if test="${addressInstance?.street}">
				<li class="fieldcontain"><span id="street-label" class="property-label"><g:message code="address.street.label"
							default="Street" /></span> <span class="property-value" aria-labelledby="street-label"><g:fieldValue bean="${addressInstance}"
							field="street" /></span></li>
			</g:if>

			<g:if test="${addressInstance?.zip}">
				<li class="fieldcontain"><span id="zip-label" class="property-label"><g:message code="address.zip.label" default="Zip" /></span> <span
					class="property-value" aria-labelledby="zip-label"><g:fieldValue bean="${addressInstance}" field="zip" /></span></li>
			</g:if>

			<g:if test="${addressInstance?.city}">
				<li class="fieldcontain"><span id="city-label" class="property-label"><g:message code="address.city.label" default="City" /></span>
					<span class="property-value" aria-labelledby="city-label"><g:fieldValue bean="${addressInstance}" field="city" /></span></li>
			</g:if>

			<g:if test="${addressInstance?.county}">
				<li class="fieldcontain"><span id="county-label" class="property-label"><g:message code="address.county.label"
							default="County" /></span> <span class="property-value" aria-labelledby="county-label"><g:fieldValue bean="${addressInstance}"
							field="county" /></span></li>
			</g:if>

			<g:if test="${addressInstance?.state}">
				<li class="fieldcontain"><span id="state-label" class="property-label"><g:message code="address.state.label" default="State" /></span>
					<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${addressInstance}" field="state" /></span></li>
			</g:if>

			<g:if test="${addressInstance?.country}">
				<li class="fieldcontain"><span id="country-label" class="property-label"><g:message code="address.country.label"
							default="Country" /></span> <span class="property-value" aria-labelledby="country-label"><g:fieldValue bean="${addressInstance}"
							field="country" /></span></li>
			</g:if>

			<g:if test="${addressInstance?.longitude}">
				<li class="fieldcontain">
					<span id="longitude-label" class="property-label">
						<g:message code="address.longitude.label" default="Longitude" />
					</span> 
					<span class="property-value" aria-labelledby="longitude-label">
						<g:formatNumber number="${addressInstance?.longitude }" maxFractionDigits="3" />
					</span>
				</li>
			</g:if>

			<g:if test="${addressInstance?.latitude}">
				<li class="fieldcontain">
					<span id="latitude-label" class="property-label">
						<g:message code="address.latitude.label" default="Latitude" />
					</span> 
					<span class="property-value" aria-labelledby="latitude-label">
						<g:formatNumber number="${addressInstance?.latitude}" maxFractionDigits="3" />
					</span>
				</li>
			</g:if>

		</ol>
		<g:form>
			<fieldset class="buttons">
				<g:hiddenField name="id" value="${addressInstance?.id}" />
				<g:hiddenField name="othermap" value="${params.othermap}" />
				<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}"
					onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				<g:actionSubmit class="home" value="Andere Karte" action="showOtherMap"/>
			</fieldset>
		</g:form>
		<div id="map"></div>
	</div>
</body>
</html>
