import snippet.User

class BootStrap {
    def init = { servletContext ->
    	new User(login:"admin", password:"password", role:"admin").save()
    }
  	def destroy = {
    }
}
