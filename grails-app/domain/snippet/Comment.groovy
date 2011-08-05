package snippet

class Comment implements Comparable{

    static belongsTo = [author:User,snippet:Snippet]

    static constraints = {
        comment blank:false, widget:'textarea'
        author display:false
        snippet display:false
        lastUpdated()
        dateCreate()
    }

    static mapping = {
        comment type:'text'
    }

    String comment
    Date dateCreated
    Date lastUpdated

    int compareTo(obj) {
        lastUpdated.compareTo(obj.lastUpdated)
    }

    String toString() {
        "${comment} by ${author.username} ${lastUpdated}"
    }
}
