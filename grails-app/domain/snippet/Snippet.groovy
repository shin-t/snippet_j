package snippet

class Snippet {

	static searchable = true
    static belongsTo = [author:User]
	static hasMany = [children: Patch, comments:Comment]

	String name
	String snippet

	Date dateCreated
	Date lastUpdated

    Patch patch

    List getHistory() {
        def list = []
        def i = this
        while(i){
            list.push(i)
            i = i.patch?.original
        }
        return list
    }

    static constraints = {
    	name(blank:false)
    	snippet(blank:false)
        patch(nullable:true)
	    dateCreated()
	    lastUpdated()
    }

    static mapping = {
        snippet type:'text'
    }
}
