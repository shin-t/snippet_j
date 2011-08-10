<div class="list">
    <g:each in="${snippetInstance.comments}" status="i" var="commentInstance">
        <div class="comment" id="comment_${commentInstance.id}">
            <div class="header">
                <div class="float_left">
                    <g:link controller="user" action="show" id="${commentInstance.author.id}">
                        ${commentInstance.author.username.encodeAsHTML()}
                    </g:link>
                </div>
                <div class="float_right">
                    <g:link controller="comment" action="show" id="${commentInstance.id}">
                        <g:formatDate date="${commentInstance.dateCreated}" />
                    </g:link>
                </div>
                <div class="clear"></div>
            </div>
            <div class="body">${commentInstance.comment.encodeAsHTML().replace('\n','<br>')}</div>
            <g:if test="${commentInstance.author==currentUser}">
            <form class="edit_comment">
                <g:hiddenField name="id" value="${commentInstance.id}" />
                <g:actionSubmit action="edit_comment" value="Edit" />
                <g:actionSubmit action="delete_comment" value="Delete" />
            </form>
            <form class="update_comment">
                <g:hiddenField name="id" value="${commentInstance.id}" />
                <g:textArea name="comment" value="${commentInstance.comment}" />
                <g:actionSubmit action="update_comment" value="Update" />
                <g:actionSubmit action="cancel_comment" value="Cancel" />
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
            $("[name=\_action\_cancel\_comment]").click(function(e){
                var p = $(e.target).parent().get(0);
                var pp = $(p).parent().get(0);
                $(p).hide();
                console.log(p);
                console.log(pp);
                console.log($(pp).find(".body"));
                $(pp).find(".body").show();
                $(pp).find(".edit\_comment").show();
                return false;
            });
            $("[name=\_action\_update\_comment]").click(function(e){
                console.log("update!");
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
                console.log("delete!");
                var f = $(e.target).parent().get(0);
                var q = $(f).serialize();
                var obj = $(f).parent().get(0);
                if(confirm('Are you sure?')){
                    $.ajax({
                        type: "POST",
                        url: "/snippet/comment/delete",
                        data: q,
                        success: function(json){
                            console.log(json);
                            if(json){
                            }
                            else{
                                $(obj).remove();
                            }
                        }
                    });
                }
                return false;
            });
        })();
    </g:javascript>
</div>
