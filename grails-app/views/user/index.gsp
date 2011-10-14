<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <r:require modules="jquery-ui, common, snippet"/>
    </head>
    <body>
        <div id="contents">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div id="user_info">
                <g:if test="${params.username}">
                ${params.username.encodeAsHTML()}
                <sec:ifLoggedIn>
                <g:if test="${params.username != userInstance?.username}">
                <div class="follow_button">
                    <a href="/snippet/user/${params.username.encodeAsURL()}/unfollow"
                        onclick="jQuery.ajax({
                            url:'/snippet/user/${params.username.encodeAsURL()}/unfollow',
                            success:function(data,textStatus){follow_update(false);},
                            error:function(XMLHttpRequest,textStatus,errorThrown){}});
                            return false;">unfollow</a>
                    <a href="/snippet/user/${params.username.encodeAsURL()}/follow"
                        onclick="jQuery.ajax({
                            url:'/snippet/user/${params.username.encodeAsURL()}/follow',
                            success:function(data,textStatus){follow_update(true);},
                            error:function(XMLHttpRequest,textStatus,errorThrown){}});
                            return false;">follow</a>
                </div>
                <g:javascript>
                    var follow_update = function(data){
                        if(data){
                            $('.follow_button a').first().show().next().hide();
                        }
                        else{
                            $('.follow_button a').first().hide().next().show();
                        }
                    }
                    $.ajax({
                        url:"/snippet/user/${params.username.encodeAsURL()}/follow_check",
                        success: function(data){
                            follow_update(data[0]);
                        }
                    });
                </g:javascript>
                </g:if>
                </sec:ifLoggedIn>
                </g:if>
                <g:else>
                <sec:username />
                </g:else>
            </div>
            <div id="lists"><g:include controller="user" action="snippets" params="[username: params.username]"/></div>
        </div>
        <div id="sidebar"><g:include controller="tag" action="hot_tags"/></div>
    </body>
</html>
