package snippet

class Star implements Serializable {

    static belongsTo = [user:User,snippet:Snippet]

    static constraints = {
        user display: false
        snippet display: false
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
}
