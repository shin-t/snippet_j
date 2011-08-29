<%@ page import="snippet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="user content">
                <div class="header">
                    <h2><g:message code="default.list.label" args="${[message(code:'user.label')]}" default="Users" /></h2>
                </div>
                <div class="body">
                    <g:each in="${users}" status="i" var="u">
                        <div><g:link action="show" params="[username:u[0]]">${u[0].encodeAsHTML()}</g:link>(${u[1].encodeAsHTML()})</div>
                    </g:each>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${total}" />
            </div>
        </div>
    </body>
</html>
