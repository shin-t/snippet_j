package snippet

import auth.*

import grails.test.*

class SnippetTests extends GroovyTestCase {

    protected void setUp() {
        super.setUp() 
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        def user = new User(username:"username",password:"password")
        user.addToSnippets(new Snippet(name:"snippet1 name",snippet:"snippet1")).save()
        println user.dump()
        def snippet = new Snippet(name:"snippet2 name",snippet:"snippet2",author:user)
        snippet.save()
        user.addToSnippets(snippet).save()
        println user.dump()
        println User.get(user.id).dump()
        println user.snippets.each{println it; println it.lastUpdated}
        snippet.snippet="snippet..."
        snippet.save()
        assert 2 == user.snippets.size()
        println user.snippets.each{println it; println it.lastUpdated}
    }
}
