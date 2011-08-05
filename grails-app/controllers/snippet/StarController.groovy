package snippet

class StarController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [starInstanceList: Star.list(params), starInstanceTotal: Star.count()]
    }

    def create = {
        def starInstance = new Star()
        starInstance.properties = params
        return [starInstance: starInstance]
    }

    def save = {
        def starInstance = new Star(params)
        if (starInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'star.label', default: 'Star'), starInstance.id])}"
            redirect(action: "show", id: starInstance.id)
        }
        else {
            render(view: "create", model: [starInstance: starInstance])
        }
    }

    def show = {
        def starInstance = Star.get(params.id)
        if (!starInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'star.label', default: 'Star'), params.id])}"
            redirect(action: "list")
        }
        else {
            [starInstance: starInstance]
        }
    }

    def edit = {
        def starInstance = Star.get(params.id)
        if (!starInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'star.label', default: 'Star'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [starInstance: starInstance]
        }
    }

    def update = {
        def starInstance = Star.get(params.id)
        if (starInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (starInstance.version > version) {
                    
                    starInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'star.label', default: 'Star')] as Object[], "Another user has updated this Star while you were editing")
                    render(view: "edit", model: [starInstance: starInstance])
                    return
                }
            }
            starInstance.properties = params
            if (!starInstance.hasErrors() && starInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'star.label', default: 'Star'), starInstance.id])}"
                redirect(action: "show", id: starInstance.id)
            }
            else {
                render(view: "edit", model: [starInstance: starInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'star.label', default: 'Star'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def starInstance = Star.get(params.id)
        if (starInstance) {
            try {
                starInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'star.label', default: 'Star'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'star.label', default: 'Star'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'star.label', default: 'Star'), params.id])}"
            redirect(action: "list")
        }
    }
    
}
