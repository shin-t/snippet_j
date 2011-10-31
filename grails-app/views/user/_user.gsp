<%@ page import="snippet.Snippet" %>
<div id="user_info">
    <p><gravatar:img hash="${userInstance.gravatar_hash}" size="72"/>${userInstance.username.encodeAsHTML()}</p>
    <p>
        <g:if test="${params.status}">
        <g:message code="snippet.${params.status}.label" default="Snippet"/> &times;${Snippet.countByUserAndStatus(userInstance, params.status)}
        </g:if>
        <g:else>
        <g:message code="snippet.snippet.label" default="Snippet"/> &times;${Snippet.countByUserAndStatus(userInstance, 'snippet')},
        <g:message code="snippet.question.label" default="Question"/> &times;${Snippet.countByUserAndStatus(userInstance, 'question')},
        <g:message code="snippet.problem.label" default="Problem"/> &times;${Snippet.countByUserAndStatus(userInstance, 'problem')}
        </g:else>
        <br/>
        <g:message code="followers.users.label" default="Followers"/> &times;${userInstance.follower.size()}
    </p>
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
