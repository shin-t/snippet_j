package snippet

import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*
import javax.servlet.http.Cookie

class OauthController {

    def springSecurityService

    def auth = {
        redirect(url:'https://github.com/login/oauth/authorize'+'?'+'client_id='+grailsApplication.config.oauth.github.client_id)
    }

    def callback = {
        if(params.code){
            println "="*80
            def gists = new HTTPBuilder('https://github.com/login/oauth/')
            def res = gists.post(path: 'access_token',
                    body: [client_id: grailsApplication.config.oauth.github.client_id, client_secret: grailsApplication.config.oauth.github.client_secret, code: params.code],
                    requestContentType: URLENC ) { resp ->
                def content = [:]
                resp.getEntity().getContent().getText().split('&').each{def m=it.split('=');content.put(m[0],m[1])}
                assert resp.statusLine.statusCode == 200
                return content
            }
            println res

            def gu = new HTTPBuilder('https://api.github.com/')
            def gu_res = gu.get(path: 'user',headers: ["Authorization":"token ${res.access_token}"],requestContentType: JSON)
            {resp, json ->
                    println json
                    println "id: ${json.id}"
                    println "login: ${json.login}"
                    return json
            }
            println gu_res

            def token = Github.findByAccess_token(res.access_token)
            def user
            println "token: ${token}"
            if(token){
                user = token.user
            }
            else{
                token = new Github()
                token.access_token = res.access_token
                token.save(flush: true)

                user = new User()
                user.username = gu_res.login
                user.password = springSecurityService.encodePassword(token.access_token)
                user.enabled = true
                user.save(flush: true)
                println user.dump()

                token.user = user
                token.save(flush: true)
                println token.dump()

                println Role.get(2).dump()
                UserRole.create user, Role.get(2), true
            }
            println "username: ${user.username}"
            println "token: ${token.access_token}"

            def http = new HTTPBuilder('http://localhost:8080/snippet/')
            def res2 = http.post(path: 'j_spring_security_check',body: [j_password:token.access_token,j_username:user.username],requestContentType: URLENC)
            {resp ->
                    println resp.statusLine
                    for(h in resp.getHeaders())
                    {
                        println "${h.name}: ${h.value}"
                    }
                    return resp.headers.'Location'
            }

            def m = res2 =~ /(http.*);(.*)=(.*)/
            def cookie = new Cookie("JSESSIONID",m[0][3])
            cookie.setPath('/snippet')
            response.addCookie(cookie)
            redirect(url:m[0][1])
        }
        else{
            redirect(controller:'snippet',action:'list')
        }
    }
}
