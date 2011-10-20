package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import org.grails.taggable.*
import auth.*

class TagController {

    def springSecurityService

    @Secured(['ROLE_USER'])
    def follow_check = {
        if(params.tag){
            def tag = Tag.findByName(params.tag)
            def currentUser = springSecurityService.getCurrentUser()
            def result
            if(tag){
                result = UserTag.get(currentUser.id, tag.name)?true:false
                render ([result] as JSON)
            }
            else render ([message: "Not Found"] as JSON)
        }
    }

    @Secured(['ROLE_USER'])
    def follow = {
        if(params.tag){
            def tag = Tag.findByName(params.tag)
            def currentUser = springSecurityService.getCurrentUser()
            if(tag){
                UserTag.create(currentUser, tag, true)
                render (status:204, text:"")
            }
            else render ([message: "Not Found"] as JSON)
        }
    }

    @Secured(['ROLE_USER'])
    def unfollow = {
        if(params.tag){
            def tag = Tag.findByName(params.tag)
            def currentUser = springSecurityService.getCurrentUser()
            def instance
            if(tag){
                instance = UserTag.get(currentUser.id, tag.name)
                if(instance){
                    instance.delete(flush:true)
                }
                render (status:204, text:"")
            }
            else render ([message: "Not Found"] as JSON)
        }
    }

    def index = {
        def query = "from Snippet s, TagLink t where s.id = t.tagRef and t.type = 'snippet' and t.tag.name = ? and s.status = ?"
        [userInstance: springSecurityService.getCurrentUser(),
            count_snippet: Snippet.executeQuery(query,[params.tag,0]).size(),
            count_question: Snippet.executeQuery(query,[params.tag,1]).size(),
            count_problem: Snippet.executeQuery(query,[params.tag,2]).size(),
            follower: Snippet.executeQuery("from UserTag u where u.tag.name = ?",[params.tag]).size()]
    }

    def list = {
        if(params.tag){
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            def snippetInstanceList
            def snippetInstanceTotal
            def query = "select s from Snippet s, TagLink t where s.id = t.tagRef and t.type = 'snippet' and t.tag.name = ? order by s.dateCreated desc"
            snippetInstanceList = Snippet.executeQuery(query, [params.tag], params)
            snippetInstanceTotal = Snippet.executeQuery(query, [params.tag]).size()
            render template:'/snippet/list', model: [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal]
        }
        else{
            def query = "select tl.tag.name from TagLink tl where tl.type = 'snippet' order by tl.tag.name"
            render template: 'tags', model: [tags:Snippet.executeQuery(query,[])]
        }
    }

    def ranking = {
        def query = "select tl.tag.name from TagLink tl, Snippet s where tl.type = 'snippet' and tl.tagRef = s.id group by tl.tag.name order by count(*) desc"
        render template: 'tags', model: [tags:Snippet.executeQuery(query,[],[max:10])]
    }
}
