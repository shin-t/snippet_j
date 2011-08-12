
<%@ page import="snippet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="user content">
                    <div class="prop">
                        <label for="username"><g:message code="user.username.label" default="ユーザー名" /></label>
                        <div><g:textField class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}" name="username" value="${userInstance?.username}" /></div>
                    </div>
                    <div class="prop">
                        <label for="password"><g:message code="user.password.label" default="パスワード" /></label>
                        <div><g:passwordField class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}" name="password" value="${userInstance?.password}" /></div>
                    </div>
                    <div class="buttons">
                        <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
