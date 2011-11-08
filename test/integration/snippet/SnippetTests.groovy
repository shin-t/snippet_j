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
        def user = new User(username:"username",password:"password",email:"MyEmailAddress@example.com ")
        user.password2 = user.password
        user.email2 = user.email
        user.gravatar_hash = user.email.trim().toLowerCase().encodeAsMD5()
        user.addToSnippet(new Snippet(text:"snippet1 name",file:"snippet1")).save()
        assert User.findByUsername("username")
        println user.dump()
        def snippet = new Snippet(text:"snippet2 name",file:"snippet2",user:user)
        snippet.save()
        user.addToSnippet(snippet).save()
        println user.dump()
        println User.get(user.id).dump()
        println user.snippet.each{println it; println it.lastUpdated}
        snippet.text="snippet..."
        snippet.save()
        assert 2 == user.snippet.size()
        println user.snippet.each{println it; println it.lastUpdated}
    }
}
