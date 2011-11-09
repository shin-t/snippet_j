<%@ page import="auth.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <r:require modules="jquery, bootstrap, common" />
    </head>
    <body>
        <div class="sidebar"></div>
        <div class="content">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog box">
                <g:form controller="user" action="save" class="form-stacked">
                    <fieldset>
                        <legend>${entityName}</legend>
                        <g:hasErrors bean="${userInstance}">
                        <div class="errors"><g:renderErrors bean="${userInstance}" as="list"/></div>
                        </g:hasErrors>
                        <div class="prop clearfix">
                            <div class="name"><label for="username"><g:message code="user.username.label" default="Username" /></label></div>
                            <div class="value input"><g:textField name="username" value="${userInstance?.username}" /></div>
                        </div>
                        <div class="prop clearfix">
                            <div class="name"><label for="password"><g:message code="user.password.label" default="Password" /></label></div>
                            <div class="value input"><g:passwordField name="password" value="${userInstance?.password}" /></div>
                        </div>
                        <div class="prop clearfix">
                            <div class="name"><label for="password2"><g:message code="user.password2.label" default="Password" /></label></div>
                            <div class="value input"><g:passwordField name="password2" value="${userInstance?.password2}" /></div>
                        </div>
                        <div class="prop clearfix">
                            <div class="name"><label for="email"><g:message code="user.email.label" default="Email" /></label></div>
                            <div class="value input"><g:textField name="email" value="${userInstance?.email}" /></div>
                        </div>
                        <div class="prop clearfix">
                            <div class="name"><label for="email2"><g:message code="user.email2.label" default="Email" /></label></div>
                            <div class="value input"><g:textField name="email2" value="${userInstance?.email2}" /></div>
                        </div>
                    </fieldset>
                    <div class="actions">
                        <g:submitButton name="create" class="btn success" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </div>
                </g:form>
            </div>
        </div>
    </body>
</html>
