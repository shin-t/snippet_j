package snippet

import grails.test.*

class UserRoleTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()

        def user1 = new User(username:"admin",password:"password").save()
        def user2 = new User(username:"user",password:"password").save()

        assert new UserRole(user:user1,role:Role.findByAuthority("ROLE_ADMIN")).save()?.instanceOf(UserRole)
        assert new UserRole(user:user1,role:Role.findByAuthority("ROLE_USER")).save()?.instanceOf(UserRole)

        assert new UserRole(user:user2,role:Role.findByAuthority("ROLE_USER")).save()?.instanceOf(UserRole)
    }

    protected void tearDown() {
        super.tearDown()
    }

    void "test hash code"() {
        UserRole.list().each{
            println it.hashCode()
            assertTrue it.hashCode() instanceof Integer
        }
        [new UserRole(user:User.findByUsername("user")),new UserRole(role:Role.get(1))].each{
            println it.hashCode()
            assertTrue it.hashCode() instanceof Integer
        }
    }

    void "test get"() {
        assert UserRole.get(User.findByUsername("admin").id,1).instanceOf(UserRole)

        assertNull UserRole.get(User.findByUsername("user").id,3)
    }

    void "test remove all User"() {
        UserRole.removeAll(User.findByUsername("admin"))
        assert 1 == UserRole.count()
        UserRole.removeAll(User.findByUsername("admin"))
        assert 1 == UserRole.count()
    }

    void "test remove all Role"() {
        UserRole.removeAll(Role.get(2))
        assert 1 == UserRole.count()
        UserRole.removeAll(Role.get(2))
        assert 1 == UserRole.count()
    }

}
