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
        environments {
            development {
                if(User.count() == 0){
                    def user = new User(username: 'user', password: springSecurityService.encodePassword('pass'), email: 'MyEmailAddress@example.com ', enabled: true)
                    def admin = new User(username: 'admin', password: springSecurityService.encodePassword('pass'), email: 'Abc.123@example.com', enabled: true)
                    user.gravatar_hash = user.email.trim().toLowerCase().encodeAsMD5()
                    user.password2 = user.password
                    user.email2 = user.email
                    user.save()
                    admin.gravatar_hash = admin.email.trim().toLowerCase().encodeAsMD5()
                    admin.password2 = admin.password
                    admin.email2 = admin.email
                    admin.save()
                    UserRole.create user, Role.findByAuthority('ROLE_USER'), true
                    UserRole.create admin, Role.findByAuthority('ROLE_USER'), true
                    assert User.count() == 2
                    if(Snippet.count() == 0){
                        def snippet

                        snippet = new Snippet(user:user)
                        snippet.text = 'sum'
                        snippet.file = 'sum([],0).\nsum([N|R],S) :-\n  sum(R,S1),\n  S is N + S1.'
                        snippet.save(flush:true)
                        snippet.parseTags('prolog sum math program logic',' ')

                        snippet = new Snippet(user:admin)
                        snippet.text = 'quicksort'
                        snippet.file = '-module(quicksort).\n-export([qsort/1]).\n\nqsort([]) -> [];\nqsort([Pivot|Rest]) ->\n  qsort([ X || X <- Rest, X < Pivot]) ++ [Pivot] ++ qsort([ Y || Y <- Rest, Y >= Pivot]).'
                        snippet.save(flush:true)
                        snippet.parseTags('erlang qsort quick_sort sort math program',' ')

                        snippet = new Snippet(user:user)
                        snippet.text = 'append diff_lists'
                        snippet.file = 'append_dl([Xs, Ys], [Ys, Zs], [Xs, Zs]).'
                        snippet.save(flush:true)
                        snippet.parseTags('prolog append diff_list diff list math program logic',' ')

                        snippet = new Snippet(user:admin)
                        snippet.text = 'total'
                        snippet.file = 'total :: [Int]\ntotal [] = 0\ntotal (x:xs) = x + total xs'
                        snippet.save(flush:true)
                        snippet.parseTags('haskell total math program list',' ')

                        snippet = new Snippet(user:user)
                        snippet.text = 'tri lemma'
                        snippet.file = 'Variables P Q R : Prop.\nLemma tri : (P -> Q) -> (Q -> R) -> (P -> R).\nProof.\n  intros; apply H0; apply H; exact H1.\nQed.'
                        snippet.save(flush:true)
                        snippet.parseTags('coq tri lemma tri_lemma program logic',' ')

                        snippet = new Snippet(user:admin)
                        snippet.text = 'Merge sort'
                        snippet.file = 'in:84376521\n1. 8437 6521\n2. 84 37 65 21\n3. 48 37 56 12\n4. 3478 1256\n5. 12345678\nout:12345678\n'
                        snippet.status = 'problem'
                        snippet.save(flush:true)
                        snippet.parseTags('merge merge_sort sort math algorithm program problem',' ')

                        def snippet2 = new Snippet(user:user)
                        snippet2.text = 'java'
                        snippet2.file = 'void merge(int[] a1,int[] a2,int[] a){\n\tint i=0,j=0;\n\twhile(i<a1.length || j<a2.length){\n\t\tif(j>=a2.length || (i<a1.length && a1[i]<a2[j])){\n\t\t\ta[i+j]=a1[i];\n\t\t\ti++;\n\t\t}\n\t\telse{\n\t\t\ta[i+j]=a2[j];\n\t\t\tj++;\n\t\t}\n\t}\n}\n\nvoid mergeSort(int[] a){\n\tif(a.length>1){\n\t\tint m=a.length/2;\n\t\tint n=a.length-m;\n\t\tint[] a1=new int[m];\n\t\tint[] a2=new int[n];\n\t\tfor(int i=0;i<m;i++) a1[i]=a[i];\n\t\tfor(int i=0;i<n;i++) a2[i]=a[m+i];\n\t\tmergeSort(a1);\n\t\tmergeSort(a2);\n\t\tmerge(a1,a2,a);\n\t}\n}\n'
                        snippet2.parent = snippet
                        snippet2.root = snippet
                        snippet2.status = snippet.status
                        snippet2.save(flush:true)
                        snippet2.parseTags('merge merge_sort sort math algorithm program problem java',' ')

                        assert Snippet.count() == 7
                    }
                }
            }
        }
    }
}
