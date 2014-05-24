package de.tp

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import de.tp.Address;
import de.tp.Distance;
import de.tp.Night;
import de.tp.Stage;

@Secured(['ROLE_ADMIN'])
class AddressController {

	static navigation = [
		order:40,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Address',
		path:'address'
	]
	
    static scaffold = true
	
	def index() {
		redirect(action:'acco')
	}
	
	def save() {
		def newAddr = [:]
		newAddr.putAll(params)
		newAddr.longitude = params.longitude.toDouble()
		newAddr.latitude = params.latitude.toDouble()
		
		def addressInstance = new Address(newAddr)
		
		if (Address.find(addressInstance)) {
			flash.message = message(code: 'address.duplicate.error')
			render(view: "create", model: [addressInstance: addressInstance])
			return
		}
		
		if (!addressInstance.save(flush: true)) {
			render(view: "create", model: [addressInstance: addressInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'address.label', default: 'Address'), addressInstance.id])
		redirect(action: "show", id: addressInstance.id)
	}
	
	def search() {
		def found = Address.search("*${params.term}*", [escape: false,  result: 'every'])
		def result = []
		found.each { a ->
			result << [id: a.id, value: a.toString()]
		}
		
		render result as JSON
	}
	
	def show() {
		println params
		def addressInstance = Address.get(params.id)
		if (!addressInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'address.label', default: 'Address'), params.id])
			redirect(action: "list")
			return
		}

		[addressInstance: addressInstance]
	}
	
	def stages() {
		def stages = []
		def accoAddresses = getAccoAddresses()

		stages = Stage.listOrderByTime().findAll { it.day }.collect()
		def center = calcCenter(stages*.address)
		
		[accoAddresses : accoAddresses, stages : stages, center : center]
	}
	
	def acco() {
		def accoAddresses = getAccoAddresses()
		def center = calcCenter(accoAddresses*.accomodation.address) 
		
		[accoAddresses : accoAddresses, center : center]
	}
	
	def showOtherMap() {
		println params
		def newParams = [:]
		newParams['id'] = params.id
		// toggle
		if (!params.othermap) {
			newParams['othermap'] = 'leafletjs'
		}
		redirect(action:'show', params:newParams)
	}
	
	def ajaxsave() {
		def newAddr = [:]
		def result = [:]
		newAddr.putAll(params)
		newAddr.longitude = params.longitude.toDouble()
		newAddr.latitude = params.latitude.toDouble()
		
		def addressInstance = new Address(newAddr)
		
		if (!addressInstance.save(flush: true)) {
			result['status'] = 'error'
		} else {
			result['status'] = 'OK'
			addressInstance.refresh()
			result['id'] = addressInstance.id
			result['label'] = addressInstance.toString()
		}

		render result as JSON
	}
	
	def getDistance() {
		println "getDistance: ${params}"
		def result = [:]
		
		if (!params.sourceId || !params.destinationId) {
			result.status = 'ERROR'
			result.textStatus = 'Missing arguments!'
		} else {
			Address source = Address.get(params.sourceId as Long)
			Address destination = Address.get(params.destinationId as Long)
			def d = Distance.findBySourceAndDestination(source, destination)
			
			if (d) {
				println d.properties
				result.status = 'OK'
				result.distance = d
			} else {
				result.status = 'NOTFOUND'
			}
		}
		
		render result as JSON
	}
	
	def storeDistance() {
		println "storeDistance: ${params}"
		def result = [:]
		
		Distance d = new Distance()
		Address source = Address.get(params.sourceId as Long)
		Address destination = Address.get(params.destinationId as Long)
		
		d.source = source
		d.destination = destination
		d.distance = params.distance as Long
		d.duration = params.duration as Long
		
		if (!d.save(flush:true)) {
			result.status = "ERROR"
			result.textStatus = d.errors.toString()
		} else {
			result.status = 'OK'
		}
		
		render result as JSON
	}
	
	def getAccoAddresses() {
		def accoAddresses = []
		accoAddresses = Night.listOrderByMidnight().findAll { it.accomodation }.collect()
		accoAddresses
	}
	
	def calcCenter(addresses) {
		def latMin = addresses*.latitude.min { it }?:0
		def latMax = addresses*.latitude.max { it }?:0
		def lonMin = addresses*.longitude.min { it }?:0
		def lonMax = addresses*.longitude.max { it }?:0
		
		println "${latMin} ${latMax} ${lonMin} ${lonMax}"
		
		def lat = (latMax + latMin).toDouble() / 2
		def lon = (lonMax + lonMin).toDouble() / 2
		
		println "${lat} ${lon}"
		def center = [:]
		center.lat = lat
		center.lon = lon
		
		return center
	}
}
