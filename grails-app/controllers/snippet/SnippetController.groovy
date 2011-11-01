package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import auth.*
import org.codehaus.groovy.grails.commons.GrailsClassUtils

class SnippetController {

    static allowedMethods = [save: 'POST', update: 'POST', delete: 'POST']

    def springSecurityService

    @Secured(['ROLE_USER'])
    def tags = {
        log.debug params
        if(params.status){
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            def query = "select distinct(s) from Snippet s, UserTag u, TagLink t where s.status = ? and s.id = t.tagRef and t.type = 'snippet' and u.tag.name = t.tag.name and u.follower.id = ?  order by s.dateCreated desc"
            def snippetInstanceList = Snippet.executeQuery(query,[params.status, springSecurityService.principal.id],params)
            def snippetInstanceTotal = Snippet.executeQuery(query,[params.status, springSecurityService.principal.id]).size()
            render view: 'list', model: [ snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, userInstance: springSecurityService.currentUser, status:params.status ]
        }
    }

    @Secured(['ROLE_USER'])
    def users = {
        log.debug params
        if(params.status){
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            def query = "select s from Snippet s, UserUser u where s.status = ? and s.user.id = u.user.id and u.follower.id = ? order by s.dateCreated desc"
            def snippetInstanceList = Snippet.executeQuery(query,[params.status, springSecurityService.principal.id],params)
            def snippetInstanceTotal = Snippet.executeQuery(query,[params.status, springSecurityService.principal.id]).size()
            render view: 'list', model: [ snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, userInstance: springSecurityService.currentUser, status:params.status ]
        }
    }

    def starred = {
        def userInstance
        def snippetInstanceList, snippetInstanceTotal = 0
        def query

        params.max = Math.min(params.max ? params.int('max') : 10, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'

        if(params.username){
            userInstance=User.findByUsername(params.username)
        }
        else if(springSecurityService.isLoggedIn()){
            userInstance=springSecurityService.currentUser
            params.username=userInstance.username
        }
        if(userInstance){
            query = """
                select sn
                from Snippet sn, Star st
                where sn = st.snippet
                and st.user = ?
                order by sn.dateCreated desc
                """
                snippetInstanceList = Snippet.executeQuery(query,[userInstance],params)
                snippetInstanceTotal = Snippet.executeQuery(query,[userInstance]).size()
            render(view: 'snippets', model: [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, user:userInstance, currentUser: springSecurityService.currentUser])
        }
        else{
            redirect(controller:'login',view:'auth')
        }
    }

    def list = {
        def userInstance
        params.max = Math.min(params.max ? params.int('max') : 5, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'
        if(params.status){
            if(springSecurityService.isLoggedIn()) userInstance = springSecurityService.currentUser
            render view:'list', model:[
                snippetInstanceList:Snippet.findAllByStatus(params.status,params),
                snippetInstanceTotal: Snippet.countByStatus(params.status),
                userInstance: userInstance
            ]
        }
    }

    @Secured(['ROLE_USER'])
    def create = {
        def snippetInstance = new Snippet()
        snippetInstance.properties = params
        if (params.parent_id) {
            render template:'replyform',model:[parent_id: params.parent_id, snippetInstance: snippetInstance, tags: params.tags]
        } else {
            render template:'form',model:[snippetInstance: snippetInstance]
        }
    }

    @Secured(['ROLE_USER'])
    def save = {
        def snippetInstance = new Snippet()
        snippetInstance.properties['text','file','status'] = params
        snippetInstance.user = springSecurityService.currentUser
        if(params.parent_id) {
            snippetInstance.parent = Snippet.get(params.parent_id)
            snippetInstance.root = snippetInstance.parent.root?:snippetInstance.parent
            snippetInstance.status = snippetInstance.parent.status
        }
        snippetInstance.setTags()
        if(snippetInstance.save(flush: true)){
            if(params.tags) snippetInstance.parseTags(params.tags,' ')
            render "${message(code:'default.created.message', args:[message(code:'snippet.'+snippetInstance.status+'.label'), snippetInstance.id])}"
        } else {
            if(params.parent_id) {
                render status:403,template:'replyform',model:[parent_id: params.parent_id, snippetInstance: snippetInstance, tags: params.tags]
            } else {
                render status:403,template:'form',model:[snippetInstance: snippetInstance]
            }
        }
    }

    def show = {
        def snippetInstance = Snippet.get(params.id)
        if (!snippetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: 'list')
        }
        else {
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            def snippetInstanceList = Snippet.createCriteria().list(params) {
                eq ('parent', snippetInstance)
            }
            [
                message: message(code:'snippet.button.reply.label'),
                snippetInstance: snippetInstance,
                snippetInstanceList: snippetInstanceList,
                snippetInstanceTotal: snippetInstanceList.totalCount,
                userInstance: springSecurityService.currentUser
            ]
        }
    }

    @Secured(['ROLE_USER'])
    def edit = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(springSecurityService.currentUser==snippetInstance.user)) {
            [snippetInstance: snippetInstance, currentUser: springSecurityService.currentUser]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: 'list')
        }
    }

    @Secured(['ROLE_USER'])
    def update = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(snippetInstance.user==springSecurityService.currentUser)) {
            if (params.version) {
                def version = params.version.toLong()
                if (snippetInstance.version > version) {
                    snippetInstance.errors.rejectValue('version', 'default.optimistic.locking.failure', [message(code: 'snippet.label', default: 'Snippet')] as Object[], 'Another user has updated this Snippet while you were editing')
                    render(view: 'edit', model: [snippetInstance: snippetInstance])
                    return
                }
            }
            snippetInstance.properties = params
            snippetInstance.setTags()
            if (!snippetInstance.hasErrors() && snippetInstance.save(flush: true)) {
                if (params.tags) snippetInstance.parseTags(params.tags)
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
                redirect(action: 'show', id: snippetInstance.id)
            } else {
                render(view: 'edit', model: [snippetInstance: snippetInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: 'list')
        }
    }

    @Secured(['ROLE_USER'])
    def delete = {
        def snippetInstance = Snippet.get(params.id)
        if(snippetInstance&&(springSecurityService.currentUser==snippetInstance.user)) {
            try {
                Snippet.remove(snippetInstance.id)
                snippetInstance.delete(flush: true)
                render "${message(code:'default.deleted.message', args:[message(code:'snippet.'+snippetInstance.status+'.label', default:'Snippet'), snippetInstance.id], default:'deleted')}"
            } catch(org.springframework.dao.DataIntegrityViolationException e) {
                render(status:404,text:"${message(code:'default.not.deleted.message', args:[message(code:'snippet.'+snippetInstance.status+'.label', default:'Snippet'), snippetInstance.id], default:'not deleted')}")
            }
        } else {
            render(status:404,text:"${message(code:'default.not.found.message', args:[message(code:'snippet.'+snippetInstance.status+'.label', default:'Snippet'), snippetInstance.id], default:'not found')}")
        }
    }
}
