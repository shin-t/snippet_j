package snippet

class Snippet {

	String name
	String snippet

    Date dateCreated
    Date lastUpdated

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

	static searchable = true
    static belongsTo = [author:User]
	static hasMany = [children:Patch, comments:Comment]
    static mappedBy = [children:"original"]

    static constraints = {
    	name(blank:false)
    	snippet(blank:false)
    }

    static mapping = {
        snippet type:'text'
    }
}

