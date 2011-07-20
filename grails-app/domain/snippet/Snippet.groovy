package snippet

class Snippet {

	static searchable = true
    static belongsTo = [author:User]
	static hasMany = [children:Patch, comments:Comment]
    static mappedBy = [children:"original"]

	String name
	String snippet

    List getHistory() {
        def list = []
        def i = this
        while(i){
            list.push(i)
            i = Patch.findBySnippet(i)?.original
        }
        return list
    }

    Patch patch() {
        Patch.findBySnippet(this)
    }

    static constraints = {
    	name(blank:false)
    	snippet(blank:false)
    }

    static mapping = {
        snippet type:'text'
    }
}

