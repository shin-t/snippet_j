package snippet

import auth.*

import grails.test.*

class StarTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()

        mockDomain(User,[new User(username:"user",password:"password")])
        mockDomain(Snippet,[new Snippet(text:"snippet",file:"snippet...",user:User.get(1))])
        mockDomain(Star,[new Star(user:User.get(1),snippet:Snippet.get(1))])
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test create"() {
        assert Star.create(User.get(1),Snippet.get(1)).instanceOf(Star)
    }

    void "test remove"() {
        assert 1 == Star.count()
        Star.remove(User.get(1),Snippet.get(1))
        assert 0 == Star.count()
        assertFalse Star.remove(User.get(1),Snippet.get(1))
    }

}
