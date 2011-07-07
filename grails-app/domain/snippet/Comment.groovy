package snippet

class Comment {
	String name
	Date date
	String comment

	Snippet snippet
	static belongsTo = Snippet
	static constraints = {
		name(blank:false)
		date(blank:false)
		comment(blank:false)
	}
}
