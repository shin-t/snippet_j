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
            <g:if test="${params.tag}">
            <div id="tag_info">
                ${params.tag.encodeAsHTML()}
                <div class="follow_${params.tag}">
                    <a href="#"></a>
                </div>
                <g:javascript>
                (function(){
                    var follow_update = function(data){
                        if(data){
                            $('.follow_${params.tag}').html($("<a href='#'>unfollow</a>").click(function(){
                                ${remoteFunction(controller:'tag', action:'unfollow', params:[tag: params.tag], onSuccess:'follow_update(false)')}
                                return false;
                            }));
                        }
                        else{
                            $('.follow_${params.tag}').html($("<a href='#'>follow</a>").click(function(){
                                ${remoteFunction(controller:'tag', action:'follow', params:[tag: params.tag], onSuccess:'follow_update(true)')}
                                return false;
                            }));
                        }
                    }
                    var follow_check = function(){
                        ${remoteFunction(controller:'tag', action:'follow_check', params:[tag: params.tag], onSuccess:'follow_update(data[0])')}
                    }
                    follow_check();
                })();
                </g:javascript>
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
