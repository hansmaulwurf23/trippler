// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
	pdf: 		   'application/pdf',
	rtf: 		   'application/rtf',
	excel: 		   'application/vnd.ms-excel',
	ods: 		   'application/vnd.oasis.opendocument.spreadsheet',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

grails.gorm.default.constraints = {
	'*'(nullable: true)
}

de.tp.defaultDateFormat="dd.MM.yyyy"

environments {
    development {
        grails.logging.jul.usebridge = true
        grails.config.locations = ["file:${userHome}/.grails/trippler-config.groovy", "file:/var/opt/trippler/trippler-config.groovy"]
    }
    production {
        grails.logging.jul.usebridge = false
        grails.config.locations = ["file:/var/opt/trippler/trippler-config.groovy"]
    }
}

// reporting
birt {
	reportHome = "reports" // will be in the webapp directory during development
	imageUrl = "images/report" // this is a subdirectory of the images dir in the webapp directory, where BIRT stores the chart-images.
}

/*
 * =================================================================================================================
 *    LOG4J CONFIGURATION
 * =================================================================================================================
 */

log4j = {
	environments {
		production {
			appenders {
				console name: 'stdout',
						layout:new util.log4j.ANSIPatternLayout(conversionPattern: '%d{yyyy-MM-dd HH:mm:ss,SSSS}  %5p %c{1} - %m%n')
			}

			warn    'org.mortbay.log',
					'de.tp.DatabaseMessageSource'

			debug   'grails.app',
					'de.tp'

			error   'grails.app.service.org.grails.plugin.resource',
					'grails.app.taglib.org.grails.plugin.resource',
					'grails.app.resourceMappers.org.grails.plugin.resource'

			root { info 'stdout', 'file'}
		}

		test {
			appenders {
				console name: 'stdout',
						layout:new util.log4j.ANSIPatternLayout(conversionPattern: '%d{yyyy-MM-dd HH:mm:ss,SSSS} %5p %c{1} - %m%n')
			}

			warn    'org.mortbay.log'

			error   'grails.app.service.org.grails.plugin.resource',
					'grails.app.taglib.org.grails.plugin.resource',
					'grails.app.resourceMappers.org.grails.plugin.resource'

			debug   'grails.app',
					'de.tp'
		}

		development {
			appenders {
				console name: 'stdout',
						layout:new util.log4j.ANSIPatternLayout(conversionPattern: '%d{yyyy-MM-dd HH:mm:ss,SSSS}  %5p %c{1} - %m%n')
			}

			warn    'org.mortbay.log',
					'de.tp.DatabaseMessageSource'

			error   'grails.app.service.org.grails.plugin.resource',
					'grails.app.taglib.org.grails.plugin.resource',
					'grails.app.resourceMappers.org.grails.plugin.resource'

			debug   'grails.app',
					'de.tp'
			root { info 'stdout'}
		}
	}
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'de.tp.sec.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'de.tp.sec.UserRole'
grails.plugins.springsecurity.authority.className = 'de.tp.sec.Role'

grails.plugins.springsecurity.useSecurityEventListener = true
grails.plugins.springsecurity.onAuthenticationSuccessEvent = { e, appCtx ->
	def u = de.tp.sec.User.findByUsername(e.authentication.name)
	def us = de.tp.UserSetting.get(u.id)
	if (us && us.defaultVariant) {
		org.springframework.web.context.request.RequestContextHolder.currentRequestAttributes().session['variant'] = us.defaultVariant
		org.springframework.web.context.request.RequestContextHolder.currentRequestAttributes().session['holiday'] = us.defaultVariant.holiday
	} else {
		def variant = de.tp.Variant.first()
		org.springframework.web.context.request.RequestContextHolder.currentRequestAttributes().session['variant'] = variant
		org.springframework.web.context.request.RequestContextHolder.currentRequestAttributes().session['holiday'] = variant.holiday
	}
}
