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
                <div class="follow_${params.username}">
                    <g:remoteLink controller="user" action="unfollow" params="[username: params.username]" onSuccess="follow_update(false)">unfollow</g:remoteLink>
                    <g:remoteLink controller="user" action="follow" params="[username: params.username]" onSuccess="follow_update(true)">follow</g:remoteLink>
                </div>
                <g:javascript>
                    var follow_update = function(data){
                        if(data){
                            $('.follow_${params.username} a').first().show().next().hide();
                        }
                        else{
                            $('.follow_${params.username} a').first().hide().next().show();
                        }
                    }
                    $.ajax({
                        url:"/snippet/user/${params.username}/follow_check",
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
