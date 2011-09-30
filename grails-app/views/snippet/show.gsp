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
        <div id="contents">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div><g:render template="content" model="[snippetInstance: snippetInstance]" /></div>
            <div id="lists"><g:render template="list" model="[snippetInstanceList: snippetInstanceList, snippetInstanceTotal: snippetInstanceTotal]" /></div>
            <r:script>
                $.autopager({
                    link:'.nextLink',
                    appendTo:'.contents',
                    content:'.list',
                    load:function(current, next){
                        $("input:checkbox.up\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-n"},text:false});
                        $("input:checkbox.down\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-s"},text:false});
                        $("input:checkbox.star\_button").button({icons:{primary:"ui-icon-star"},text:false});
                    }
                });
            </r:script>
        </div>
        <div id="sidebar"><g:include action="tags"/></div>
    </body>
</html>
