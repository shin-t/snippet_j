package snippet

class Snippet {
	static searchable = true
	String name
	String language
	String snippet

	static hasMany = [comments:Comment]
	
	List comments() {
		return comments.collect{it.comment}
	}

    static constraints = {
    	name(blank:false)
    	language(blank:false)
    	snippet(blank:false)
    }
}
