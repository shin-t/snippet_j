package snippet

import grails.test.*
import org.codehaus.groovy.grails.plugins.codecs.MD5Codec
import auth.*

class UserUserTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
        loadCodec(MD5Codec)
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        mockDomain(User, [
            new User(username: 'admin', enabled: true, password: 'password', email: 'abc.123@example.com', gravatar_hash: "abc.123@example.com".trim().toLowerCase().encodeAsMD5()),
            new User(username: 'user', enabled: true, password: 'password', email: 'abc@example.com', gravatar_hash: "abc@example.com".trim().toLowerCase().encodeAsMD5())])
        mockDomain(UserUser)
        UserUser.create User.get(1), User.get(2), true
        assert 1 == UserUser.count()
    }
}
