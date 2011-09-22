<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require modules="jquery-ui, common" />
        <r:script>
            $(function(){
                $("input:submit, input:button").button().css("font-size","8pt");
                $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
            });
        </r:script>
    </head>
    <body>
        <div class="body">
            <div class="sidebar"></div>
            <div class="contents">
                <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
                </g:if>
                <div id="form_dialog">
                <g:include action="create" model="[snippetInstance:snippetInstance]" />
                </div>
                <g:include action="list" model="[snippetInstanceList:snippetInstanceList]" />
            </div>
        </div>
    </body>
</html>
