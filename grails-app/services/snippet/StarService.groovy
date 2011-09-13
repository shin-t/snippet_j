package snippet

class StarService {

    static transactional = true

    def starred() {
        def query = """
            select st.snippet.id, count(st.snippet.id)
            from Star st
            group by st.snippet.id
            order by size(st.snippet.stars) desc
        """
        def results = Snippet.executeQuery(query,[],[max:10])
        results
    }
}
