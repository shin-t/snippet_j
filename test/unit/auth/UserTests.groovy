package auth

import grails.test.*

class UserTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
        loadCodec(org.codehaus.groovy.grails.plugins.codecs.MD5Codec)
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test to string"() {
        mockDomain(User,[new User(username:"admin",password:"password")])
        assertEquals "admin", User.get(1).toString()
    }

    void testGetAuthorities() {
        mockDomain(Role,[new Role(authority:"ROLE_ADMIN"),new Role(authority:"ROLE_USER")])
        mockDomain(User,[new User(username:"admin",password:"password")])
        mockDomain(UserRole,[new UserRole(user:User.get(1),role:Role.get(1)),new UserRole(user:User.get(1),role:Role.get(2))])

        assert 2 == User.get(1).getAuthorities().size()
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

        user.email = "MyEmailAddress.123@example.com "
        assertTrue user.validate(["email"])

        user.gravatar_hash = user.email.trim().toLowerCase().encodeAsMD5()

        assertTrue user.validate()
    }
}
