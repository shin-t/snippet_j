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
            <div id="users" class="content">
                <g:if test="${params.username}">
                <div><g:message code="following.users.label" default="Follwing users" /></div>
                </g:if><g:else>
                <div><g:message code="user.label" default="Users" /></div>
                </g:else>
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
