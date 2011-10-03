package snippet

class TagController {

    def index = {
        params.max = Math.min(params.max ? params.int('max') : 10, 30)
        def snippetInstanceList
        def snippetInstanceTotal
        def tags = []
        if(params.tag){
            params.sort = params.sort?:'dateCreated'
            params.order = params.order?:'desc'
            snippetInstanceList = Snippet.findAllByTag(params.tag, params)
            snippetInstanceTotal = Snippet.countByTag(params.tag)
            [snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, tags: tags]
        }
        else{
            def query
            query = """
                select tl.tag.name, count(tl)
                from TagLink as tl
                where tl.type = 'snippet'
                group by tl.tag.name
                order by count(tl) desc, tl.tag.name asc
            """
            [tags:Snippet.executeQuery(query,[],params)]
        }
    }

    def hot_tags = {
        def query = """
            select t.name, count(tl)
            from TagLink tl, Tag t, Snippet s
            where tl.type = 'snippet'
            and tl.tag.id = t.id
            and tl.tagRef = s.id
            and s.lastUpdated >= :date
            group by t.name
            order by count(tl) desc, t.name asc
        """
        def date = new Date() - 7
        render template: 'tags', model: [tags:Snippet.executeQuery(query,[date:date],[max:10])]
    }
}
