package snippet

class Problem extends Content{

    static constraints = {
        user display:false
        text blank:false, widget:'textarea'
        file nullable:true, blank:false, widget:'textarea'
        deadline nullable:true
        dateCreated ()
        lastUpdated ()
        children display:false
    }

    Date deadline
}
