package snippet

class Comment implements Comparable{

    static belongsTo = [author:User,snippet:Snippet]

    static constraints = {
        comment blank:false, widget:'textarea'
        author display:false
        snippet display:false
    }

    static mapping = {
        comment type:'text'
    }

    String comment
    Date dateCreated
    Date lastUpdated

    int compareTo(obj) {
        dateCreated.compareTo(obj.dateCreated)
    }

    String toString() {
        "snippet: ${snippet.description},user: ${author.username},date: ${dateCreated}"
    }
}
