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
            $.ajax({
                contentType:"text/json",
                url:"/snippet/snippet/list"
            }).success(function(data) {
                console.log(data);
                for(var i in data){
                    $("<div/>",{"class":"content"})
                    .append($("<div/>",{"class":"header",text:data[i].username}))
                    .append($("<div/>",{text:data[i].text}))
                    .append($("<div/>",{text:data[i].file}))
                    .appendTo("#list");
                }
            }).error(function(data) {
            }).complete(function(data) {});
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
                <g:include action="create" />
                </div>
                <g:include action="list" />
                <r:script>
                    $.autopager({link:'.nextLink',appendTo:'.contents',content:'.list'});
                </r:script>
            </div>
        </div>
    </body>
</html>
