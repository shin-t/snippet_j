package snippet

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
    	params.max = Math.min(params.max ? params.int('max') : 10, 100)
    	[snippetInstanceList: Snippet.list(params), snippetInstanceTotal: Snippet.count()]
    }

    def create = {
        def snippetInstance = new Snippet()
        snippetInstance.properties = params
        return [snippetInstance: snippetInstance]
    }

    def save = {
        def snippetInstance = new Snippet(params)
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
            [snippetInstance: snippetInstance]
        }
    }

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

    def update = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance) {
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

    def delete = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance) {
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
    	//render Snippet.search(params.q, params)
    	def searchResults = Snippet.search(params.q, params)
    	flash.message = "${searchResults.total} results foundo for search: ${params.q}"
    	flash.q = params.q
    	[searchResults:searchResults.results, resultCount:searchResults.total]
    }
}
