package snippet

import grails.test.*
import auth.*

class QuestionTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test validate"() {
        mockForConstraintsTests(Question)
        Question question = new Question()
        assertFalse question.validate()

        assertFalse question.validate(["text"])
        question.text = null
        assertFalse question.validate(["text"])
        question.text = ""
        assertFalse question.validate(["text"])
        question.text = "text"
        assertTrue question.validate(["text"])

        assertTrue question.validate(["file"])
        question.file = null
        assertTrue question.validate(["file"])
        question.file = ""
        assertFalse question.validate(["file"])
        question.file = "file"
        assertTrue question.validate(["file"])

        assertFalse question.validate(["user"])
        question.user = null
        assertFalse question.validate(["user"])

        User user = new User(username:"user",password:"password")
        mockDomain(User,[user])
        assertEquals 1, User.count()

        question.user = user
        assertTrue question.validate(["user"])

        assertTrue question.validate(["recepting"])
        assertEquals true, question.recepting
        question.recepting = false
        assertTrue question.validate(["recepting"])

        assertTrue question.validate()
    }
}
