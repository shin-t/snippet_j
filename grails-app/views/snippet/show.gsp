
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <sec:ifLoggedIn><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></sec:ifLoggedIn>
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:render template="/layouts/snippet" model="${[snippetInstance: snippetInstance, patch: patch]}"/>
            <sec:ifLoggedIn>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${snippetInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <g:if test="${snippetInstance.author == currentUser}">
                        <span class="button">
                            <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </span>
                    </g:if>
                </g:form>
            </div>
            </sec:ifLoggedIn>
            <sec:ifLoggedIn>
            <g:form controller="comment" action="save">
                <div class="comment">
                    <div class="head"><label for="comment"><g:message code="comment.comment.label" default="Comment" /></label></div>
                    <div class="body ${hasErrors(bean: commentInstance, field: 'comment', 'errors')}">
                        <g:hiddenField name="snippet.id" value="${snippetInstance.id}"  />
                        <g:textArea name="comment" value="${commentInstance?.comment}" />
                    </div>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
            </sec:ifLoggedIn>
            <div>
                <g:each in="${snippetInstance.comments}" status="i" var="commentInstance">
                    <g:render template="/layouts/comment" model="${[commentInstance: commentInstance]}"/>
                </g:each>
            </div>
            <g:render template="/layouts/history" model="${[snippetInstance: snippetInstance]}"/>
        </div>
    </body>
</html>
