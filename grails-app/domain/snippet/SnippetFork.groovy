package snippet

class SnippetFork {

    static belongsTo = [child:Snippet, parent:Snippet]

    static constraints = {
    }
}
