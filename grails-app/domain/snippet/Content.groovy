package snippet

import org.grails.taggable.*
import auth.*

class Content implements Taggable {

    static belongsTo = [user: User]
    static hasMany = [children: Snippet]
    static constraints = {
    }

    String text
    String file
    Date dateCreated
    Date lastUpdated
}
