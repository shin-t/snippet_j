

<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
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
                <div class="dialog">
                    <div class="head">
                        <div valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'description', 'errors')}">
                            <label for="description"><g:message code="snippet.description.label" default="Description" /></label>
                            <g:textField name="description" value="${snippetInstance?.description}" />
                        </div>
                        <div valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'tags', 'errors')}">
                            <label for="tags"><g:message code="snippet.tags.label" default="Tags" /></label>
                            <g:textField name="tags" value="${snippetInstance?.tags?.join(',')}" />
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="body">
                        <div valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}">
                            <g:textArea name="snippet" cols="40" rows="5" value="${snippetInstance?.snippet}" />
                        </div>
                    </div>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
