package snippet

class TagsService {

    static transactional = true

    def recent_tags() {
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
        Snippet.executeQuery(query,[date:date],[max:10])
    }
    def tag_ranking() {
        def query = """
            select t.name, count(tl)
            from TagLink tl, Tag t, Snippet s
            where tl.type = 'snippet'
            and tl.tag.id = t.id
            and tl.tagRef = s.id
            group by t.name
            order by count(tl) desc, t.name asc
        """
        Snippet.executeQuery(query,[],[max:10])
    }
}
