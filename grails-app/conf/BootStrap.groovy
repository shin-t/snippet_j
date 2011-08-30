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
        UserRole.create testUser, userRole, true
        UserRole.create testUser2, userRole, true

        assert UserRole.count() == 3
        assert Role.count() == 2
        assert User.count() == 2

        def snippets = []

        snippets << new Snippet(
            name:"sum.pl",
            description:"sum",
            snippet:"sum([],0).\nsum([N|R],S) :-\n  sum(R,S1),\n  S is N + S1.",
            author:User.get(1)
            ).save(flush:true)
        snippets << new Snippet(
            name: "qsort.erl", 
            description:"quicksort",
            snippet: "-module(quicksort).\n-export([qsort/1]).\n\nqsort([]) -> [];\nqsort([Pivot|Rest]) ->\n  qsort([ X || X <- Rest, X < Pivot]) ++ [Pivot] ++ qsort([ Y || Y <- Rest, Y >= Pivot]).",
            author:User.get(2)
            ).save(flush:true)
        snippets << new Snippet(
            name: "append_dl.pl",
            description:"append diff lists",
            snippet:"append_dl([Xs, Ys], [Ys, Zs], [Xs, Zs]).",
            author:User.get(1)
            ).save(flush:true)
        snippets << new Snippet(
            name: "total.hs",
            description:"total",
            snippet: "total :: [Int]\ntotal [] = 0\ntotal (x:xs) = x + total xs",
            author: User.get(1)
            ).save(flush: true)
        snippets << new Snippet(
            name: "tri.v",
            description:"tri lemma",
            snippet: "Variables P Q R : Prop.\nLemma tri : (P -> Q) -> (Q -> R) -> (P -> R).\nProof.\n  intros; apply H0; apply H; exact H1.\nQed.",
            author: User.get(2)
            ).save(flush: true)

        assert Snippet.count() == 5

        def snippetTags = []

        snippets[0].parseTags("snippet prolog sum"," ")
        snippets[1].parseTags("snippet erlang qsort"," ")
        snippets[2].parseTags("snippet prolog diff lists append"," ")
        snippets[3].parseTags("snippet haskell total"," ")
        snippets[4].parseTags("snippet user coq tri"," ")

        def comments = []

        comments << new Comment(snippet: snippets[4],author:testUser,comment:"coq").save(flush: true)
        comments << new Comment(snippet: snippets[4],author:testUser2,comment:"syllogism").save(flush: true)

        assert Comment.count() == 2

        Star.create(testUser,snippets[2],true)
        Star.create(testUser,snippets[4],true)
        Star.create(testUser2,snippets[1],true)
        Star.create(testUser2,snippets[3],true)
        Star.create(testUser2,snippets[4],true)

        assert Star.count() == 5

    }
}
