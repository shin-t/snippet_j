package snippet

import auth.*

class Star implements Serializable {

    static belongsTo = [user:User,snippet:Snippet]
    static mapping = {
        id composite:['user', 'snippet']
        version false
    }
    static constraints = {
    }

    static Star get(long userId, long snippetId) {
        find 'from Star where user.id=:userId and snippet.id=:snippetId',
            [userId: userId, snippetId: snippetId]
    }

    static Star create(User user, Snippet snippet, boolean flush = false) {
        def instance = new Star(user: user, snippet: snippet).save(flush: flush, insert: true)
        return instance
    }

    static boolean remove(User user, Snippet snippet, boolean flush = false) {
        Star instance = Star.findByUserAndSnippet(user, snippet)
        instance ? instance.delete(flush: flush) : false
    }
    
    String toString(){
        "$user , $snippet"
    }
}
