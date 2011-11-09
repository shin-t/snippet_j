<%@ page import="auth.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <r:require modules="jquery, bootstrap, common" />
    </head>
    <body>
        <div class="sidebar"></div>
        <div class="content">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <div class="dialog box">
                <g:if test="${params.prop == 'password'}">
                    <g:render template="password"/>
                </g:if>
                <g:elseif test="${params.prop == 'email'}">
                    <g:render template="email"/>
                </g:elseif>
                <g:else>
                    <h3><g:fieldValue bean="${userInstance}" field="username"/></h3>
                    <p><g:link controller="user" action="edit" params="[prop:'password']"><g:message code="user.password.label" default="Password"/></g:link></p>
                    <p><g:link controller="user" action="edit" params="[prop:'email']"><g:message code="user.email.label" default="Email"/></g:link></p>
                    <g:form method="post" class="form-stacked">
                        <g:hiddenField name="id" value="${userInstance?.id}" />
                        <g:hiddenField name="version" value="${userInstance?.version}" />
                        <div class="actions">
                            <g:actionSubmit class="btn danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </div>
                    </g:form>
                </g:else>
            </div>
        </div>
    </body>
</html>
