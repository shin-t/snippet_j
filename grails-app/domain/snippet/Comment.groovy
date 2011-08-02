package snippet

class Comment implements Comparable{

    String comment
    Date dateCreated
    Date lastUpdated

    static belongsTo = [author:User,snippet:Snippet]

    static constraints = {
        comment blank:false, widget:'textarea'
        author display:false
        snippet display:false
    }
    static mapping = {
        comment type:'text'
    }

    int compareTo(obj) {
        lastUpdated.compareTo(obj.lastUpdated)
    }
}
