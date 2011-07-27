
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <sec:ifLoggedIn><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></sec:ifLoggedIn>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <script type="text/javascript">
                (function(){
                        $.getJSON('/snippet/snippet/gistsAPI?'+encodeURI('path=/gists${id}'),function(json){
                            console.log(json);
                            for(var i=0;i<json.length;i++){
                                $("#gists").append(
                                    '<div class="dialog">'+
                                        '<a href="/snippet/snippet/show/id='+json.id+'">'+
                                            '<div class="head">'+
                                                '<p>description:&nbsp;'+json.description+'</p>'+
                                                '<p>user login:&nbsp;'+json.user.login+
                                                '&nbsp;<img width="16" height="16" alt="Gravatar" class="gravatar" src="'+json.user.avatar_url+'"/></p>'+
                                                '<p>created at:&nbsp;'+json.created_at+'</p>'+
                                            '</div>'+
                                        '</a>'+
                                    '</div>'
                                );
                            }
                        });
                })();
            </script>
            <g:render template="/layouts/snippet" model="${[snippetInstance: snippetInstance]}"/>
            <sec:ifLoggedIn>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${snippetInstance?.id}" />
                    <g:if test="${snippetInstance.author == currentUser}">
                        <span class="button">
                            <g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
                        </span>
                        <span class="button">
                            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </span>
                    </g:if>
                    <g:else>
                        <span class="button">
                            <g:actionSubmit class="fork" action="fork" value="Fork"/>
                        </span>
                    </g:else>
                </g:form>
            </div>
            </sec:ifLoggedIn>
        </div>
    </body>
</html>
