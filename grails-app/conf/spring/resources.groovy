import org.springframework.web.servlet.i18n.SessionLocaleResolver

beans = {
   localeResolver(SessionLocaleResolver) {
	  defaultLocale= Locale.GERMAN
	  Locale.setDefault(Locale.GERMAN)
   }
   
   messageSource(de.tp.DatabaseMessageSource) {
	   basenames = "WEB-INF/grails-app/i18n/messages"
	   cacheSeconds = 10
	   fallbackToSystemLocale = false
	   defaultEncoding = "UTF-8"
   }
}