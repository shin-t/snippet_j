package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*

class CommentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def save = {
        def commentInstance = new Comment(params)
        commentInstance.author = springSecurityService.getCurrentUser()
        if (commentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])}"
            redirect(controller: "snippet", action: "show", id: commentInstance.snippet.id)
        }
        else {
            redirect(controller: "snippet", action: "show", id: commentInstance.snippet.id)
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def update = {
        def commentInstance = Comment.get(params.id)
        if (commentInstance&&(commentInstance.author==springSecurityService.getCurrentUser())) {
            def snippet_id = commentInstance.snippet.id
            if (params.version) {
                def version = params.version.toLong()
                if (commentInstance.version > version) {
                    commentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'comment.label', default: 'Comment')] as Object[], "Another user has updated this Comment while you were editing")
                    render ([message: "Another user has updated this Comment while you were editing"] as JSON)
                }
            }
            commentInstance.properties = params
            if (!commentInstance.hasErrors() && commentInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])}"
                render (commentInstance as JSON)
            }
            else {
                render ([message: "error"] as JSON)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            render ([message: flash.message] as JSON)
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def delete = {
        def commentInstance = Comment.get(params.id)
        if (commentInstance&&(commentInstance.author==springSecurityService.getCurrentUser())) {
            def snippet_id = commentInstance.snippet.id
            try {
                commentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                response.status = 204
                render ""
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                render ([message: flash.message] as JSON)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            render ([message: flash.message] as JSON)
        }
    }
}
