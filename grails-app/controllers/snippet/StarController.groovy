package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*

class StarController {

    static allowedMethods = [save: "POST", delete: "POST"]

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
    def check = {
        def starInstance
        def snippetInstance
        def results = [:]
        if(params.id){
            snippetInstance = Snippet.get(params.id)
            if(snippetInstance){
                starInstance = Star.get(springSecurityService.principal.id, snippetInstance.id)
                results['exists'] = starInstance?true:false
            }
            else{
                results['message'] = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            }
        }
        render (results as JSON)
    }

    @Secured(['ROLE_USER'])
    def save = {
        def snippetInstance
        def results = [:]
        if(params.id){
            snippetInstance = Snippet.get(params.id)
            if(snippetInstance){
                if(!Star.get(springSecurityService.principal.id, snippetInstance.id)) Star.create(userInstance, snippetInstance, true)
            }
            else{
                results['message'] = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            }
        }
        render (results as JSON)
    }

    @Secured(['ROLE_USER'])
    def delete = {
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
