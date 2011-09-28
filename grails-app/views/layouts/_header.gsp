<div id="header">
    <h1><g:link uri="/">Snippet</g:link></h1>
    <div class="nav">
        <ul>
            <sec:ifLoggedIn>
            <li><g:link controller='user' action='show'><sec:username /></g:link></li>
            <li class="logout"><g:link controller='logout'> <g:message code="logout.label" default="Log Out" /></g:link></li>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
            <li><g:link controller='user' action='create'><g:message code="login.signup.label" default="Sign Up" /></g:link></li>
            <li class="login"><g:link controller='login' action='auth'><g:message code="login.label" default="Log In" /></g:link></li>
            </sec:ifNotLoggedIn>
        </ul>
    </div>
</div>
