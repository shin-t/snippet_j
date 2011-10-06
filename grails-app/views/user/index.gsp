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
            <g:if test="${params.username}">
            <div>${params.username}</div>
            <g:if test="${params.username!=username}">
            <div class="follow_${params.username}">
                <a href="#"></a>
            </div>
            <g:javascript>
            (function(){
                var follow_update = function(data){
                    if(data){
                        $('.follow_${params.username}').html($("<a href='#'>unfollow</a>").click(function(){
                            ${remoteFunction(controller:'user', action:'unfollow', params:[username: params.username], onSuccess:'follow_update(false)')}
                            return false;
                        }));
                        console.log("update unfollow");
                    }
                    else{
                        $('.follow_${params.username}').html($("<a href='#'>follow</a>").click(function(){
                            ${remoteFunction(controller:'user', action:'follow', params:[username: params.username], onSuccess:'follow_update(true)')}
                            return false;
                        }));
                        console.log("update follow");
                    }
                }
                var follow_check = function(){
                    ${remoteFunction(controller:'user', action:'follow_check', params:[username: params.username], onSuccess:'follow_update(data[0])')}
                    console.log("check");
                }
                follow_check();
            })();
            </g:javascript>
            </g:if>
            </g:if>
            <g:else>
            <div><sec:username /></div>
            </g:else>
            <div id="lists"><g:include controller="user" action="snippets" params="[username: params.username]"/></div>
        </div>
        <div id="sidebar"><g:include controller="tag" action="hot_tags"/></div>
    </body>
</html>