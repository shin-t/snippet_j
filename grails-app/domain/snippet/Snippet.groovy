package snippet

class Snippet {

    def githubService

    String gist_id
    String tags
    Date dateCreated
    Date lastUpdated

    static searchable = true
    static belongsTo = [author:User]
    static constraints = {
        gist_id(blank:false)
        tags(blank:true)
    }
}

