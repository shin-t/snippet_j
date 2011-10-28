<%@ page import="snippet.Snippet" %>
<%@ page import="snippet.UserTag" %>
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
            <g:if test="${params.username}">
            <div id="content"><g:include controller="tag" action="list" params="[status:params.status, username:sec.loggedInUserInfo(field:'username')]"/></div>
            </g:if>
            <g:else>
            <div id="content"><g:include controller="tag" action="list" params="[status:params.status]"/></div>
            </g:else>
        </div>
        <div id="sidebar">
        </div>
    </body>
</html>
