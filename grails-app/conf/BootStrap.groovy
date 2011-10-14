import auth.*
import snippet.*

class BootStrap {
    
    def springSecurityService

    def init = { servletContext ->

        if(Role.count() == 0){
            def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
            def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
            assert Role.count() == 2
        }

        if(User.count() == 0){
            def user = new User(username: 'user', password: springSecurityService.encodePassword('pass'), enabled: true).save()
            def admin = new User(username: 'admin', password: springSecurityService.encodePassword('pass'), enabled: true).save()
            UserRole.create user, Role.findByAuthority('ROLE_USER'), true
            UserRole.create admin, Role.findByAuthority('ROLE_USER'), true
            assert User.count() == 2
            if(Snippet.count() == 0){
                def snippets = []
                snippets << new Snippet(text:"sum",file:"sum([],0).\nsum([N|R],S) :-\n  sum(R,S1),\n  S is N + S1.",user:user).save(flush:true)
                snippets[0].parseTags("prolog sum math program logic"," ")
                snippets << new Snippet(text:"quicksort",file: "-module(quicksort).\n-export([qsort/1]).\n\nqsort([]) -> [];\nqsort([Pivot|Rest]) ->\n  qsort([ X || X <- Rest, X < Pivot]) ++ [Pivot] ++ qsort([ Y || Y <- Rest, Y >= Pivot]).",user:admin).save(flush:true)
                snippets[1].parseTags("erlang qsort quick_sort sort math program"," ")
                snippets << new Snippet(text:"append diff_lists", file:"append_dl([Xs, Ys], [Ys, Zs], [Xs, Zs]).",user:user).save(flush:true)
                snippets[2].parseTags("prolog append diff_list diff list math program logic"," ")
                snippets << new Snippet(text:"total",file: "total :: [Int]\ntotal [] = 0\ntotal (x:xs) = x + total xs",user:admin).save(flush:true)
                snippets[3].parseTags("haskell total math program list"," ")
                snippets << new Snippet(text:"tri lemma",file: "Variables P Q R : Prop.\nLemma tri : (P -> Q) -> (Q -> R) -> (P -> R).\nProof.\n  intros; apply H0; apply H; exact H1.\nQed.",user:user).save(flush:true)
                snippets[4].parseTags("coq tri lemma tri_lemma program logic"," ")
                snippets << new Snippet(user:admin,text:"Merge sort",file:"in:84376521\n1. 8437 6521\n2. 84 37 65 21\n3. 48 37 56 12\n4. 3478 1256\n5. 12345678\nout:12345678\n").save(flush:true)
                snippets[5].parseTags("merge merge_sort sort math algorithm program problem"," ")
                snippets << new Snippet(user:user,text:"java",file:"void merge(int[] a1,int[] a2,int[] a){\n\tint i=0,j=0;\n\twhile(i<a1.length || j<a2.length){\n\t\tif(j>=a2.length || (i<a1.length && a1[i]<a2[j])){\n\t\t\ta[i+j]=a1[i];\n\t\t\ti++;\n\t\t}\n\t\telse{\n\t\t\ta[i+j]=a2[j];\n\t\t\tj++;\n\t\t}\n\t}\n}\n\nvoid mergeSort(int[] a){\n\tif(a.length>1){\n\t\tint m=a.length/2;\n\t\tint n=a.length-m;\n\t\tint[] a1=new int[m];\n\t\tint[] a2=new int[n];\n\t\tfor(int i=0;i<m;i++) a1[i]=a[i];\n\t\tfor(int i=0;i<n;i++) a2[i]=a[m+i];\n\t\tmergeSort(a1);\n\t\tmergeSort(a2);\n\t\tmerge(a1,a2,a);\n\t}\n}\n")
                snippets[6].parent = Snippet.get(6)
                snippets[6].root = Snippet.get(6)
                snippets[6].save(flush:true)
                snippets[6].parseTags("merge merge_sort sort math algorithm program problem java"," ")
                assert Snippet.count() == 7
            }
        }
    }
}
