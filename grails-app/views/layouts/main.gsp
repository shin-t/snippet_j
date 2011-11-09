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
        <div class="topbar">
            <div class="topbar-inner">
                <div class="container">
                    <h3><a><g:link controller='snippet'>Snippet</g:link></a></h3>
                    <ul class="nav">
                        <g:if test="${params.status}">
                        <li><g:link controller='snippet' action='list' params="[status: params.status]"><g:message code="snippet.${params.status}.label" default="Snippet"/></g:link></li>
                        <sec:ifLoggedIn>
                        <li><g:link controller='snippet' action='tags' params="[status: params.status]"><g:message code="following.tags.label" default="Tags"/></g:link></li>
                        <li><g:link controller='snippet' action='users' params="[status: params.status]"><g:message code="following.users.label" default="Users"/></g:link></li>
                        </sec:ifLoggedIn>
                        </g:if>
                        <g:else>
                        <li><g:link controller='snippet' action='list' params="[status: 'snippet']"><g:message code="snippet.snippet.label" default="Snippet"/></g:link></li>
                        <li><g:link controller='snippet' action='list' params="[status: 'question']"><g:message code="snippet.question.label" default="Question"/></g:link></li>
                        <li><g:link controller='snippet' action='list' params="[status: 'problem']"><g:message code="snippet.problem.label" default="Problem"/></g:link></li>
                        </g:else>
                    </ul>
                    <ul class="nav secondary-nav">
                        <sec:ifLoggedIn>
                        <g:if test="${params.status}">
                        <li><g:link controller='user' action='show' params="[status:params.status, username:sec.loggedInUserInfo(field:'username')]"><sec:username /></g:link></li>
                        </g:if>
                        <li><g:link controller='user' action='edit'><g:message code="user.settings.label" default="Settings"/></g:link></li>
                        <li><g:link controller='logout'><g:message code="logout.label" default="Log Out"/></g:link></li>
                        </sec:ifLoggedIn><sec:ifNotLoggedIn>
                        <li><g:link controller='user' action='create'><g:message code="login.signup.label" default="Sign Up"/></g:link></li>
                        <li><g:link controller='login' action='auth'><g:message code="login.label" default="Log In"/></g:link></li>
                        </sec:ifNotLoggedIn>
                    </li>
                </div>
            </div>
        </div>
        <div class="container-fluid"><g:layoutBody /></div>
        <r:layoutResources />
    </body>
</html>
