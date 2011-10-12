class UrlMappings {

    static mappings = {
        '/login'(controller:'login', action:'auth')
        '/logout'(controller:'logout', action:'index')
        '/signup'(controller:'user', action:'create')
        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }

        '/'(controller:'snippet', action:'index')
        '500'(view:'/error')
    }
}
