package snippet

import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*

import javax.servlet.http.Cookie

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class OauthController {

    def springSecurityService

    def auth = {
        def config = grailsApplication.config.oauth.github
        redirect(url: "${config.authorize_url}?client_id=${config.client_id}")
    }

    def callback = {
        def config = grailsApplication.config.oauth.github
        if(params.code){
            def github = new HTTPBuilder(config.access_token_url)
            def access_token = github.post(
                    body: [
                        client_id: config.client_id,
                        client_secret: config.client_secret,
                        code: params.code
                    ],
                    requestContentType: URLENC ) { resp ->
                def content = [:]
                resp.getEntity().getContent().getText().split('&').each{def m=it.split('=');content.put(m[0],m[1])}
                assert resp.statusLine.statusCode == 200
                return content.access_token
            }

            def http = new HTTPBuilder(config.domain)
            def json = http.get(path: '/user', headers: ["Authorization":"token ${access_token}"], requestContentType: JSON)
            {r, j ->
                log.debug j
                log.debug j.id
                log.debug j.login
                return j
            }

            def token = Github.findByAccess_token(access_token)
            def user
            if(token){
                user = token.user
            }
            else{
                token = new Github(access_token: access_token)
                user = new User(username: json.login, password: springSecurityService.encodePassword(token.access_token), enabled: true)
                if(user.save(flush: true)){
                    token.user = user
                    if(token.save(flush: true)){
                        UserRole.create user, Role.get(2), true
                    }
                }
            }

            def http2 = new HTTPBuilder(grailsApplication.config.grails.serverURL+SpringSecurityUtils.securityConfig.apf.filterProcessesUrl)
            def location = http2.post(body: [j_password: token.access_token, j_username: user.username], requestContentType: URLENC)
            { resp ->
                    log.debug(resp.statusLine)
                    for(h in resp.getHeaders())
                    {
                        log.debug "${h.name}: ${h.value}"
                    }
                    return resp.headers.'Location'
            }
            def m = location =~ /(http.*);(.*)=(.*)/
            def cookie = new Cookie("JSESSIONID",m[0][3])
            cookie.setPath('/snippet')
            response.addCookie(cookie)
            redirect(url:m[0][1])
        }
        else{
            redirect(controller: 'snippet', action: 'list')
        }
    }
}
