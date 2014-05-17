import de.tp.sec.Role
import de.tp.sec.User
import de.tp.sec.UserRole

class BootStrap {

    def init = { servletContext ->
			assert User.count() >= 1 
			assert Role.count() >= 2 
			assert UserRole.count() >= 1
    }
    def destroy = {
    }
}
