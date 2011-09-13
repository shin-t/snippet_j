import auth.*

class BootStrap {
    
    def springSecurityService

    def init = { servletContext ->

        if(Role.count() == 0){
            def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
            def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
            assert Role.count() == 2
        }

    }
}
