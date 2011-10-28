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
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <g:if test="${params.username}">
            <g:include controller="user" action="list" params="[username:sec.loggedInUserInfo(field:'username')]"/>
            </g:if>
            <g:else>
            <g:include controller="user" action="list"/>
            </g:else>
        </div>
        <div id="sidebar">
        </div>
    </body>
</html>
