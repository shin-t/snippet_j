
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
            <sec:ifLoggedIn><span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span></sec:ifLoggedIn>
                            <g:sortableColumn property="id" title="${message(code: 'snippet.id.label', default: 'Id')}" />
                        |
                            <g:sortableColumn property="description" title="${message(code: 'snippet.description.label', default: 'Description')}" />
                        |
                            <g:sortableColumn property="name" title="${message(code: 'snippet.name.label', default: 'Name')}" />
                        |
                            <g:sortableColumn property="snippet" title="${message(code: 'snippet.snippet.label', default: 'Snippet')}" />
                        |
                            <g:sortableColumn property="dateCreated" title="${message(code: 'snippet.dateCreated.label', default: 'Date Created')}" />
                        |
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'snippet.lastUpdated.label', default: 'Last Updated')}" />
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                        
                    <g:each in="${snippetInstanceList}" status="i" var="snippetInstance">
                        <ul class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <li>
                            <div>
                            <p>
                            <g:link action="show" id="${snippetInstance.id}">${fieldValue(bean: snippetInstance, field: "id")}</g:link>
                            </p>
                            <p>
                            ${fieldValue(bean: snippetInstance, field: "description")}
                            </p>
                            <p>
                            ${fieldValue(bean: snippetInstance, field: "name")}
                            </p>
                            <p>
                            ${fieldValue(bean: snippetInstance, field: "snippet")}
                            </p>
                            <p>
                            <g:formatDate date="${snippetInstance.dateCreated}" />
                            </p>
                            <p>
                            <g:formatDate date="${snippetInstance.lastUpdated}" />
                            </p>
                            </div>
                            </li>
                        
                        </ul>
                    </g:each>
            </div>
        </div>
        <div>
                <g:paginate total="${snippetInstanceTotal}" />
        </div>
    </body>
</html>
