<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
    </head>
    <body>
        <div id="contents">
            <p class="message"><span style="display:none;"></span></p>
            <g:if test="${snippetInstanceList}">
            <div class="box">
                <g:render template="list" model="[snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal, userInstance: userInstance]" />
            </div>
            </g:if>
        </div>
        <div id="sidebar"></div>
    </body>
</html>
