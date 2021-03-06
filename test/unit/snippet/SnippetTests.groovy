package snippet

import auth.*
import grails.test.*

class SnippetTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test problem"(){
        mockDomain(User,[new User(username:"user",password:"password")])
        mockDomain(Snippet,[new Snippet(text:"comment",user:User.get(1))])

        assertEquals 1, User.count()
        assertEquals 1, Snippet.count()
    }

    void "test comment"(){
        mockDomain(User,[new User(username:"user",password:"password")])
        mockDomain(Snippet,[new Snippet(text:"comment",user:User.get(1))])

        assertEquals 1, User.count()
        assertEquals 1, Snippet.count()

        def comment = new Snippet(text:"comment",user:User.get(1),parent:Snippet.get(1))

        assertTrue comment.save() instanceof Snippet
        assertEquals 2, Snippet.count()
        assertEquals Snippet.get(1).id, comment.parent.id
    }

    void "test validate"() {
        mockForConstraintsTests(Snippet)
        Snippet snippet = new Snippet()
        assertFalse snippet.validate()

        assertFalse snippet.validate(["text"])
        snippet.text = null
        assertFalse snippet.validate(["text"])
        snippet.text = ""
        assertFalse snippet.validate(["text"])
        snippet.text = "text"
        assertTrue snippet.validate(["text"])

        assertTrue snippet.validate(["file"])
        snippet.file = null
        assertTrue snippet.validate(["file"])
        snippet.file = ""
        assertFalse snippet.validate(["file"])
        snippet.file = "file"
        assertTrue snippet.validate(["file"])

        assertFalse snippet.validate(["user"])
        snippet.user = null
        assertFalse snippet.validate(["user"])

        User user = new User(username:"user",password:"password")
        mockDomain(User,[user])
        assertEquals 1, User.count()

        snippet.user = user
        assertTrue snippet.validate(["user"])

        assertTrue snippet.validate()
    }
}
