package de.tp

import de.tp.Day;
import de.tp.Night;
import grails.plugins.springsecurity.Secured;
import groovy.sql.Sql;

@Secured(['ROLE_ADMIN'])
class StatsController {
	
	def dataSource
	
	static navigation = [
		order:300,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Stats',
		path:'stats'
	]

    def index() {
		redirect action:'acco'
	}
	
	def acco() {
		def nights = Night.listOrderByMidnight()
		def accoCost = []
		nights.each { n ->
			if (n.accomodation) {
				def entry = [:]
				entry.night = n.midnight
				entry.price = n.accomodation.price
				entry.label = "${n.midnight.format('dd.MM.')} (${n.accomodation.address?.city}): ${n.accomodation.price}"
				accoCost << entry
			}
		}
		
		[accoCost : accoCost]
	}
	
	def distances() {
		Sql sql = new Sql(dataSource)
		def distances = []
		def result = sql.rows("""
				select day_id, sum(distance) as distance, day
				from (select day_id, coalesce(distance, 0) as distance, address_id from stage
				           UNION ALL
				      select d.day_id, coalesce(n.distance, 0) as distance, acc.address_id
					from night n join accomodation acc using (accomodation_id) join day d on d.day::date = n.midnight - interval '1 day'
				     ) as s
				join day using (day_id)
				group by day_id, day
				order by day
		""")
		
		result.each { r ->
			def entry = [:]
			entry.day = r.day
			entry.distance = r.distance ? r.distance.toDouble() / 1000 : 0
			entry.label = "${r.day.format('dd.MM.')}: ${entry.distance} km (${Day.get(r.day_id).name})"
			distances << entry
		}
		
		[distances : distances]
	}
}
