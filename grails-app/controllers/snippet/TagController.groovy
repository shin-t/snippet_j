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
        [userInstance: springSecurityService.getCurrentUser()]
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
            def query = "select tl.tag.name from TagLink as tl where tl.type = 'snippet' group by tl.tag.name"
            render template: 'tags', model: [tags:Snippet.executeQuery(query,[],params)]
        }
    }

    def ranking = {
        def query = "select t.name from TagLink tl, Tag t, Snippet s where tl.type = 'snippet' and tl.tag.id = t.id and tl.tagRef = s.id and s.lastUpdated >= :date group by t.name"
        def date = new Date() - 7
        render template: 'tags', model: [tags:Snippet.executeQuery(query,[date:date],[max:10])]
    }
}
