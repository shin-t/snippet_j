package snippet

import org.grails.taggable.*
import auth.*

class Snippet implements Taggable {

    static belongsTo = [user: User]
    static mappedBy = [children:'parent']
    static hasMany = [children: Snippet]
    static constraints = {
        user display:false
        text blank:false, widget:'textarea'
        file nullable:true, blank:false, widget:'textarea'
        status display:false
        help ()
        deadline nullable:true
        dateCreated ()
        lastUpdated ()
        root nullable:true, display:false
        parent nullable:true, display:false
        children display:false
    }

    Snippet root
    Snippet parent
    String text
    String file
    Integer status = 0
    Boolean help = true
    Date deadline
    Date dateCreated
    Date lastUpdated

    static boolean remove(long id){
        def snippetInstance = Snippet.get(id)
        if(snippetInstance){
            Snippet.executeUpdate("update Snippet s set s.root = null where s.parent = ?",[snippetInstance])
            Snippet.executeUpdate("update Snippet s set s.parent = null where s.parent = ?",[snippetInstance])
            Snippet.executeUpdate("update Snippet s set s.root = s.parent where s.root= ?",[snippetInstance])
        }
    }
}
