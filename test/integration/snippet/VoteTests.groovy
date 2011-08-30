package snippet

import grails.test.*

class VoteTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()

        def user = new User(username:"user",password:"password")
        assert user.save() instanceof User

        def snippet1 = new Snippet(name:"snippet1",snippet:"snippet...",author:user)
        assert snippet1.save() instanceof Snippet

        def snippet2 = new Snippet(name:"snippet2",snippet:"snippet...",author:user)
        assert snippet2.save() instanceof Snippet
        
        assert new Vote(user:user,snippet:snippet1).save() instanceof Vote
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test get"() {
        assert Vote.get(User.findByUsername("user").id,Snippet.findByName("snippet1").id).instanceOf(Vote)
    }

    void "test up vote"() {
        3.times{assert Vote.up_vote(User.findByUsername("user").id,Snippet.findByName("snippet2").id).instanceOf(Vote)}
    }

    void "test down vote"() {
        3.times{assert Vote.down_vote(User.findByUsername("user").id,Snippet.findByName("snippet2").id).instanceOf(Vote)}
    }
}
