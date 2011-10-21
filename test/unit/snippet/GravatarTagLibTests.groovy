package snippet

import grails.test.*
import auth.*

class GravatarTagLibTests extends TagLibUnitTestCase {

    def gravatarTagLib

    protected void setUp() {
        super.setUp()
        loadCodec(org.codehaus.groovy.grails.plugins.codecs.MD5Codec)
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        mockConfig("""
            gravatar.profile_request.url = 'http://www.gravatar.com/'
            gravatar.image_request.url = 'http://www.gravatar.com/avatar/'
            gravatar.image_request.params = '?r=G&d=identicon&s='
        """)
        mockDomain(User, [new User(username: "user", password: "password", email: "MyEmailAddress@example.com ", gravatar_hash: "0bc83cb571cd1c50ba6f3e8a78ef1346")])
        mockTagLib(GravatarTagLib)
        def gravatarTagLib = new GravatarTagLib()
        User user = User.findByUsername("user")
        def expected = "<a href=\"http://www.gravatar.com/${user.email.trim().toLowerCase().encodeAsMD5()}\"><img src=\"http://www.gravatar.com/avatar/${user.email.trim().toLowerCase().encodeAsMD5()}?r=G&d=identicon&s=18\" alt=\"Gravatar\" /></a>"
        def result = gravatarTagLib.img([hash: user.gravatar_hash, size: "18"],{}).toString()
        println expected
        println result
        assert expected == result 
    }
}
