<div class="nav">
    <div class="float_left">
        <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        <sec:ifLoggedIn><span class="menuButton"><g:link controller="snippet" class="create" action="create">New Snippet</g:link></span></sec:ifLoggedIn>
    </div>
    <div class="float_right">
        <sec:ifLoggedIn><g:link controller='user' action='show'><sec:username/></g:link>&nbsp;[<g:link controller='logout'>Logout</g:link>]</sec:ifLoggedIn>
        <sec:ifNotLoggedIn>[<g:link controller='login' action='auth'>Login</g:link>|<g:link controller='user' action='create'>Singup</g:link>]</sec:ifNotLoggedIn>
    </div>
    <div class="float_right">
        <g:form url='[controller: "snippet", action: "list"]' id="searchableForm" name="searchableForm" method="get">
            <g:textField name="q" value="${params.q}"/><input type="submit" value="Search" />
        </g:form>
    </div>
    <div class="clear"></div>
</div>
