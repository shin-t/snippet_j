class UrlMappings {

    static mappings = {
        '/login'(controller:'login', action:'auth')
        '/logout'(controller:'logout', action:'index')
        '/signup'(controller:'user', action:'create')
        '/registration'(controller:'user',action:'save')
        '/settings'(controller:'user',action:'edit')

        /* snippet */
        "/$status" {
            controller = 'snippet'
            action = 'list'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        "/show/$id"(controller:'snippet', action:'show')
        "/$status/tags" {
            controller = 'snippet'
            action = 'tags'
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
        "/$status/tag" {
            controller = 'tag'
            action = 'index'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        "/$status/tag/$tag" {
            controller = 'tag'
            action = 'show'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        '/tag/following' {
            controller = 'tag'
            action = 'following'
        }
        "/tag/$tag/$action" {
            controller = 'tag'
            constraints {
                action matches:/follow_check|follow|unfollow/
            }
        }

        /* user */
        '/user'(controller:'user', action='index')
        "/user/$username" {
            controller = 'user'
            action = 'show'
        }
        "/user/$username/$status" {
            controller = 'user'
            action = 'show'
            constraints {
                status matches:/snippet|question|problem/
            }
        }
        "/user/$username/$action" {
            controller = 'user'
            constraints {
                action matches:/follow_check|follow|unfollow/
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
