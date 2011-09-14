package snippet

class Question extends Content{

    static constraints = {
        user display:false
        text blank:false, widget:'textarea'
        file nullable:true, blank:false, widget:'textarea'
        recepting ()
        dateCreated ()
        lastUpdated ()
        children display:false
    }

    boolean recepting = true
}
