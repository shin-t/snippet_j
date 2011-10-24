package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*

class StarController {

    static allowedMethods = [unstar: "POST"]

    def springSecurityService

    def index = {
        def snippetInstance
        def results = [:]
        if(params.id){
            snippetInstance = Snippet.get(params.id)
            if(snippetInstance){
                results['count'] = Star.countBySnippet(snippetInstance)
            }
            else{
                results['message'] = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            }
        }
        render (results as JSON)
    }

    @Secured(['ROLE_USER'])
    def star = {
        def starInstance
        def snippetInstance
        def results = [:]
        if(params.id){
            snippetInstance = Snippet.get(params.id)
            if(snippetInstance){
                starInstance = Star.get(springSecurityService.principal.id, snippetInstance.id)
                if(request.get){
                    results['exists'] = starInstance?true:false
                }
                else if(request.post){
                    if(!starInstance) Star.create(springSecurityService.currentUser, snippetInstance, true)
                }
            }
            else{
                results['message'] = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            }
        }
        render (results as JSON)
    }

    @Secured(['ROLE_USER'])
    def unstar = {
        def snippetInstance
        def results = [:]
        if(params.id){
            snippetInstance = Snippet.get(params.id)
            if(snippetInstance){
                Star.get(springSecurityService.principal.id, snippetInstance.id)?.delete(flush: true)
            }
            else{
                results['message'] = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            }
        }
        render (results as JSON)
    }
}
