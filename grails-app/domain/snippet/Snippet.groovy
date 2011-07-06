package snippet

class Snippet {
	static searchable = true
	String name
	String language
	String comment
	String snippet
    static constraints = {
    	name(blank:false)
    	language(blank:false)
    	comment()
    	snippet(blank:false)
    }
}
