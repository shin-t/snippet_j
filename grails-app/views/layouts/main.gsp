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
            <h1><g:link controller="snippet" action="index">Snippet</g:link></h1>
            <div id="nav">
                <sec:ifLoggedIn>
                <div><g:link controller='user' action='index' params="[username: sec.loggedInUserInfo(field:'username')]"><sec:username /></g:link></div>
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
