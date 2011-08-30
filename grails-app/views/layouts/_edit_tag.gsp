<div class="edit_tag">
    <form id="edit_tags_${snippetInstance.id}">
        <span><g:message code="snippet.tags.label" default="Tags" /></span>
        <span class="tags">
            <g:each status="i" in="${snippetInstance.tags}" var="t"><g:link action="tag" params="[tag:t]" class="tag">${t.encodeAsHTML()}</g:link></g:each>
        </span>
        <input type="button" id="editTags_${snippetInstance.id}" name="editTags_${snippetInstance.id}" value="${message(code: 'default.button.edit.label', default: 'Edit')}">
    </form>
    <form id="parse_tags_${snippetInstance.id}" action="/snippet/snippet/parse_tags" method="POST">
        <g:hiddenField name="id" value="${snippetInstance.id}" />
        <g:textField name="tags" value="${snippetInstance.tags?.join(' ')}" />
        <g:submitButton name="parseTags" value="${message(code: 'default.button.update.label', default: 'Update')}" />
    </form>
    <g:javascript>
    (function(){
        $("#parse\_tags\_${snippetInstance.id}").hide();
        $("#editTags\_${snippetInstance.id}").click(function(e){
            $("#edit\_tags\_${snippetInstance.id}").hide();
            $("#parse\_tags\_${snippetInstance.id}").show();
        });
        $("#parse\_tags\_${snippetInstance.id}").submit(function(){
            var q = $(this).serialize();
            var obj = $(this);
            $.ajax({
                type: "POST",
                url: "/snippet/snippet/parse_tags",
                data: q,
                success: function(json){
                    $(obj).hide();
                    $("#edit\_tags\_${snippetInstance.id}").show();
                    $("#edit\_tags\_${snippetInstance.id} span.tags").empty();
                    for(var i=0;i<json.length;i++){
                        $("<a/>",{"class":"tag","href":"/snippet/?tag="+encodeURI(json[i]),text:json[i]}).appendTo("#edit\_tags\_${snippetInstance.id} span.tags");
                    }
                    var tag_list = $(".tags .body #searchableForm").next();
                    if(tag_list.length){
                        $.ajax({
                            type: "GET",
                            url: "/snippet/user/tag",
                            success: function(json){
                                $(tag_list).empty();
                                for(var i=0;i<json.length;i++){
                                    $("<div/>",{"class":"tag"})
                                        .append($("<a/>",{"class":"tag","href":"/snippet/?tags="+encodeURI(json[i][0]),text:json[i][0]}))
                                        .append("("+json[i][1]+")")
                                        .appendTo(tag_list);
                                }
                            }
                        });
                    }
                }
            });
            return false;
        });
    })();
    </g:javascript>
</div>
