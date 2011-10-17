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
            <g:if test="${userInstance}">
            <div id="user_info">
                ${params.username.encodeAsHTML()}
                <sec:ifLoggedIn>
                <g:if test="${currentUser?.username != userInstance.username}">
                <g:checkBox name="follow_button"/>
                <label for="follow_button"></label>
                <g:javascript>
                    var follow_update = function(){
                        var label = $(this).attr("checked")?"unfollow":"follow";
                        $.ajax({
                            url:'/snippet/user/${params.username.encodeAsURL()}/'+$(this).button("option","label"),
                            success:function(data,textStatus){
                                $("#follow_button").button("option","label",label);
                            },
                            error:function(XMLHttpRequest,textStatus,errorThrown){}
                        });
                    }
                    $.ajax({
                        url:'/snippet/user/${params.username.encodeAsURL()}/follow_check',
                        success: function(data){
                            var label;
                            if(data[0]){
                                label = "unfollow";
                                $("#follow_button").attr("checked","checked");
                            }
                            else{
                                label = "follow";
                            }
                            $("#follow_button").button({label:label,icons:{primary:"ui-icon-heart"}}).click(follow_update);
                        }
                    });
                </g:javascript>
                </g:if>
                </sec:ifLoggedIn>
            </div>
            <div id="lists"><g:include controller="user" action="snippets" params="[username: params.username]"/></div>
            </g:if>
            <g:else>
            <g:include controller="user" action="list"/>
            </g:else>
        </div>
        <div id="sidebar">
            <g:include controller="user" action="tags" params="[username: params.username]"/>
            <g:include controller="user" action="users" params="[username: params.username]"/>
            <g:include controller="tag" action="hot_tags"/>
            <g:include controller="user" action="list"/>
        </div>
    </body>
</html>
