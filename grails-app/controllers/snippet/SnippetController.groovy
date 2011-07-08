package snippet

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def scaffold = Snippet

    def beforeInterceptor = [action:this.&auth, except:["index", "list", "show"]]
    
    def auth() {
        if(!session.user){
            redirect(controller:"user", action:"login")
            return false
        }
    }

    def search = {
    	if (params.q){
	    	def searchResults = Snippet.search(params.q, params)
	    	flash.message = "${searchResults.total} results foundo for search: ${params.q}"
	    	flash.q = params.q
	    	[searchResults:searchResults.results, resultCount:searchResults.total]
	    }
	    else {
	    	redirect(action: "list")
	    }
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def create = {
        def snippetInstance = new Snippet()

        snippetInstance.properties = params
        return [snippetInstance: snippetInstance]
    }

    def save = {
        def snippetInstance = new Snippet(params)

        snippetInstance.author = session.user

        if(session.user.role=="author"&&!(session.user.login==snippetInstance.author.login)){
        	redirect(action:list)
        	return
        }
        
        snippetInstance.author = session.user

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

    def edit ={
        def snippetInstance = Snippet.get(params.id)
        
        if(session.user.role=="author"&&!(session.user.login==snippetInstance.author.login)){
        	redirect(action:list)
        	return
        }
        
        if(!snippetInstance){
            redirect(action:list)
        }
        else{
            return[snippetInstance:snippetInstance]
        }
    }

    def list ={
        if(!params.max) params.max = 10
        flash.id = params.id
        if(!params.id) params.id = "No User"
        
        def snippetList
        def snippetTotal
        def author = User.findByLogin(params.id)
        if(author){
            def query = { eq('author', author) }
            snippetList = Snippet.createCriteria().list(params, query)
            snippetTotal = Snippet.createCriteria().count(query)
        }
        else{
            snippetList = Snippet.list(params)
            snippetTotal = Snippet.count()
        }

        [snippetInstanceList:snippetList, snippetInstanceTotal:snippetTotal]
    }

    def update = {
        def snippetInstance = Snippet.get(params.id)        
        
        if(session.user.role=="author"&&!(session.user.login==params.author.login)){
        	redirect(action:"list")
        	return
        }

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
        
        if(session.user.role=="author"&&!(session.user.login==snippetInstance.author.login)){
        	redirect(action:list)
        	return
        }
        
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
    
}
