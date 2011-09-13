
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
                            <label for="title">
                                <g:message code="snippet.title.label" default="Title" />
                            </label>
                        </h2>
                        <g:textField class="${hasErrors(bean: snippetInstance, field: 'title', 'errors')}" name="title" value="${snippetInstance?.title}" />
                    </div>
                    <div class="body">
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
