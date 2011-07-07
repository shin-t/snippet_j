package snippet

class Snippet {
	static searchable = true
	String description
	String name
	String language
	String snippet

	static hasMany = [comments:Comment]
	
    static belongsTo = [author:User]

	List comments() {
		return comments.collect{it.comment}
	}

    static constraints = {
    	description(blank:false)
    	name(blank:false)
    	language(blank:false)
    	snippet(blank:false)
    }
}
