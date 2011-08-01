package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def scaffold = true
    def springSecurityService
    def githubService

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

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def snippetInstanceList
        def snippetInstanceTotal

        params.max = Math.min(params.max ? params.int('max') : 10, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'
        flash.id = params.id
        log.debug params

        if(params.q?.trim()){
            def result = Snippet.findAllByTag(params.q)
            log.debug "result:\n${result}"
            snippetInstanceList = result
            snippetInstanceTotal = result.size()
            log.debug "search results:\n${snippetInstanceList}"
            flash.q = params.q
            flash.message = "${params.q}"
        }
        else if(params.user){
            def query = 'from snippet.Snippet as s where s.author.username = ?'
            snippetInstanceList = Snippet.executeQuery(query,[params.user],params)
            snippetInstanceTotal = Snippet.executeQuery(query,[params.user]).size()
        }
        else{
            snippetInstanceList = Snippet.list(params)
            snippetInstanceTotal = Snippet.count()
        }

        log.debug request.getHeader("accept")
        log.debug request.format
        log.debug snippetInstanceList
        log.debug snippetInstanceTotal
        withFormat {
            html {
                [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, currentUser: springSecurityService.getCurrentUser()]
            }
            json {
                def meta = params
                meta.total = snippetInstanceTotal
                log.debug (snippetInstanceList as JSON).toString()
                log.debug (params as JSON).toString()
                render snippetInstanceList as JSON
            }
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def create = {
        def snippetInstance = new Snippet()
        def currentUser = springSecurityService.getCurrentUser()
        log.debug params
        snippetInstance.properties = params
        log.debug snippetInstance.dump()
        log.debug currentUser.dump()
        [snippetInstance: snippetInstance, currentUser: currentUser]
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def save = {
        def snippetInstance = new Snippet()

        log.debug params
        log.debug "snippet: ${snippetInstance}"
        def json = []
        if(params.filename){
            def body = '{"description":"'+params.description.encodeAsJavaScript()+
                '","public":'+params.public.encodeAsJavaScript()+
                ',"files":{"'+params.filename.encodeAsJavaScript()+
                '":{"content":"'+params.content.encodeAsJavaScript()+
                '"}}}'
            json = githubService.api(path: "/gists", method: POST, body: body)
            log.debug json
        }
        else if(params.gist_id){
            def results = Snippet.executeQuery(
                    'from snippet.Snippet as s where s.author = :author and s.gist_id = :gist_id',
                    [author: springSecurityService.getCurrentUser(), gist_id: params.gist_id])
            if(results){
                redirect(action: "edit", id: results[0].id)
            }
            json = githubService.api(path: "/gists/${params.gist_id}", method:GET)
            log.debug "json : ${json}"
            String txt = json
            log.debug "text : ${txt}"
            log.debug "text : ${JSON.parse(txt)}"
        }
        else{
            log.debug snippetInstance.errors
            flash.errors = "${snippetInstance.errors}"
            log.debug snippetInstance.dump()
            return render(view: "create", model: [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()])
        }
        if(!json){
            flash.message = "Not Found : /gists/${params.gist_id}"
            render(view: "create", model: [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()])
        }
        else{
            snippetInstance.author = springSecurityService.getCurrentUser()
            snippetInstance.gist_id = json.id
            snippetInstance.html_url = json.html_url
            snippetInstance.setTags()
            if(snippetInstance.save(flush: true)){
                log.debug snippetInstance.dump()
                snippetInstance.parseTags(params.tags)
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
                redirect(action: "show", id: snippetInstance.id)
            }
            else {
                render(view: "create", model: [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()])
            }
        }
    }

    def show = {
        def snippetInstance = Snippet.get(params.id)

        if (!snippetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
        else {
            [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def edit = {
        def snippetInstance = Snippet.get(params.id)

        if (snippetInstance&&(springSecurityService.getCurrentUser()==snippetInstance.author)) {
            [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
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
            if (!snippetInstance.hasErrors() && snippetInstance.save(flush: true)) {
                log.debug params.tags
                snippetInstance.setTags()
                snippetInstance.parseTags(params.tags)
                log.debug snippetInstance.tags
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
