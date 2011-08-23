package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService

    def index = {
        redirect(action: "snippets", params: params)
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
        userInstance.password = ""
        return [userInstance: userInstance]
    }

    def save = {
        log.debug params
        def userInstance = new User(params)
        userInstance.password = params.password?springSecurityService.encodePassword(params.password):""
        userInstance.enabled = true
        if (userInstance.save(flush: true)) {
            UserRole.create userInstance, Role.findByAuthority('ROLE_USER'), true
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
            redirect(action: "show", id: userInstance.id)
        }
        else {
            userInstance.password = params.password
            render(view: "create", model: [userInstance: userInstance])
        }
    }

    def snippets = {
        def userInstance
        def snippetInstanceList, snippetInstanceTotal = 0
        def query
        
        params.max = Math.min(params.max ? params.int('max') : 10, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'
        params.username = params.username?:params.id

        if(params.username){
            userInstance=User.findByUsername(params.username)
        }
        else if(springSecurityService.isLoggedIn()){
            userInstance=springSecurityService.getCurrentUser()
            params.username=userInstance.username
        }
        if(userInstance){
            query = """
                from Snippet sp 
                where sp.author = :user
                order by sp.dateCreated desc
                """
            snippetInstanceList = SnippetTags.executeQuery(query,[user:userInstance],params)
            snippetInstanceTotal = SnippetTags.executeQuery(query,[user:userInstance]).size()
            [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, user:userInstance, tags: userInstance.tagCloud(), currentUser: springSecurityService.getCurrentUser()]
        }
        else{
            render(status: 404, text: " ")
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
            userInstance=springSecurityService.getCurrentUser()
            params.username=userInstance.username
        }
        if(userInstance){
            query = """
                select sp
                from Snippet sp, Star st
                where sp.id = st.snippet.id
                and st.user = :user
                order by sp.dateCreated desc
                """
                snippetInstanceList = SnippetTags.executeQuery(query,[user:userInstance],params)
                snippetInstanceTotal = SnippetTags.executeQuery(query,[user:userInstance]).size()
            render(view: "snippets", model: [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, user:userInstance, tags: userInstance.tagCloud(), currentUser: springSecurityService.getCurrentUser()])
        }
        else{
            render(status: 404, text: " ")
        }
    }

    def tag = {
        def tag = []
        if(springSecurityService.isLoggedIn()){
            tag = springSecurityService.getCurrentUser().tagCloud()
        }
        render (tag as JSON)
    }

    def tags = {
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
            userInstance=springSecurityService.getCurrentUser()
            params.username=userInstance.username
        }
        if(userInstance){
            if(params.tags?.split(' ')){
                query = """
                    select sp
                    from Snippet sp, SnippetTags st, TagLink tl
                    where sp.id = st.snippet.id
                    and st.id = tl.tagRef
                    and tl.type = 'snippetTags'
                    and tl.tag.name in (:tags)
                    and st.user = :user
                    order by sp.dateCreated desc
                    """
                snippetInstanceList = SnippetTags.executeQuery(query,[tags:params.tags.split(' '),user:userInstance],params)
                snippetInstanceTotal = SnippetTags.executeQuery(query,[tags:params.tags.split(' '),user:userInstance]).size()
            }
            else{
                query = """
                    select sp
                    from Snippet sp, SnippetTags st
                    where sp.id = st.snippet.id
                    and st.user = :user
                    order by sp.dateCreated desc
                    """
                snippetInstanceList = SnippetTags.executeQuery(query,[user:userInstance],params)
                snippetInstanceTotal = SnippetTags.executeQuery(query,[user:userInstance]).size()
            }
            [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, userInstance:userInstance, tags: userInstance.tagCloud(), currentUser: springSecurityService.getCurrentUser()]
        }
        else{
            render(status: 404, text: " ")
        }
    }

    def show = {
        def userInstance

        params.max = Math.min(params.max ? params.int('max') : 10, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'

        if(params.username){
            userInstance=User.findByUsername(params.username)
        }
        else if(springSecurityService.isLoggedIn()){
            userInstance=springSecurityService.getCurrentUser()
        }
        if(userInstance){
            [currentUser: springSecurityService.getCurrentUser(), user:userInstance, tags: userInstance.tagCloud()]
        }
        else{
            redirect(controller:"login",view:"auth")
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def edit = {
        def userInstance = User.get(params.id)
        if (userInstance&&(userInstance==springSecurityService.getCurrentUser())) {
            userInstance.password = ""
            return [userInstance: userInstance]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def update = {
        def userInstance = User.get(params.id)
        if (userInstance&&(userInstance==springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {
                    
                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance])
                    return
                }
            }
            if(userInstance.password != params.password) {
                params.password = springSecurityService.encodePassword(params.password)
            }
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
                if (springSecurityService.loggedIn && springSecurityService.principal.username == userInstance.username) {
                    springSecurityService.reauthenticate userInstance.username
                }
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
                redirect(action: "show", id: userInstance.id)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance&&(userInstance==springSecurityService.getCurrentUser())) {
            try {
                UserRole.removeAll(userInstance)
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(controller: "logout")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(controller: "snippet", action: "list")
        }
    }
}
