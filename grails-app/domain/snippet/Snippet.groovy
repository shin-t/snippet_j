package snippet
import auth.*
import org.grails.taggable.*

class Snippet implements Taggable {

    static belongsTo = [user:User]
    static hasMany = [comments: Comment, stars: Star, votes: Vote]
    
    static constraints = {
        title blank:false
    }

    String title
    Date dateCreated
    Date lastUpdated

    Comment comment

    String toString() {
        title
    }
}
