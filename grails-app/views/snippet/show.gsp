
<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
        <r:script>$("input:submit, input:button").button().css("font-size","8pt");</r:script>
    </head>
    <body>
        <div class="body">
            <div class="sidebar"></div>
            <div class="contents">
                <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
                </g:if>
                <div id="lists"><g:render template="list" model="[snippetInstanceList:snippetInstanceList,snippetInstanceTotal:snippetInstanceTotal]" /></div>
                <r:script>$.autopager({link:'.nextLink',appendTo:'.contents',content:'.list'});</r:script>
            </div>
        </div>
    </body>
</html>
