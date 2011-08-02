package snippet

import org.grails.taggable.*

class Snippet implements Taggable {

    String description
    String snippet
    Date dateCreated
    Date lastUpdated
    SortedSet comments

    static belongsTo = [author:User]
    static hasMany = [comments:Comment,stars:Star]
    
    static constraints = {
        description blank:false
        snippet blank:false, widget:'textarea'
        author display:false
        comments display:false
        lastUpdated()
        dateCreated()
    }
    static mapping = {
        snippet type:'text'
        sort lastUpdated:"desc"
    }
}

