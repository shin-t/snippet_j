package snippet

import auth.*

import grails.test.*

class StarTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()

        def user = new User(username:"username",password:"password",email:"MyEmailAddress@example.com ")
        user.gravatar_hash = user.email.trim().toLowerCase().encodeAsMD5()
        assert user.save() instanceof User

        def snippet = new Snippet(text:"snippet",file:"snippet...",user:user)
        assert snippet.save() instanceof Snippet

        assert new Star(user:user,snippet:snippet).save() instanceof Star
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test get"() {
        assert Star.get(User.findByUsername("username").id,Snippet.findByText("snippet").id).instanceOf(Star)
    }
    void "test removeall"() {
        assert 1 == Star.count()
        Star.removeAll User.findByUsername("username")
        assert 0 == Star.count()
    }
}
