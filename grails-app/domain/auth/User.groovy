package auth

import snippet.*

class User {

    static constraints = {
        username blank: false, unique: true
        password blank: false, password: true, validator: { val, obj -> val == obj.password2 ? true : ['user.password.mismatch.message'] }
        email blank: false, email: true, unique: true, validator: { val, obj -> val == obj.email2 ? true : ['user.email.mismatch.message'] }
        gravatar_hash blank: false, unique: true, validator: { val, obj -> val == obj.email.trim().toLowerCase().encodeAsMD5() }
        enabled display: false
        accountExpired display: false
        accountLocked display: false
        passwordExpired display: false
    }
    
    static mapping = {
        password column: '`password`'
    }

    static hasMany = [follower: UserUser, follow: UserUser, snippet: Snippet]

    static mappedBy = [follower: 'user', follow: 'follower']

    static transients = ['password2','email2']

    String username
    String password
    String password2
    String email
    String email2
    String gravatar_hash
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

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
