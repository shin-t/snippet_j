

<%@ page import="snippet.Comment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
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
            <g:hasErrors bean="${commentInstance}">
            <div class="errors">
                <g:renderErrors bean="${commentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${commentInstance?.id}" />
                <g:hiddenField name="version" value="${commentInstance?.version}" />
                <div class="dialog">
                        
                            <div class="prop">
                                <div valign="top" class="name">
                                  <label for="comment"><g:message code="comment.comment.label" default="Comment" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: commentInstance, field: 'comment', 'errors')}">
                                    <g:textArea name="comment" cols="40" rows="5" value="${commentInstance?.comment}" />
                                </div>
                            </div>
                        
                            <div class="prop">
                                <div valign="top" class="name">
                                  <label for="author"><g:message code="comment.author.label" default="Author" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: commentInstance, field: 'author', 'errors')}">
                                    <g:select name="author.id" from="${snippet.User.list()}" optionKey="id" value="${commentInstance?.author?.id}"  />
                                </div>
                            </div>
                        
                            <div class="prop">
                                <div valign="top" class="name">
                                  <label for="snippet"><g:message code="comment.snippet.label" default="Snippet" /></label>
                                </div>
                                <div valign="top" class="value ${hasErrors(bean: commentInstance, field: 'snippet', 'errors')}">
                                    <g:select name="snippet.id" from="${snippet.Snippet.list()}" optionKey="id" value="${commentInstance?.snippet?.id}"  />
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
