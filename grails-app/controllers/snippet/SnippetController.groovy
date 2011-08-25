package snippet

import grails.plugins.springsecurity.Secured
import grails.converters.*
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.Method.*
import static groovyx.net.http.ContentType.*

class SnippetController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def scaffold = true
    def springSecurityService
    def githubService
    def tagsService
    def starService

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def parse_tags = {
        def user_id, instance
        def tags = []
        user_id = springSecurityService.getCurrentUser()?.id
        if(params.id) instance = SnippetTags.get(user_id.toLong(), params.id.toLong())
        if(instance){
            if(params.tags){
                instance.setTags([])
                if(!instance.tags){
                    instance.parseTags(params.tags)
                    tags = instance.tags
                }
            }
            else{
                instance.delete(flush: true)
            }
        }
        else {
            if(params.tags){
                instance = SnippetTags.create(User.get(user_id), Snippet.get(params.id), params.tags, true)
                tags = instance.tags
            }
        }
        render ([snippet_tags: tags] as JSON)
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def star = {
        def user_id, instance, exists
        user_id = springSecurityService.getCurrentUser().id
        if(params.id) instance = Star.get(user_id.toLong(), params.id.toLong())
        switch(request.method){
            case "GET":
                exists=instance?true:false
                break
            case "POST":
                if(instance){
                    instance.delete(flush: true)
                    exists = false
                }
                else{
                    instance = Star.create(User.get(user_id), Snippet.get(params.id), true)
                    exists = true
                }
                break
        }
        def results = Star.executeQuery('from snippet.Star as s where s.snippet.id = ?',[params.id.toLong()])
        render ([exists: exists, total: results.size()] as JSON)
    }

    def tags = {
        def snippetInstanceList
        def snippetInstanceTotal=0
        def query
        if(params.tags&&params.tags.split(' ')!=[]){
            query = """
                select distinct sp
                from Snippet sp, SnippetTags st, TagLink tl 
                where sp.id = st.snippet.id
                and st.id = tl.tagRef 
                and tl.type = 'snippetTags'
                and tl.tag.name in (:tags)
                order by sp.dateCreated desc
            """
            snippetInstanceList = SnippetTags.executeQuery(query,[tags:params.tags.split(' ')],params)
            snippetInstanceTotal = SnippetTags.executeQuery(query,[tags:params.tags.split(' ')]).size()
        }
        println params
        println snippetInstanceList
        render(view: "list", model: [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, tags: tagsService.recent_tags(), tag_ranking: tagsService.tag_ranking(), snippet_ranking: starService.starred()])
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def snippetInstanceList
        def snippetInstanceTotal
        def query
        def tags = tagsService.recent_tags()
        def tag_ranking = tagsService.tag_ranking()
        def snippet_ranking = starService.starred()

        params.max = Math.min(params.max ? params.int('max') : 10, 30)
        params.sort = params.sort?:'dateCreated'
        params.order = params.order?:'desc'

        if(params.q?.trim()){
            query = """
                from Snippet sp
                where sp.name like :q
                or sp.snippet like :q
            """
            snippetInstanceList = Snippet.executeQuery(query,[q:"%${params.q}%"],params)
            snippetInstanceTotal = Snippet.executeQuery(query,[q:"%${params.q}%"]).size()
        }
        else{
            snippetInstanceList = Snippet.list(params)
            snippetInstanceTotal = Snippet.count()
        }

        withFormat {
            html {
                [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, tags: tags, tag_ranking: tag_ranking, snippet_ranking: snippet_ranking]
            }
            json {
                def meta = params
                meta.total = snippetInstanceTotal
                render snippetInstanceList as JSON
            }
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def create = {
        def snippetInstance = new Snippet()
        snippetInstance.properties = params
        if (params.tags) snippetInstance.parseTags(params.tags)
        [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()]
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def save = {
        def snippetInstance = new Snippet()
        snippetInstance.properties = params
        snippetInstance.author = springSecurityService.getCurrentUser()
        snippetInstance.setTags()
        if(snippetInstance.save(flush: true)){
            if (params.tags) snippetInstance.parseTags(params.tags)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
            redirect(action: "show", id: snippetInstance.id)
        }
        else {
            render(view: "create", model: [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()])
        }
    }

    def show = {
        def snippetInstance = Snippet.get(params.id)
        if (!snippetInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
        else {
            def tags,stars,star
            if(springSecurityService.isLoggedIn()){
                tags = SnippetTags.get(springSecurityService.getCurrentUser().id, snippetInstance.id)
                stars = Snippet.executeQuery('from Star as s where s.snippet.id = :snippet_id',[snippet_id: snippetInstance.id])
                if(Star.get(springSecurityService.getCurrentUser().id, snippetInstance.id))star=true else star =false
            }
            [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser(), snippetTags: tags, stars: stars, star:star]
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def edit = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(springSecurityService.getCurrentUser()==snippetInstance.author)) {
            [snippetInstance: snippetInstance, currentUser: springSecurityService.getCurrentUser()]
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def update = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(snippetInstance.author==springSecurityService.getCurrentUser())) {
            if (params.version) {
                def version = params.version.toLong()
                if (snippetInstance.version > version) {
                    snippetInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'snippet.label', default: 'Snippet')] as Object[], "Another user has updated this Snippet while you were editing")
                    render(view: "edit", model: [snippetInstance: snippetInstance])
                    return
                }
            }
            snippetInstance.properties = params
            snippetInstance.setTags()
            if (!snippetInstance.hasErrors() && snippetInstance.save(flush: true)) {
                if (params.tags) snippetInstance.parseTags(params.tags)
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'snippet.label', default: 'Snippet'), snippetInstance.id])}"
                redirect(action: "show", id: snippetInstance.id)
            }
            else {
                render(view: "edit", model: [snippetInstance: snippetInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN','ROLE_USER'])
    def delete = {
        def snippetInstance = Snippet.get(params.id)
        if (snippetInstance&&(springSecurityService.getCurrentUser()==snippetInstance.author)) {
            try {
                snippetInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else{
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'snippet.label', default: 'Snippet'), params.id])}"
            redirect(action: "list")
        }
    }
}
