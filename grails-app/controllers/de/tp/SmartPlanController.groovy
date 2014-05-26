package de.tp

import de.tp.Day;
import de.tp.Night;
import grails.plugins.springsecurity.Secured;
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
	
	def list(long week) {
		def dayInstanceList = Day.list(sort:'date')
		def weekMap = dateTimeService.splitToWeekMap(dayInstanceList)
		def displayInstanceList = weekMap[(week?:0)]
		
		
		[
			dayInstanceList		: dayInstanceList,
			weekMap				: weekMap,
			displayInstanceList : displayInstanceList,
		]
	}
}
