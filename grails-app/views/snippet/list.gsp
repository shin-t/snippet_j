
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${params.q}">
                <div class="message">
                    <g:message code="search.keyword.message" args="${[params.q.encodeAsHTML(),snippetInstanceTotal]}" />
                </div>
                <div class="message">
                    <g:message code="snippet.tags.label" />: <g:link controller="snippet" action="tag" params="[tag:params.q]">${params.q.encodeAsHTML()}</g:link>
                </div>
            </g:if>
            <g:elseif test="${params.user}">
                <div class="message">${params.user.encodeAsHTML()} /<g:if test="${params.tags}"> ${params.tags.encodeAsHTML()}</g:if> (${snippetInstanceTotal})</div>
            </g:elseif>
            <g:elseif test="${params.tag}">
                <div class="message">
                    <g:message code="search.tag.message" args="${[params.tag.encodeAsHTML(),snippetInstanceTotal]}" />
                </div>
            </g:elseif>
            <g:render template="/layouts/snippets" model="[snippetInstanceList:snippetInstanceList]" />
            <div class="paginateButtons">
                <g:paginate total="${snippetInstanceTotal}" params="[tag:params.tag,user:params.user,q:params.q]" />
            </div>
        </div>
    </body>
</html>
