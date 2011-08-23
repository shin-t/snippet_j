package snippet

import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*

import javax.servlet.http.Cookie

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import grails.test.*

class SnippetTests extends GroovyTestCase {

    def springSecurityService

    protected void setUp() {
        super.setUp() 
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        def ctrl = new SnippetController()
        println ctrl
    }
}
