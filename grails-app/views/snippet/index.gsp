<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}"/>
        <r:require modules="jquery-ui, common, snippet"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <g:if test="${actionName ==~ /list|tags|users/}">
            <g:include controller="snippet" action="create" params="[status:params.status]"/>
            <sec:ifLoggedIn>
            <div id="list_filter">
                <div><g:link controller='snippet' action='list' params="[status: params.status]"><g:message code="list.filter.all.label"/></g:link></div>
                <div><g:link controller='snippet' action='tags' params="[status: params.status]"><g:message code="tag.label" default="Tags"/></g:link></div>
                <div><g:link controller='snippet' action='users' params="[status: params.status]"><g:message code="user.label" default="Users"/></g:link></div>
            </div>
            </sec:ifLoggedIn>
            </g:if>
            <div id="lists"><g:render template="list"/></div>
        </div>
        <div id="sidebar">
            <sec:ifLoggedIn>
            <g:include controller="tag" action="following" params="[status:params.status]"/>
            </sec:ifLoggedIn>
            <g:include controller="tag" action="recent" params="[status:params.status]"/>
        </div>
    </body>
</html>
