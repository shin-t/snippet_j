

<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
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
            <g:hasErrors bean="${snippetInstance}">
            <div class="errors">
                <g:renderErrors bean="${snippetInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                        
                            <div class="prop">
                                <div valign="top" class="name">
                                    <label for="description"><g:message code="snippet.description.label" default="Description" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'description', 'errors')}">
                                        <g:textField name="description" value="${snippetInstance?.description}" />
                                </div>
                            </div>
                        
                            <div class="prop">
                                <div valign="top" class="name">
                                    <label for="snippet"><g:message code="snippet.snippet.label" default="Snippet" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'snippet', 'errors')}">
                                        <g:textArea name="snippet" cols="40" rows="5" value="${snippetInstance?.snippet}" />
                                </div>
                            </div>
                            <div class="prop">
                                <div valign="top" class="name">
                                    <label for="tags"><g:message code="snippet.tags.label" default="Tags" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: snippetInstance, field: 'tags', 'errors')}">
                                        <g:textField name="tags" value="${snippetInstance?.tags?.join(',')}" />
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
