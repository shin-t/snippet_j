<div id="header">
    <div>
        <sec:ifLoggedIn><sec:username/>[<g:link controller='logout'>Logout</g:link>]</sec:ifLoggedIn>
        <sec:ifNotLoggedIn>[<g:link controller='oauth' action='auth'>Login</g:link> | <g:link controller='oauth' action='create'>Signup</g:link>]</sec:ifNotLoggedIn>
        <g:form url='[controller: "snippet", action: "search"]' id="searchableForm" name="searchableForm" method="get">
            <g:textField name="q" value="${params.q}"/><input type="submit" value="Search" />
        </g:form>
    </div>
    <h1><g:link controller="snippet">Snippet</g:link></h1>
</div>
