package auth

import grails.plugins.springsecurity.Secured
import grails.converters.*
import snippet.*

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService

    def snippets = {
        def userInstance
        def snippetInstanceList
        def snippetInstanceTotal = 0
        if(!params.username && springSecurityService.isLoggedIn()) params.username = springSecurityService.principal.username
        if(params.username){
            userInstance = User.findByUsername(params.username)
            if(userInstance){
                params.max = Math.min(params.max ? params.int('max') : 10, 30)
                params.sort = params.sort?:'dateCreated'
                params.order = params.order?:'desc'
                snippetInstanceList = Snippet.findAllByUser(userInstance, params)
                snippetInstanceTotal = Snippet.countByUser(userInstance)
            }
        }
        render template:"/snippet/list",model:[snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal]
    }

    def tags = {
        def query = "select distinct new map(u.tag.name as name, u.dateCreated as dateCreated) from UserTag u, TagLink t where t.type = 'snippet' and t.tag.name = u.tag.name and u.follower.username = ? order by u.dateCreated desc"
        if(params.username){
            render template: "/user/tags", model: [tags:Snippet.executeQuery(query,[params.username],params)]
        }
        else if(springSecurityService.isLoggedIn()){
            render template: "/user/tags", model: [tags:Snippet.executeQuery(query,[springSecurityService.principal.username],params)]
        }
    }

    def users = {
        def query = "select u.username from User u, UserUser uu where u.username = uu.user.username and uu.follower.username = ? group by u.username"
        if(params.username){
            render template: "/user/users", model: [users:Snippet.executeQuery(query,[params.username],params)]
        }
        else if(springSecurityService.isLoggedIn()){
            render template: "/user/users", model: [users:Snippet.executeQuery(query,[springSecurityService.principal.username],params)]
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
                select sn
                from Snippet sn, Star st
                where sn = st.snippet
                and st.user = ?
                order by sn.dateCreated desc
                """
                snippetInstanceList = Snippet.executeQuery(query,[userInstance],params)
                snippetInstanceTotal = Snippet.executeQuery(query,[userInstance]).size()
            render(view: "snippets", model: [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, user:userInstance, currentUser: springSecurityService.getCurrentUser()])
        }
        else{
            redirect(controller:"login",view:"auth")
        }
    }

    @Secured(['ROLE_USER'])
    def follow_check = {
        if(params.username){
            def user = User.findByUsername(params.username)
            def currentUser = springSecurityService.getCurrentUser()
            def result
            if(user){
                result = UserUser.get(currentUser.id, user.id)?true:false
                render ([result] as JSON)
            }
            else render ([message: "Not Found"] as JSON)
        }
    }

    @Secured(['ROLE_USER'])
    def follow = {
        if(params.username){
            def user = User.findByUsername(params.username)
            def currentUser = springSecurityService.getCurrentUser()
            if(user && user != currentUser){
                UserUser.create(currentUser, user, true)
                render (status:204, text:"")
            }
            else render ([message: "Not Found"] as JSON)
        }
    }

    @Secured(['ROLE_USER'])
    def unfollow = {
        if(params.username){
            def user = User.findByUsername(params.username)
            def currentUser = springSecurityService.getCurrentUser()
            def instance
            if(user){
                instance = UserUser.get(currentUser.id, user.id)
                if(instance){
                    instance.delete(flush:true)
                }
                render (status:204, text:"")
            }
            else render ([message: "Not Found"] as JSON)
        }
    }

    def index = {
        def model = [:]
        if(springSecurityService.isLoggedIn()){
            model['currentUser'] = springSecurityService.getCurrentUser()
        }
        if(params.username){
            model['userInstance'] = User.findByUsername(params.username)
            if(model.userInstance){
                model
            }
        }
    }

    def list = {
        def query = "select new map(u.username as username, u.follower.size as followers) from User u order by u.follower.size desc"
        render template:'list', model: [users:User.executeQuery(query,[],params),total:User.executeQuery(query).size()]
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
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])}"
            redirect(controller: 'user', action: 'index', params: [username: userInstance.username])
        }
        else {
            userInstance.password = params.password
            render(view: "create", model: [userInstance: userInstance])
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
            [currentUser: springSecurityService.getCurrentUser(), user:userInstance]
        }
        else{
            redirect(controller:"login",view:"auth")
        }
    }

    @Secured(['ROLE_USER'])
    def edit = {
        def userInstance = springSecurityService.getCurrentUser()
        userInstance.password = ""
        [userInstance: userInstance]
    }

    @Secured(['ROLE_USER'])
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
            if(params.password) {
                params.password = springSecurityService.encodePassword(params.password)
            }
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
                if (springSecurityService.loggedIn && springSecurityService.principal.username == userInstance.username) {
                    springSecurityService.reauthenticate userInstance.username
                }
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])}"
                redirect(action: 'index', params: [username: userInstance.username])
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(controller: "snippet", action: "list")
        }
    }

    @Secured(['ROLE_USER'])
    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance&&(userInstance==springSecurityService.getCurrentUser())) {
            try {
                Snippet.removeAll(userInstance)
                UserUser.removeAll(userInstance)
                UserTag.removeAll(userInstance)
                Star.removeAll(userInstance)
                UserRole.removeAll(userInstance)
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(controller: "logout")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", model: [username: userInstance.username])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(controller: "snippet", action: "list")
        }
    }
}
