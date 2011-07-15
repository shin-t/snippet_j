
<%@ page import="snippet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <sec:ifLoggedIn><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></sec:ifLoggedIn>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        <div class="dialog">
                        
                            
                                <div class="head"><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "id")}</g:link></div>
                            
                                <div>${fieldValue(bean: userInstance, field: "username")}</div>
                            
                                <div>${fieldValue(bean: userInstance, field: "password")}</div>
                            
                                <div><g:formatBoolean boolean="${userInstance.accountExpired}" /></div>
                            
                                <div><g:formatBoolean boolean="${userInstance.accountLocked}" /></div>
                            
                                <div><g:formatBoolean boolean="${userInstance.enabled}" /></div>
                            
                        </div>
                    </g:each>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
