package snippet

import grails.test.*
import auth.*

class ContentTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test validate"() {
        mockForConstraintsTests(Content)
        Content content = new Content()
        assertFalse content.validate()

        assertFalse content.validate(["text"])
        content.text = null
        assertFalse content.validate(["text"])
        content.text = ""
        assertFalse content.validate(["text"])
        content.text = "text"
        assertTrue content.validate(["text"])

        assertTrue content.validate(["file"])
        content.file = null
        assertTrue content.validate(["file"])
        content.file = ""
        assertFalse content.validate(["file"])
        content.file = "file"
        assertTrue content.validate(["file"])

        assertFalse content.validate(["user"])
        content.user = null
        assertFalse content.validate(["user"])

        User user = new User(username:"user",password:"password")
        mockDomain(User,[user])
        assertEquals 1, User.count()

        content.user = user
        assertTrue content.validate(["user"])

        assertTrue content.validate()
    }
}
