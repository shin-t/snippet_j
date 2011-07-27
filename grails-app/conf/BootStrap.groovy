import snippet.Role
import snippet.User
import snippet.UserRole

class BootStrap {
    
    def springSecurityService

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        String password = springSecurityService.encodePassword('password')
        def testUser = new User(username: 'admin', enabled: true, password: password)
        testUser.save(flush: true)

        UserRole.create testUser, adminRole, true

        assert UserRole.count() == 1
        assert Role.count() == 2
        assert User.count() == 1
    }
}
