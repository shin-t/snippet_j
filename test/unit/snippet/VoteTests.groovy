package snippet

import grails.test.*

class VoteTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()

        mockDomain(User,[new User(username:"user",password:"password")])
        mockDomain(Snippet,[new Snippet(snippet:"snippet...",author:User.get(1))])
        mockDomain(Vote,[new Vote(user:User.get(1),snippet:Snippet.get(1))])
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test create"() {
        assert Vote.create(User.get(1),Snippet.get(1),0).instanceOf(Vote)
    }

    void "test remove"() {
        assert 1 == Vote.count()
        Vote.remove(User.get(1),Snippet.get(1))
        assert 0 == Vote.count()
        assertFalse Vote.remove(User.get(1),Snippet.get(1))
    }

}
