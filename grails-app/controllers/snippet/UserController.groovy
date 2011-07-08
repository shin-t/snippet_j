package snippet

class UserController {
    
    def beforeInterceptor = [action:this.&auth, except:["login", "authenticate", "create", "save"]]

    def scaffold = User

    def auth() {
        if(!session.user){
            redirect(action:"login")
            return false
        }
    }

    def login = {}

    def authenticate = {
        def user = User.findByLoginAndPassword(params.login, params.password)
        if(user){
            session.user = user
            flash.message = "${user.name}"
            redirect(controller:"snippet", action:"list")
        }
        else{
            flash.message = "Please try again."
            redirect(action:"login")
        }
    }
    
    def logout = {
        flash.message = "logout"
        session.user = null
        redirect(controller:"snippet", action:"list")
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
    	if (session.user.role=="admin"){
	        params.max = Math.min(params.max ? params.int('max') : 10, 100)
    	    [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    	}
    	else{
    		redirect(action: "show")
    	}
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance]
    }

    def save = {
        def userInstance = new User(params)
        
        if (!(session?.user?.role=="admin")&&userInstance.role=="admin"){
            render(view: "create", model: [userInstance: userInstance])
            return
        }
        
        if (userInstance.save(flush: true)) {
        	flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
        	redirect(action: "show", id: userInstance.id)
        }
        else {
        	render(view: "create", model: [userInstance: userInstance])
        }
    }

    def show = {
        def userInstance = User.get(params.id)
        
        if(session.user.role=="author"&&!(session.user.id==params.id)){
        	redirect(action:list)
        	return
        }
        
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userInstance: userInstance]
        }
    }

    def edit = {
        def userInstance = User.get(params.id)

        if(session.user.role=="author"&&!(session.user.id==params.id)){
        	redirect(action:list)
        	return
        }

        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userInstance: userInstance]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
        
        if(session.user.role=="author"&&!(session.user.id==params.id)){
        	redirect(action:list)
        	return
        }
        
        if (userInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {
                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance])
                    return
                }
            }
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
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

    def delete = {
        def userInstance = User.get(params.id)

        if(session.user.role=="author"&&!(session.user.id==params.id)){
        	redirect(action:list)
        	return
        }
        
        if (userInstance) {
            try {
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }
    
}
