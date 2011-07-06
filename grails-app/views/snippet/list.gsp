
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="search"
            <g:form action="list">
			<g:textField id="keyword" name="keyword" value="keyword" />
			<g:submitButton name="search" />
			</g:form>
			</div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'snippet.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'snippet.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="language" title="${message(code: 'snippet.language.label', default: 'Language')}" />
                        
                            <g:sortableColumn property="comment" title="${message(code: 'snippet.comment.label', default: 'Comment')}" />
                        
                            <g:sortableColumn property="snippet" title="${message(code: 'snippet.snippet.label', default: 'Snippet')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${snippetInstance.id}">${fieldValue(bean: snippetInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: snippetInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: snippetInstance, field: "language")}</td>
                        
                            <td>${fieldValue(bean: snippetInstance, field: "comment")}</td>
                        
                            <td>${fieldValue(bean: snippetInstance, field: "snippet")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
