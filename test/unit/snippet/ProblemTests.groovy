package snippet

import grails.test.*
import auth.*

class ProblemTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test validate"() {
        mockForConstraintsTests(Problem)
        Problem problem = new Problem()
        assertFalse problem.validate()

        assertFalse problem.validate(["text"])
        problem.text = null
        assertFalse problem.validate(["text"])
        problem.text = ""
        assertFalse problem.validate(["text"])
        problem.text = "text"
        assertTrue problem.validate(["text"])

        assertTrue problem.validate(["file"])
        problem.file = null
        assertTrue problem.validate(["file"])
        problem.file = ""
        assertFalse problem.validate(["file"])
        problem.file = "file"
        assertTrue problem.validate(["file"])

        assertFalse problem.validate(["user"])
        problem.user = null
        assertFalse problem.validate(["user"])

        User user = new User(username:"user",password:"password")
        mockDomain(User,[user])
        assertEquals 1, User.count()

        problem.user = user
        assertTrue problem.validate(["user"])

        assertTrue problem.validate(["deadline"])
        problem.deadline = null
        assertTrue problem.validate(["deadline"])
        problem.deadline = new Date()
        assertTrue problem.validate(["deadline"])

        assertTrue problem.validate()
    }
}
