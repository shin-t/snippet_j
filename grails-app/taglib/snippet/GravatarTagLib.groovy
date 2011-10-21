package snippet

import org.codehaus.groovy.grails.commons.ConfigurationHolder as GrailsConfig

class GravatarTagLib {
    static namespace = "gravatar"
    def img = { attrs, body ->
        out << "<a href=\""
        out << "${GrailsConfig.config.gravatar.profile_request.url}"
        out << "${attrs.hash}"
        out << "\"><img src=\""
        out << "${GrailsConfig.config.gravatar.image_request.url}"
        out << "${attrs.hash}"
        out << "${GrailsConfig.config.gravatar.image_request.params}"
        out << "${attrs.size}"
        out << "\" alt=\"Gravatar\" /></a>"
    }
}
