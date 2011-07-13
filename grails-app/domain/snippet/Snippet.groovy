package snippet

class Snippet {

	static searchable = true

    static belongsTo = [author:User]

	static hasMany = [subsnippets:SubSnippet, comments:Comment]

	String name
	String snippet
	
	Date dateCreated
	Date lastUpdated

	List comments() {
		return comments.collect{it.comment}
	}

    List subsnippets() {
        return subsnippets.collect{it.subsnippet}
    }

    static constraints = {
    	name(blank:false)
    	snippet(blank:false)
	    dateCreated()
	    lastUpdated()
    }

    static mapping = {
        snippet type:'text'
    }
}
