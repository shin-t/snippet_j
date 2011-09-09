<div class="nav">
    <script>
        $(function(){
            $("input:submit, input:button").button().css("font-size","8pt");
            $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
        });
    </script>
    <h1 class="float_left"><g:link uri="/">Snippet</g:link></h1>
    <div class="float_right">
        <div>
            <sec:ifLoggedIn>
                <g:link controller='user' action='show'>
                    <sec:username />
                </g:link>
                [
                <g:link controller='logout'>
                    <g:message code="logout.label" default="Log Out" />
                </g:link>
                ]
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                [
                <g:link controller='user' action='create'>
                    <g:message code="login.signup.label" default="Sign Up" />
                </g:link>
                |
                <g:link controller='login' action='auth'>
                    <g:message code="login.label" default="Log In" />
                </g:link>
                ]
            </sec:ifNotLoggedIn>
        </div>
        <div>
            <sec:ifLoggedIn>
                <span class="menuButton">
                    <g:link controller="snippet" class="create" action="create">
                        <g:message code="default.create.label" args="${[message(code: 'snippet.label', default: 'Snippet')]}" default="Create" />
                    </g:link>
                </span>
                <span class="menuButton">
                    <g:link controller="user" action="snippets">
                        <g:message code="default.list.label" args="${[message(code: 'snippet.label', default: 'Snippet')]}" default="My Snippets" />
                    </g:link>
                </span>
                <span class="menuButton">
                    <g:link controller="user" action="starred">
                        <g:message code="default.list.label" args="${[message(code: 'star.label', default: 'Star')]}" default="Starred Snippets" />
                    </g:link>
                </span>
            </sec:ifLoggedIn>
        </div>
        <div>
            <g:form url='[controller: "snippet", action: "list"]' id="searchableForm" name="searchableForm" method="get">
                <g:textField name="q" value="${params.q}"/><button><g:message code="default.search.label" default="Search" /></button>
            </g:form>
        </div>
    </div>
    <div class="clear"></div>
</div>
