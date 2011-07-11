package snippet

class Comment {

	static belongsTo = [snippet:Snippet, author:User]

	String comment
	
	Date dateCreated
	Date lastUpdated
	
	static constraints = {
		comment(blank:false)
	    dateCreated()
	    lastUpdated()
	}
}
