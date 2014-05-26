
package de.tp

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import de.tp.Stage;

@Secured(['ROLE_ADMIN'])
class StageController {

	static navigation = [
		order:50,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Stage',
		path:'stage'
	]
	
	static scaffold = true
	
	def search() {
		def found = Stage.search("*${params.term}*", [escape: false,  result: 'every'])
		println found
		def result = []
		found.each { a ->
			result << [id: a.id, value: a.toString() + (a.address ? " (" + a.address + ")" : ""), address: a.address?.toSearchableString(), addressid: a.address?.id]
		}
		
		render result as JSON
	}
	
	def list() {
		[stageInstanceList: Stage.findAllByVariant(session.variant, params), stageInstanceTotal: Stage.countByVariant(session.variant)]
	}
	
	def save() {
		def stageInstance = new Stage(params)
		stageInstance.variant = session.variant
		if (!stageInstance.save(flush: true)) {
			render(view: "create", model: [stageInstance: stageInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'stage.label', default: 'Stage'), stageInstance.id])
		redirect(action: "show", id: stageInstance.id)
	}
}

    