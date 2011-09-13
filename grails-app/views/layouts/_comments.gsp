<div class="list">
    <g:each in="${snippetInstance.comments}" status="i" var="commentInstance">
        <div class="comment content" id="comment_${commentInstance.id}">
            <div class="header">
                <div class="float_left">
                    <g:link controller="user" action="show" params="[username:commentInstance.user.username]">
                        ${commentInstance.user.username.encodeAsHTML()}
                    </g:link>
                </div>
                <div class="float_right">
                    <g:link controller="snippet" action="show" id="${snippetInstance.id}" fragment="comment_${commentInstance.id}">
                        <g:formatDate date="${commentInstance.dateCreated}" />
                    </g:link>
                </div>
                <div class="clear"></div>
            </div>
            <div class="body">${commentInstance.text.encodeAsHTML().replace('\n','<br>')}</div>
            <g:if test="${commentInstance.user==currentUser}">
            <form class="edit_comment">
                <g:hiddenField name="id" value="${commentInstance.id}" />
                <g:actionSubmit action="edit_comment" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
                <g:actionSubmit action="delete_comment" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
            </form>
            <form class="update_comment">
                <g:hiddenField name="id" value="${commentInstance.id}" />
                <g:textArea name="text" value="${commentInstance.text}" />
                <g:actionSubmit action="update_comment" value="${message(code: 'default.button.update.label', default: 'Update')}" />
            </form>
            </g:if>
        </div>
    </g:each>
    <g:javascript>
        (function(){
            $(".update\_comment").hide();
            $("[name=\_action\_edit\_comment]").click(function(e){
                var p = $(e.target).parent().get(0);
                var pp = $(p).parent().get(0);
                $(p).hide();
                $(pp).find(".body").hide();
                $(pp).find(".update\_comment").show();
                return false;
            });
            $("[name=\_action\_update\_comment]").click(function(e){
                var f = $(e.target).parent().get(0);
                var q = $(f).serialize();
                var obj = $(f).parent().get(0);
                var p = $(e.target).parent().get(0);
                var pp = $(p).parent().get(0);
                $(p).hide();
                $(pp).find(".body").show();
                $(pp).find(".edit\_comment").show();
                $.ajax({
                    type: "POST",
                    url: "/snippet/comment/update",
                    data: q,
                    success: function(json){
                        console.log(json);
                        $(p).hide();
                        $(pp).find(".body").show();
                        $(pp).find(".edit\_comment").show();
                        var lines = json.comment.split('\n');
                        var body = $(obj).find(".body");
                        $(body).text("");
                        for(var i=0;i<lines.length;i++){
                            $(body).append($("<div/>",{text:lines[i]}).html());
                            $(body).append($("<br/>"));
                        }
                    }
                });
                return false;
            });
            $("[name=\_action\_delete\_comment]").click(function(e){
                var f = $(e.target).parent().get(0);
                var q = $(f).serialize();
                var obj = $(f).parent().get(0);
                if(confirm("")){
                    $.ajax({
                        type: "POST",
                        url: "/snippet/comment/delete",
                        data: q,
                        success: function(json){
                            $(obj).remove();
                        }
                    });
                }
                return false;
            });
        })();
    </g:javascript>
</div>
