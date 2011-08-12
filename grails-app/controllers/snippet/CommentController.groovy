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
                render (commentInstance as JSON)
            }
            else {
                response.status = 400
                render ""
            }
        }
        else {
            response.status = 404
            render ""
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def delete = {
        def commentInstance = Comment.get(params.id)
        if (commentInstance&&(commentInstance.author==springSecurityService.getCurrentUser())) {
            def snippet_id = commentInstance.snippet.id
            try {
                commentInstance.delete(flush: true)
                response.status = 204
                render ""
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                render ([message: ""] as JSON)
            }
        }
        else {
            response.status = 404
            render ""
        }
    }
}
