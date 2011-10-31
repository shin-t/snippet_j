<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <g:set var="entityName" value="${message(code: 'tag.label', default: 'Tag')}"/>
        <r:require modules="jquery-ui, common, snippet"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <div id="tags" class="content">
                <div><g:message code="snippet.${params.status}.label" default=""/> / <g:message code="tag.label" default="Tags"/></div>
                <g:if test="${tags}">
                    <g:each in="${tags}" var="t">
                        <p>
                            <g:link controller="tag" action="show" params="[status: params.status, tag: t.name.encodeAsURL()]">${t.name.encodeAsHTML()}</g:link>
                            <span>&times;${t.count.encodeAsHTML()}</span>
                        </p>
                    </g:each>
                    <div class="paginateButtons"><g:paginate total="${total}" params="[status: params.status]"/></div>
                </g:if>
            </div>
        </div>
        <div id="sidebar">
        </div>
    </body>
</html>
