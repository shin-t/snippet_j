<%@ page import="snippet.Snippet" %>
<%@ page import="snippet.UserTag" %>
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
            <g:if test="${params.tag}">
            <div id="tag_info">
                ${params.tag.encodeAsHTML()}
                <sec:ifLoggedIn>
                <div class="follow_button">
                    <a href="/snippet/tag/${params.tag.encodeAsURL()}/unfollow"
                        onclick="jQuery.ajax({
                            url:'/snippet/tag/${params.tag.encodeAsURL()}/unfollow',
                            success:function(data,textStatus){follow_update(false);},
                            error:function(XMLHttpRequest,textStatus,errorThrown){}});
                            return false;">unfollow</a>
                    <a href="/snippet/tag/${params.tag.encodeAsURL()}/follow"
                        onclick="jQuery.ajax({
                            url:'/snippet/tag/${params.tag.encodeAsURL()}/follow',
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
                        url:"/snippet/tag/${params.tag.encodeAsURL()}/follow_check",
                        success: function(data){
                            follow_update(data[0]);
                        }
                    });
                </g:javascript>
                </sec:ifLoggedIn>
            </div>
            <div id="lists"><g:include controller="tag" action="list" params="[tag: params.tag]"/></div>
            </g:if>
            <g:else>
            <div id="content"><g:include controller="tag" action="tags"/></div>
            </g:else>
        </div>
        <div id="sidebar"><g:include controller="tag" action="hot_tags"/></div>
    </body>
</html>
