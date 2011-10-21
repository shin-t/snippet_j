package auth

import snippet.*

class User {

    static constraints = {
        username blank: false, unique: true
        password blank: false, password: true
        email blank: false, email: true, unique: true
        //gravatar_hash blank: false, unique: true
        enabled display: false
        accountExpired display: false
        accountLocked display: false
        passwordExpired display: false
    }
    
    static mapping = {
        password column: '`password`'
    }

    static hasMany = [follower: UserUser, follow: UserUser]

    static mappedBy = [follower: 'user', follow: 'follower']

    String username
    String password
    String email
    //String gravatar_hash
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
