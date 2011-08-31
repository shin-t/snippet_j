import geb.spock.GebSpec

class UserCRUDSpec extends GebSpec {
    def "index"() {
        when:
        go ""
        then:
        println page
        println page.dump()
        println page.pageUrl
        println page.title
    }
    def "user create"() {
        when:
        go "/snippet/user/create"
        then:
        println page
        println page.dump()
        println page.pageUrl
        println page.title
    }
    def "login"() {
        when:
        go "/snippet/login/auth"
        then:
        println page
        println page.dump()
        println page.pageUrl
        println page.title
    }
    def "user index"() {
        when:
        to UserPage
        then:
        println page
        println page.dump()
        println page.pageUrl
        println page.title
    }
}
