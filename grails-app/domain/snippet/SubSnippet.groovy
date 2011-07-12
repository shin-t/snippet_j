package snippet

class SubSnippet {

    static belongsTo = [snippet:Snippet]
    
	Date dateCreated
	Date lastUpdated

    String subsnippet
    String patch

    static constraints = {
        subsnippet(blank:false)
        patch(blank:false)
    }

    static mapping = {
        subsnippet type:'text'
    }
}
