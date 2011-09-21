class UrlMappings {

    static mappings = {
        "/login"(controller:"login", action:"auth")
        "/logout"(controller:"logout", action:"index")
        "/signup"(controller:"user", action:"create")
        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:'/index')
        "500"(view:'/error')
    }
}
