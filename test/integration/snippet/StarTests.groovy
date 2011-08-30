package snippet

import grails.test.*

class StarTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()

        def user = new User(username:"user",password:"password")
        assert user.save() instanceof User

        def snippet = new Snippet(name:"snippet",snippet:"snippet...",author:user)
        assert snippet.save() instanceof Snippet

        assert new Star(user:user,snippet:snippet).save() instanceof Star
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test get"() {
        assert Star.get(User.findByUsername("user").id,Snippet.findByName("snippet").id).instanceOf(Star)
    }
}
