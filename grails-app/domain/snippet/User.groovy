package snippet

class User {

    static hasMany = [snippet:Snippet, comment:Comment]
    
    String login
    String password
    String name
    String role = "author"

    String toString(){name}

    static constraints = {
        login(unique:true)
        password(password:true)
        name()
        role(inList:["author", "admin"])
    }
}
