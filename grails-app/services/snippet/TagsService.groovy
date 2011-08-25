package snippet

class TagsService {

    static transactional = true

    def recent_tags() {
        def query = """
            select tg.name, count(tl)
            from TagLink tl, Tag tg, Snippet sp
            where tl.type = 'snippetTags'
            and tl.tag.id = tg.id
            and tl.tagRef = sp.id
            and sp.lastUpdated >= :date
            group by tg.name
            order by count(tl) desc, tg.name asc
        """
        def date = new Date() - 7
        Snippet.executeQuery(query,[date:date],[max:10])
    }
    def tag_ranking() {
        def query = """
            select tg.name, count(tl)
            from TagLink tl, Tag tg, Snippet sp
            where tl.type = 'snippetTags'
            and tl.tag.id = tg.id
            and tl.tagRef = sp.id
            group by tg.name
            order by count(tl) desc, tg.name asc
        """
        Snippet.executeQuery(query,[],[max:10])
    }
}
