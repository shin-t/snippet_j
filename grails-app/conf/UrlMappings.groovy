class UrlMappings {

    static mappings = {
        '/login'(controller:'login', action:'auth')
        '/logout'(controller:'logout', action:'index')
        '/signup'(controller:'user', action:'create')
        '/registration'(controller:'user',action:'save')
        '/settings'(controller:'user',action:'edit')

        /* snippet */
        "/show/$id"(controller:'snippet', action:'show')
        "/$status" {
            controller = 'snippet'
            action = 'list'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        "/$status/tags" {
            controller = 'snippet'
            action = 'tags'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        "/$status/tag/$tag" {
            controller = 'snippet'
            action = 'tag'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        "/$status/users" {
            controller = 'snippet'
            action = 'users'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        "/$status/user/$username" {
            controller = 'snippet'
            action = 'user'
            constraints {
                status matches:/snippet|question|problem/
            }
        }

        /* user */
        "/user/$username?" {
            controller = 'user'
            action = 'index'
        }
        "/user/$username/$action" {
            controller = 'user'
            constraints {
                action(matches:/follow_check|follow|unfollow/)
            }
        }

        /* tag */
        '/tag' (controller:'tag', action:'index')
        "/tag/$tag" {
            controller = 'tag'
            action = 'show'
        }
        "/tag/$tag/$action" {
            controller = 'tag'
            constraints {
                action(matches:/follow_check|follow|unfollow/)
            }
        }

        /* default */
        "/$controller/$action?/$id?"{
            constraints {
                // apply constraints here
            }
        }

        '/'(view:'/index')
        '500'(view:'/error')
    }
}
