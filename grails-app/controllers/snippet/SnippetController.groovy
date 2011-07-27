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

    def getRaw = {
        log.debug params

        def headers = [:]
        if(loggedIn){
            def user = springSecurityService.getCurrentUser()
            def token = Github.executeQuery("from snippet.Github as gh where gh.user = ?",user)
            log.debug token
            headers = ["Authorization":"token ${token[0].access_token}"]
            log.debug headers
        }

        def text = ""
        if(params.raw_url && (params.raw_url ==~ /https:\/\/gist\.github\.com\/raw\/.*/)){
            def http = new HTTPBuilder(params.raw_url)
            try {
                text = http.get(headers: headers) {r, t ->
                    r.headers.each{
                        log.debug "${it.name} : ${it.value}"
                    }
                    log.debug r
                    log.debug r.statusLine
                    log.debug r.contentType
                    log.debug r.success
                    return t.text
                }
            }
            catch(Exception e) {
                log.error e
            }
            log.debug text
        }
        render text
    }

    def gistsAPI = {
        log.debug params

        def config = grailsApplication.config.oauth.github
        def http = new HTTPBuilder(config.domain)
        def json = []

        if(loggedIn){
            def user = springSecurityService.getCurrentUser()
            def token = Github.executeQuery("from snippet.Github as gh where gh.user = ?",user)
            log.debug token
            def headers = ["Authorization":"token ${token[0].access_token}"]
            log.debug headers
            try {
                json = http.get(path: params.path, headers: headers, requestContentType: JSON) {r, j ->
                    r.headers.each{
                        log.debug "${it.name} : ${it.value}"
                    }
                    log.debug r
                    log.debug r.statusLine
                    log.debug r.contentType
                    log.debug r.success
                    return j
                }
            }
            catch(Exception e) {
                log.error e
            }
            log.debug json
            log.debug json[0]
            log.debug json[0].id
        }

        render(contentType: "application/json", text: json)
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
            [snippetInstanceList: Snippet.list(params), snippetInstanceTotal: Snippet.count()]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def create = {
        def snippetInstance = new Snippet()
        log.debug params
        snippetInstance.properties = params
        log.debug snippetInstance.dump()
        [snippetInstance: snippetInstance]
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def save = {
        def snippetInstance = new Snippet(params)
        snippetInstance.author=springSecurityService.getCurrentUser()
        log.debug snippetInstance
        if (snippetInstance.save(flush: true)) {
            log.debug snippetInstance
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
            [snippetInstance: snippetInstance,currentUser: springSecurityService.getCurrentUser()]
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
        def snippetInstance = Snippet.get(params.id)

        if (snippetInstance&&(snippetInstance.author==springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (snippetInstance.version > version) {
                    snippetInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'snippet.label', default: 'Snippet')] as Object[], "Another user has updated this Snippet while you were editing")
                    render(view: "edit", model: [snippetInstance: snippetInstance])
                    return
                }
            }
            snippetInstance.properties = params
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
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }
}
