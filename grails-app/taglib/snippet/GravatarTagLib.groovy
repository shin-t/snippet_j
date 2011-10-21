package snippet

class GravatarTagLib {
    static namespace = "gravatar"
    def img = { attrs, body ->
        out << "<a href=\""
        out << grailsApplication.config.gravatar.profile_request.url
        out << attrs.hash
        out << "\"><img src=\""
        out << grailsApplication.config.gravatar.image_request.url
        out << attrs.hash
        out << grailsApplication.config.gravatar.image_request.params
        out << attrs.size
        out << "\" alt=\"Gravatar\" /></a>"
    }
}
