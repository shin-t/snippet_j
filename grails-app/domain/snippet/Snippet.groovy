package snippet

import org.grails.taggable.*

class Snippet implements Taggable {

    String gist_id
    String html_url
    Date dateCreated
    Date lastUpdated

    static searchable = true
    static belongsTo = [author:User]
    static constraints = {
        gist_id(blank:false)
        html_url(url:true)
    }
}

