<div class="value buttons">
    <span><g:message code="snippet.tags.label" default="Tags" /></span>
    <form id="edit_tags">
        <span class="tags">${snippetTags?.tags?.join(',')}</span>
        <input type="button" id="editTags" name="editTags" value="Edit">
    </form>
    <form id="parse_tags" name="parse_tags" action="/snippet/snippet/parse_tags" method="POST">
        <g:hiddenField name="id" value="${snippetInstance?.id}" />
        <g:textField name="tags" value="${snippetTags?.tags?.join(',')}" />
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
            console.log(q);
            var obj = $(this);
            $.ajax({
                type: "POST",
                url: "/snippet/snippet/parse_tags",
                data: q,
                success: function(json){
                    console.log(json);
                    console.log(json.snippet_tags.join(','));
                    $(obj).hide();
                    $("#edit\_tags").show();
                    $("span.tags").text(json.snippet_tags.join(','));
                }
            });
            return false;
        });
    })();
    </g:javascript>
</div>
