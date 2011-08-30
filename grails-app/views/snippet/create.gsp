
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title>
            <g:message code="default.create.label" args="[entityName]" />
        </title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${snippetInstance}">
            <div class="errors">
                <g:renderErrors bean="${snippetInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="snippet content">
                    <div class="header">
                        <h2>
                            <label for="name">
                                <g:message code="snippet.name.label" default="Name" />
                            </label>
                        </h2>
                        <g:textField class="${hasErrors(bean: snippetInstance, field: 'name', 'errors')}" name="name" value="${snippetInstance?.name}" />
                    </div>
                    <div class="body">
                        <label for="snippet">
                            <g:message code="snippet.snippet.label" default="Snippet" />
                        </label>
                        <g:textArea class="${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}" name="snippet" value="${snippetInstance?.snippet}" />
                    </div> 
                    <div class="buttons">
                        <span class="button">
                            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                        </span>
                    </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
