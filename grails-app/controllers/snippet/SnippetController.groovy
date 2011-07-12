package snippet

import grails.plugins.springsecurity.Secured

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService

    def searchableService

    def diffService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [snippetInstanceList: Snippet.list(params), snippetInstanceTotal: Snippet.count()]
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
        println "getCurrentUser(): ${springSecurityService.getCurrentUser()}"
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
            [snippetInstance: snippetInstance,currentUser: springSecurityService.getCurrentUser()]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def edit = {
        def snippetInstance = Snippet.get(params.id)
        if (!snippetInstance||(springSecurityService.getCurrentUser()!=snippetInstance.author)) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [snippetInstance: snippetInstance]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def update = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(springSecurityService.getCurrentUser()==snippetInstance.author)) {
            if (params.version) {
                def version = params.version.toLong()
                println params.version
                println snippetInstance.version
                if (snippetInstance.version > version) {
                    
                    snippetInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'snippet.label', default: 'Snippet')] as Object[], "Another user has updated this Snippet while you were editing")
                    render(view: "edit", model: [snippetInstance: snippetInstance])
                    return
                }
            }
            //
            def subsnippetInstance = new SubSnippet()
            subsnippetInstance.snippet = Snippet.get(params.id)
            subsnippetInstance.subsnippet = Snippet.get(params.id).snippet
            def orig_sn=subsnippetInstance.subsnippet.readLines()
            def new_sn=params.snippet.readLines()
            println "orig_sn:\n${orig_sn}"
            println "new_sn:\n${new_sn}"
            subsnippetInstance.patch = diffService.getDiffString(orig_sn,new_sn)
            println "--\n${subsnippetInstance.patch}\n--"
            subsnippetInstance.save(flush:true)
            //
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
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }

    def search = {
        if(params.q){
            def searchResult = searchableService.search(params.q)
            flash.q = params.q
            flash.message = "${params.q}"
            [snippetInstanceList: searchResult.results, snippetInstanceTotal: searchResult.total]
        }
        else{
            redirect(action: "list")
        }
    } 
}
