package de.tp

import grails.plugins.springsecurity.Secured;

import org.springframework.dao.DataIntegrityViolationException

@Secured(['ROLE_ADMIN'])
class VariantController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }
	
	def switchVariant() {
		[:]
	}
	
	def doSwitchVariant(Long newVariant) {
		println params
		Variant v = Variant.get(newVariant)
		if (v) {
			session.variant = v
			if (params.newDefault) {
				UserSetting us = UserSetting.get(springSecurityService.currentUser.id)
				if (!us) {
					us = new UserSetting()
					us.id = springSecurityService.currentUser.id
				}
				us.defaultVariant = v
				us.save(failOnError:true, flush:true)
			}
		}
		redirect(action:'list')
	}

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [variantInstanceList: Variant.list(params), variantInstanceTotal: Variant.count()]
    }

    def create() {
        [variantInstance: new Variant(params)]
    }

    def save() {
        def variantInstance = new Variant(params)
        if (!variantInstance.save(flush: true)) {
            render(view: "create", model: [variantInstance: variantInstance])
            return
        }
		
		if (params.copyFromVariant) {
			Variant copyFromVariant = Variant.get(params.copyFromVariant.toLong())
			if (copyFromVariant) {
				Day.findAllByVariant(copyFromVariant).each { originalDay ->
					Day copiedDay = originalDay.clone()
					copiedDay.variant = variantInstance
					copiedDay.save()
				}
				
				Night.findAllByVariant(copyFromVariant).each { originalNight ->
					Night copiedNight = originalNight.clone()
					copiedNight.variant = variantInstance
					copiedNight.save()
				}
				
				Stage.findAllByVariant(copyFromVariant).each { originalStage ->
					Stage copiedStage = originalStage.clone()
					copiedStage.variant = variantInstance
					copiedStage.save()
				}
			} 
		}

        flash.message = message(code: 'default.created.message', args: [message(code: 'variant.label', default: 'Variant'), variantInstance.id])
        redirect(action: "show", id: variantInstance.id)
    }

    def show(Long id) {
        def variantInstance = Variant.get(id)
        if (!variantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'variant.label', default: 'Variant'), id])
            redirect(action: "list")
            return
        }

        [variantInstance: variantInstance]
    }

    def edit(Long id) {
        def variantInstance = Variant.get(id)
        if (!variantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'variant.label', default: 'Variant'), id])
            redirect(action: "list")
            return
        }

        [variantInstance: variantInstance]
    }

    def update(Long id, Long version) {
        def variantInstance = Variant.get(id)
        if (!variantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'variant.label', default: 'Variant'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (variantInstance.version > version) {
                variantInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'variant.label', default: 'Variant')] as Object[],
                          "Another user has updated this Variant while you were editing")
                render(view: "edit", model: [variantInstance: variantInstance])
                return
            }
        }

        variantInstance.properties = params

        if (!variantInstance.save(flush: true)) {
            render(view: "edit", model: [variantInstance: variantInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'variant.label', default: 'Variant'), variantInstance.id])
        redirect(action: "show", id: variantInstance.id)
    }

    def delete(Long id) {
        def variantInstance = Variant.get(id)
        if (!variantInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'variant.label', default: 'Variant'), id])
            redirect(action: "list")
            return
        }

        try {
			Stage.findAllByVariant(variantInstance).each { it.delete(flush: true) }
			Day.findAllByVariant(variantInstance).each { it.delete(flush: true) }
			Night.findAllByVariant(variantInstance).each { it.delete(flush: true) }
			
            variantInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'variant.label', default: 'Variant'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'variant.label', default: 'Variant'), id])
            redirect(action: "show", id: id)
        }
    }
}
