package snippet

class Snippet extends Content {

    static constraints = {
        user display:false
        text blank:false, widget:'textarea'
        file nullable:true, blank:false, widget:'textarea'
        dateCreated ()
        lastUpdated ()
        problem nullable:true, display:false
        question nullable:true, display:false
        parent nullable:true, display:false
        children display:false
    }

    Problem problem
    Question question
    Snippet parent
}
