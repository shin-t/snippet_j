<%@ page import="auth.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
        <r:script>
            $(function(){
                $("input:submit, input:button").button().css("font-size","8pt");
                $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
            });
        </r:script>
    </head>
    <body>
        <div class="body">
            <div class="sidebar"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${userInstance}">
            <div class="errors">
                <g:renderErrors bean="${userInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="user" action="save" >
                <div class="dialog">
                    <div class="header">${entityName}</div>
                    
                        <div class="prop">
                            <div class="name">
                                <label for="username"><g:message code="user.username.label" default="Username" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: userInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${userInstance?.username}" />
                            </div>
                        </div>
                    
                        <div class="prop">
                            <div class="name">
                                <label for="password"><g:message code="user.password.label" default="Password" /></label>
                            </div>
                            <div class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="password" value="${userInstance?.password}" />
                            </div>
                        </div>
                    
                    <div class="buttons">
                        <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                    </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
