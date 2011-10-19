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
                <p>${params.tag.encodeAsHTML()}</p>
                <p>Snippet &times;${count_snippet},
                Question &times;${count_question},
                Problem &times;${count_problem}<br/>
                Follower &times;${follower}</p>
                <sec:ifLoggedIn>
                <div><g:checkBox name="follow_button"/><label for="follow_button"></label></div>
                <g:javascript>
                    var follow_update = function(){
                        var label = $(this).attr("checked")?"unfollow":"follow";
                        $.ajax({
                            url:'/snippet/tag/${params.tag.encodeAsURL()}/'+$(this).button("option","label"),
                            success:function(data,textStatus){
                                $("#follow_button").button("option","label",label);
                            },
                            error:function(XMLHttpRequest,textStatus,errorThrown){}
                        });
                    }
                    $.ajax({
                        url:'/snippet/tag/${params.tag.encodeAsURL()}/follow_check',
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
            <div id="lists"><g:include controller="tag" action="list" params="[tag: params.tag]"/></div>
            </g:if>
            <g:else>
            <div id="content"><g:include controller="tag" action="list"/></div>
            </g:else>
        </div>
        <div id="sidebar">
            <g:include controller="tag" action="ranking"/>
            <g:include controller="user" action="list" params="[max:10]"/>
        </div>
    </body>
</html>
