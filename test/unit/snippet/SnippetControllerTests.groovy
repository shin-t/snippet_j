package snippet

import grails.plugins.springsecurity.SpringSecurityService
import grails.test.*

class SnippetControllerTests extends ControllerUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        controller.index()
        println controller.redirectArgs["action"]
        controller.springSecurityService = new SpringSecurityService()
        controller.parse_tags()
        println controller.response.contentAsString
    }
}
