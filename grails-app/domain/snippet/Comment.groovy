package snippet
import auth.*

class Comment {

    static belongsTo = [user:User,snippet:Snippet]
    static hasMany =[votes: Vote]

    static constraints = {
        text blank:false, widget:'textarea'
    }

    static mapping = {
        text type:'text'
    }

    String text
    Date dateCreated
    Date lastUpdated

    String toString() {
        text
    }
}
