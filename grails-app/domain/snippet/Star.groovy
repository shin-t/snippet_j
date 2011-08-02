package snippet

class Star {

    static belongsTo = [author:User,snippet:Snippet]

    static constraints = {
        author display:false
        snippet display:false
    }
}
