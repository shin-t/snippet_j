<%@ page import="snippet.Snippet" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'snippet.label', default: 'Snippet')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <r:require modules="jquery, bootstrap, common"/>
    </head>
    <body>
        <div id="sidebar">
        </div>
        <div class="content">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="box">
                <h3>${params.tag.encodeAsHTML()}</h3>
                <p><g:message code="snippet.${params.status}.label" default="Snippet"/> &times;${counts[(params.status)]?:0}<br/>
                <g:message code="followers.users.label" default="Follower"/> &times;${follower}</p>
                <sec:ifLoggedIn>
                <div><g:checkBox name="follow_button"/><label for="follow_button"></label></div>
                <g:javascript>
                    var follow_update = function(){
                        var label = $(this).attr("checked")?"unfollow":"follow";
                        $.ajax({
                            url:'/snippet/${params.status}/tag/${params.tag.encodeAsURL()}/'+$(this).button("option","label"),
                            success:function(data,textStatus){
                                $("#follow_button").button("option","label",label);
                            },
                            error:function(XMLHttpRequest,textStatus,errorThrown){}
                        });
                    }
                    $.ajax({
                        url:'/snippet/${params.status}/tag/${params.tag.encodeAsURL()}/follow_check',
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
                </sec:ifLoggedIn>
            </div>
            <g:include controller="tag" action="${params.status}" params="[tag:params.tag, status:params.status]"/>
        </div>
    </body>
</html>
