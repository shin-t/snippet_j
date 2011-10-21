package auth

import grails.test.*

class UserControllerTests extends GrailsUnitTestCase {

    def springSecurityService

    protected void setUp() {
        super.setUp()
        mockController(UserController)
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
    }
}
