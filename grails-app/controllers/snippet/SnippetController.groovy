package snippet

import grails.plugins.springsecurity.Secured

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def scaffold = true
    def springSecurityService
    def searchableService
    def diffService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = params.sort?:'lastUpdated'
        params.order = params.order?:'desc'
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
            return [snippetInstance: snippetInstance]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def update = {
        def originalInstance = Snippet.get(params.id)
        def snippetInstance = new Snippet()
        snippetInstance.name = originalInstance.name
        snippetInstance.author = springSecurityService.getCurrentUser()
        snippetInstance.snippet = params.snippet
        if (originalInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (originalInstance.version > version) {
                    originalInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'snippet.label', default: 'Snippet')] as Object[], "Another user has updated this Snippet while you were editing")
                    render(view: "edit", model: [snippetInstance: snippetInstance])
                    return
                }
            }
            snippetInstance.save(flush:true)
            snippetInstance.patch = new Patch()
            snippetInstance.patch.original = originalInstance
            snippetInstance.patch.snippet = snippetInstance
            snippetInstance.patch.patch = diffService.getDiffString(originalInstance.snippet.readLines(), snippetInstance.snippet.readLines())
            snippetInstance.patch.save(flush:true)
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
        if(params.q){redirect(action: "list", params: params)}else{redirect(action: "list")}
    } 
}
