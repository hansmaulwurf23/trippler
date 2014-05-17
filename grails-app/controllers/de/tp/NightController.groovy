package de.tp

import grails.plugins.springsecurity.Secured

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import de.tp.Night;

@Secured(['ROLE_ADMIN'])
class NightController {

    static scaffold = true
	
	def exportService
	
	static navigation = [
		order:20,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Night',
		path:'night'
	]
	
	def list() {
		params.max = 7
		if (!params.sort) {
			params.sort = 'midnight'
		}
		
		
		if (params?.format && params.format != "html") {
			params.max = null
			response.contentType = grailsApplication.config.grails.mime.types[params.format] 
			response.setHeader("Content-disposition", "attachment; filename=nights.${params.extension}")

			exportService.export(params.format, response.outputStream, Night.list(params), [:], [:])
		}
		
		[nightInstanceList: Night.list(params), nightInstanceTotal: Night.count()]
	}
	
	def bla() {
		Date d = new Date(114, 7, 19, 0, 0)
		(1..32).each {
			Night day = new Night()
			day.midnight = d
			day.save()
			d = (d + 1)
		}
		redirect(action:'list')
	}
}
