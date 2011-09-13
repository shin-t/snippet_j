package auth

import grails.test.*

class RoleTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
        mockForConstraintsTests(Role,[new Role(authority:'ROLE_ADMIN')])
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testValidation() {
        def role = new Role()

        role.authority = null
        assertFalse role.validate(["authority"])

        role.authority = ''
        assertFalse role.validate(["authority"])

        role.authority = 'ROLE_ADMIN'
        assertFalse role.validate(["authority"])

        role.authority = 'ROLE_USER'
        assertTrue role.validate(["authority"])

        assertTrue role.validate()
    }
}
