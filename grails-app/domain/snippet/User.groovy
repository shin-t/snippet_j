package snippet

class User {

	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    static hasMany = [comments:Comment, snippets:Snippet]

    static belongsTo = [oauth:Github]

	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static mapping = {
		password column: '`password`'
	}

    List snippetList() {
        Snippet.executeQuery('from snippet.Snippet as s where s.author=:author and s.children is empty',[author:this])
    }

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}
}
