class UrlMappings {

    static mappings = {
        '/login'(controller:'login', action:'auth')
        '/logout'(controller:'logout', action:'index')
        '/signup'(controller:'user', action:'create')
        '/registration'(controller:'user',action:'save')
        '/settings'(controller:'user',action:'edit')
        '/user/'(controller:'user',action:'index')
        "/user/$username"(controller:'user', action:'index')
        "/user/$username/$action" {
            controller = 'user'
            constraints {
                action(matches:/follow_check|follow|unfollow/)
            }
        }
        '/tag/'(controller:'tag', action:'index')
        "/tag/$tag"(controller:'tag', action:'index')
        "/tag/$tag/$action" {
            controller = 'tag'
            constraints {
                action(matches:/follow_check|follow|unfollow/)
            }
        }
        "/show/$id"(controller:'snippet', action:'show')
        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }

        '/'(controller:'snippet', action:'index')
        '500'(view:'/error')
    }
}
