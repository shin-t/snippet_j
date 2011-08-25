package snippet

class StarService {

    static transactional = true

    def starred() {
        def query = """
            select sp.id, sp.name, count(st)
            from Snippet sp, Star st
            where sp = st.snippet
            group by sp.id, sp.name
            order by size(sp.stars) desc
        """
        def results = Snippet.executeQuery(query,[],[max:10])
        println results
        results
    }
}
