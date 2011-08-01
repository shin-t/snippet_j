package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import groovyx.net.http.*
import groovyx.net.http.Method
import groovyx.net.http.ContentType

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
            def hs = ["Authorization":"token ${token[0].access_token}"]
            log.debug hs
            log.debug "params : ${params}"
            try{
                json = http.request(params.method,{
                    uri.path = params.path
                    headers = hs
                    requestContentType = ContentType.JSON
                    log.debug requestContentType
                    log.debug params.body
                    body = params.body
                    response.success={r,j->
                        log.debug r.dump()
                        log.debug r.statusLine
                        log.debug r.contentType
                        r.headers.each{
                            log.debug "${it.name} : ${it.value}"
                        }
                        return j
                    }
                })
            }
            catch(HttpResponseException e){
                log.debug e.statusCode
                def resp = e.response
                log.debug resp.dump()
                log.debug resp.statusLine
                log.debug resp.contentType
                resp.headers.each{
                    log.debug "${it.name} : ${it.value}"
                }
                log.error e
            }
            log.debug json
        }
        json
    }

    // List

    // Get

    // Create
    // POST /gists
    def createGist(){
        api(method: POST)
    }

    // Edit
    // PATCH /gists/:id
    def editGist(){
    }

    // Fork
    // POST /gists/:id/fork
    def forkGist(){
    }

    // Delete
    // DELETE /gists/:id
    def deleteGist(){
    }
}
