package de.tp

import de.tp.Night;
import de.tp.Stage;
import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class AccomodationController {

	static navigation = [
		order:30,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Accomodation',
		path:'accomodation'
		
	]
	
    static scaffold = true
	
	def exportpoi() {
		def nights = Night.executeQuery("from Night n inner join fetch n.accomodation")
		StringBuilder sb = new StringBuilder()
		nights*.accomodation.unique().each { a ->
			sb.append(formatPOI(a)).append("\n")
		}
		
		[result:sb.toString()]
	}
	
	def exportstagepoi() {
		def stages = Stage.list()
		StringBuilder sb = new StringBuilder()
		stages.findAll { it.address }.each { a ->
			sb.append(formatStagePOI(a)).append("\n")
		}
		
		[result:sb.toString()]
	}
	
	def formatPOI(a) {
		//return "${a.address.longitude}, ${a.address.latitude}, ${a.address.street} ${a.address.zip} ${a.address.city}, ${a.name},,,,,${a.cancellationContact?:''}"
		return "${a.address.longitude}, ${a.address.latitude}, ${a.name}, -, ${a.address.street}, ${a.address.city}, ${a.address.state}, ${a.address.zip}, ${a.address.country}, ${a.cancellationContact?:''}"
		//return "${a.address.street} ${a.address.zip} ${a.address.city}"
	}
	
	def formatStagePOI(a) {
		return "${a.address.longitude}, ${a.address.latitude}, ${a.name}, -, ${a.address.street}, ${a.address.city}, ${a.address.state}, ${a.address.zip}, ${a.address.country}"
	}
}
