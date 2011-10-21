package snippet

import grails.test.*
import org.codehaus.groovy.grails.plugins.codecs.MD5Codec

class UserTagTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
        loadCodec(MD5Codec)
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        /*
        def email = "abc@example.com"
        def hash = email.trim().toLowerCase().encodeAsMD5()
        mockDomain(User,[new User(username: 'user', enabled: true, password: 'password', email: 'abc@example.com', gravatar_hash: "abc@example.com".trim().toLowerCase().encodeAsMD5())])
        assert 1 == User.count()
        mockDomain(Snippet,[new Snippet(user: User.get(1), text: 'Text', file: 'File')])
        assert 1 == Snippet.count()
        Snippet.get(1).parseTags('test snippet',' ')
        UserTag.create User.get(1), 
        */
    }
}
