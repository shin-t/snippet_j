<div class="nav">
    <g:javascript>
        $(function(){
            $("input:submit, input:button").button().css("font-size","8pt");
            $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
        });
    </g:javascript>
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
        <div>
            <span class="menuButton"><g:link controller="snippet" action="list"><g:message code="snippet.label" default="Snippets" /></g:link></span>
            <span class="menuButton"><g:link controller="problem" action="list"><g:message code="problem.label" default="Problems" /></g:link></span>
            <span class="menuButton"><g:link controller="question" action="list"><g:message code="question.label" default="Questions" /></g:link></span>
        </div>
    </div>
    <div class="clear"></div>
</div>
