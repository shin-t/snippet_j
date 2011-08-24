
<%@ page import="snippet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form method="post">
                <g:hiddenField name="id" value="${userInstance?.id}" />
                <g:hiddenField name="version" value="${userInstance?.version}" />
                <div class="user content">
                    <div class="prop">
                        <label for="username"><g:message code="user.username.label" default="Username" /></label>
                        <div>
                            <g:textField class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}" name="username" value="${userInstance?.username}" />
                            <g:hasErrors bean="${userInstance}" field="username">
                                <g:eachError bean="${userInstance}" field="username"><span class="error"><g:message error="${it}" /></span></g:eachError>
                            </g:hasErrors>
                        </div>
                    </div>
                    <div class="prop">
                        <label for="password"><g:message code="user.password.label" default="Password" /></label>
                        <div>
                            <g:passwordField class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}" name="password" />
                            <g:hasErrors bean="${userInstance}" field="password">
                                <g:eachError bean="${userInstance}" field="password"><span class="error"><g:message error="${it}" /></span></g:eachError>
                            </g:hasErrors>
                        </div>
                    </div>
                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                    </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
