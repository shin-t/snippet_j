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
            <sec:ifLoggedIn>
            <g:include controller="user" action="list" params="[username:sec.loggedInUserInfo(field:'username')]"/>
            </sec:ifLoggedIn>
            <g:include controller="user" action="list"/>
        </div>
        <div id="sidebar">
        </div>
    </body>
</html>
