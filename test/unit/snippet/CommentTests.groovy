package snippet

import grails.test.*

class CommentTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
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
