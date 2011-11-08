package snippet

import grails.test.*
import org.grails.taggable.*
import auth.*

class UserTagTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
        assert 0 == User.count()
        assert 0 == Snippet.count()
        assert 0 == UserTag.count()
        def user = new User(username:"username",password:"password",email:"MyEmailAddress@example.com ")
        user.password2 = user.password
        user.email2 = user.email
        user.gravatar_hash = user.email.trim().toLowerCase().encodeAsMD5()
        user.save(flush:true)
        assert 1 == User.count()
        new Snippet(text:"snippet",file:"snippet...",user:user).save(flush:true)
        new Snippet(text:"text",file:"code",user:user).save(flush:true)
        assert 2 == Snippet.count()
        def snippets = Snippet.findAllByUser(user)
        assert 2 == snippets.size()
        snippets[0].parseTags('snippet test',' ')
        snippets[1].parseTags('text test',' ')
        UserTag.create user, Tag.findByName("snippet"), true
        UserTag.create user, Tag.findByName("test"), true
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test get"() {
        assert 2 == UserTag.count()
        assert UserTag.get(User.findByUsername('username').id,'test') instanceof UserTag
    }

    void "test remove"() {
        assert 2 == UserTag.count()
        UserTag.remove User.findByUsername('username'),Tag.findByName('test'),true
        assert 1 == UserTag.count()
        assertFalse UserTag.remove(User.findByUsername('username'),Tag.findByName('test'),true)
    }

    void "test removeall"() {
        assert 2 == UserTag.count()
        UserTag.removeAll User.findByUsername('username')
        assert 0 == UserTag.count()
    }
}
