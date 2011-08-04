import snippet.Role
import snippet.User
import snippet.UserRole
import snippet.Snippet

class BootStrap {
    
    def springSecurityService

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        String password = springSecurityService.encodePassword('password')
        def testUser = new User(username: 'admin', enabled: true, password: password)
        testUser.save(flush: true)
        
        String password2 = springSecurityService.encodePassword('password')
        def testUser2 = new User(username: 'user', enabled: true, password: password2)
        testUser2.save(flush: true)

        UserRole.create testUser, adminRole, true
        UserRole.create testUser2, userRole, true

        assert UserRole.count() == 2
        assert Role.count() == 2
        assert User.count() == 2

        def s1 = new Snippet(description: "A", snippet: "sample", author: User.get(1)).save(flush: true)
        s1.parseTags("ABC,DEF,GH")
        def s2 = new Snippet(description: "ABC", snippet: "s\namp\nle", author: User.get(2)).save(flush: true)
        s2.parseTags("abc,def")
        def s3 = new Snippet(description: "B", snippet: "test", author: User.get(1)).save(flush: true)
        s3.parseTags("def,GH")
        def s4 = new Snippet(description: "C", snippet: "abc", author: User.get(1)).save(flush: true)
        s4.parseTags("test")
        def s5 = new Snippet(description: "Test", snippet: "t\nest", author: User.get(2)).save(flush: true)
        s5.parseTags("test,sample")

        assert Snippet.count() == 5
    }
}
