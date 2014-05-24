import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils;


class LogoutController {
	
	static navigation = [
		order:9000,
		isVisible: { springSecurityService.isLoggedIn() },
		title:'Logout'
	]

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService
	
	/**
	 * Index action. Redirects to the Spring security logout uri.
	 */
	def index = {
		// TODO put any pre-logout code here
		redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
	}
}
