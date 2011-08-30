package snippet

import grails.test.*

class SnippetTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test to string"() {
        mockDomain(User,[new User(username:"user",password:"password")])
        mockDomain(Snippet,[new Snippet(name:"snippet",snippet:"snippet",author:User.get(1))])
        assertTrue Snippet.get(1).toString() instanceof String
    }
    void testValidation() {
        mockForConstraintsTests(Snippet)

        def snippet = new Snippet()

        snippet.name = null
        assertFalse snippet.validate(["name"])

        snippet.name = ''
        assertFalse snippet.validate(["name"])

        snippet.name = "snippet"
        assertTrue snippet.validate(["name"])

        snippet.description = null
        assertTrue snippet.validate(["description"])

        snippet.description = ''
        assertTrue snippet.validate(["description"])

        snippet.description = "snippet"
        assertTrue snippet.validate(["description"])

        snippet.snippet = null
        assertFalse snippet.validate(["snippet"])

        snippet.snippet = ''
        assertFalse snippet.validate(["snippet"])

        snippet.snippet = "snippet"
        assertTrue snippet.validate(["snippet"])

        assertFalse snippet.validate()
    }
}
