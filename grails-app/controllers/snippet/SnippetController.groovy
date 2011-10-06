package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*

import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService

    /* SignIn */
    def authenticationManager

    def star = {
        def starInstance
        def userInstance
        def snippetInstance
        def results = [:]
        if(params.id){
            snippetInstance = Snippet.get(params.id)
            if(snippetInstance){
                if(springSecurityService.isLoggedIn()){
                    userInstance = springSecurityService.getCurrentUser()
                    starInstance = Star.get(userInstance.id, snippetInstance.id)
                    switch(request.method){
                        case "GET":
                            results['exists'] = starInstance?true:false
                            break
                        case "POST":
                            if(starInstance){
                                starInstance.delete(flush: true)
                                results['exists'] = false
                            }
                            else{
                                starInstance = Star.create(userInstance, snippetInstance, true)
                                results['exists'] = true
                            }
                            break
                    }
                }
                results['count'] = Star.countBySnippet(snippetInstance)
            }
        }
        render (results as JSON)
    }

    @Secured(['ROLE_USER'])
    def solved = {
        if(params.id){
            def snippetInstance = Snippet.get(params.id)
            def userId= springSecurityService.principal.id
            if(snippetInstance && snippetInstance.user.id == userId){
                snippetInstance.help = !snippetInstance.help
                snippetInstance.save(flush:true)
            }
        }
        render(status:204,text:"")
    }

    @Secured(['ROLE_USER'])
    def user = {
        params.max = Math.min(params.max ? params.int('max') : 5, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'
        def query = "select s from Snippet s, UserUser u where s.user.id = u.user.id and u.follower.id = ?"
        def snippetInstanceList = Snippet.executeQuery(query,[springSecurityService.getCurrentUser().id],params)
        def snippetInstanceTotal = Snippet.executeQuery(query,[springSecurityService.getCurrentUser().id]).size()
        render template: "list", model: [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, username: springSecurityService.principal.username]
    }

    @Secured(['ROLE_USER'])
    def tags = {
        params.max = Math.min(params.max ? params.int('max') : 5, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'
        def query = """select distinct(s)
            from Snippet s, UserTag u, TagLink t
            where s.id = t.tagRef
            and t.type = 'snippet'
            and u.tag.name = t.tag.name
            and u.follower.id = ?"""
        def snippetInstanceList = Snippet.executeQuery(query,[springSecurityService.getCurrentUser().id],params)
        def snippetInstanceTotal = Snippet.executeQuery(query,[springSecurityService.getCurrentUser().id]).size()
        render template: "list", model: [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, username: springSecurityService.principal.username]
    }

    @Secured(['ROLE_USER'])
    def index = {
        /* SignIn
            SCH.context.authentication = new UsernamePasswordAuthenticationToken(User.get(2), springSecurityService.encodePassword('password'))
            def authentication = new UsernamePasswordAuthenticationToken('user', springSecurityService.encodePassword('password'))
            def authentication = new UsernamePasswordAuthenticationToken('user', 'password')
            SCH.context.authentication = authenticationManager.authenticate(authentication)
            println SCH.toString()
            println SCH.context.authentication.dump()
            println session
        */
        //redirect(action: "list", params: params)
    }

    @Secured(['ROLE_USER'])
    def list = {
        def snippetInstanceList
        def snippetInstanceTotal

        params.max = Math.min(params.max ? params.int('max') : 5, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'
        snippetInstanceList = Snippet.list(params)
        snippetInstanceTotal = Snippet.count()
        withFormat {
            json {
                render (contentType:'text/json') {
                    array {
                        for(i in snippetInstanceList) {
                            element {
                                id = i.id
                                text = i.text
                                file = i.file
                                status = i.status
                                help = i.help
                                deadline = i.deadline
                                date_created = prettytime.display(date:i.dateCreated)
                                last_updated = prettytime.display(date:i.lastUpdated)
                                username = i.user.username
                            }
                        }
                    }
                }
            }
            html { render template:'list',model:[snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, username: springSecurityService.principal.username] }
        }
    }

    @Secured(['ROLE_USER'])
    def create = {
        def snippetInstance = new Snippet()
        snippetInstance.properties = params
        if (params.tags) snippetInstance.parseTags(params.tags)
        if (params.parent_id) {
            render template:'replyform',model:[parent_id: params.parent_id, snippetInstance: snippetInstance]
        } else {
            render template:'form',model:[snippetInstance: snippetInstance]
        }
    }

    @Secured(['ROLE_USER'])
    def save = {
        def snippetInstance = new Snippet()
        snippetInstance.properties['text','file','status'] = params
        snippetInstance.help = params.help?true:false
        snippetInstance.user = springSecurityService.getCurrentUser()
        snippetInstance.deadline = params.deadline?new Date(params.deadline):null
        if (params.parent_id) {
            snippetInstance.parent = Snippet.get(params.parent_id)
            snippetInstance.root = snippetInstance.parent.root?:snippetInstance.parent
        }
        snippetInstance.setTags()
        if(snippetInstance.save(flush: true)){
            if (params.tags) snippetInstance.parseTags(params.tags)
            // flash.message = "${message(code: 'default.created.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            render(text:'')
        }
        else {
            // render(snippetInstance.errors.allErrors.collect{ message(error:it) } as JSON)
            render(template:'form',model:[parent_id: params.parent_id, snippetInstance: snippetInstance],status:400)
        }
    }

    def show = {
        def snippetInstance = Snippet.get(params.id)
        if (!snippetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: 'list')
        }
        else {
            params.max = Math.min(params.max ? params.int('max') : 10, 30)
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            def snippetInstanceList = Snippet.createCriteria().list(params) {
                eq ('parent', snippetInstance)
            }
            def snippetInstanceTotal = snippetInstanceList.totalCount
            [snippetInstance: snippetInstance, snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal]
        }
    }

    @Secured(['ROLE_USER'])
    def edit = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(springSecurityService.getCurrentUser()==snippetInstance.user)) {
            [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: 'list')
        }
    }

    @Secured(['ROLE_USER'])
    def update = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(snippetInstance.user==springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (snippetInstance.version > version) {
                    snippetInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'snippet.label', default: 'Snippet')] as Object[], "Another user has updated this Snippet while you were editing")
                    render(view: "edit", model: [snippetInstance: snippetInstance])
                    return
                }
            }
            snippetInstance.properties = params
            snippetInstance.setTags()
            if (!snippetInstance.hasErrors() && snippetInstance.save(flush: true)) {
                if (params.tags) snippetInstance.parseTags(params.tags)
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
                redirect(action: "show", id: snippetInstance.id)
            }
            else {
                render(view: "edit", model: [snippetInstance: snippetInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_USER'])
    def delete = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(springSecurityService.getCurrentUser()==snippetInstance.user)) {
            try {
                snippetInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else{
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }
}
