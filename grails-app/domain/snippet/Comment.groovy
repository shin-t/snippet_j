package snippet

class Comment {

	static belongsTo = [snippet:Snippet]

	User author
	
	Date date
	String comment
	
	static constraints = {
		date(blank:false)
		comment(blank:false)
	}
}
