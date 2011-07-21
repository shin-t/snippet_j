package snippet

class Patch {

    String patch

    static belongsTo = [snippet:Snippet, original:Snippet]

    static constraints = {
        patch(blank:false)
    }

    static mapping = {
        patch type:'text'
    }
}

