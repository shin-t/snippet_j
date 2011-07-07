package snippet

class SnippetController {

	def scaffold = Snippet
	// def command = """git ..."""
	// def proc = 
    
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

    def search = {
    	//render Snippet.search(params.q, params)
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
}
