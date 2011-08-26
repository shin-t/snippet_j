package snippet

import static groovyx.net.http.ContentType.*
import grails.plugins.springsecurity.Secured
import grails.converters.*

class VoteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def vote = {
        def user_id = springSecurityService.getCurrentUser().id
        def status
        if(params.id){
            switch(request.method){
                case "GET":
                    status = Vote.get(user_id.toLong(), params.id.toLong())?204:404
                    break
                case "POST":
                    Vote.up_vote(user_id.toLong(), params.id.toLong())
                    status = 204
                    break
                default:
                    status = 400
                    break
            }
        }
        else{
            status = 404
        }
        render(status:status,text:"")
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def up_vote = {
        def user_id = springSecurityService.getCurrentUser().id
        def status
        if(params.id){
            switch(request.method){
                case "POST":
                    Vote.up_vote(user_id.toLong(), params.id.toLong())
                    status = 204
                    break
                default:
                    status = 400
                    break
            }
        }
        else{
            status = 404
        }
        render(status:status,text:"")
    }
    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def down_vote = {
        def user_id = springSecurityService.getCurrentUser().id
        def status
        if(params.id){
            switch(request.method){
                case "POST":
                    Vote.down_vote(user_id.toLong(), params.id.toLong())
                    status = 204
                    break
                default:
                    status = 400
                    break
            }
        }
        else{
            status = 404
        }
        render(status:status,text:"")
    }

    def votes_counts = {
        if(params.id){
            def instance = Snippet.get(params.id)
            if(instance){
                def c = Snippet.executeQuery("select sum(v.vote) from Vote as v where v.snippet.id = ?",[instance.id])
                c = c[0]?:0
                render(contentType:'application/json') {
                    id = instance.id
                    counts = c
                }
            }
            else{
                render(contentType:'application/json') {
                    message = message(code:'default.not.found.message',args:["Snippet",params.id])
                }
            }
        }
        else{
            render(status:404,text:"")
        }
    }
}
