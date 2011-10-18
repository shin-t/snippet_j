<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <r:require modules="jquery-ui, common, snippet"/>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div id="form_dialog">
                <g:include action="create"/>
            </div>
            <div id="list_filter">
                <g:radio id="filter_all" name="lists" checked="true" onclick="${remoteFunction(controller:'snippet',action:'list',update:'lists',onComplete:'reset_autopager()')}"/>
                <g:radio id="filter_user" name="lists" onclick="${remoteFunction(controller:'snippet',action:'user',update:'lists',onComplete:'reset_autopager()')}"/>
                <g:radio id="filter_tags" name="lists" onclick="${remoteFunction(controller:'snippet',action:'tags',update:'lists',onComplete:'reset_autopager()')}"/>
                <label for="filter_all"><g:message code="list.filter.all.label"/></label><label for="filter_user"><g:message code="list.filter.user.label"/></label><label for="filter_tags"><g:message code="list.filter.tags.label"/></label>
            </div>
            <div id="lists"><g:include action="list"/></div>
        </div>
        <div id="sidebar">
            <g:if test="${params.username}">
            <g:include controller="user" action="tags"/>
            <g:include controller="user" action="users"/>
            </g:if>
            <g:else>
            <sec:ifLoggedIn>
            <g:include controller="user" action="tags"/>
            <g:include controller="user" action="users"/>
            </sec:ifLoggedIn>
            </g:else>
            <g:include controller="tag" action="ranking"/>
            <g:include controller="user" action="list"/>
        </div>
    </body>
</html>
