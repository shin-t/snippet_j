package snippet

class Snippet {

	static searchable = true

    static belongsTo = [author:User]

	static hasMany = [comments:Comment]

	String description
	String name
	String snippet
	
	Date dateCreated
	Date lastUpdated

	List comments() {
		return comments.collect{it.comment}
	}

    static constraints = {
    	description(blank:false)
    	name(blank:false)
    	snippet(blank:false)
	    dateCreated()
	    lastUpdated()
    }

    static mapping = {
        snippet type:'text'
    }
}
