package de.mf.tp

import org.springframework.web.servlet.support.RequestContextUtils;

class MainTagLib {

	static namespace = "tp"
	
	def messageSource
	
	def dayinfo = { attrs, body ->
		out << "<div class='infobox'><p>"
		out << g.link(controller:'day', action:'show', id: attrs.day.id) { messageSource.getMessage('day.label', null, null, RequestContextUtils.getLocale(request)) } << ": "
		out << formatDate(date:attrs.day.date, format:'dd.MM. (E)')
		out << " ${attrs.day.description}"
		out << "</p></div>"
	}
	
	def weekdaybox = { attrs, body ->
		out << "<span class='weekdaybox'>"
		out << attrs.date?.format("E")
		out << "</span>"
	}
	
	def weekcolorbox = { attrs, body ->
		def weekno = (attrs.date.format('w') as Long) % 6
		out << "<span class='weekcolorbox weekcolor_${weekno}'>&nbsp;</span>"
	}
	
	def yesno = { attrs, body ->
		def imgLink
		
		def imgBaseDir = '/images/tango/22x22/'
		
		if (attrs.value == null && attrs.treatnull) {
			imgLink = g.resource(dir:imgBaseDir,file:'null.png')
		} else if (attrs.value) {
			imgLink = g.resource(dir:imgBaseDir,file:'available.png')
		} else {
			imgLink = g.resource(dir:imgBaseDir,file:'not-available.png')
		}
		
		def alt = messageSource.getMessage("default.boolean." + attrs.value?.toString(), null, null, RequestContextUtils.getLocale(request))

		out << "<img src='${imgLink}' alt='${alt}'/>"
		out << "<span style='display:none;'>${attrs.value}</span>"
	}
	
	def formatDistance = { attrs, body ->
		def meters = attrs.value as Long
		if (!attrs.value) {
			out << ""
		} else if (meters < 1000) {
			out << meters + ' m';
		} else {
			out << (Math.round(meters / 100) / 10) + ' km';
		}
	}
	
	def formatDuration = { attrs, body ->
		def seconds = attrs.value as Long
		if (!attrs.value) {
			out << ""
		} else  {
			def hours = Math.round(seconds.div(36)) / 100
			out << hours + ' h'
		}
	}
	
	def datePicker = { attrs, body ->
		out << "<input class='datepicker' id='${attrs.name}' name='${attrs.name}' "
		if (attrs.value) {
			out << "value='${(attrs.value?.format(grailsApplication.config.de.mf.tp.defaultDateFormat))}'"
		}
		out << "/>"
		if (attrs.connectedField) {
			out << "${hiddenField(name:attrs.name + '_year', linkedto:attrs.connectedField + '_year')}"
			out << "${hiddenField(name:attrs.name + '_month', linkedto:attrs.connectedField + '_month')}"
			out << "${hiddenField(name:attrs.name + '_day', linkedto:attrs.connectedField + '_day')}"
			out << "${hiddenField(name:attrs.connectedField + '_year')}"
			out << "${hiddenField(name:attrs.connectedField + '_month')}"
			out << "${hiddenField(name:attrs.connectedField + '_day')}"
		} else {
			out << "${hiddenField(name:attrs.name + '_year')}"
			out << "${hiddenField(name:attrs.name + '_month')}"
			out << "${hiddenField(name:attrs.name + '_day')}"
		}
		
		//out << "<script>makeDatePickers();</script>"
	}
	
	def timePicker = { attrs, body ->
		out << "${select(name : attrs.name + '_hour', class:'timepicker', from : 0..23, value : attrs.value?.getAt(Calendar.HOUR_OF_DAY))}"
		out << " : "
		out << "${select(name : attrs.name + '_minute', class:'timepicker', from : (0..3)*.multiply(15), value : attrs.value?.getAt(Calendar.MINUTE))}"
	}
}
