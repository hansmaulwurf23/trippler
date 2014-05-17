import de.mf.tp.sec.Role
import de.mf.tp.sec.User
import de.mf.tp.sec.UserRole

class BootStrap {

    def init = { servletContext ->
			assert User.count() >= 1 
			assert Role.count() >= 2 
			assert UserRole.count() >= 1
    }
    def destroy = {
    }
}
