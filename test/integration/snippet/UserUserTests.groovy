package snippet

import grails.test.*
import auth.*

class UserUserTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
        assert 0 == User.count()

        def user1 = new User(username:"admin",password:"password",email:"abc@example.com")
        user1.password2 = user1.password
        user1.email2 = user1.email
        user1.gravatar_hash = user1.email.trim().toLowerCase().encodeAsMD5()
        user1.save()
        def user2 = new User(username:"user",password:"password",email:"abc.123@example.com")
        user2.password2 = user2.password
        user2.email2 = user2.email
        user2.gravatar_hash = user2.email.trim().toLowerCase().encodeAsMD5()
        user2.save()
        
        assert 2 == User.count()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "testGet"() {
        assert 0 == UserUser.count()
        assert null == UserUser.get(User.findByUsername("admin").id, User.findByUsername("user").id)
        UserUser.create User.findByUsername("admin"), User.findByUsername("user")
        assert 1 == UserUser.count()
        assert UserUser.get(User.findByUsername("admin").id, User.findByUsername("user").id) instanceof UserUser
    }

    void "testRemove"() {
        assert 0 == UserUser.count()
        assert null == UserUser.get(User.findByUsername("admin").id, User.findByUsername("user").id)
        UserUser.create User.findByUsername("admin"), User.findByUsername("user")
        assert 1 == UserUser.count()
        assert UserUser.get(User.findByUsername("admin").id, User.findByUsername("user").id) instanceof UserUser
        UserUser.remove User.findByUsername("admin"), User.findByUsername("user")
        assert 0 == UserUser.count()
        assertFalse UserUser.remove(User.findByUsername("admin"), User.findByUsername("user"))
        assert 0 == UserUser.count()
    }

    void "test Remove All"() {
        UserUser.create User.findByUsername("admin"), User.findByUsername("user")
        UserUser.create User.findByUsername("user"), User.findByUsername("admin")
        assert 2 == UserUser.count()
        UserUser.removeAll User.findByUsername("user")
        assert null == UserUser.get(User.findByUsername("admin").id, User.findByUsername("user").id)
        assert UserUser.get(User.findByUsername("user").id, User.findByUsername("admin").id) instanceof UserUser
        assert 1 == UserUser.count()
        UserUser.removeAll User.findByUsername("admin")
        assert 0 == UserUser.count()
    }
}
