package snippet

import grails.plugins.springsecurity.Secured

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def scaffold = true
    def springSecurityService

    @Secured(['ROLE_ADMIN'])
    def index = {
        redirect(action: "list", params: params)
    }

    @Secured(['ROLE_ADMIN'])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
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

    def show = {
        def userInstance
        if((!params.id)&&springSecurityService.isLoggedIn()){
            userInstance = springSecurityService.getCurrentUser()
            redirect(controller: "snippet", action: "list", params: [user: userInstance.username])
        }
        else{
            userInstance = User.get(params.id)
        }
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            redirect(controller: "snippet", action: "list", params: [user: userInstance.username])
            //[userInstance: userInstance,tags: userInstance.tagCloud(),currentUser:springSecurityService.getCurrentUser()]
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
