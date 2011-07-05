package snippet

class SnippetController {

    def index = {
    	if(request.getMethod()=='POST'){
    		["snippets" : Snippet.findAll("from Snippet as s where s.snippet like :search", [search:"%"+params.keyword+"%"])]
    	}else{
	    	["snippets" : Snippet.list()]
	    }
    }
    def add = {
    	if(request.getMethod()=='POST'){
    		def snippet=new Snippet(params)
    		if(snippet.save()){
    			redirect(action:index)
    		}else{
    			snippet.erors.allErrors.each{
    				println it.getField()
    			}
    		}
    	}
    }
}
