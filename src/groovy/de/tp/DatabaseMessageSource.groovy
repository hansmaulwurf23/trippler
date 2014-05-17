package de.tp

import java.text.MessageFormat
import java.util.Locale
import org.apache.log4j.Logger

import org.codehaus.groovy.grails.context.support.PluginAwareResourceBundleMessageSource

import de.tp.Localization;

class DatabaseMessageSource extends PluginAwareResourceBundleMessageSource {

	def log = Logger.getLogger(DatabaseMessageSource.class)

	def messageCache = []
	def cacheDate = new Date()
	def cacheMillis = -1

	void clearCache() {
		log.trace "Clearing cache"
		messageCache = []
		super.clearCache()
	}

	@Override
	public void setCacheSeconds(int cacheSeconds) {
		cacheMillis = cacheSeconds*1000
		super.setCacheSeconds(cacheSeconds);
	}

	private String resolveFromDB(String code, Locale locale) {
		return Localization.decodeMessage(code, locale);
	}

	protected String resolveCodeWithoutArguments(String code, Locale locale) {
		String localized = resolveFromDB(code, locale)//?.text
		if(localized == null) {
			localized = super.resolveCodeWithoutArguments(code, locale)
		}
		if (localized == null) { Localization.addMissing(code) }
		log.trace "resolveCodeWithoutArguments(${code}, ${locale}): ${localized}"
		return localized
	}
	
	protected String resolveCodeWithoutArgumentsFromPlugins(String code, Locale locale) {
		String localized = resolveFromDB(code, locale)//?.text
		if(localized == null) {
			localized = super.resolveCodeWithoutArgumentsFromPlugins(code, locale)
		}
		if (localized == null) { Localization.addMissing(code) }
		log.trace "resolveCodeWithoutArgumentsFromPlugins(${code}, ${locale}): ${localized}"
		return localized
	}

	protected MessageFormat resolveCodeFromPlugins(String code, Locale locale) {
		log.trace "resolveCodeFromPlugins(${code}, ${locale})"
		String localized = resolveFromDB(code, locale)//?.text
		if(localized != null) {
			return new MessageFormat(localized, locale)
		}
		else {
			MessageFormat localizedMessage = super.resolveCodeFromPlugins(code, locale)
			if (localizedMessage == null) { Localization.addMissing(code) }
			return localizedMessage
		}
	}

	protected MessageFormat resolveCode(String code, Locale locale) {
		log.trace "resolveCode(${code}, ${locale})"
		String localized = resolveFromDB(code, locale)//?.text
		if(localized != null) {
			return new MessageFormat(localized, locale)
		}
		else {
			MessageFormat localizedMessage = super.resolveCode(code, locale)
			if (localizedMessage == null) { Localization.addMissing(code) }
			return localizedMessage
		}
	}
}
