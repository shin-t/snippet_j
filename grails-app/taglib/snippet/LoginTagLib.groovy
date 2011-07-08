package snippet

class LoginTagLib {
    def loginControl = {
        if(session.user){
            out << "${session.user.name} "
            out << """[${link(action:"logout",  controller:"user"){"Logout"}}]"""
        }
        else{
            out << """[${link(action:"login", controller:"user"){"Login"}}]"""
        }
    }
}
