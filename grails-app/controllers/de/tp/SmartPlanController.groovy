package de.tp

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

@Secured(['ROLE_ADMIN'])
class SmartPlanController {
	
	static navigation = [
		order:9,
		isVisible: { SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN') },
		title:'SmartPlan',
		path:'smartPlan'
	]
	
	def dateTimeService
	
	def list() {
		def dayInstanceList = Day.list(sort:'date')
		def weekMap = dateTimeService.splitToWeekMap(dayInstanceList)
		
		[
			dayInstanceList		: dayInstanceList,
			weekMap				: weekMap,
		]
	}
	
	
	def remoteEditDay(Long pk, String name, String value) {
		log.warn(params)
		
		if (name == 'dayDescription') {
			
			def day = Day.get(pk)
			if (day) {
				day.description = value
				day.save(failOnError:true)
			}
			
		}
		
		
		def result = [success:true, msg: null] 
//		def result = [success:false, msg: "Horrible error!"]
		render result as JSON
	}
}
