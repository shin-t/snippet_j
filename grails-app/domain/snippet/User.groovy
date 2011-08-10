package snippet

class User {

    static hasMany = [snippets:Snippet,comments:Comment, tags: SnippetTags,stars:Star]

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
            from SnippetTags st, TagLink tl 
            where st.id = tl.tagRef
            and st.user = :user
            and tl.type = 'snippetTags'
            group by tl.tag.name"""
        SnippetTags.executeQuery(query,[user:this]);
    }
}
