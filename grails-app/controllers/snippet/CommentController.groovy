package snippet

import grails.plugins.springsecurity.Secured

class CommentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def save = {
        def commentInstance = new Comment(params)
        log.debug params
        commentInstance.author = springSecurityService.getCurrentUser()
        log.debug commentInstance.dump()
        if (commentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])}"
            redirect(controller: "snippet", action: "show", id: commentInstance.snippet.id)
        }
        else {
            log.debug commentInstance.dump()
            redirect(controller: "snippet", action: "show", id: commentInstance.snippet.id)
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
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
    def update = {
        def commentInstance = Comment.get(params.id)
        def snippet_id = commentInstance.snippet.id
        if (commentInstance&&(commentInstance.author==springSecurityService.getCurrentUser())) {
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
                redirect(controller: "snippet", action: "show", id: snippet_id)
            }
            else {
                render(view: "edit", model: [commentInstance: commentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(controller: "snippet", action: "list", id: snippet_id)
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def delete = {
        def commentInstance = Comment.get(params.id)
        def snippet_id = commentInstance.snippet.id
        if (commentInstance&&(commentInstance.author==springSecurityService.getCurrentUser())) {
            try {
                commentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                redirect(controller: "snippet", action: "show", id: snippet_id)
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(uri:"/")
        }
    }
}
