package de.mf.tp

import grails.plugins.springsecurity.Secured;

@Secured(['ROLE_ADMIN'])
class ReportController {
	
	def birtReportService
	
	static navigation = [
		order:890,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Report',
		path:'report'
	]

    def index() { }
	
	def tagebuch() {
		String reportExt = 'pdf'
		def parameters = [:]
		def options = birtReportService.getRenderOption(request, 'pdf')
		def result=birtReportService.runAndRender("Tagebuch", parameters, options)
		response.setHeader("Content-disposition", "attachment; filename=Tagebuch."+reportExt);
		response.contentType = 'application/pdf'
		response.outputStream << result.toByteArray()
		return false
	}
}
