package auth

import grails.plugins.springsecurity.Secured
import grails.converters.*
import snippet.*

class UserController {

    static allowedMethods = [save: 'POST', update: 'POST', delete: 'POST']

    def springSecurityService

    @Secured(['ROLE_USER'])
    def follow_check = {
        if(params.username) {
            def userInstance = User.findByUsername(params.username)
            def result = [:]
            if(userInstance) {
                result.exists = UserUser.get(springSecurityService.principal.id, userInstance.id)?true:false
            } else {
                result.message = "${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"
            }
            render (result as JSON)
        } else {
            render status:404, text:''
        }
    }

    @Secured(['ROLE_USER'])
    def follow = {
        if(params.username) {
            def userInstance = User.findByUsername(params.username)
            def currentUser = springSecurityService.currentUser
            if(userInstance) {
                if(userInstance != currentUser) {
                    UserUser.create currentUser, userInstance, true
                }
                render (status:204, text:'')
            } else {
                render (["${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"] as JSON)
            }
        } else {
            render status:404, text:''
        }
    }

    @Secured(['ROLE_USER'])
    def unfollow = {
        if(params.username){
            def userInstance = User.findByUsername(params.username)
            if(userInstance){
                UserUser.remove springSecurityService.currentUser, userInstance, true
                render (status:204, text:'')
            }
            else render (["${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"] as JSON)
        } else {
            render status:404, text:''
        }
    }

    def snippet = {
        if(params.username) {
            def userInstance = User.findByUsername(params.username)
            if(userInstance) {
                params.max = Math.min(params.max ? params.int('max') : 5, 30)
                params.sort = params.sort?:'dateCreated'
                params.order = params.order?:'desc'
                render template:'/snippet/list', model:[
                    currentUser:springSecurityService.currentUser,
                    userInstance:userInstance,
                    snippetInstanceList:Snippet.findAllByStatusAndUser('snippet',userInstance,params),
                    snippetInstanceTotal:Snippet.countByStatusAndUser('snippet',userInstance)
                ]
            } else {
                flash.message = "${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"
                redirect uri:'/'
            }
        } else {
            render status:404, text:''
        }
    }

    def question = {
        if(params.username) {
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            def userInstance = User.findByUsername(params.username)
            if(userInstance) {
                render template:'/snippet/list', model:[
                    currentUser:springSecurityService.currentUser,
                    userInstance:userInstance,
                    snippetInstanceList:Snippet.findAllByStatusAndUser('question',userInstance,params),
                    snippetInstanceTotal:Snippet.countByStatusAndUser('question',userInstance)
                ]
            } else render (["${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"] as JSON)
        } else {
            render status:404, text:''
        }
    }

    def problem = {
        if(params.username) {
            params.max = Math.min(params.max ? params.int('max') : 5, 30)
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            def userInstance = User.findByUsername(params.username)
            if(userInstance) {
                render template:'/snippet/list', model:[
                    currentUser:springSecurityService.currentUser,
                    userInstance:userInstance,
                    snippetInstanceList:Snippet.findAllByStatusAndUser('problem',userInstance,params),
                    snippetInstanceTotal:Snippet.countByStatusAndUser('problem',userInstance)
                ]
            } else render (["${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"] as JSON)
        } else {
            render status:404, text:''
        }
    }

    def following = {
        if(params.username) {
            def userInstance = User.findByUsername(params.username)
            if(userInstance) {
                params.max = Math.min(params.max ? params.int('max') : 15, 30)
                def query = "\
                    select new map(u.username as username, u.gravatar_hash as gravatar_hash)\
                    from User u, UserUser uu\
                    where u.username = uu.user.username\
                    and uu.follower.username = ?\
                    order by uu.dateCreated desc"
                def userInstanceList = User.executeQuery(query,[params.username],params)
                def userInstanceTotal = User.executeQuery(query,[params.username]).size()
                if(params.max > 5){
                    render view:'list', model:[currentUser:springSecurityService.currentUser, userInstance:userInstance, userInstanceList:userInstanceList, userInstanceTotal:userInstanceTotal]
                } else {
                    render template:'list', model:[currentUser:springSecurityService.currentUser, userInstance:userInstance, userInstanceList:userInstanceList, userInstanceTotal:userInstanceTotal]
                }
            } else render (["${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"] as JSON)
        } else {
            render status:404, text:''
        }
    }

