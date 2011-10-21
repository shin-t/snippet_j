package auth

import grails.test.*

class UserControllerTests extends GroovyTestCase {

    def controller

    protected void setUp() {
        super.setUp()
        controller = new UserController()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "testIndex"() {
        controller.index()
        println controller.response.redirectedUrl
        println controller.response.contentAsString
    }

    void "testList"() {
        controller.list()
        println controller.response.redirectedUrl
        println controller.response.contentAsString
    }
}
