package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    static oauthService

    def scaffold = true
    def springSecurityService
    def searchableService
    def diffService

    def gistsAPI = {
        def http = new HTTPBuilder("https://api.github.com")
        def res
        println "="*80
        println session

        def headers = [:]
        if(loggedIn){
            def user = springSecurityService.getCurrentUser()
            def token = Github.executeQuery("from snippet.Github as gh where gh.user = ?",user)
            println token
            headers = ["Authorization":"token ${token[0].access_token}"]
        }
        println headers

        try {
             res = http.get(path: '/gists',
                headers: headers,
                requestContentType: JSON) {resp, json ->
                    println "response"
                    println resp.dump()
                    println resp.statusLine
                    println resp.contentType
                    println resp.success
                    println "--"
                    return json
                }
        }
        catch(Exception e) {
            println e
        }
        render(contentType:"application/json", text:res)
    }

    def getJson = {
        if(params.q){render searchableService.search(params.q, escape: true).results as JSON}else{render Snippet.list(params) as JSON}
    }

    def search = {
        if(params.q){redirect(action: "list", params: params)}else{redirect(action: "list")}
    }
    
    def fork = {
        def parent = Snippet.get(params.id)
        if(parent&&(parent.author!=springSecurityService.getCurrentUser())){
            println parent.dump()

            def child = new Snippet()
            child.name = parent.name
            child.author = springSecurityService.getCurrentUser()
            child.snippet = parent.snippet
            child.save(flush:true)
            println child.dump()

            def snippetFork = new SnippetFork(child:child, parent:parent).save(flush:true)
            println snippetFork.dump()

            redirect(action: "show", id: child.id)
        }
        else{
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(params.q){
            def searchResult = searchableService.search(params.q, escape: true)
            flash.q = params.q
            flash.message = "${params.q}"
            [snippetInstanceList: searchResult.results, snippetInstanceTotal: searchResult.total]
        }
        else{
            def snippetList = Snippet.executeQuery('from snippet.Snippet as s where s.children is empty')
            [snippetInstanceList: snippetList, snippetInstanceTotal: snippetList.size()]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def create = {
        def snippetInstance = new Snippet()
        snippetInstance.properties = params
        return [snippetInstance: snippetInstance]
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def save = {
        def snippetInstance = new Snippet(params)
        snippetInstance.author=springSecurityService.getCurrentUser()
        if (snippetInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            redirect(action: "show", id: snippetInstance.id)
        }
        else {
            render(view: "create", model: [snippetInstance: snippetInstance])
        }
    }

    def show = {
        def snippetInstance = Snippet.get(params.id)

        if (!snippetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
        else {

            println "--"
            SnippetFork.list().each{println it.dump()}
            println snippetInstance.forkParent()

            [snippetInstance: snippetInstance,currentUser: springSecurityService.getCurrentUser(), patch: params.patch]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def edit = {
        def snippetInstance = Snippet.get(params.id)
        if (!snippetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
        else {
            [snippetInstance: snippetInstance]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def update = {

        def originalInstance = Snippet.get(params.id)

        if (originalInstance&&(originalInstance.author==springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (originalInstance.version > version) {
                    originalInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'snippet.label', default: 'Snippet')] as Object[], "Another user has updated this Snippet while you were editing")
                    render(view: "edit", model: [snippetInstance: snippetInstance])
                    return
                }
            }
            
            def snippetInstance = new Snippet()
            snippetInstance.name = originalInstance.name
            snippetInstance.author = springSecurityService.getCurrentUser()
            snippetInstance.snippet = params.snippet
            snippetInstance.save(flush:true)
            
            def patchInstance = new Patch(patch:diffService.getDiffString(originalInstance.snippet.readLines(), snippetInstance.snippet.readLines()))
            patchInstance.original = originalInstance
            patchInstance.snippet = snippetInstance
            patchInstance.save()

            if (!snippetInstance.hasErrors() && snippetInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
                redirect(action: "show", id: snippetInstance.id)
            }
            else {
                render(view: "edit", model: [snippetInstance: snippetInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def delete = {

        def snippetInstance = Snippet.get(params.id)

        if (snippetInstance&&(springSecurityService.getCurrentUser()==snippetInstance.author)) {
            try {
                snippetInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else{
            flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "show", id: params.id)
        }
    }
}
