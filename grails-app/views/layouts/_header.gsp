<div id="loginHeader">
    <sec:ifLoggedIn>
        <sec:username/> [<g:link controller='logout'>Logout</g:link>]
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
        [<g:link controller='login' action='auth'>Login</g:link> | <g:link controller='user' action='create'>Signup</g:link>]
    </sec:ifNotLoggedIn>
</div>
<g:render template="/layouts/search" />
<div id="header">
	<p><g:link class="header-main" controller="snippet">Snippet</g:link></p>

</div>
