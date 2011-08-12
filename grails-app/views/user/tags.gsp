
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}"><div class="message">${flash.message}</div></g:if>
            <div class="sidebar">
                <g:render template="/layouts/tags" />
            </div>
            <h2>
                <g:if test="${params.username}">
                    <div class="message">${params.username.encodeAsHTML()} /<g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
                </g:if>
            </h2>
            <g:render template="/layouts/snippets"/>
            <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" params="[tags:params.tags,user:params.user,q:params.q]" />
            </div>
        </div>
    </body>
</html>
