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
            if(Tag.findByName(params.tag)){
                render ([UserTag.get(springSecurityService.principal.id, params.tag)?true:false] as JSON)
            } else {
                render ([message: 'Not Found'] as JSON)
            }
        } else {
            render status:404, text:''
        }
    }

    @Secured(['ROLE_USER'])
    def follow = {
        if(params.tag){
            def tag = Tag.findByName(params.tag)
            if(tag){
                UserTag.create(springSecurityService.currentUser, tag, true)
                render (status:204, text:'')
            }
            else render ([message: 'Not Found'] as JSON)
        } else {
            render status:404, text:''
        }
    }

    @Secured(['ROLE_USER'])
    def unfollow = {
        if(params.tag){
            if(Tag.findByName(params.tag)){
                UserTag.get(springSecurityService.principal.id, params.tag)?.delete(flush:true)
                render (status:204, text:'')
            }
            else render ([message: 'Not Found'] as JSON)
        } else {
            render status:404, text:''
        }
    }

    def snippet = {
        if(params.tag) {
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            def query = "select s from Snippet s, TagLink t where s.status = 'snippet' and s.id = t.tagRef and t.type = 'snippet' and t.tag.name = ? order by s.dateCreated desc"
            render template:'/snippet/list', model:[
                snippetInstanceList: Snippet.executeQuery(query, [params.tag], params),
                snippetInstanceTotal: Snippet.executeQuery(query, [params.tag]).size(),
                currentUser: springSecurityService.currentUser
            ]
        } else {
            render status:404, text:''
        }
    }

    def question = {
        if(params.tag) {
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            def query = "select s from Snippet s, TagLink t where s.status = 'question' and s.id = t.tagRef and t.type = 'snippet' and t.tag.name = ? order by s.dateCreated desc"
            render template:'/snippet/list', model:[
                snippetInstanceList: Snippet.executeQuery(query, [params.tag], params),
                snippetInstanceTotal: Snippet.executeQuery(query, [params.tag]).size(),
                currentUser: springSecurityService.currentUser
            ]
        } else {
            render status:404, text:''
        }
    }

    def problem = {
        if(params.tag) {
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            def query = "select s from Snippet s, TagLink t where s.status = 'problem' and s.id = t.tagRef and t.type = 'snippet' and t.tag.name = ? order by s.dateCreated desc"
            render template:'/snippet/list', model:[
                snippetInstanceList: Snippet.executeQuery(query, [params.tag], params),
                snippetInstanceTotal: Snippet.executeQuery(query, [params.tag]).size(),
                currentUser: springSecurityService.currentUser
            ]
        } else {
            render status:404, text:''
        }
    }

    def recent = {
        if(params.status) {
            def date = new Date() - 7
            def query = "\
                select new map(tl.tag.name as name, count(*) as count)\
                from TagLink tl, Snippet s\
                where tl.type = 'snippet' and tl.tagRef = s.id and s.status = ? and s.dateCreated > ?\
                group by name\
                order by count(*) desc, name asc"
            render template:'list', model:[tags:Snippet.executeQuery(query, [params.status, date], [max:10]), total:Snippet.executeQuery(query, [params.status, date])]
        } else {
            render status:404, text:''
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

    def list = {
        if(params.status) {
            params.max = Math.min(params.max ? params.int('max') : 15, 30)
            def query = "\
                select new map(tl.tag.name as name, count(*) as count)\
                from TagLink tl, Snippet s\
                where tl.type = 'snippet' and tl.tagRef = s.id and s.status = ?\
                group by name\
                order by count(*) desc, name asc"
            [tags:Snippet.executeQuery(query, [params.status], params), total:Snippet.executeQuery(query, [params.status]).size()]
        } else {
            render status:404, text:''
        }
    }

    def show = {
        if(params.status) {
            def query = "select new map(s.status as status, count(*) as count) from Snippet s, TagLink tl where s.id = tl.tagRef and tl.type = 'snippet' and tl.tag.name = ? group by s.status"
            def counts = Snippet.executeQuery(query,[params.tag]).inject([:]){ s, e -> s << [(e.status):e.count] }
            [currentUser:springSecurityService.currentUser, counts:counts, follower:Snippet.executeQuery("select count(*) from UserTag u where u.tag.name = ?",[params.tag]).first()]
        } else {
            render status:404, text:''
        }
    }
}
