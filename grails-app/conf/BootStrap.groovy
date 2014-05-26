import de.tp.Accomodation;
import de.tp.Day;
import de.tp.Holiday;
import de.tp.Night;
import de.tp.Stage;
import de.tp.Variant;
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
				
			def holiday = Holiday.first()
			if (!holiday) {
				holiday = new Holiday(name:'USA 2014').save(failOnError:true, flush:true)
				holiday.refresh()
				
				// due to changes in price, etc accomodations belong to a certain holiday
				Accomodation.list().each { a ->
					a.holiday = holiday
					a.save(failOnError:true, flush:true)
				}
			}
			
			def variant = Variant.first()
			if (!variant) {
				variant = new Variant(name:'default', holiday: holiday).save(failOnError:true, flush:true)
				variant.refresh()
				
				// stages, days and nights belong to a certain variant of a holiday
				Stage.list().each { s ->
					s.variant = variant
					s.save(failOnError:true, flush:true)
				}
				
				Day.list().each { d ->
					d.variant = variant
					d.save(failOnError:true, flush:true)
				}
				
				Night.list().each { n ->
					n.variant = variant
					n.save(failOnError:true, flush:true)
				}
			}
		
			// check if everything went fine
			assert User.count() >= 1 
			assert Role.count() >= 2 
			assert UserRole.count() >= 1
			assert Holiday.count() >= 1
			assert Variant.count() >= 1
    }
    def destroy = {
    }
}