    def followers = {
        if(params.username) {
            def userInstance = User.findByUsername(params.username)
            if(userInstance) {
                params.max = Math.min(params.max ? params.int('max') : 15, 30)
                def query = "\
                    select new map(u.username as username, u.gravatar_hash as gravatar_hash)\
                    from User u, UserUser uu\
                    where u.username = uu.follower.username\
                    and uu.user.username = ?\
                    order by uu.dateCreated desc"
                def userInstanceList = User.executeQuery(query,[params.username],params)
                def userInstanceTotal = User.executeQuery(query,[params.username]).size()
                if(params.max > 5){
                    render view:'list', model:[currentUser:springSecurityService.currentUser, userInstance:userInstance, userInstanceList:userInstanceList, userInstanceTotal:userInstanceTotal]
                } else {
                    render template:'list', model:[currentUser:springSecurityService.currentUser, userInstance:userInstance, userInstanceList:userInstanceList, userInstanceTotal:userInstanceTotal]
                }
            } else render (["${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"] as JSON)
        } else {
            render status:404, text:''
        }
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 5, 30)
        def query= "select new map(u.username as username, u.gravatar_hash as gravatar_hash, u.follower.size as followers) from User u order by u.follower.size desc"
        [userInstanceList:User.executeQuery(query,[],params), userInstanceTotal:User.executeQuery(query).size()]
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
        userInstance.password = ''
        return [userInstance:userInstance]
    }

    def save = {
        def userInstance = new User(params)
        userInstance.password = params.password?springSecurityService.encodePassword(params.password):''
        userInstance.password2 = params.password2?springSecurityService.encodePassword(params.password2):''
        userInstance.gravatar_hash = userInstance.email.trim().toLowerCase().encodeAsMD5()
        userInstance.enabled = true
        if (userInstance.save(flush: true)) {
            UserRole.create userInstance, Role.findByAuthority('ROLE_USER'), true
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])}"
            redirect(controller:'user', action:'index', params:[username:userInstance.username])
        }
        else {
            userInstance.password = params.password
            render(view:'create', model:[userInstance:userInstance])
        }
    }

    def show = {
        if(params.username) {
            def userInstance
            params.max = Math.min(params.max ? params.int('max') : 10, 30)
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            userInstance=User.findByUsername(params.username)
            if(userInstance){
                [currentUser:springSecurityService.currentUser, userInstance:userInstance]
            } else {
                flash.message = "${message(code:'default.not.found.message', args:[message(code:'user.label', default:'User'), params.username], default:'not found')}"
                redirect uri:'/'
            }
        } else {
            render status:404, text:''
        }
    }

    @Secured(['ROLE_USER'])
    def edit = {
        def userInstance = springSecurityService.currentUser
        userInstance.password = ''
        [userInstance: userInstance]
    }

    @Secured(['ROLE_USER'])
    def update = {
        def userInstance = User.get(params.id)
        if(userInstance && (userInstance.id == springSecurityService.principal.id)) {
            if(params.version) {
                def version = params.version.toLong()
                if(userInstance.version > version) {
                    userInstance.errors.rejectValue('version', 'default.optimistic.locking.failure', [message(code: 'user.label', default: 'User')] as Object[], 'Another user has updated this User while you were editing')
                    render(view: 'edit', model: [userInstance: userInstance])
                    return
                }
            }
            if(params.password || params.password2) {
                params.password = params.password?springSecurityService.encodePassword(params.password):''
                params.password2 = params.password2?springSecurityService.encodePassword(params.password2):''
                params.prop = 'password'
            } else {
                userInstance.password2 = userInstance.password
            }
            if(params.email || params.email2) {
                params.prop = 'email'
            } else {
                userInstance.email2 = userInstance.email
            }
            userInstance.properties = params
            userInstance.gravatar_hash = userInstance.email.trim().toLowerCase().encodeAsMD5()
            if(!userInstance.hasErrors() && userInstance.save(flush: true)) {
                if(springSecurityService.loggedIn && springSecurityService.principal.username == userInstance.username) {
                    springSecurityService.reauthenticate userInstance.username
                }
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.username])}"
                redirect(action:'show', params:[username: userInstance.username])
            } else {
                render(view:'edit', model:[userInstance: userInstance])
            }
        } else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect uri:'/'
        }
    }

    @Secured(['ROLE_USER'])
    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance && (userInstance.id == springSecurityService.principal.id)) {
            try {
                Snippet.removeAll(userInstance)
                UserUser.removeAll(userInstance)
                UserTag.removeAll(userInstance)
                Star.removeAll(userInstance)
                UserRole.removeAll(userInstance)
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(controller: 'logout')
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: 'edit', model: [username: userInstance.username])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect uri:'/'
        }
    }
}
