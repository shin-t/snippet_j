<%@ page import="auth.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <r:require modules="jquery-ui, common, snippet"/>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <sec:ifLoggedIn>
            <g:render template="user"/>
            </sec:ifLoggedIn>
            <div id="users" class="content">
                <h1>
                    <g:if test="${params.username}">
                    <g:message code="${actionName}.users.label" default="Users" />
                    </g:if><g:else>
                    <g:message code="user.label" default="Users" />
                    </g:else>
                </h1>
                <g:each in="${userInstanceList}" var="c">
                <p>
                    <gravatar:img hash="${c.gravatar_hash}" size="16"/>
                    <g:if test="${params.status}">
                    <g:link controller="user" action="show" params="[status: params.status, username: c.username]">${c.username.encodeAsHTML()}</g:link>
                    </g:if>
                    <g:else>
                    <g:link controller="user" action="show" params="[username: c.username]">${c.username.encodeAsHTML()}</g:link>
                    </g:else>
                </p>
                </g:each>
                <g:paginate total="${userInstanceTotal}"/>
            </div>
        </div>
        <div id="sidebar">
        </div>
    </body>
</html>
