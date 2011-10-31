<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails"/></title>
        <g:javascript library="application"/>
        <g:layoutHead />
        <r:layoutResources />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;"><img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}"/></div>
        <div id="header">
            <h1><g:link url="[controller:null]">Snippet</g:link></h1>
            <g:if test="${params.status}">
            <ul id="nav-list">
                <sec:ifLoggedIn>
                <li><g:link controller='snippet' action='tags' params="[status: params.status]"><g:message code="tag.label" default="Tags"/></g:link></li>
                <li><g:link controller='snippet' action='users' params="[status: params.status]"><g:message code="user.label" default="Users"/></g:link></li>
                </sec:ifLoggedIn>
                <li><g:link controller='snippet' action='list' params="[status: params.status]"><g:message code="snippet.${params.status}.label" default="Snippet"/></g:link></li>
            </ul>
            </g:if>
            <div id="nav">
                <sec:ifLoggedIn>
                <div><g:link controller='user' action='show' params="[username: sec.loggedInUserInfo(field:'username')]"><sec:username /></g:link></div>
                <div><g:link controller='user' action='edit'><g:message code="user.settings.label" default="Settings"/></g:link></div>
                <div><g:link controller='logout'><g:message code="logout.label" default="Log Out"/></g:link></div>
                </sec:ifLoggedIn><sec:ifNotLoggedIn>
                <div><g:link controller='user' action='create'><g:message code="login.signup.label" default="Sign Up"/></g:link></div>
                <div><g:link controller='login' action='auth'><g:message code="login.label" default="Log In"/></g:link></div>
                </sec:ifNotLoggedIn>
            </div>
        </div>
        <div id="container"><g:layoutBody /></div>
        <r:layoutResources />
    </body>
</html>
