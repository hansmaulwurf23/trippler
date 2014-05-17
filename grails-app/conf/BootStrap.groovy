import de.tp.sec.Role
import de.tp.sec.User
import de.tp.sec.UserRole

class BootStrap {

    def init = { servletContext ->
		
			// create default roles
			def adminRole = Role.findByAuthority('ROLE_ADMIN')?:new Role(authority: 'ROLE_ADMIN').save(flush: true)
			def userRole = Role.findByAuthority('ROLE_USER')?:new Role(authority: 'ROLE_USER').save(flush: true)
	   
			// create default admin user
			def adminUser = User.findByUsername('admin')
			if (!adminUser) { 
				log.warn("Creating default admin user - PLEASE CHANGE IMMEDIATELY AFTER FIRST LOGIN: username='admin' / password='trippler'")
				adminUser = new User(username: 'admin', password:'trippler').save(flush: true)
			}

			if (!UserRole.findByUserAndRole(adminUser, adminRole))
				new UserRole(user:adminUser, role:adminRole).save(flush:true)
				
			
		
			// check if everything went fine
			assert User.count() >= 1 
			assert Role.count() >= 2 
			assert UserRole.count() >= 1
    }
    def destroy = {
    }
}
