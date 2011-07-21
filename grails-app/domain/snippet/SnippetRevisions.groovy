package snippet

class SnippetRevisions {

    static hasMany = [snippets:Snippet]

    static constraints = {
    }

    Snippet head() {
        Snippet.executeQuery('from snippet.Snippet as s where s.revisions = ? and s.children is empty',[this])[0]
    }
}
