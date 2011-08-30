package snippet

import grails.test.*

class UserControllerTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testIndex() {
        def uc = new UserController()
        uc.index()
        println uc.response.redirectedUrl
    }
}
