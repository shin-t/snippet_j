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
            def currentUser = springSecurityService.currentUser
            def result
            if(tag){
                result = UserTag.get(currentUser.id, tag.name)?true:false
                render ([result] as JSON)
            }
            else render ([message: 'Not Found'] as JSON)
        }
    }

    @Secured(['ROLE_USER'])
    def follow = {
        if(params.tag){
            def tag = Tag.findByName(params.tag)
            def currentUser = springSecurityService.currentUser
            if(tag){
                UserTag.create(currentUser, tag, true)
                render (status:204, text:'')
            }
            else render ([message: 'Not Found'] as JSON)
        }
    }

    @Secured(['ROLE_USER'])
    def unfollow = {
        if(params.tag){
            def tag = Tag.findByName(params.tag)
            def currentUser = springSecurityService.currentUser
            def instance
            if(tag){
                instance = UserTag.get(currentUser.id, tag.name)
                if(instance) instance.delete(flush:true)
                render (status:204, text:'')
            }
            else render ([message: 'Not Found'] as JSON)
        }
    }

    @Secured(['ROLE_USER'])
    def following = {
        def query = "\
                select new map(u.tag.name as name, count(distinct u.tag.name) as count)\
                from UserTag u, TagLink t\
                where t.type = 'snippet' and t.tag.name = u.tag.name and u.follower.username = ?\
                group by name"
        render template:'list', model:[
            tags:Snippet.executeQuery(query, [springSecurityService.principal.username], params),
            total:Snippet.executeQuery(query, [springSecurityService.principal.username])
        ]
    }

    def index = {
    }

    def list = {
        def query = "\
            select new map(tl.tag.name as name, count(*) as count)\
            from TagLink tl, Snippet s\
            where tl.type = 'snippet' and tl.tagRef = s.id and s.status = ?\
            group by name\
            order by count(*) desc, name asc"
        render template:'list', model:[tags:Snippet.executeQuery(query, [params.status], params), total:Snippet.executeQuery(query, [params.status])]
    }

    def show = {
        def query = "select new map(s.status as status, count(*) as count) from Snippet s, TagLink tl where s.id = tl.tagRef and tl.type = 'snippet' and tl.tag.name = ? group by s.status"
        def counts = Snippet.executeQuery(query,[params.tag]).inject([:]){ s, e -> s << [(e.status):e.count] }
        log.debug counts
        [userInstance:springSecurityService.currentUser, counts:counts, follower:Snippet.executeQuery("select count(*) from UserTag u where u.tag.name = ?",[params.tag]).first()]
    }
}
