package de.mf.tp

import grails.plugins.springsecurity.Secured

import java.lang.invoke.MethodHandleImpl.BindCaller.T

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.grails.plugins.localization.*

@Secured(['ROLE_ADMIN'])
class LocalizationController {

	static navigation = [
		order:900,
		isVisible: { org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN, ROLE_USER') },
		title:'Localization',
		path:'localization'
	]

	def filterPaneService

	def index = { redirect(action:'smartcreate',params:params) }

	// the delete, save and update actions only accept POST requests
	static allowedMethods = [delete:'POST', save:'POST', update:'POST', reset:'POST', load:'POST']

	def list = {
		// The following line has the effect of checking whether this plugin
		// has just been installed and, if so, gets the plugin to load all
		// message bundles from the i18n directory BEFORE we attempt to display
		// them in this list!
		message(code: "home", default: "Home")

		def max = 50
		def dflt = 20

		// If the settings plugin is available, try and use it for pagination
		//        if (localizationService.hasPlugin("settings")) {
		//
		//            // This convolution is necessary because this plugin can't see the
		//            // domain classes of another plugin
		//            def setting = ((GrailsDomainClass) ApplicationHolder.getApplication().getArtefact(DomainClassArtefactHandler.TYPE, "org.grails.plugins.settings.Setting")).newInstance()
		//            max = setting.valueFor("pagination.max", max)
		//            dflt = setting.valueFor("pagination.default", dflt)
		//        }

		params.max = (params.max && params.max.toInteger() > 0) ? Math.min(params.max.toInteger(), max) : dflt
		params.sort = params.sort ?: "code"

		def lst
		//		if (localizationService.hasPlugin("criteria") || localizationService.hasPlugin("drilldowns")) {
		//			lst = Localization.selectList( session, params )
		//		} else {
		lst = Localization.list( params )
		//		}

		[ localizationList: lst ]
	}

	def filter = {
		if(!params.max) params.max = 10
		render( view:'list',
		model:[ localizationList: filterPaneService.filter( params, Localization ),
			localizationCount: filterPaneService.count( params, Localization ),
			filterParams: org.grails.plugin.filterpane.FilterPaneUtils.extractFilterParams(params),
			params:params ] )
	}

	def show = {
		def localization = Localization.get( params.id )

		if(!localization) {
			flash.message = "localization.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Localization not found with id ${params.id}"
			redirect(action:list)
		}
		else { return [ localization : localization ] }
	}

	def delete = {
		log.debug "----------------------------> ID ${params.id}"
		def localization = Localization.get( params.int("id") )

		if(localization) {
			localization.delete()
			Localization.resetThis(localization.code)
			flash.message = "localization.deleted"
			flash.args = [params.id]
			flash.defaultMessage = "Localization ${params.id} deleted"
		}
		else {
			// findByCode
			def localizations = Localization.findAllByCode( params.id )
			log.debug "found multiple (${localizations.size()}) location entries for code ${params.id}"
			def ids = []
			if (localizations) {
				localizations.each { loc ->
					loc.delete()
					ids.add(loc.id)
					Localization.resetThis(loc.code)
				}

				flash.message = "localization.deleted"
				flash.args = [ids]
				flash.defaultMessage = "Localization ${ids} deleted"
			} else {
				flash.message = "localization.not.found"
				flash.args = [params.id]
				flash.defaultMessage = "Localization not found with id ${params.id}"
			}
		}

		redirect(action:list)
	}

	def edit = {
		def localization = Localization.get( params.id )

		if(!localization) {
			flash.message = "localization.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Localization not found with id ${params.id}"
			redirect(action:list)
		}
		else {
			return [ localization : localization ]
		}
	}

	def smartlist() {
		def codes = Localization.codes.list()
		def locales = Localization.locales.list()
		def localizations = Localization.list()
		def localizationsByCodeAndLocale = [:]
		localizations.each { locz ->
			(localizationsByCodeAndLocale[locz.code]?:(localizationsByCodeAndLocale[locz.code] = [:]))[locz.locale] = locz
		}
		[ codes: codes, locales:locales, localizationsByCodeAndLocale:localizationsByCodeAndLocale ]
	}

	def smartcreate = {
		def code = params.id
		if (params.code) {
			code = params.code
		}
		if (params.reset) {
			Localization.resetMissings()
			params.reset = false
			redirect(action:'smartcreate')
		}
		def locales = Localization.locales.list()
		log.warn locales
		def localizationsByLocale = [:]
		return [ code:code, locales:locales, localizationsByLocale:localizationsByLocale ]
	}

	def smartsave = {
		def code = params.id
		def update = true
		def locales = Localization.locales.list()
		log.warn locales
		def localizationsByLocale = [:]
		params.findAll { k,v -> k.startsWith("text_") }.each { param ->
			def parts = param.key.tokenize('_')
			if (parts.size() > 1) {
				// def field = parts[0] // always text
				def locale = parts[1]
				log.warn "creating new entry for code '${code}', locale '${locale}', and text '${param.value}'"
				def localization = new Localization()
				localization.code = code
				localization.locale = locale
				localization.text = param.value
				if (!localization.save()) {
					update = false
				}
				localizationsByLocale[locale] = localization
			}
		}

		if(update) {
			Localization.resetThis(code)
			Localization.removeMissing(code)
			flash.message = "code.created"
			flash.args = [params.id]
			flash.defaultMessage = "Code ${params.id} created"
			redirect(action:'smartcreate')
		}
		else {
			render(view:'smartcreate',model:[ code:code, locales:locales, localizationsByLocale:localizationsByLocale ])
		}
	}

	def smartedit = {
		def code = params.id
		if (params.code) {
			code = params.code
		}
		def localizations = Localization.findAllByCode(code)

		if(!localizations) {
			flash.message = "localization.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Localization not found with code ${params.id}"
			redirect(action:list)
		}
		else {
			log.warn localizations
			def locales = Localization.locales.list()
			log.warn locales
			def localizationsByLocale = [:]
			localizations.each { locz ->
				localizationsByLocale[locz.locale] = locz
			}
			log.warn localizationsByLocale
			return [ code:code, locales:locales, localizationsByLocale:localizationsByLocale ]
		}
	}

	def smartupdate = {
		def code = params.id
		def localizations = Localization.findAllByCode(code)
		if(localizations) {
			def update = true
			def locales = Localization.locales.list()
			log.warn locales
			def localizationsByLocale = [:]
			localizations.each { locz ->
				localizationsByLocale[locz.locale] = locz
			}
			params.findAll { k,v -> k.startsWith("text_") }.each { param ->
				def parts = param.key.tokenize('_')
				if (parts.size() > 1) {
					// def field = parts[0] // always text
					def locale = parts[1]
					if (parts.size() > 2) {
						def id = parts[2]
						log.warn "processing ${id} with text '${param.value}'"
						def localization = localizations.find {it.id == id.toLong()}
						if (localization) {
							localization.text = param.value
							if (!localization.save()) {
								update = false
							}
						} else {
							log.warn "oops"
							update = false
						}
					} else {
						log.warn "creating new entry for code '${code}', locale '${locale}', and text '${param.value}'"
						def localization = new Localization()
						localization.code = code
						localization.locale = locale
						localization.text = param.value
						if (!localization.save()) {
							update = false
						}
					}
				}
			}
			if(update) {
				Localization.resetThis(code)
				flash.message = "code.updated"
				flash.args = [params.id]
				flash.defaultMessage = "Code ${params.id} updated"
				redirect(action:'smartlist')
			}
			else {
				render(view:'smartedit',model:[ code:code, locales:locales, localizationsByLocale:localizationsByLocale ])
			}
		}
		else {
			flash.message = "localization.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Localization not found with code ${params.id}"
			redirect(action:edit,id:params.id)
		}
	}

	def update = {
		def localization = Localization.get( params.id )
		if(localization) {
			def oldCode = localization.code
			localization.properties = params
			if(!localization.hasErrors() && localization.save()) {
				Localization.resetThis(oldCode)
				if (localization.code != oldCode) Localization.resetThis(localization.code)
				flash.message = "localization.updated"
				flash.args = [params.id]
				flash.defaultMessage = "Localization ${params.id} updated"
				redirect(action:show,id:localization.id)
			}
			else {
				render(view:'edit',model:[localization:localization])
			}
		}
		else {
			flash.message = "localization.not.found"
			flash.args = [params.id]
			flash.defaultMessage = "Localization not found with id ${params.id}"
			redirect(action:edit,id:params.id)
		}
	}

	def create = {
		def localization = new Localization()
		localization.properties = params
		return ['localization':localization]
	}

	def save = {
		def localization = new Localization(params)
		if(!localization.hasErrors() && localization.save()) {
			Localization.resetThis(localization.code)
			flash.message = "localization.created"
			flash.args = ["${localization.id}"]
			flash.defaultMessage = "Localization ${localization.id} created"
			redirect(action:show,id:localization.id)
		}
		else {
			render(view:'create',model:[localization:localization])
		}
	}

	def cache = {
		def stats = Localization.statistics()
		def cacheSizeColumns = [
			['string', 'Status'],
			['number', 'Size']
		]
		def cacheSizeData = []
		cacheSizeData.add([
			message(code:'cache.size.used.label'),
			stats.size
		])
		cacheSizeData.add([
			message(code:'cache.size.free.label'),
			stats.max-stats.size
		])

		def cacheRatioColumns = [
			['string', 'Status'],
			['number', 'Anzahl']
		]
		def cacheRatioData = []
		cacheRatioData.add([
			message(code:'cache.ratio.misses.label'),
			stats.misses
		])
		cacheRatioData.add([
			message(code:'cache.ratio.hits.label'),
			stats.hits
		])

		[stats:stats,
			cacheSizeColumns:cacheSizeColumns, cacheSizeData:cacheSizeData,
			cacheRatioColumns:cacheRatioColumns, cacheRatioData:cacheRatioData]
	}

	def reset = {
		Localization.resetAll()
		redirect(action:cache)
	}

	def imports = {
		// The following line has the effect of checking whether this plugin
		// has just been installed and, if so, gets the plugin to load all
		// message bundles from the i18n directory BEFORE we attempt to display
		// the property files here.
		message(code: "home", default: "Home")

		def names = []
		def path = servletContext.getRealPath("/")
		if (path) {
			def dir = new File(new File(path).getParent(), "grails-app${File.separator}i18n")
			if (dir.exists() && dir.canRead()) {
				def name
				dir.listFiles().each {
					if (it.isFile() && it.canRead() && it.getName().endsWith(".properties")) {
						name = it.getName()
						names << name.substring(0, name.length() - 11)
					}
				}

				names.sort()
			}
		}

		return [names: names]
	}

	def exports() {
		def file = params.file
		if (file) {
			log.warn "export properties file for locale ${file}"
			def localizations = Localization.findAllByLocale(file)
			if (localizations) {
				log.debug "found ${localizations?.size()} entries for locale ${file}"
				def output = new StringBuffer()
				localizations.sort{it.code}.each { localization -> output << "${localization.code}=${localization.text}\n" }
				response.setContentType("text/plain")
				if (file == "*") {
					response.setHeader("Content-disposition", "attachment; filename=messages.properties")
				} else {
					response.setHeader("Content-disposition", "attachment; filename=messages_${file}.properties")
				}
				response.outputStream << output
			}
		}

		def locales = Localization.locales.list()
		log.warn locales
		return [ locales:locales ]
	}

	def load = {
		def name = params.file
		if (name) {
			name += ".properties"
			def path = servletContext.getRealPath("/")
			if (path) {
				def dir = new File(new File(path).getParent(), "grails-app${File.separator}i18n")
				if (dir.exists() && dir.canRead()) {
					def file = new File(dir, name)
					if (file.isFile() && file.canRead()) {
						def locale
						if (name ==~ /.+_[a-z][a-z]_[A-Z][A-Z]\.properties$/) {
							locale = new Locale(name.substring(name.length() - 16, name.length() - 14), name.substring(name.length() - 13, name.length() - 11))
						} else if (name ==~ /.+_[a-z][a-z]\.properties$/) {
							locale = new Locale(name.substring(name.length() - 13, name.length() - 11))
						} else {
							locale = null
						}

						def counts = Localization.loadPropertyFile(file, locale)
						loadPropertyFile(file, locale)
						flash.message = "localization.imports.counts"
						flash.args = [
							counts.imported,
							counts.skipped
						]
						flash.defaultMessage = "Imported ${counts.imported} key(s). Skipped ${counts.skipped} key(s)."
					} else {
						flash.message = "localization.imports.access"
						flash.args = [file]
						flash.defaultMessage = "Unable to access ${file}"
					}
				} else {
					flash.message = "localization.imports.access"
					flash.args = [dir]
					flash.defaultMessage = "Unable to access ${dir}"
				}
			} else {
				flash.message = "localization.imports.access"
				flash.args = ["/"]
				flash.defaultMessage = "Unable to access /"
			}
		} else {
			flash.message = "localization.imports.missing"
			flash.defaultMessage = "No properties file selected"
		}

		redirect(action: "imports")
	}

	private loadPropertyFile(file, locale) {
		def loc = locale ? locale.getLanguage() + locale.getCountry() : "*"
		def props = new Properties()
		def reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"))
		try {
			props.load(reader)
		} finally {
			if (reader) reader.close()
		}

		def rec, txt
		def counts = [imported: 0, skipped: 0]
		props.stringPropertyNames().each {key ->
			txt = props.getProperty(key)
			if (key && key.length() <= 250 && txt && txt.length() <= 2000) {
				rec = Localization.findByCodeAndLocale(key, loc)
				if (!rec) {
					//					Localization.withTransaction {status ->
					//						rec = new Localization()
					//						rec.code = key
					//						rec.locale = loc
					//						rec.text = txt
					//						if (rec.save(flush: true)) {
					//							counts.imported = counts.imported + 1
					//						} else {
					//							counts.skipped = counts.skipped + 1
					//							status.setRollbackOnly()
					//						}
					//					}
				} else {
					if (txt != rec.text)
						log.warn "${txt} vs ${rec.text}"
					counts.skipped = counts.skipped + 1
				}
			} else {
				counts.skipped = counts.skipped + 1
			}
		}

		// Clear the whole cache if we actually imported any new keys
		if (counts.imported > 0) Localization.resetAll()

		return counts
	}
}