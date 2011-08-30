package snippet

class Vote {

    static belongsTo = [user:User,snippet:Snippet]

    static constraints = {
        user display: false
        snippet display: false
    }

    int vote

    static Vote get(long userId, long snippetId) {
        find 'from Vote where user.id=:userId and snippet.id=:snippetId',
            [userId: userId, snippetId: snippetId]
    }

    static Vote create(User user, Snippet snippet, int vote, boolean flush = false) {
        def instance = new Vote(user: user, snippet: snippet, vote: vote)
        return instance.save(flush: flush)
    }

    static boolean remove(User user, Snippet snippet, boolean flush = false) {
        Vote instance = Vote.findByUserAndSnippet(user, snippet)
        instance ? instance.delete(flush: flush) : false
    }
    
    static up_vote(long userId, long snippetId) {
        Vote instance = get(userId, snippetId)
        if(instance){
            instance.vote = (instance.vote>0)?0:1
            instance.save(flush: true)
        }
        else{
            create(User.get(userId), Snippet.get(snippetId), 1, true)
        }
    }

    static down_vote(long userId, long snippetId) {
        Vote instance = get(userId, snippetId)
        if(instance){
            instance.vote = (instance.vote<0)?0:-1
            instance.save(flush: true)
        }
        else{
            create(User.get(userId), Snippet.get(snippetId), -1, true)
        }
    }
}
