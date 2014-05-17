package de.tp

import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import groovy.time.TimeCategory

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import de.tp.DateHelper;
import de.tp.Day;
import de.tp.Night;
import de.tp.Stage;

@Secured(['ROLE_ADMIN'])
class DayController {

    static scaffold = true
	
	static navigation = [
		order:10,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Day',
		path:'day'
	]
	
	def manageStages() {
		def day = Day.get(params.id as Long)
		def dayStages = Stage.findAllByDay(day, [sort:'time'])
		def dayStart = day.date.clone()
		def dawn = Night.findByMidnight(dayStart.clearTime())
		def dusk = Night.findByMidnight((dayStart + 1).clearTime())
		
		[day : day, dayStages : dayStages, dawn:dawn, dusk:dusk]
	}
	
	def updateStages() {
		def result = [:]
		def data = JSON.parse(params.data)
		
		println data
		
		def day = Day.get(data.dayid)
		if (!day) {
			result['status'] = 'ERROR'
			result['msg'] = 'Day not found!'
		} else {
			def dayStages = Stage.findAllByDay(day)
			dayStages.each { ds ->
				ds.day = null
				ds.save(flush:true)
			}
			
			data.stages.eachWithIndex { s, i ->
				def stage = Stage.get(s.stageid as Long)
				stage.day = day
				use (TimeCategory) {
					def stageTime = new Date(s.time.toLong())
					stage.time = DateHelper.mergeDateAndTime(day.date, stageTime)
					stage.distance = s.distance as Long
					stage.staySeconds = s.staySeconds as Long
				}
				if (!stage.save(flush:true)) {
					log.error stage.errors
				}
			}
			
			def duskNight = day.duskNight
			duskNight.distanceFromLastStage = data.duskData.distance as Long
			duskNight.durationFromLastStage = data.duskData.duration as Long
			// FIXME this will fail, if arrival at accomodation is after midnight
			duskNight.arrivalTime = DateHelper.mergeDateAndTime(day.date, new Date(data.duskData.time.toLong()))
			if (!duskNight.merge(flush:true)) {
				log.error duskNight.errors
			}
			
			result['status'] = "OK"
		}
		
		render result as JSON
	}
	
	def fetchsundata() {
		[days : Day.listOrderByDate()]
	}
	
//	def shiftOneDay() {
//		def days = Day.findAll(sort:'id', order:'asc')
//		def lastDescr = null
//		def buffer
//		days.each { d ->
//			if (d.id > 10 && d.id < 26) {
//				println "${d.date}: ${d.description} -> ${lastDescr}"
//				buffer = d.description
//				d.description = lastDescr
//				d.save(flush:true)
//			}
//			lastDescr = buffer ?: d.description
//		}
//		redirect(action:'list')
//	}
	
	def list() {
		/*params.max = 7
		if (!params.sort) {
			params.sort = 'date'
		}
		[dayInstanceList: Day.list(params), dayInstanceTotal: Day.count()]*/
		[dayInstanceList: Day.list(sort:'date')]
	}
}
