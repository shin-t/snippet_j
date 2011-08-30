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

    String toString() {
        username
    }

    def tagCloud() {
        def query = """
            select tl.tag.name, count(tl.tag.name) 
            from Snippet s, TagLink tl 
            where s.id = tl.tagRef
            and s.author = ?
            and tl.type = 'snippet'
            group by tl.tag.name
        """
        Snippet.executeQuery(query,[this]);
    }
}
