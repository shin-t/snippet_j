<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails"/></title>
        <g:javascript library="application"/>
        <g:layoutHead />
        <r:layoutResources />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}"/>
        </div>
        <div id="header">
            <h1><g:link uri="/">Snippet</g:link></h1>
            <div id="nav">
                <ul>
                    <sec:ifLoggedIn>
                    <li><g:link controller='user' action='show'><sec:username /></g:link></li>
                    <li class="logout"><g:link controller='logout'><g:message code="logout.label" default="Log Out"/></g:link></li>
                    </sec:ifLoggedIn>
                    <sec:ifNotLoggedIn>
                    <li><g:link controller='user' action='create'><g:message code="login.signup.label" default="Sign Up"/></g:link></li>
                    <li class="login"><g:link controller='login' action='auth'><g:message code="login.label" default="Log In"/></g:link></li>
                    </sec:ifNotLoggedIn>
                </ul>
            </div>
        </div>
        <div id="container"><g:layoutBody /></div>
        <r:layoutResources />
    </body>
</html>
