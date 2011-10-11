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
                $("input:checkbox.star\_button").button({icons:{primary:"ui-icon-star"},text:false});
            }
            var reset_autopager = function(){
                $.autopager('destroy');
                $.autopager({ link:'.nextLink', appendTo:'#lists', content:'.list', load: button_icons });
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
            <div id="form_dialog">
                <g:include action="create"/>
            </div>
            <div id="list_filter">
                <g:radio id="filter_all" name="lists" checked="true"/><g:radio id="filter_user" name="lists"/><g:radio id="filter_tags" name="lists"/>
                <label for="filter_all"><g:message code="list.filter.all.label"/></label><label for="filter_user"><g:message code="list.filter.user.label"/></label><label for="filter_tags"><g:message code="list.filter.tags.label"/></label>
            </div>
            <g:javascript>
                $("#list_filter").buttonset().children(":radio")
                                 .first().click(function(){${remoteFunction(controller:'snippet',action:'list',update:'lists',onComplete:'reset_autopager()')}})
                                 .next().click(function(){${remoteFunction(controller:'snippet',action:'user',update:'lists',onComplete:'reset_autopager()')}})
                                 .next().click(function(){${remoteFunction(controller:'snippet',action:'tags',update:'lists',onComplete:'reset_autopager()')}});
            </g:javascript>
            <div id="lists"><g:include action="list"/></div>
        </div>
        <div id="sidebar"><g:include controller="tag" action="hot_tags"/></div>
    </body>
</html>
