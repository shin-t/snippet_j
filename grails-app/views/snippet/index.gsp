<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <r:require modules="jquery-ui, common"/>
        <r:script>
            $("input:submit, input:button").button().css("font-size","8pt");
            $("#searchableForm button").button({icons:{primary:"ui-icon-search"},text:false}).css("font-size","8pt");
            var button_icons = function(){
                $("input:checkbox.up\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-n"},text:false});
                $("input:checkbox.down\_vote\_button").button({icons:{primary:"ui-icon-triangle-1-s"},text:false});
                $("input:checkbox.star\_button").button({icons:{primary:"ui-icon-star"},text:false});
            }
            $.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });
            button_icons();
        </r:script>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:include action="create"/>
            <div>
                <g:remoteLink controller="snippet" action="list" update="lists" onSuccess="jQuery.autopager('destroy')" onComplete="jQuery.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons })">all</g:remoteLink>
                <g:remoteLink controller="snippet" action="user" update="lists" onSuccess="jQuery.autopager('destroy')" onComplete="jQuery.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons })">user</g:remoteLink>
            </div>
            <div id="lists"><g:include action="list"/></div>
        </div>
        <div id="sidebar"><g:include controller="tag" action="hot_tags"/></div>
    </body>
</html>
