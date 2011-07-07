package snippet

class LoginTagLib {
    def loginControl = {
        if(session.user){
            out << "${session.user.name} "
            out << """[${link(acton:"logout",  controller:"user"){"Logout"}}]"""
        }
        else{
            out << """[${link(action:"login", controller:"user"){"Login"}}]"""
        }
    }
}
