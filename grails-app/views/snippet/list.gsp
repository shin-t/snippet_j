
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifLoggedIn><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></sec:ifLoggedIn>
        </div>
        <div class="body">
            <script type="text/javascript">
                (function(){
                        $.getJSON('/snippet/snippet/gistsAPI',function(json){
                            console.log(json);
                            for(var i=0;i<json.length;i++){
                                $("#gists").append(
                                    '<div class="dialog">'+
                                        '<a href="/snippet/?id='+json[i].id+'">'+
                                            '<div class="head">'+
                                                '<p>description:&nbsp;'+json[i].description+'</p>'+
                                                '<p>user login:&nbsp;'+json[i].user.login+
                                                '&nbsp;<img width="16" height="16" alt="Gravatar" class="gravatar" src="'+json[i].user.avatar_url+'"/></p>'+
                                                '<p>created at:&nbsp;'+json[i].created_at+'</p>'+
                                            '</div>'+
                                        '</a>'+
                                    '</div>'
                                );
                            }
                        });
                })();
            </script>
            <div id="gists"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                    <g:render template="/layouts/snippet" model="${[snippetInstance: snippetInstance]}"/>
                </g:each>
            </div>
        </div>
        <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" />
        </div>
    </body>
</html>
