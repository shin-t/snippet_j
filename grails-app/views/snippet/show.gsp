<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <r:require modules="jquery, bootstrap, common" />
    </head>
    <body>
        <div class="sidebar"></div>
        <div class="content">
            <p class="message"><span style="display:none;"></span></p>
            <g:if test="${snippetInstanceList}">
            <g:render template="list" model="[snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, userInstance: userInstance]" />
            </g:if>
        </div>
    </body>
</html>
