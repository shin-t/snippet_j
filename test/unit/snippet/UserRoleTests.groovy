package snippet

import grails.test.*

class UserRoleTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
        mockDomain(Role,[new Role(authority: 'ROLE_ADMIN'), new Role(authority: 'ROLE_USER')])
        mockDomain(User,[new User(username: 'admin', enabled: true, password: 'password'), new User(username: 'user', enabled: true, password: 'password')])
        mockDomain(UserRole,[new UserRole(user: User.get(1), role: Role.get(1)), new UserRole(user: User.get(1), role: Role.get(2))])
        assert 2 == UserRole.count()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test create"() {
        assert new UserRole(user: User.get(1), role: Role.get(1)).save() instanceof UserRole
        assert UserRole.create(User.get(2), Role.get(2)) instanceof UserRole
        assert 3 == UserRole.count()
    }

    void "test equals"() {
        assertTrue UserRole.get(1).equals(UserRole.get(1))
        assertFalse UserRole.get(1).equals(UserRole.get(2))
        assertFalse UserRole.get(1).equals("Test")
    }

    void "test remove"() {
        UserRole.remove(User.get(1),Role.get(2))
        assert 1 == UserRole.count()
        UserRole.remove(User.get(1),Role.get(2))
        assert 1 == UserRole.count()
    }

}
