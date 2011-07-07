package snippet

class SnippetController {

	def scaffold = Snippet
	// def command = """git ..."""
	// def proc = 

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
