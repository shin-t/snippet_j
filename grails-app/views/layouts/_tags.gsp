<div class="value buttons">
    <form id="edit_tags">
        <span><g:message code="snippet.tags.label" default="Tags" /></span>
        <span class="tags">
            <g:each status="i" in="${snippetInstance.tags()}" var="tag">
                <g:if test="${i!=0}"> </g:if>
                <g:link action="list" params="[tags:tag]" class="tag">${tag.encodeAsHTML()}</g:link>
            </g:each>
        </span>
        <input type="button" id="editTags" name="editTags" value="Edit">
    </form>
    <form id="parse_tags" name="parse_tags" action="/snippet/snippet/parse_tags" method="POST">
        <g:hiddenField name="id" value="${snippetInstance?.id}" />
        <g:textField name="tags" value="${snippetInstance?.tags()?.join(',')}" />
        <g:submitButton name="parseTags" value="Update" />
    </form>
    <g:javascript>
    (function(){
        $("#parse\_tags").hide();
        $("#editTags").click(function(e){
            $("#edit\_tags").hide();
            $("#parse\_tags").show();
        });
        $("#parse\_tags").submit(function(){
            var q = $(this).serialize();
            var obj = $(this);
            $.ajax({
                type: "POST",
                url: "/snippet/snippet/parse_tags",
                data: q,
                success: function(json){
                    $(obj).hide();
                    $("#edit\_tags").show();
                    $("span.tags").empty();
                    $("<a/>",{"class":"tag","href":"/snippet/?tags="+encodeURI(json.snippet_tags[0]),text:json.snippet_tags[0]}).appendTo("span.tags");
                    for(var i=1;i<json.snippet_tags.length;i++){
                        $("span.tags").append(" ");
                        $("<a/>",{"class":"tag","href":"/snippet/?tags="+encodeURI(json.snippet_tags[i]),text:json.snippet_tags[i]}).appendTo("span.tags");
                    }
                }
            });
            return false;
        });
    })();
    </g:javascript>
</div>
