package snippet

class Snippet {
	String name
	String language
	String comment
	String snippet
    static constraints = {
    	name(blank:false)
    	snippet(blank:false)
    }
}
