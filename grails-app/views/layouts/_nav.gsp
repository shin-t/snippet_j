<div class="nav">
    <script>
        $(function(){
            $("input:submit, input:button").button().css("font-size","8pt");
            $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
        });
    </script>
    <h1 class="float_left"><g:link uri="/">Snippet</g:link></h1>
    <div class="float_right">
        <div>
            <sec:ifLoggedIn><g:link controller='user' action='show'><sec:username/></g:link>&nbsp;[<g:link controller='logout'>ログアウト</g:link>]</sec:ifLoggedIn>
            <sec:ifNotLoggedIn>[<g:link controller='user' action='create'>ユーザー登録</g:link>|<g:link controller='login' action='auth'>ログイン</g:link>]</sec:ifNotLoggedIn>
        </div>
        <div>
            <sec:ifLoggedIn><span class="menuButton"><g:link controller="snippet" class="create" action="create">作成</g:link></span></sec:ifLoggedIn>
            <sec:ifLoggedIn><span class="menuButton"><g:link controller="user" action="snippets">スニペット</g:link></span></sec:ifLoggedIn>
            <sec:ifLoggedIn><span class="menuButton"><g:link controller="user" action="starred">スター</g:link></span></sec:ifLoggedIn>
            <sec:ifLoggedIn><span class="menuButton"><g:link controller="user" action="tags">タグ</g:link></span></sec:ifLoggedIn>
        </div>
        <div>
            <g:form url='[controller: "snippet", action: "list"]' id="searchableForm" name="searchableForm" method="get">
                <button>検索</button><g:textField name="q" value="${params.q}"/>
            </g:form>
        </div>
    </div>
    <div class="clear"></div>
</div>
