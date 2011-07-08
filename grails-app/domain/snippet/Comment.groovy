package snippet

class Comment {

	static belongsTo = [snippet:Snippet]

	User author

	String comment
	
	Date dateCreated
	Date lastUpdated
	
	static constraints = {
		comment(blank:false)
	    dateCreated()
	    lastUpdated()
	}
}
