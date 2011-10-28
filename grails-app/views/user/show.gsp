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
            <p class="message"><span>${flash.message}</span></p>
            </g:if>
            <div id="user_info">
                <p><gravatar:img hash="${userInstance.gravatar_hash}" size="72"/>${userInstance.username.encodeAsHTML()}</p>
                <p><g:message code="snippet.snippet.label" default="Snippet"/> &times;${Snippet.countByUserAndStatus(userInstance,'snippet')},
                <g:message code="snippet.question.label" default="Question"/>  &times;${Snippet.countByUserAndStatus(userInstance,'question')},
                <g:message code="snippet.problem.label" default="Problem"/> &times;${Snippet.countByUserAndStatus(userInstance,'problem')}<br/>
                <g:message code="following.label" default="Follow"/> &times;${userInstance.follower.size()}</p>
                <sec:ifLoggedIn>
                <g:if test="${currentUser.username != userInstance.username}">
                <div><g:checkBox name="follow_button"/><label for="follow_button"></label></div>
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
            <g:if test="${params.status}">
                <div id="lists">
                    <g:include controller="user" action="${params.status}" params="[username:params.username]"/>
                </div>
            </g:if>
            <g:else>
                <g:include controller="user" action="following" params="[username:params.username]"/>
                <g:include controller="user" action="followers" params="[username:params.username]"/>
            </g:else>
        </div>
        <div id="sidebar">
        </div>
    </body>
</html>
