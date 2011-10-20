<%@ page import="auth.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors"><g:renderErrors bean="${userInstance}" as="list" /></div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${userInstance?.id}" />
                <g:hiddenField name="version" value="${userInstance?.version}" />
                <div class="dialog">
                    <div class="header">${entityName}</div>
                        <div class="prop">
                            <div class="name"><label for="username"><g:message code="user.username.label" default="Username" /></label></div>
                            <div class="value"><g:textField name="username" value="${userInstance?.username}" /></div>
                        </div>
                        <div class="prop">
                            <div class="name"><label for="password"><g:message code="user.password.label" default="Password" /></label></div>
                            <div class="value"><g:passwordField name="password" value="${userInstance?.password}" /></div>
                        </div>
                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </div>
                </div>
            </g:form>
        </div>
        <div id="sidebar"></div>
    </body>
</html>
