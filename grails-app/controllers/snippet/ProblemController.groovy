package snippet

import grails.plugins.springsecurity.Secured
import auth.*

class ProblemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [problemInstanceList: Problem.list(params), problemInstanceTotal: Problem.count()]
    }

    @Secured(['ROLE_USER'])
    def create = {
        def problemInstance = new Problem()
        problemInstance.properties = params
        return [problemInstance: problemInstance]
    }

    @Secured(['ROLE_USER'])
    def save = {
        def problemInstance = new Problem(params)
        problemInstance.user = springSecurityService.getCurrentUser()
        if (problemInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'problem.label', default: 'Problem'), problemInstance.id])}"
            redirect(action: "show", id: problemInstance.id)
        }
        else {
            render(view: "create", model: [problemInstance: problemInstance])
        }
    }

    def show = {
        def problemInstance = Problem.get(params.id)
        if (!problemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
        else {
            [problemInstance: problemInstance]
        }
    }

    @Secured(['ROLE_USER'])
    def edit = {
        def problemInstance = Problem.get(params.id)
        if (problemInstance && problemInstance.user.id == springSecurityService.getCurrentUser().id) {
            return [problemInstance: problemInstance]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_USER'])
    def update = {
        def problemInstance = Problem.get(params.id)
        if (problemInstance && problemInstance.user.id == springSecurityService.getCurrentUser().id) {
            if (params.version) {
                def version = params.version.toLong()
                if (problemInstance.version > version) {
                    
                    problemInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'problem.label', default: 'Problem')] as Object[], "Another user has updated this Problem while you were editing")
                    render(view: "edit", model: [problemInstance: problemInstance])
                    return
                }
            }
            problemInstance.properties = params
            if (!problemInstance.hasErrors() && problemInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'problem.label', default: 'Problem'), problemInstance.id])}"
                redirect(action: "show", id: problemInstance.id)
            }
            else {
                render(view: "edit", model: [problemInstance: problemInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_USER'])
    def delete = {
        def problemInstance = Problem.get(params.id)
        if (problemInstance && problemInstance.user.id == springSecurityService.getCurrentUser().id) {
            try {
                problemInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
    }
    
}
