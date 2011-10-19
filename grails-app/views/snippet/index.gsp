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
            <div class="message">${flash.message}</div>
            </g:if>
            <g:include controller="snippet" action="create"/>
            <sec:ifLoggedIn>
            <div id="list_filter">
                <div><g:remoteLink controller='snippet' action='list' update='lists' onComplete='reset_autopager()'><g:message code="list.filter.all.label"/></g:remoteLink></div>
                <div><g:remoteLink controller='snippet' action='user' update='lists' onComplete='reset_autopager()'><g:message code="user.label"/></g:remoteLink></div>
                <div><g:remoteLink controller='snippet' action='tags' update='lists' onComplete='reset_autopager()'><g:message code="snippet.tags.label"/></g:remoteLink></div>
            </div>
            </sec:ifLoggedIn>
            <div id="lists"><g:include action="list"/></div>
        </div>
        <div id="sidebar">
            <g:if test="${params.username}">
            <g:include controller="user" action="tags"/>
            <g:include controller="user" action="users"/>
            </g:if><g:else>
            <sec:ifLoggedIn>
            <g:include controller="user" action="tags" params="[max:10]"/>
            <g:include controller="user" action="users" params="[max:10]"/>
            </sec:ifLoggedIn>
            </g:else>
            <g:include controller="tag" action="ranking"/>
            <g:include controller="user" action="list" params="[max:10]"/>
        </div>
    </body>
</html>
