package snippet

class Snippet implements Comparable {

    static belongsTo = [author: User]
    static hasMany = [comments: Comment, tags: SnippetTags, stars: Star]
    
    static constraints = {
        description blank:false
        snippet blank:false, widget:'textarea'
        author display:false
        comments display:false
    }

    static mapping = {
        snippet type:'text'
        sort lastUpdated:'desc'
    }

    String description
    String snippet
    Date dateCreated
    Date lastUpdated
    SortedSet comments

    int compareTo(obj) {
        lastUpdated.compareTo(obj.lastUpdated)
    }
    
    String toString() {
        "${description} by ${author.username}, ${lastUpdated}"
    }

    def springSecurityService
    def tags() {
        def tags = []
        def user = springSecurityService.getCurrentUser()
        if(user){
            def r = SnippetTags.get(user.id,this.id)
            if(r)tags = r.tags
        }
        return tags
    }
}

