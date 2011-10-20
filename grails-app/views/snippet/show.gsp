<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common, snippet" />
    </head>
    <body>
        <div id="contents">
            <div><g:render template="content" model="[snippetInstance: snippetInstance, userInstance: userInstance]" /></div>
            <div id="lists">
                <g:if test="${snippetInstanceList}">
                <g:render template="list" model="[snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, userInstance: userInstance]" />
                </g:if>
            </div>
        </div>
        <div id="sidebar"><g:include controller="tag" action="hot_tags"/></div>
    </body>
</html>
