package snippet

import grails.test.*

class UserTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testValidation() {
        mockForConstraintsTests(User,[new User(username:"admin",password:"password")])

        def user = new User()

        user.username = null
        assertFalse user.validate(["username"])

        user.username = ''
        assertFalse user.validate(["username"])

        user.username = "admin"
        assertFalse user.validate(["username"])

        user.username = "user"
        assertTrue user.validate(["username"])

        user.password = null
        assertFalse user.validate(["password"])

        user.password = ''
        assertFalse user.validate(["password"])

        user.password = "password"
        assertTrue user.validate(["password"])

        assertTrue user.validate()
    }
}
