<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <g:set var="entityName" value="${message(code: 'snippet.'+params.status+'.label', default: 'Snippet')}"/>
        <r:require modules="jquery, bootstrap, common"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>
    <body>
        <div class="sidebar">
            <g:if test="${actionName == 'users'}">
            <sec:ifLoggedIn>
            <g:include controller="user" action="following" params="[status:params.status, username:sec.loggedInUserInfo(field:'username'), max:5]"/>
            <g:include controller="user" action="followers" params="[status:params.status, username:sec.loggedInUserInfo(field:'username'), max:5]"/>
            </sec:ifLoggedIn>
            </g:if>
            <g:elseif test="${actionName == 'tags'}">
            <sec:ifLoggedIn>
            <g:include controller="tag" action="following" params="[status:params.status]"/>
            </sec:ifLoggedIn>
            <g:include controller="tag" action="recent" params="[status:params.status]"/>
            </g:elseif>
        </div>
        <div class="content">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <g:include controller="snippet" action="create" params="[status:params.status]"/>
            <g:render template="list"/>
        </div>
    </body>
</html>
