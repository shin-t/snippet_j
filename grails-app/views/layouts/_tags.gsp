<div class="value buttons">
    <form id="parse_tags" name="parse_tags" action="/snippet/snippet/parse_tags" method="POST">
        <span><g:message code="snippet.tags.label" default="Tags" /></span>
        <g:hiddenField name="id" value="${snippetInstance?.id}" />
        <g:textField name="tags" value="${snippetTags?.tags?.join(',')}" />
        <g:submitButton name="parseTags" value="Update" />
    </form>
    <g:javascript>
    (function(){
        $("#parse\_tags").submit(function(){
            var q = $(this).serialize();
            console.log(q);
            $.ajax({
                type: "POST",
                url: "/snippet/snippet/parse_tags",
                data: q,
                success: function(json){
                    console.log(json);
                    console.log(json.snippet_tags.join(','));
                }
            });
            return false;
        });
    })();
    </g:javascript>
</div>
