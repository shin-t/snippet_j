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

    List forkParent() {
        SnippetFork.executeQuery('from snippet.SnippetFork as sf where sf.child.id = ?',[this.id])
    }

	static searchable = true
    static belongsTo = [author:User]
	static hasMany = [children:Patch, comments:Comment, fork:SnippetFork]
    static mappedBy = [children:"original", fork:"parent"]

    static constraints = {
    	name(blank:false)
    	snippet(blank:false)
    }

    static mapping = {
        snippet type:'text'
    }
}

