package snippet

import grails.plugins.springsecurity.Secured

class CommentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def scaffold = true
    def springSecurityService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [commentInstanceList: Comment.list(params), commentInstanceTotal: Comment.count()]
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def create = {
        def commentInstance = new Comment()
        commentInstance.properties = params
        return [commentInstance: commentInstance]
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def save = {
        def commentInstance = new Comment(params)
        commentInstance.author = springSecurityService.getCurrentUser()
        if (commentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])}"
            redirect(controller: 'snippet', action: "show", id: commentInstance.snippet.id)
        }
        else {
            render(view: "create", model: [commentInstance: commentInstance])
        }
    }

    def show = {
        def commentInstance = Comment.get(params.id)
        if (!commentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
        else {
            [commentInstance: commentInstance]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def edit = {
        def commentInstance = Comment.get(params.id)
        if (!commentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [commentInstance: commentInstance]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def update = {
        def commentInstance = Comment.get(params.id)
        if (commentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (commentInstance.version > version) {
                    
                    commentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'comment.label', default: 'Comment')] as Object[], "Another user has updated this Comment while you were editing")
                    render(view: "edit", model: [commentInstance: commentInstance])
                    return
                }
            }
            commentInstance.properties = params
            if (!commentInstance.hasErrors() && commentInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])}"
                redirect(action: "show", id: commentInstance.id)
            }
            else {
                render(view: "edit", model: [commentInstance: commentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def delete = {
        def commentInstance = Comment.get(params.id)
        if (commentInstance) {
            try {
                commentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
    }
    
}
