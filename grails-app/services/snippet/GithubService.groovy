package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*

class GithubService {

    static transactional = true

    def springSecurityService
    def grailsApplication

    def api(params) {
        def config = grailsApplication.config.oauth.github
        log.debug config
        def http = new HTTPBuilder(config.domain)
        def json = []

        if(springSecurityService.loggedIn){
            def user = springSecurityService.getCurrentUser()
            def token = Github.executeQuery("from snippet.Github as gh where gh.user = ?",user)
            log.debug token
            def headers = ["Authorization":"token ${token[0].access_token}"]
            log.debug headers
            log.debug "path : ${params.path}"
            log.debug "query : ${params.query}"
            try {
                json = http.get(path: params.path, headers: headers, requestContentType: JSON) {r, j ->
                    r.headers.each{
                        log.debug "${it.name} : ${it.value}"
                    }
                    log.debug r
                    log.debug r.statusLine
                    log.debug r.contentType
                    log.debug r.success
                    return j
                }
            }
            catch(Exception e) {
                log.error e
            }
            log.debug json
        }
        json
    }
}
