package snippet

class Patch {

    static belongsTo = [snippet:Snippet, original:Snippet]
    
    String patch

    static constraints = {
        patch(blank:false)
    }

    static mapping = {
        patch type:'text'
    }
}

