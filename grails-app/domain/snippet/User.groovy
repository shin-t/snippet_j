package snippet

class User {

    static hasMany = [snippets:Snippet,comments:Comment,stars:Star,votes:Vote]

    static constraints = {
        username blank: false, unique: true
        password blank: false, password: true
        enabled display: false
        accountExpired display: false
        accountLocked display: false
        passwordExpired display: false
    }
    
    static mapping = {
        password column: '`password`'
    }

    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    SortedSet snippets
    SortedSet comments

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role } as Set
    }

    /**
     * @return String username
     */
    String toString() {
        username
    }

}
