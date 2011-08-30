package snippet

import grails.test.*

class CommentTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        def user = new User(username:"username",password:"password")
        def snippet = new Snippet(name:"snippet name",snippet:"snippet...")
        user.addToSnippets(snippet).save()
        println user.dump()
        println snippet.dump()
        def comment = new Comment(comment:"comment",author:user,snippet:snippet)
        comment.save()
        snippet.addToComments(comment)
        println snippet.dump()
        def comment2 = new Comment(comment:"comment",author:user,snippet:snippet)
        comment2.save()
        snippet.addToComments(comment2)
        println snippet.dump()
        println snippet.comments
        assert 2 == snippet.comments.size()
    }
}
