package snippet

import org.grails.taggable.*

class SnippetTags implements Taggable {

    static belongsTo = [user: User, snippet: Snippet]

    static constraints = {
        user nullable:false, display: false
        snippet nullable:false, display: false
    }

    static SnippetTags get(long userId, long snippetId) {
        find 'from SnippetTags where user.id = :userId and snippet.id = :snippetId',
            [userId: userId, snippetId: snippetId]
    }

    static SnippetTags create(User user, Snippet snippet, String tags, boolean flush = false) {
        def instance = new SnippetTags(user: user, snippet: snippet).save(flush: true)
        if(instance) {
            instance.parseTags(tags)
        }
        return instance
    }

    static boolean remove(User user, Snippet snippet, boolean flush = false) {
        SnippetTags instance = SnippetTags.findByAuthorAndSnippet(user, snippet)
        instance ? instance.delete(flush: flush) : false
    }
}
