
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title>
            <g:message code="default.edit.label" args="[entityName]" />
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
            <g:form method="post" >
                <g:hiddenField name="id" value="${snippetInstance?.id}" />
                <g:hiddenField name="version" value="${snippetInstance?.version}" />
                <div class="snippet content">
                    <div class="header">
                        <h2>
                            <label for="name">
                                <g:message code="snippet.name.label" default="Name" />
                            </label>
                        </h2>
                        <g:textField class="value ${hasErrors(bean: snippetInstance, field: 'name', 'errors')}" name="name" value="${snippetInstance?.name}" />
                        <h3>
                            <label for="description">
                                <g:message code="snippet.description.label" default="Description" />
                            </label>
                        </h3>
                        <g:textField class="${hasErrors(bean: snippetInstance, field: 'description', 'errors')}" name="description" value="${snippetInstance?.description}" />
                    </div>
                    <div class="body">
                        <label for="snippet">
                            <g:message code="snippet.snippet.label" default="Snippet" />
                        </label>
                        <g:textArea class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}" name="snippet" value="${snippetInstance?.snippet}" />
                    </div>
                    <div class="buttons">
                        <span class="button">
                            <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                        </span>
                        <span class="button">
                            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </span>
                    </div>
                </div>
            </g:form>
        </div>
    </body>
</html>
