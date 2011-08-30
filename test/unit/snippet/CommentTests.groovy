package snippet

import grails.test.*

class CommentTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test to string"(){
        mockDomain(User,[new User(username:"user",password:"password")])
        mockDomain(Snippet,[new Snippet(name:"snippet",snippet:"snippet",author:User.get(1))])
        mockDomain(Comment,[new Comment(comment:"comment",snippet:Snippet.get(1),author:User.get(1))])
        assertTrue Comment.get(1).toString() instanceof String
    }

    void testValidation() {
        mockForConstraintsTests(Comment)

        def comment = new Comment()

        comment.comment = null
        assertFalse comment.validate(["comment"])

        comment.comment = ''
        assertFalse comment.validate(["comment"])

        comment.comment = "comment"
        assertTrue comment.validate(["comment"])

        assertFalse comment.validate()
    }
}
