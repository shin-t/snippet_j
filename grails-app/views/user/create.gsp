

<%@ page import="snippet.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
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
                <div class="dialog">
                            <div class="prop">
                                <div valign="top" class="name">
                                    <label for="username"><g:message code="user.username.label" default="Username" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
                                        <g:textField name="username" value="${userInstance?.username}" />
                                </div>
                            </div>
                            <div class="prop">
                                <div valign="top" class="name">
                                    <label for="password"><g:message code="user.password.label" default="Password" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                        <g:passwordField name="password" value="${userInstance?.password}" />
                                </div>
                            </div>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
