<div class="nav">
    <h1 class="float_left"><g:link uri="/">Snippet</g:link></h1>
    <div class="float_right">
        <div>
            <sec:ifLoggedIn>
            <g:link controller='user' action='show'><sec:username /></g:link>
            [
            <g:link controller='logout'><g:message code="logout.label" default="Log Out" /></g:link>
            ]
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
            [
            <g:link controller='user' action='create'><g:message code="login.signup.label" default="Sign Up" /></g:link>
            |
            <g:link controller='login' action='auth'><g:message code="login.label" default="Log In" /></g:link>
            ]
            </sec:ifNotLoggedIn>
        </div>
    </div>
    <div class="clear"></div>
</div>
