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
                <div class="follow_${params.tag}">
                    <g:remoteLink controller="tag" action="unfollow" params="[tag: params.tag]" onSuccess="follow_update(false)">unfollow</g:remoteLink>
                    <g:remoteLink controller="tag" action="follow" params="[tag: params.tag]" onSuccess="follow_update(true)">follow</g:remoteLink>
                </div>
                <g:javascript>
                    var follow_update = function(data){
                        if(data){
                            $('.follow_${params.tag} a').first().show().next().hide();
                        }
                        else{
                            $('.follow_${params.tag} a').first().hide().next().show();
                        }
                    }
                    follow_update(${UserTag.get(userInstance.id, params.tag)?true:false});
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
