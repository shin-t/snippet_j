package snippet

class User {

	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    List comments() {
        return comments.collect{it.comment}
    }

    List snippets() {
        return snippets.collect{it.snippet}
    }

    static hasMany = [comments:Comment, snippets:Snippet]

	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}
}
