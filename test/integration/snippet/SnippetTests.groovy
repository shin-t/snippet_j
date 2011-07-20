package snippet

import grails.test.*

class SnippetTests extends GroovyTestCase {

    def springSecurityService

    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {

        // mockDomain(Snippet)
        // mockDomain(Patch)
        // mockDomain(UserRole)
        // mockDomain(User)
        // mockDomain(Role)

        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
        def testUser1 = new User(username: 'admin', enabled: true, password: 'password')
        def testUser2 = new User(username: 'user', enabled: true, password: 'password')

        testUser1.save(flush: true)
        UserRole.create testUser1, adminRole, true
        testUser2.save(flush: true)
        UserRole.create testUser2, userRole, true

        assert User.count() == 2
        assert Role.count() == 2
        assert UserRole.count() == 2

        def snippet = new Snippet(author:User.get(2),name:"Test",snippet:"main()\n{\n\treturn 0;\n}\n")
        snippet.save(flush: true)
        assert Snippet.count() == 1

        def sc = new SnippetController()
        sc.params.id=1
        sc.params.snippet="#include <stdio.h>\nmain()\n{\n}\n"
        sc.update()
    }
}
