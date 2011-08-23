import snippet.*

class BootStrap {
    
    def springSecurityService

    def init = { servletContext ->
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        String password = springSecurityService.encodePassword('password')
        def testUser = new User(username: 'admin', enabled: true, password: password)
        testUser.save(flush: true)
        
        String password2 = springSecurityService.encodePassword('password')
        def testUser2 = new User(username: 'user', enabled: true, password: password2)
        testUser2.save(flush: true)

        UserRole.create testUser, adminRole, true
        UserRole.create testUser2, userRole, true

        assert UserRole.count() == 2
        assert Role.count() == 2
        assert User.count() == 2

        def snippets = []

        snippets << new Snippet(name:"sum.pl",snippet:"sum([],0).\nsum([N|R],S) :-\n  sum(R,S1),\n  S is N + S1.",author:User.get(1)).save(flush:true)
        snippets << new Snippet(name: "qsort.erl", snippet: "-module(quicksort).\n-export([qsort/1]).\n\nqsort([]) -> [];\nqsort([Pivot|Rest]) ->\n  qsort([ X || X <- Rest, X < Pivot]) ++ [Pivot] ++ qsort([ Y || Y <- Rest, Y >= Pivot]).", author:User.get(2)).save(flush:true)
        snippets << new Snippet(name: "append_dl.pl", snippet:"append_dl([Xs, Ys], [Ys, Zs], [Xs, Zs]).",author:User.get(1)).save(flush:true)
        snippets << new Snippet(name: "total.hs", snippet: "total :: [Int]\ntotal [] = 0\ntotal (x:xs) = x + total xs", author: User.get(1)).save(flush: true)
        snippets << new Snippet(name: "tri.v", snippet: "Variables P Q R : Prop.\nLemma tri : (P -> Q) -> (Q -> R) -> (P -> R).\nProof.\n  intros; apply H0; apply H; exact H1.\nQed.", author: User.get(2)).save(flush: true)


        assert Snippet.count() == 5

        def snippetTags = []

        snippetTags << SnippetTags.create(testUser2,snippets[1],"test,abc",true)
        snippetTags << SnippetTags.create(testUser2,snippets[3],"test,sample,abc",true)
        snippetTags << SnippetTags.create(testUser2,snippets[4],"test,def",true)
        snippetTags << SnippetTags.create(testUser,snippets[0],"admin,sample,abc",true)
        snippetTags << SnippetTags.create(testUser,snippets[2],"admin,sample",true)
        snippetTags << SnippetTags.create(testUser,snippets[3],"admin",true)

        assert SnippetTags.count() == 6

        def comments = []

        comments << new Comment(snippet: snippets[4],author:testUser,comment:"admin\nae\ntest\na").save(flush: true)
        comments << new Comment(snippet: snippets[4],author:testUser2,comment:"ab\ncde\n12345").save(flush: true)

        assert Comment.count() == 2

        Star.create(testUser,snippets[2],true)
        Star.create(testUser,snippets[4],true)
        Star.create(testUser2,snippets[1],true)
        Star.create(testUser2,snippets[3],true)
        Star.create(testUser2,snippets[4],true)

        assert Star.count() == 5

    }
}
