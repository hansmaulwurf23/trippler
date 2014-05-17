modules = {
    application {
        resource url:'js/application.js'
    }
	
	googleMaps {
		resource url:'js/googlemaps.js'
		resource id:'googlemapsapi', url:'js/googlemapsapi.js', linkOverride:'https://maps.googleapis.com/maps/api/js?sensor=false&language=de', attrs:[type:"js"], disposition:'head'
		//dependsOn 'jquery'
	}
	
	'jquery-ui' {
		dependsOn 'jquery', 'jquery-theme'
		resource id:'js', url:[dir:'js/jquery', file:"jquery-ui-1.10.0.custom.min.js"], nominify: true, disposition: 'head'
	}

	'jquery-ui-dev' {
		dependsOn 'jquery', 'jquery-theme'
		resource id:'js', url:[dir:'js/jquery', file:"jquery-ui-1.10.0.custom.js"], disposition:'head'
	}
	
	'jquery-theme' {
		resource id:'theme', url:[dir: 'css/jqueryui', file:'jquery-ui-1.10.0.custom.css'], attrs:[media:'screen, projection']
	}
	
	'select2' {
		resource url:'js/select2/select2.css', disposition:'head'
		resource url:'js/select2/select2.js', disposition:'head'
		resource url:'js/select2/integrate.js', disposition:'head'
	}
	
	datePickers {
		resource url:'js/datepickers.js'
		dependsOn 'jquery-ui'
		//resource url:'js/jquery/i18n/jquery.ui.datepicker-de.js'
		resource url:'js/jquery-ui-timepicker-addon.js'
	}
	
	moment {
		resource url:'js/momentjs/moment.js'
	}
	
	stageManagement {
		resource url:'css/stagemanagement.css'
	}
	
	sunriseset {
		resource url:'js/sunriseset.js'
	}
}