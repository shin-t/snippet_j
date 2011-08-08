<div id="header">
    <div>
        <sec:ifLoggedIn><sec:username/>[<g:link controller='logout'>Logout</g:link>]</sec:ifLoggedIn>
        <sec:ifNotLoggedIn>[<g:link controller='login' action='auth'>Login</g:link>|<g:link controller='user' action='create'>Singup</g:link>]</sec:ifNotLoggedIn>
        <g:form url='[controller: "snippet", action: "list"]' id="searchableForm" name="searchableForm" method="get">
            <g:textField name="q" value="${params.q}"/><input type="submit" value="Search" />
        </g:form>
        <sec:ifLoggedIn>
            <g:form url='[controller: "snippet", action: "list"]' id="searchableForm" name="searchableForm" method="get">
                <g:textField name="tags" value="${params.tags}"/><input type="submit" value="Search(Tags)" />
            </g:form>
        </sec:ifLoggedIn>
    </div>
    <h1><g:link controller="snippet">Snippet</g:link></h1>
</div>
