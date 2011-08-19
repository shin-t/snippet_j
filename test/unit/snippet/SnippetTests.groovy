package snippet

import grails.test.*

class SnippetTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
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

        snippet.snippet = null
        assertFalse snippet.validate(["snippet"])

        snippet.snippet = ''
        assertFalse snippet.validate(["snippet"])

        snippet.snippet = "test\nsnippet"
        assertTrue snippet.validate(["snippet"])

        assertFalse snippet.validate()
    }
}
