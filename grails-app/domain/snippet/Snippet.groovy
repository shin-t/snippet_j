package snippet

import org.grails.taggable.*

class Snippet implements Taggable, Comparable {

    static belongsTo = [author: User]
    static hasMany = [comments: Comment, stars: Star, votes: Vote]
    
    static constraints = {
        name blank:false
        snippet blank:false, widget:'textarea'
        author display:false
        comments display:false
    }

    static mapping = {
        snippet type:'text'
        sort lastUpdated:'desc'
    }

    String name
    String snippet
    Date dateCreated
    Date lastUpdated
    SortedSet comments

    int compareTo(obj) {
        lastUpdated.compareTo(obj.lastUpdated)
    }
    
    String toString() {
        "${name} by ${author.username}, ${lastUpdated}"
    }

}

