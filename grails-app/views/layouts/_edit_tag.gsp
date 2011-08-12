<div class="edit_tag">
    <form id="edit_tags_${snippetInstance.id}">
        <span><g:message code="snippet.tags.label" default="Tags" /></span>
        <span class="tags">
            <g:each status="i" in="${snippetInstance.tags()}" var="tag">
                <g:if test="${i!=0}"> </g:if>
                <g:link action="tags" params="[tags:tag]" class="tag">${tag.encodeAsHTML()}</g:link>
            </g:each>
        </span>
        <input type="button" id="editTags_${snippetInstance.id}" name="editTags_${snippetInstance.id}" value="${message(code: 'default.button.edit.label', default: 'Edit')}">
    </form>
    <form id="parse_tags_${snippetInstance.id}" action="/snippet/snippet/parse_tags" method="POST">
        <g:hiddenField name="id" value="${snippetInstance.id}" />
        <g:textField name="tags" value="${snippetInstance.tags()?.join(',')}" />
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
                    $("<a/>",{"class":"tag","href":"/snippet/?tags="+encodeURI(json.snippet_tags[0]),text:json.snippet_tags[0]}).appendTo("#edit\_tags\_${snippetInstance.id} span.tags");
                    for(var i=1;i<json.snippet_tags.length;i++){
                        $("#edit\_tags\_${snippetInstance.id} span.tags").append(" ");
                        $("<a/>",{"class":"tag","href":"/snippet/?tags="+encodeURI(json.snippet_tags[i]),text:json.snippet_tags[i]}).appendTo("#edit\_tags\_${snippetInstance.id} span.tags");
                    }
                }
            });
            return false;
        });
    })();
    </g:javascript>
</div>
