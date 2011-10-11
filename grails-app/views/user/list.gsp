<%@ page import="auth.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
        <r:script>
            $(function(){
                $("input:submit, input:button").button().css("font-size","8pt");
                $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
            });
        </r:script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <div class="sidebar"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <g:each in="${userInstanceList}" status="i" var="userInstance">
                <div class="content">
                    <div class="header">${fieldValue(bean: userInstance, field: "username")}</div>
                    <div>${fieldValue(bean: userInstance, field: "password")}</div>
                    <div><g:formatBoolean boolean="${userInstance.enabled}" /></div>
                    <div><g:formatBoolean boolean="${userInstance.accountExpired}" /></div>
                    <div><g:formatBoolean boolean="${userInstance.accountLocked}" /></div>
                    <div><g:formatBoolean boolean="${userInstance.passwordExpired}" /></div>
                    <div><g:link action="show" id="${userInstance.id}"><g:formatDate date="${userInstance.lastUpdated}" /></g:link></div>
                </div>
                </g:each>
                <div class="paginateButtons">
                    <g:paginate total="${userInstanceTotal}" />
                </div>
            </div>
        </div>
    </body>
</html>
